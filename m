Received: from eggs.gnu.org ([2001:4830:134:3::10]:41158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1daPrU-0001nD-Pv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1daPrR-0006iH-K7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1daPrR-0006hp-BS
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:12:37 -0400
Date: Wed, 26 Jul 2017 18:12:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170726171221.GB8648@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-11-dgilbert@redhat.com>
	<a638411e-a2d1-644e-705a-1452e6df66f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a638411e-a2d1-644e-705a-1452e6df66f6@redhat.com>
Subject: Re: [Qemu-devel] [RFC 10/29] vhub: Open userfaultfd
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
> > Open a userfaultfd (on a postcopy_advise) and send it back in
> > the reply to the qemu for it to monitor.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   contrib/libvhost-user/libvhost-user.c | 24 +++++++++++++++++++++---
> >   contrib/libvhost-user/libvhost-user.h |  3 +++
> >   2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> > index e3a32755cf..62e97f6b84 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -15,6 +15,7 @@
> >   #include <qemu/osdep.h>
> >   #include <sys/eventfd.h>
> > +#include <sys/syscall.h>
> >   #include <linux/vhost.h>
> >   #include "qemu/atomic.h"
> > @@ -774,11 +775,28 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
> >   static bool
> >   vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
> >   {
> > -    /* TODO: Open ufd, pass it back in the request
> > -    /* TODO: Add addresses
> > -     */
> > +    struct uffdio_api api_struct;
> > +
> > +    dev->postcopy_ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > +    /* TODO: Add addresses */
> >       vmsg->payload.u64 = 0xcafe;
> >       vmsg->size = sizeof(vmsg->payload.u64);
> > +
> > +    if (dev->postcopy_ufd == -1) {
> > +        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
> > +        return false;
> 
> I think we may want to reply something even in case of error.
> 
> Indeed, if something goes wrong on backend side, Qemu will remain
> blocked waiting for the reply.

Fixed.

> > +    }
> > +    api_struct.api = UFFD_API;
> > +    api_struct.features = 0;
> > +    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
> > +        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
> > +        close(dev->postcopy_ufd);
> > +        return false;
> Ditto

Fixed.

Thanks,

Dave

> > +    }
> > +    /* TODO: Stash feature flags somewhere */
> > +    /* Return a ufd to the QEMU */
> > +    vmsg->fd_num = 1;
> > +    vmsg->fds[0] = dev->postcopy_ufd;
> >       return true; /* = send a reply */
> >   }
> > diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> > index 8bb35582ea..3e65a962da 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -231,6 +231,9 @@ struct VuDev {
> >        * re-initialize */
> >       vu_panic_cb panic;
> >       const VuDevIface *iface;
> > +
> > +    /* Postcopy data */
> > +    int postcopy_ufd;
> >   };
> >   typedef struct VuVirtqElement {
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
