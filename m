Received: from eggs.gnu.org ([2001:4830:134:3::10]:48332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnsja-00085b-O0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnsjW-00065w-0D
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:54 -0400
Received: from mail.kernel.org ([198.145.29.136]:55510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnsjV-00065G-Mi
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:49 -0400
Date: Tue, 14 Mar 2017 13:07:44 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1404f716-826a-1fe0-abe1-2be00dbba256@suse.com>
Message-ID: <alpine.DEB.2.10.1703141307120.4807@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-4-git-send-email-sstabellini@kernel.org>
	<1404f716-826a-1fe0-abe1-2be00dbba256@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 4/9] xen/9pfs: introduce Xen 9pfs backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Tue, 14 Mar 2017, Juergen Gross wrote:
> On 14/03/17 00:55, Stefano Stabellini wrote:
> > Introduce the Xen 9pfs backend: add struct XenDevOps to register as a
> > Xen backend and add struct V9fsTransport to register as v9fs transport.
> > 
> > All functions are empty stubs for now.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > CC: anthony.perard@citrix.com
> > CC: jgross@suse.com
> > CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > CC: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/xen-9p-backend.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 hw/9pfs/xen-9p-backend.c
> > 
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > new file mode 100644
> > index 0000000..35032d3
> > --- /dev/null
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -0,0 +1,96 @@
> > +/*
> > + * Xen 9p backend
> > + *
> > + * Copyright Aporeto 2017
> > + *
> > + * Authors:
> > + *  Stefano Stabellini <stefano@aporeto.com>
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "hw/hw.h"
> > +#include "hw/9pfs/9p.h"
> > +#include "hw/xen/xen_backend.h"
> > +#include "xen_9pfs.h"
> > +#include "qemu/config-file.h"
> > +#include "fsdev/qemu-fsdev.h"
> > +
> > +typedef struct Xen9pfsDev {
> > +    struct XenDevice xendev;  /* must be first */
> > +} Xen9pfsDev;
> > +
> > +static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> > +                                     size_t offset,
> > +                                     const char *fmt,
> > +                                     va_list ap)
> > +{
> > +    return 0;
> > +}
> > +
> > +static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > +                                       size_t offset,
> > +                                       const char *fmt,
> > +                                       va_list ap)
> > +{
> > +    return 0;
> > +}
> > +
> > +static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> > +                                           struct iovec **piov,
> > +                                           unsigned int *pniov)
> > +{
> > +}
> > +
> > +static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> > +                                          struct iovec **piov,
> > +                                          unsigned int *pniov,
> > +                                          size_t size)
> > +{
> > +}
> > +
> > +static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
> > +{
> > +}
> > +
> > +static const struct V9fsTransport xen_9p_transport = {
> > +    .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
> > +    .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
> > +    .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
> > +    .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
> > +    .push_and_notify = xen_9pfs_push_and_notify,
> > +};
> > +
> > +static int xen_9pfs_init(struct XenDevice *xendev)
> > +{
> > +    return 0;
> > +}
> > +
> > +static int xen_9pfs_free(struct XenDevice *xendev)
> > +{
> > +    return -1;
> > +}
> > +
> > +static int xen_9pfs_connect(struct XenDevice *xendev)
> > +{
> > +    return 0;
> > +}
> > +
> > +static void xen_9pfs_alloc(struct XenDevice *xendev)
> > +{
> > +}
> > +
> > +static void xen_9pfs_disconnect(struct XenDevice *xendev)
> > +{
> > +}
> > +
> > +struct XenDevOps xen_9pfs_ops = {
> > +    .size       = sizeof(Xen9pfsDev),
> > +    .flags      = DEVOPS_FLAG_NEED_GNTDEV,
> > +    .alloc      = xen_9pfs_alloc,
> > +    .init       = xen_9pfs_init,
> > +    .initialise    = xen_9pfs_connect,
> 
> Alignment?

I'll fix, thanks


> > +    .disconnect = xen_9pfs_disconnect,
> > +    .free       = xen_9pfs_free,
> > +};
> > 
