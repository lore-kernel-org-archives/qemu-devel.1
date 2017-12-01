Received: from eggs.gnu.org ([2001:4830:134:3::10]:50325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKnYe-0002aV-8o
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKnXv-0001fy-03
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKnXu-0001cF-KK
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:48:10 -0500
Date: Fri, 1 Dec 2017 16:39:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171201083925.GC2712@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-2-peterx@redhat.com>
	<20171130102437.GA2248@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130102437.GA2248@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 01/32] migration: better error handling
 with QEMUFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Nov 30, 2017 at 10:24:38AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > If the postcopy down due to some reason, we can always see this on dst:
> > 
> >   qemu-system-x86_64: RP: Received invalid message 0x0000 length 0x0000
> > 
> > However in most cases that's not the real issue. The problem is that
> > qemu_get_be16() has no way to show whether the returned data is valid or
> > not, and we are _always_ assuming it is valid. That's possibly not wise.
> > 
> > The best approach to solve this would be: refactoring QEMUFile interface
> > to allow the APIs to return error if there is. However it needs quite a
> > bit of work and testing. For now, let's explicitly check the validity
> > first before using the data in all places for qemu_get_*().
> > 
> > This patch tries to fix most of the cases I can see. Only if we are with
> > this, can we make sure we are processing the valid data, and also can we
> > make sure we can capture the channel down events correctly.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c |  5 +++++
> >  migration/ram.c       | 26 ++++++++++++++++++++++----
> >  migration/savevm.c    | 40 ++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 65 insertions(+), 6 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c0206023d7..eae34d0524 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1708,6 +1708,11 @@ static void *source_return_path_thread(void *opaque)
> >          header_type = qemu_get_be16(rp);
> >          header_len = qemu_get_be16(rp);
> >  
> > +        if (qemu_file_get_error(rp)) {
> > +            mark_source_rp_bad(ms);
> > +            goto out;
> > +        }
> > +
> >          if (header_type >= MIG_RP_MSG_MAX ||
> >              header_type == MIG_RP_MSG_INVALID) {
> >              error_report("RP: Received invalid message 0x%04x length 0x%04x",
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 8620aa400a..960c726ff2 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2687,7 +2687,7 @@ static int ram_load_postcopy(QEMUFile *f)
> >      void *last_host = NULL;
> >      bool all_zero = false;
> >  
> > -    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> > +    while (!(flags & RAM_SAVE_FLAG_EOS)) {
> 
> I still think you need to keep the !ret && - see below;
> anyway, there's no harm in keeping it!

Fair enough; I'll keep it no matter what. :-)

> 
> >          ram_addr_t addr;
> >          void *host = NULL;
> >          void *page_buffer = NULL;
> > @@ -2696,6 +2696,16 @@ static int ram_load_postcopy(QEMUFile *f)
> >          uint8_t ch;
> >  
> >          addr = qemu_get_be64(f);
> > +
> > +        /*
> > +         * If qemu file error, we should stop here, and then "addr"
> > +         * may be invalid
> > +         */
> > +        ret = qemu_file_get_error(f);
> > +        if (ret) {
> > +            break;
> > +        }
> > +
> >          flags = addr & ~TARGET_PAGE_MASK;
> >          addr &= TARGET_PAGE_MASK;
> >  
> > @@ -2776,6 +2786,13 @@ static int ram_load_postcopy(QEMUFile *f)
> >              error_report("Unknown combination of migration flags: %#x"
> >                           " (postcopy mode)", flags);
> >              ret = -EINVAL;

[1]

> > +            break;
> 
> This 'break' breaks from the switch, but doesn't break the loop and
> because you remove dthe !ret && from the top, the loop keeps going when
> it shouldn't.

Ah yes I missed this one, thanks.

What I should have written here is a "goto out", and also I should add
that "out" label at the end.  I think after this single change current
patch should be fine.

However I understand that you would prefer me to check the ret every
time.  IMHO it's a matter of taste.  I would prefer current way to do
things since I see it awkward to keep checking against (!ret) possibly
multiple times even we already know it's non-zero (especially when the
failure happens at the beginning of the loop block).  But for this
patch, I can follow yours (since you asked for twice already :).

> 
> > +        }
> > +
> > +        /* Detect for any possible file errors */
> > +        if (qemu_file_get_error(f)) {
> > +            ret = qemu_file_get_error(f);
> > +            break;
> >          }
> 
> This is all simpler if you just leave the !ret && at the top, and then
> make this:
>   if (!ret) {
>       ret = qemu_file_get_error(f);
>   }

Sure.

(So to show what I meant: if we failed at [1] above we still need to
 check this, which is unecessary imho)

> 
> >  
> >          if (place_needed) {
> 
> Make that
> 
>       if (!ret && place_needed) {

Will do.

(same here if we failed at [1], actually we don't need to check the
 ret value so many times)

> 
> > @@ -2789,9 +2806,10 @@ static int ram_load_postcopy(QEMUFile *f)
> >                  ret = postcopy_place_page(mis, place_dest,
> >                                            place_source, block);
> >              }
> > -        }
> > -        if (!ret) {
> > -            ret = qemu_file_get_error(f);
> > +
> > +            if (ret) {
> > +                break;
> > +            }
> 
> And with the !ret check at the top this goes again.

Yes, will remove it.  Thanks!

-- 
Peter Xu
