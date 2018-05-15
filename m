Received: from eggs.gnu.org ([2001:4830:134:3::10]:57121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fIcnG-0003GP-Dd
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fIcnC-0006IU-GJ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:27:18 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:53066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fIcnC-0006Ec-6o
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:27:14 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 15 May 2018 16:26:51 +0000
Message-ID: <0317d5e0856341008eda21f9503dce18@AMSPEX02CL03.citrite.net>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-4-paul.durrant@citrix.com>
	<20180515153821.GD2057@perard.uk.xensource.com>
	<d3dff46e447b4a18bead5bf6ae36f3ba@AMSPEX02CL03.citrite.net>
	<20180515161641.GE2057@perard.uk.xensource.com>
In-Reply-To: <20180515161641.GE2057@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano
	Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 15 May 2018 17:17
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v2 3/3] xen-hvm: try to use
> xenforeignmemory_map_resource() to map ioreq pages
>=20
> On Tue, May 15, 2018 at 04:45:25PM +0100, Paul Durrant wrote:
> > > > diff --git a/include/hw/xen/xen_common.h
> > > b/include/hw/xen/xen_common.h
> > > > index 5f1402b494..d925751040 100644
> > > > --- a/include/hw/xen/xen_common.h
> > > > +++ b/include/hw/xen/xen_common.h
> > > > @@ -119,6 +119,20 @@ static inline int
> > > xendevicemodel_pin_memory_cacheattr(
> > > >      return xc_domain_pin_memory_cacheattr(xen_xc, domid, start,
> end,
> > > type);
> > > >  }
> > > >
> > > > +typedef void xenforeignmemory_resource_handle;
> > > > +
> > > > +#define XENMEM_resource_ioreq_server_frame_bufioreq 0
> > > > +#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
> > > > +
> > > > +static inline xenforeignmemory_resource_handle
> > > *xenforeignmemory_map_resource(
> > > > +    xenforeignmemory_handle *fmem, domid_t domid, unsigned int
> type,
> > > > +    unsigned int id, unsigned long frame, unsigned long nr_frames,
> > > > +    void **paddr, int prot, int flags)
> > > > +{
> > > > +    errno =3D EOPNOTSUPP;
> > >
> > > I think ENOSYS would be better. EOPNOTSUPP seems to be for sockets.
> > >
> >
> > No, EOPNOTSUPP is more general than that and is convention for
> unimplemented API operations elsewhere. ENOSYS is supposed to strictly
> mean 'system call not implemented' but we use it for hypercalls in Xen,
> leading to occasional fun with Linux checkpatch.pl.
>=20
> In man errno, I have:
> ENOTSUP         Operation not supported (POSIX.1-2001)
> EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> ENOSYS          Function not implemented (POSIX.1-2001).
>=20
> But I guess any of these would work.

My reference is the non-Linux definitions in tools/libs/foreignmemory/priva=
te.h in the Xen tree. The one for xenforeignmemory_map_resource() is as fol=
lows:

static inline int osdep_xenforeignmemory_map_resource(
    xenforeignmemory_handle *fmem, xenforeignmemory_resource_handle *fres)
{
    errno =3D EOPNOTSUPP;
    return -1;
}

So I'll stick with EOPNOTSUPP.

Cheers,

  Paul

>=20
> --
> Anthony PERARD
