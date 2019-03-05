Received: from eggs.gnu.org ([209.51.188.92]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1CXX-0004yF-CS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1CXW-0003rP-94
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:03:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1CXW-0003r0-4q
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:03:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so9453332qta.7
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:03:34 -0800 (PST)
Date: Tue, 5 Mar 2019 11:03:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190305110201-mutt-send-email-mst@kernel.org>
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
	<20190305051134.27930-3-david@gibson.dropbear.id.au>
	<00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/2] virtio-balloon: Restore MADV_WILLNEED
 hint on balloon deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, Mar 05, 2019 at 03:15:38PM +0100, David Hildenbrand wrote:
> On 05.03.19 06:11, David Gibson wrote:
> > Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED on
> > deflate", the balloon device issued an madvise() MADV_WILLNEED on
> > pages removed from the balloon.  That would hint to the host kernel
> > that the pages were likely to be needed by the guest in the near
> > future.
> > 
> > It's unclear if this is actually valuable or not, and so f6deb6d9
> > removed this, essentially ignoring balloon deflate requests.  However,
> > concerns have been raised that this might cause a performance
> > regression by causing extra latency for the guest in certain
> > configurations.
> 
> I mean, it will mainly create page tables as far as I know. Any write to
> a page will have an overhead either way (COW zero page). Reads *might*
> be faster.
> 
> As we are working on 4k granularity in the balloon (and doing
> MADV_DONTNEED on 4k granularity!), there will most probably be page
> tables already either way. A page table could only be zapped if all
> pages of that page table are MADV_DONTNEED'ed (or I assume never were
> touched), and I am not sure if "random MADV_DONTNEED'ing of 4k pages"
> will actually get rid of page tables (my assumption would be: only if a
> complete range is zapped at once). I haven't looked into the details,
> though (plenty of other stuff to do).
> 
> I am not sure if I share the concerns. Real-time workload should never
> use the virtio-balloon in a way that anything like that would be possible.
> 
> > 
> > So, until we can get actual benchmark data to see if that's the case,
> > this restores (by default) the old behaviour, issuing a MADV_WILLNEED
> > when a page is removed from the balloon.  A new property on the
> > balloon device "hint-on-deflate" can be set to false to remove this
> > behaviour for testing.
> 
> This is certainly a good approach for you to finally be able to leave
> the ugly land of virtio-balloon :)
> 
> But at least to me, this looks completely useless. I'll be happy to be
> proven wrong as always :)

Point is if we don't intend to extend balloon any further then let's
not make random untested changes to its behaviour.

> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/virtio/virtio-balloon.c         | 15 +++++++++++++++
> >  include/hw/virtio/virtio-balloon.h |  1 +
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index e5e82b556d..69968502d9 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -146,6 +146,20 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
> >              balloon->pbp = NULL;
> >          }
> >      }
> > +
> > +    if (balloon->hint_on_deflate) {
> > +        void *host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
> > +        int ret;
> > +
> > +        /* When a page is deflated, we hint the whole host page it
> > +         * lives on, since we can't do anything smaller */
> > +        ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
> > +        if (ret != 0) {
> > +            warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
> > +                        strerror(errno));
> > +            /* Otherwise ignore, failing to page hint shouldn't be fatal */
> > +        }
> > +    }
> >  }
> >  
> >  static const char *balloon_stat_names[] = {
> > @@ -622,6 +636,7 @@ static const VMStateDescription vmstate_virtio_balloon = {
> >  static Property virtio_balloon_properties[] = {
> >      DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
> >                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> > +    DEFINE_PROP_BOOL("hint-on-deflate", VirtIOBalloon, hint_on_deflate, true),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> > index 99dcd6d105..69732cedaa 100644
> > --- a/include/hw/virtio/virtio-balloon.h
> > +++ b/include/hw/virtio/virtio-balloon.h
> > @@ -45,6 +45,7 @@ typedef struct VirtIOBalloon {
> >      int64_t stats_poll_interval;
> >      uint32_t host_features;
> >      PartiallyBalloonedPage *pbp;
> > +    bool hint_on_deflate;
> >  } VirtIOBalloon;
> >  
> >  #endif
> > 
> 
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
