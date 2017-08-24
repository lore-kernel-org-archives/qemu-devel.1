Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dktVf-0000bD-Fg
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 10:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dktVa-0003vE-K8
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 10:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dktVa-0003uj-Ao
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 10:53:22 -0400
Date: Thu, 24 Aug 2017 15:53:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170824145308.GC2737@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-27-dgilbert@redhat.com>
	<0ac99cfe-1cb6-e405-b4c0-1f1c407cf94f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac99cfe-1cb6-e405-b4c0-1f1c407cf94f@redhat.com>
Subject: Re: [Qemu-devel] [RFC 26/29] vhost: Add VHOST_USER_POSTCOPY_END
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Maxime Coquelin (maxime.coquelin@redhat.com) wrote:
> 
> 
> On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > This message is sent just before the end of postcopy to get the
> > client to stop using userfault since we wont respond to any more
> > requests.  It should close userfaultfd so that any other pages
> > get mapped to the backing file automatically by the kernel, since
> > at this point we know we've received everything.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
> >   contrib/libvhost-user/libvhost-user.h |  1 +
> >   hw/virtio/vhost-user.c                |  1 +
> >   3 files changed, 25 insertions(+)
> > 
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> > index d37052b7b0..c1716d1a62 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -68,6 +68,7 @@ vu_request_to_string(int req)
> >           REQ(VHOST_USER_INPUT_GET_CONFIG),
> >           REQ(VHOST_USER_POSTCOPY_ADVISE),
> >           REQ(VHOST_USER_POSTCOPY_LISTEN),
> > +        REQ(VHOST_USER_POSTCOPY_END),
> >           REQ(VHOST_USER_MAX),
> >       };
> >   #undef REQ
> > @@ -889,6 +890,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
> >       return false;
> >   }
> > +
> > +static bool
> > +vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    fprintf(stderr, "%s: Entry\n", __func__);
> > +    dev->postcopy_listening = false;
> > +    if (dev->postcopy_ufd > 0) {
> > +        close(dev->postcopy_ufd);
> > +        dev->postcopy_ufd = -1;
> > +        fprintf(stderr, "%s: Done close\n", __func__);
> > +    }
> > +
> > +    vmsg->fd_num = 0;
> > +    vmsg->payload.u64 = 0;
> > +    vmsg->size = sizeof(vmsg->payload.u64);
> > +    vmsg->flags = VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> > +    fprintf(stderr, "%s: exit\n", __func__);
> > +    return true;
> > +}
> > +
> 
> It is what reply-ack is done for, so to avoid code duplication,
> maybe Qemu could set VHOST_USER_NEED_REPLY_MASK bit when reply-ack
> feature is supported.
> 
> I'm wondering if we shouldn't consider adding reply-ack feature support
> to libvhost-user, and make postcopy support to depend on this feature.

Yes, that would make sense;  for the moment I'm adding what I think is
the same replies in the places I need ack's, and setting the VHOST_USER_NEED_REPLY_MASK
so for the messages where I need it the semantics should be the same as
that.

Dave

> Cheers,
> Maxime
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
