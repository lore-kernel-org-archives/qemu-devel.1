Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=598c11397=Paul.Durrant@citrix.com>)
	id 1etv3g-0000li-9n
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=598c11397=Paul.Durrant@citrix.com>)
	id 1etv3c-0007fw-95
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:54:08 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:21463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=598c11397=Paul.Durrant@citrix.com>)
	id 1etv3b-0007dE-Vx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:54:04 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 8 Mar 2018 12:53:47 +0000
Message-ID: <e9d205b6139c4e338b5535fc6bed3a2a@AMSPEX02CL03.citrite.net>
References: <1520513551-19851-1-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1520513551-19851-1-git-send-email-igor.druzhinin@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen-pvdevice: Introduce a simplistic
 xen-pvdevice save state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

> -----Original Message-----
> From: Igor Druzhinin [mailto:igor.druzhinin@citrix.com]
> Sent: 08 March 2018 12:53
> To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> Cc: sstabellini@kernel.org; Paul Durrant <Paul.Durrant@citrix.com>; Antho=
ny
> Perard <anthony.perard@citrix.com>; mst@redhat.com;
> pbonzini@redhat.com; Igor Druzhinin <igor.druzhinin@citrix.com>
> Subject: [PATCH] xen-pvdevice: Introduce a simplistic xen-pvdevice save
> state
>=20
> This should help to avoid problems with accessing the device after
> migration/resume without PV drivers. Older systems will acquire
> the new record when migrated which should not change their state for
> worse.
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  hw/i386/xen/xen_pvdevice.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
> index c093b34..ef22a03 100644
> --- a/hw/i386/xen/xen_pvdevice.c
> +++ b/hw/i386/xen/xen_pvdevice.c
> @@ -71,6 +71,16 @@ static const MemoryRegionOps xen_pv_mmio_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>=20
> +static const VMStateDescription vmstate_xen_pvdevice =3D {
> +    .name =3D "xen-pvdevice",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, XenPVDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void xen_pv_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      XenPVDevice *d =3D XEN_PV_DEVICE(pci_dev);
> @@ -120,6 +130,7 @@ static void xen_pv_class_init(ObjectClass *klass, voi=
d
> *data)
>      k->class_id =3D PCI_CLASS_SYSTEM_OTHER;
>      dc->desc =3D "Xen PV Device";
>      dc->props =3D xen_pv_props;
> +    dc->vmsd =3D &vmstate_xen_pvdevice;
>  }
>=20
>  static const TypeInfo xen_pv_type_info =3D {
> --
> 2.7.4
