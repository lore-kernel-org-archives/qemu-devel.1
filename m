Received: from eggs.gnu.org ([2001:4830:134:3::10]:44905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coEBo-0001mH-QD
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coEBk-0000P8-To
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:02:28 -0400
Received: from mail.kernel.org ([198.145.29.136]:41854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1coEBk-0000Ob-Jm
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:02:24 -0400
Date: Wed, 15 Mar 2017 12:02:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170315100653.6702d52f@bahia.lab.toulouse-stg.fr.ibm.com>
Message-ID: <alpine.DEB.2.10.1703151136520.4807@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-3-git-send-email-sstabellini@kernel.org>
	<20170315100653.6702d52f@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 3/9] xen: introduce the header file for
 the Xen 9pfs transport protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com

On Wed, 15 Mar 2017, Greg Kurz wrote:
> On Mon, 13 Mar 2017 16:55:54 -0700
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > It uses the new ring.h macros to declare rings and interfaces.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > CC: anthony.perard@citrix.com
> > CC: jgross@suse.com
> > ---
> >  hw/9pfs/xen_9pfs.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 hw/9pfs/xen_9pfs.h
> > 
> 
> This header file has only one user: please move its content to
> hw/9pfs/xen-9p-backend.c (except the 9P header structure, see
> below).

OK, I can do that. There is going to be a very similar header in the Xen
tree under xen/include/public/io
(http://marc.info/?l=xen-devel&m=148952997709142), but from QEMU point
of view, it makes sense to fold it in xen-9p-backend.c.


> > diff --git a/hw/9pfs/xen_9pfs.h b/hw/9pfs/xen_9pfs.h
> > new file mode 100644
> > index 0000000..c4e8901
> > --- /dev/null
> > +++ b/hw/9pfs/xen_9pfs.h
> > @@ -0,0 +1,20 @@
> > +#ifndef XEN_9PFS_H
> > +#define XEN_9PFS_H
> > +
> > +#include "hw/xen/io/ring.h"
> > +#include <xen/io/protocols.h>
> > +
> > +struct xen_9pfs_header {
> > +	uint32_t size;
> > +	uint8_t id;
> > +	uint16_t tag;
> > +
> > +	/* uint8_t sdata[]; */
> 
> This doesn't seem useful.

I'll remove


> > +} __attribute__((packed));
> > +
> 
> A few remarks:
> - this is a 9P message header actually, which is also used with virtio,
> - QEMU coding style requires a typedef in CamelCase,
> - the 9P protocol explicitely uses little-endian ordering. Since we
>   don't have endian-specific types, it makes sense to indicate that
>   when naming the fields.
> - we have a QEMU_PACKED macro which seems to be used a lot more than
>   the gcc syntax
> 
> Please define a new type in hw/9pfs/9p.h and use it in both transports.
> Something like:
> 
> typedef struct {
>     uint32_t size_le;
>     uint8_t id;
>     uint16_t tag_le;
> } QEMU_PACKED P9MsgHeader;

OK


> > +#define PAGE_SHIFT XC_PAGE_SHIFT
> 
> I don't see any user for this in hw/9pfs/xen-9p-backend.c

PAGE_SHIFT is used by the macros below, but the original Xen headers
don't have the PAGE_SHIFT definition, so, for the sake of keeping the
two in sync, I didn't add it there.


> > +#define XEN_9PFS_RING_ORDER 6
> > +#define XEN_9PFS_RING_SIZE  XEN_FLEX_RING_SIZE(XEN_9PFS_RING_ORDER)
> > +DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
> > +
> > +#endif
