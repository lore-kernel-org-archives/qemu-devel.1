Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIcd7-0003Ly-0X
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIcd3-0008Ey-QY
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:16:49 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:21739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIcd3-0008DU-E0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:16:45 -0400
Date: Tue, 15 May 2018 17:16:41 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180515161641.GE2057@perard.uk.xensource.com>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-4-paul.durrant@citrix.com>
	<20180515153821.GD2057@perard.uk.xensource.com>
	<d3dff46e447b4a18bead5bf6ae36f3ba@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3dff46e447b4a18bead5bf6ae36f3ba@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen-hvm: try to use
 xenforeignmemory_map_resource() to map ioreq pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>

On Tue, May 15, 2018 at 04:45:25PM +0100, Paul Durrant wrote:
> > > diff --git a/include/hw/xen/xen_common.h
> > b/include/hw/xen/xen_common.h
> > > index 5f1402b494..d925751040 100644
> > > --- a/include/hw/xen/xen_common.h
> > > +++ b/include/hw/xen/xen_common.h
> > > @@ -119,6 +119,20 @@ static inline int
> > xendevicemodel_pin_memory_cacheattr(
> > >      return xc_domain_pin_memory_cacheattr(xen_xc, domid, start, end,
> > type);
> > >  }
> > >
> > > +typedef void xenforeignmemory_resource_handle;
> > > +
> > > +#define XENMEM_resource_ioreq_server_frame_bufioreq 0
> > > +#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
> > > +
> > > +static inline xenforeignmemory_resource_handle
> > *xenforeignmemory_map_resource(
> > > +    xenforeignmemory_handle *fmem, domid_t domid, unsigned int type,
> > > +    unsigned int id, unsigned long frame, unsigned long nr_frames,
> > > +    void **paddr, int prot, int flags)
> > > +{
> > > +    errno = EOPNOTSUPP;
> > 
> > I think ENOSYS would be better. EOPNOTSUPP seems to be for sockets.
> > 
> 
> No, EOPNOTSUPP is more general than that and is convention for unimplemented API operations elsewhere. ENOSYS is supposed to strictly mean 'system call not implemented' but we use it for hypercalls in Xen, leading to occasional fun with Linux checkpatch.pl.

In man errno, I have:
ENOTSUP         Operation not supported (POSIX.1-2001)
EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
ENOSYS          Function not implemented (POSIX.1-2001).

But I guess any of these would work.

-- 
Anthony PERARD
