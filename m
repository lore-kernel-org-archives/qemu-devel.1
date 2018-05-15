Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fIc8q-0002UW-OL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fIc8m-0004ug-QE
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:32 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:51040
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fIc8m-0004so-Ee
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:28 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 15 May 2018 15:45:25 +0000
Message-ID: <d3dff46e447b4a18bead5bf6ae36f3ba@AMSPEX02CL03.citrite.net>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-4-paul.durrant@citrix.com>
	<20180515153821.GD2057@perard.uk.xensource.com>
In-Reply-To: <20180515153821.GD2057@perard.uk.xensource.com>
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
> Sent: 15 May 2018 16:38
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v2 3/3] xen-hvm: try to use
> xenforeignmemory_map_resource() to map ioreq pages
>=20
> On Thu, May 10, 2018 at 10:15:18AM +0100, Paul Durrant wrote:
> > --- a/hw/i386/xen/xen-hvm.c
> > +++ b/hw/i386/xen/xen-hvm.c
> > @@ -1239,13 +1239,41 @@ static void xen_wakeup_notifier(Notifier
> *notifier, void *data)
> >
> >  static int xen_map_ioreq_server(XenIOState *state)
> >  {
> > +    void *addr =3D NULL;
> > +    xenforeignmemory_resource_handle *fres;
> >      xen_pfn_t ioreq_pfn;
> >      xen_pfn_t bufioreq_pfn;
> >      evtchn_port_t bufioreq_evtchn;
> >      int rc;
> >
> > +    /*
> > +     * Attempt to map using the resource API and fall back to normal
> > +     * foreign mapping if this is not supported.
> > +     */
> > +
> QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq
> !=3D 0);
> > +
> QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0)
> !=3D 1);
> > +    fres =3D xenforeignmemory_map_resource(xen_fmem, xen_domid,
> > +                                         XENMEM_resource_ioreq_server,
>=20
> XENMEM_resource_ioreq_server undeclared with Xen 4.10

Yes, I missed that from my compat definitions. Will add.

>=20
> > +                                         state->ioservid, 0, 2,
> > +                                         &addr,
> > +                                         PROT_READ | PROT_WRITE, 0);
> > +    if (fres !=3D NULL) {
> > +        trace_xen_map_resource_ioreq(state->ioservid, addr);
> > +        state->buffered_io_page =3D addr;
> > +        state->shared_page =3D addr + TARGET_PAGE_SIZE;
> > +    } else {
> > +        error_report("failed to map ioreq server resources: error %d
> handle=3D%p",
> > +                     errno, xen_xc);
>=20
> Maybe printing the error message only when
> xenforeignmemory_map_resource
> fails, would be better? i.e. after checking errno value.
>=20

Yes, that be better. I'll move it lower.

> > +        if (errno !=3D EOPNOTSUPP) {
> > +            return -1;
> > +        }
> > +    }
> > +
> >      rc =3D xen_get_ioreq_server_info(xen_domid, state->ioservid,
> > -                                   &ioreq_pfn, &bufioreq_pfn,
> > +                                   (state->shared_page =3D=3D NULL) ?
> > +                                   &ioreq_pfn : NULL,
> > +                                   (state->buffered_io_page =3D=3D NUL=
L) ?
> > +                                   &bufioreq_pfn : NULL,
> >                                     &bufioreq_evtchn);
> >      if (rc < 0) {
> >          error_report("failed to get ioreq server info: error %d handle=
=3D%p",
> > diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> > index 5f1402b494..d925751040 100644
> > --- a/include/hw/xen/xen_common.h
> > +++ b/include/hw/xen/xen_common.h
> > @@ -119,6 +119,20 @@ static inline int
> xendevicemodel_pin_memory_cacheattr(
> >      return xc_domain_pin_memory_cacheattr(xen_xc, domid, start, end,
> type);
> >  }
> >
> > +typedef void xenforeignmemory_resource_handle;
> > +
> > +#define XENMEM_resource_ioreq_server_frame_bufioreq 0
> > +#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
> > +
> > +static inline xenforeignmemory_resource_handle
> *xenforeignmemory_map_resource(
> > +    xenforeignmemory_handle *fmem, domid_t domid, unsigned int type,
> > +    unsigned int id, unsigned long frame, unsigned long nr_frames,
> > +    void **paddr, int prot, int flags)
> > +{
> > +    errno =3D EOPNOTSUPP;
>=20
> I think ENOSYS would be better. EOPNOTSUPP seems to be for sockets.
>=20

No, EOPNOTSUPP is more general than that and is convention for unimplemente=
d API operations elsewhere. ENOSYS is supposed to strictly mean 'system cal=
l not implemented' but we use it for hypercalls in Xen, leading to occasion=
al fun with Linux checkpatch.pl.

>=20
> > +    return -1;
>=20
> Should this return NULL instead?  That doesn't build on Xen 4.10 and earl=
ier.
>=20

Indeed it should. Not sure how I missed that.

> > +}
> > +
> >  #endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100 */
> >
> >  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
>=20
> Thanks,

Thanks. V3 coming soon.

  Paul

>=20
> --
> Anthony PERARD
