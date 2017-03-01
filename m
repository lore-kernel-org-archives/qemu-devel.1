Received: from eggs.gnu.org ([2001:4830:134:3::10]:48017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=226d5cfd0=Paul.Durrant@citrix.com>)
	id 1cj6vl-0005HK-T1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=226d5cfd0=Paul.Durrant@citrix.com>)
	id 1cj6vi-0005d7-Jm
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:16:45 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:15440
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=226d5cfd0=Paul.Durrant@citrix.com>)
	id 1cj6vi-0005cG-7o
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:16:42 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 1 Mar 2017 16:16:32 +0000
Message-ID: <89af9dc8f67d4ae8b32d7e046e5bb10a@AMSPEX02CL03.citrite.net>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-4-git-send-email-paul.durrant@citrix.com>
	<20170301161340.GD1760@perard.uk.xensource.com>
In-Reply-To: <20170301161340.GD1760@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/5] xen: create wrappers for all other
 uses of xc_hvm_XXX() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 01 March 2017 16:14
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> Stabellini <sstabellini@kernel.org>; Paolo Bonzini <pbonzini@redhat.com>;
> Richard Henderson <rth@twiddle.net>; Eduardo Habkost
> <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>
> Subject: Re: [PATCH 3/5] xen: create wrappers for all other uses of
> xc_hvm_XXX() functions
>=20
> On Thu, Feb 23, 2017 at 02:53:53PM +0000, Paul Durrant wrote:
> > This patch creates inline wrapper functions in xen_common.h for all ope=
n
> > coded calls to xc_hvm_XXX() functions outside of xen_common.h so that
> use
> > of xen_xc can be made implicit. This again is in preparation for the mo=
ve
> > to using libxendevicemodel.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> > index 1e08b98..31cf25f 100644
> > --- a/include/hw/xen/xen_common.h
> > +++ b/include/hw/xen/xen_common.h
> > @@ -26,6 +26,50 @@ extern xc_interface *xen_xc;
> >   * We don't support Xen prior to 4.2.0.
> >   */
> >
> > +static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t
> type,
> > +                                   uint64_t first_pfn, uint32_t nr)
> > +{
>=20
> I don't know if it matters from where the functions are called, but
> here, xc_hvm_set_mem_type takes a "uint64_t nr" (and not uint32_t).

Yes, the old APIs were wrong and discarded the upper 32 bits, so limiting h=
ere is correct. Moving to the new API fixes the issue.

>=20
> > +    return xc_hvm_set_mem_type(xen_xc, domid, type, first_pfn, nr);
> > +}
> > +
> > +static inline int xen_set_pci_intx_level(domid_t domid, uint16_t segme=
nt,
> > +                                         uint8_t bus, uint8_t device,
> > +                                         uint8_t intx, unsigned int le=
vel)
> > +{
> > +    return xc_hvm_set_pci_intx_level(xen_xc, domid, segment, bus,
> device,
> > +                                     intx, level);
> > +}
> > +
> > +static inline int xen_set_pci_link_route(domid_t domid, uint8_t link,
> > +                                         uint8_t irq)
> > +{
> > +    return xc_hvm_set_pci_link_route(xen_xc, domid, link, irq);
> > +}
> > +
> > +static inline int xen_inject_msi(domid_t domid, uint64_t msi_addr,
> > +                                 uint32_t msi_data)
> > +{
> > +    return xc_hvm_inject_msi(xen_xc, domid, msi_addr, msi_data);
> > +}
> > +
> > +static inline int xen_set_isa_irq_level(domid_t domid, uint8_t irq,
> > +                                        unsigned int level)
> > +{
> > +    return xc_hvm_set_isa_irq_level(xen_xc, domid, irq, level);
> > +}
> > +
> > +static inline int xen_track_dirty_vram(domid_t domid, uint64_t first_p=
fn,
> > +                                       uint32_t nr, unsigned long *bit=
map)
> > +{
>=20
> Same here.
>=20
> > +    return xc_hvm_track_dirty_vram(xen_xc, domid, first_pfn, nr, bitma=
p);
> > +}
> > +
> > +static inline int xen_modified_memory(domid_t domid, uint64_t
> first_pfn,
> > +                                      uint32_t nr)
> > +{
>=20
> And here.
>=20
> > +    return xc_hvm_modified_memory(xen_xc, domid, first_pfn, nr);
> > +}
> > +
> >  /* Xen 4.2 through 4.6 */
> >  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 471
> >
>=20
> The rest looks good.

Thanks,

  Paul

>=20
> --
> Anthony PERARD
