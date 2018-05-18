Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJbmv-0005FB-9Q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJbmr-0004Pw-Cl
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:35:01 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:30377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJbmr-0004OY-1l
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:34:57 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 18 May 2018 09:34:33 +0000
Message-ID: <03b01c2edf144f78bfba30fded0706ce@AMSPEX02CL03.citrite.net>
References: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
	<20180517163053.GN2057@perard.uk.xensource.com>
In-Reply-To: <20180517163053.GN2057@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen-hvm: stop faking I/O to access PCI
 config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
	Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 17 May 2018 17:31
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> Stabellini <sstabellini@kernel.org>; Michael S. Tsirkin <mst@redhat.com>;
> Marcel Apfelbaum <marcel@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>; Eduardo
> Habkost <ehabkost@redhat.com>
> Subject: Re: [PATCH] xen-hvm: stop faking I/O to access PCI config space
>=20
> On Thu, May 03, 2018 at 12:18:40PM +0100, Paul Durrant wrote:
> > This patch removes the current hackery where IOREQ_TYPE_PCI_CONFIG
> > reqyests are handled by faking PIO to 0xcf8 and 0xcfc and replaces it
>=20
>   ^ requests

Ok.

>=20
> > with direct calls to pci_host_config_read/write_common().
> > Doing so necessitates mapping BDFs to PCIDevices but maintaining a simp=
le
> > QLIST in xen_device_realize/unrealize() will suffice.
> >
> > NOTE: whilst config space accesses are currently limited to
> >       PCI_CONFIG_SPACE_SIZE, this patch paves the way to increasing the
> >       limit to PCIE_CONFIG_SPACE_SIZE when Xen gains the ability to
> >       emulate MCFG table accesses.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> > +static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
> > +{
> > +    uint32_t sbdf =3D req->addr >> 32;
> > +    uint32_t reg =3D req->addr;
> > +    XenPciDevice *xendev;
> > +
> > +    if (req->size > sizeof(uint32_t)) {
> > +        hw_error("PCI config access: bad size (%u)", req->size);
> > +    }
> > +
> > +    QLIST_FOREACH(xendev, &state->dev_list, entry) {
> > +        unsigned int i;
> > +
> > +        if (xendev->sbdf !=3D sbdf) {
> > +            continue;
> > +        }
> > +
> > +        if (req->dir =3D=3D IOREQ_READ) {
> > +            if (!req->data_is_ptr) {
> > +                req->data =3D pci_host_config_read_common(
> > +                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
> > +                    req->size);
> > +                trace_cpu_ioreq_config_read(req, sbdf, reg, req->size,
> > +                                            req->data);
> > +            } else {
> > +                for (i =3D 0; i < req->count; i++) {
> > +                    uint32_t tmp;
> > +
> > +                    tmp =3D pci_host_config_read_common(
> > +                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
> > +                        req->size);
>=20
> So, if data is a pointer, we just keep reading the same address
> req->count time?
>=20

That's what would have happened before AFAICT, since the old scheme used po=
rt I/O. I think you're right that it is probably worth changing to MMIO sem=
antics with this change though.

  Paul

> > +                    write_phys_req_item(req->data, req, i, &tmp);
> > +                }
> > +            }
> > +        } else if (req->dir =3D=3D IOREQ_WRITE) {
> > +            if (!req->data_is_ptr) {
> > +                trace_cpu_ioreq_config_write(req, sbdf, reg, req->size=
,
> > +                                             req->data);
> > +                pci_host_config_write_common(
> > +                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE, req->=
data,
> > +                    req->size);
> > +            } else {
> > +                for (i =3D 0; i < req->count; i++) {
> > +                    uint32_t tmp =3D 0;
> > +
> > +                    read_phys_req_item(req->data, req, i, &tmp);
> > +                    pci_host_config_write_common(
> > +                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE, t=
mp,
> > +                        req->size);
> > +                }
> > +            }
> > +        }
> > +    }
> > +}
>=20
> --
> Anthony PERARD
