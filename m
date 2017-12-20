Received: from eggs.gnu.org ([2001:4830:134:3::10]:33154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRf5W-0000cY-AH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRf5S-0004kg-48
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:11:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRf5R-0004jj-RJ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:11:10 -0500
Date: Wed, 20 Dec 2017 16:11:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220160952-mutt-send-email-mst@kernel.org>
References: <20171213082644.83113-1-ben@skyportsystems.com>
	<20171220062738-mutt-send-email-mst@kernel.org>
	<5E450532-FCCA-4785-8C96-E3569FE683EE@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5E450532-FCCA-4785-8C96-E3569FE683EE@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, yan@daynix.com, lprosek@redhat.com, eswierk@skyportsystems.com

On Tue, Dec 19, 2017 at 09:11:31PM -0800, Ben Warren wrote:
> Hi Michael,
>=20
> > On Dec 19, 2017, at 8:27 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >=20
> > On Wed, Dec 13, 2017 at 12:26:44AM -0800, ben@skyportsystems.com wrot=
e:
> >> From: Ben Warren <ben@skyportsystems.com>
> >>=20
> >> Now that virtio-win guest drivers provided by non-Redhat vendors nee=
d to
> >> use a different Subsystem Vendor ID value, a way is needed to set th=
is
> >> parameter on the host.  This works with all of the PCI-based devices=
,
> >> such as NetKVM, viostor, vioscsi, vioserial and balloon.
> >>=20
> >> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> >=20
> > I applied a related patch by Ladi, pls take a look.
> >=20
> If you=E2=80=99re talking about the one titled "virtio-pci: Don't force=
 Subsystem Vendor ID =3D Vendor ID=E2=80=9D, then this is complementary. =
 If it=E2=80=99s another one, I must have missed it.  The patch I=E2=80=99=
m aware of doesn=E2=80=99t provide any way of setting the subsystem vendo=
r ID, which is needed.
>=20
> BTW - would you prefer this to be contained to virtio-pci, or all of PC=
I, as another reviewer suggested.  Either is easy.

Let me respond to that one.

> >> ---
> >> hw/virtio/virtio-pci.c | 5 +++++
> >> hw/virtio/virtio-pci.h | 1 +
> >> 2 files changed, 6 insertions(+)
> >>=20
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index e92837c..b5c86e3 100644
> >> --- a/hw/virtio/virtio-pci.c
> >> +++ b/hw/virtio/virtio-pci.c
> >> @@ -1757,6 +1757,9 @@ static void virtio_pci_realize(PCIDevice *pci_=
dev, Error **errp)
> >>     if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
> >>         proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OF=
F_AUTO_OFF;
> >>     }
> >> +    /* Set the PCI Subsystem Vendor ID */
> >> +    k->parent_class.subsystem_vendor_id =3D proxy->subsystem_vendor=
_id;
> >> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID, proxy->=
subsystem_vendor_id);
> >>=20
> >>     if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
> >>         error_setg(errp, "device cannot work as neither modern nor l=
egacy mode"
> >> @@ -1876,6 +1879,8 @@ static Property virtio_pci_properties[] =3D {
> >>                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >> +    DEFINE_PROP_UINT16("subsystem-vendor-id", VirtIOPCIProxy,
> >> +                       subsystem_vendor_id, PCI_VENDOR_ID_REDHAT_QU=
MRANET),
> >>     DEFINE_PROP_END_OF_LIST(),
> >> };
> >>=20
> >> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> >> index 12d3a90..8a897ea 100644
> >> --- a/hw/virtio/virtio-pci.h
> >> +++ b/hw/virtio/virtio-pci.h
> >> @@ -186,6 +186,7 @@ struct VirtIOPCIProxy {
> >>     VirtIOIRQFD *vector_irqfd;
> >>     int nvqs_with_notifiers;
> >>     VirtioBusState bus;
> >> +    uint16_t subsystem_vendor_id;
> >> };
> >>=20
> >> static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
> >> --=20
> >> 2.7.4
>=20
