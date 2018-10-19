Received: from eggs.gnu.org ([2001:4830:134:3::10]:56176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTQs-0004eM-IK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTQp-000406-5z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDTQo-0003zO-Sb
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:59:07 -0400
References: <20180830105757.10577-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53e26708-6c8f-1aac-1cad-1b38b3c93130@redhat.com>
Date: Fri, 19 Oct 2018 13:58:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180830105757.10577-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: clarify that the Q35 machine type
 implements a P35 chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 30/08/2018 12:57, Daniel P. Berrang=C3=A9 wrote:
> The 'q35' machine type implements an Intel Series 3 chipset,
> of which there are several variants:
>=20
>   https://www.intel.com/Assets/PDF/datasheet/316966.pdf
>=20
> The key difference between the 82P35 MCH ('p35', PCI device ID 0x29c0)
> and 82Q35 GMCH ('q35', PCI device ID 0x29b0) variants is that the latte=
r
> has an integrated graphics adapter. QEMU does not implement integrated
> graphics, so uses the PCI ID for the 82P35 chipset, despite calling the
> machine type 'q35'. Thus we rename the PCI device ID constant to reflec=
t
> reality, to avoid confusing future developers. The new name more closel=
y
> matches what pci.ids reports it to be:
>=20
> $ grep  P35 /usr/share/hwdata/pci.ids  | grep 29
> 	29c0  82G33/G31/P35/P31 Express DRAM Controller
> 	29c1  82G33/G31/P35/P31 Express PCI Express Root Port
> 	29c4  82G33/G31/P35/P31 Express MEI Controller
> 	29c5  82G33/G31/P35/P31 Express MEI Controller
> 	29c6  82G33/G31/P35/P31 Express PT IDER Controller
> 	29c7  82G33/G31/P35/P31 Express Serial KT Controller
>=20
> $ grep  Q35 /usr/share/hwdata/pci.ids  | grep 29
> 	29b0  82Q35 Express DRAM Controller
> 	29b1  82Q35 Express PCI Express Root Port
> 	29b2  82Q35 Express Integrated Graphics Controller
> 	29b3  82Q35 Express Integrated Graphics Controller
> 	29b4  82Q35 Express MEI Controller
> 	29b5  82Q35 Express MEI Controller
> 	29b6  82Q35 Express PT IDER Controller
> 	29b7  82Q35 Express Serial KT Controller
>=20
> Arguably the QEMU machine type should be named 'p35'. At this point in
> time, however, it is not worth the churn for management applications &
> documentation to worry about renaming it.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/pci-host/q35.c        | 10 +++++++++-
>  include/hw/pci/pci_ids.h |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 02f9576588..0a056d6aea 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -618,7 +618,15 @@ static void mch_class_init(ObjectClass *klass, voi=
d *data)
>      dc->desc =3D "Host bridge";
>      dc->vmsd =3D &vmstate_mch;
>      k->vendor_id =3D PCI_VENDOR_ID_INTEL;
> -    k->device_id =3D PCI_DEVICE_ID_INTEL_Q35_MCH;
> +    /*
> +     * The 'q35' machine type implements an Intel Series 3 chipset,
> +     * of which there are several variants. The key difference between
> +     * the 82P35 MCH ('p35') and 82Q35 GMCH ('q35') variants is that
> +     * the latter has an integrated graphics adapter. QEMU does not
> +     * implement integrated graphics, so uses the PCI ID for the 82P35
> +     * chipset.
> +     */
> +    k->device_id =3D PCI_DEVICE_ID_INTEL_P35_MCH;
>      k->revision =3D MCH_HOST_BRIDGE_REVISION_DEFAULT;
>      k->class_id =3D PCI_CLASS_BRIDGE_HOST;
>      /*
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 63acc722a9..eeb33018ad 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -255,7 +255,7 @@
>  #define PCI_DEVICE_ID_INTEL_82801I_EHCI2 0x293c
>  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF 0x10ed
> =20
> -#define PCI_DEVICE_ID_INTEL_Q35_MCH      0x29c0
> +#define PCI_DEVICE_ID_INTEL_P35_MCH      0x29c0
> =20
>  #define PCI_VENDOR_ID_XEN                0x5853
>  #define PCI_DEVICE_ID_XEN_PLATFORM       0x0001
>=20

Queued, thanks.

Paolo
