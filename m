Received: from eggs.gnu.org ([2001:4830:134:3::10]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cqUWg-0005dk-KD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 20:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cqUWd-0003AR-Gr
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 20:53:22 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:32944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cqUWd-0003AA-72
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 20:53:19 -0400
Received: by mail-pg0-x22f.google.com with SMTP id n190so101192567pga.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 17:53:18 -0700 (PDT)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <71BEDF9C-3FA5-4F2B-8763-5169B729103B@skyportsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 21 Mar 2017 17:53:16 -0700
In-Reply-To: <20170320170557.15645-2-lersek@redhat.com>
References: <20170320170557.15645-1-lersek@redhat.com>
	<20170320170557.15645-2-lersek@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/acpi/vmgenid: prevent device
 realization on pre-2.5 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


> On Mar 20, 2017, at 10:05 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> The WRITE_POINTER linker/loader command that underlies VMGENID depends =
on
> commit baf2d5bfbac0 ("fw-cfg: support writeable blobs", 2017-01-12), =
which
> in turn depends on fw_cfg DMA.
>=20
> DMA for fw_cfg is enabled in 2.5+ machine types only (see commit
> e6915b5f3a87, "fw_cfg: unbreak migration compatibility for 2.4 and =
earlier
> machines", 2016-02-18).
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ben Warren <ben@skyportsystems.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
> ---
>=20
> Notes:
>    v2:
>    - disable/enable vmgenid exactly in parallel with DMA support for =
fw_cfg
>      [Michael, Paolo]
>=20
> include/hw/acpi/vmgenid.h |  1 +
> include/hw/compat.h       |  4 ++++
> hw/acpi/vmgenid.c         | 14 ++++++++++++++
> 3 files changed, 19 insertions(+)
>=20
> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> index db7fa0e63303..8578476baebe 100644
> --- a/include/hw/acpi/vmgenid.h
> +++ b/include/hw/acpi/vmgenid.h
> @@ -21,6 +21,7 @@ typedef struct VmGenIdState {
>     DeviceClass parent_obj;
>     QemuUUID guid;                /* The 128-bit GUID seen by the =
guest */
>     uint8_t vmgenid_addr_le[8];   /* Address of the GUID =
(little-endian) */
> +    bool write_pointer_available;
> } VmGenIdState;
>=20
> static inline Object *find_vmgenid_dev(void)
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index fc8c3e060007..5d5be91daf59 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -131,6 +131,10 @@
>         .driver   =3D "fw_cfg_io",\
>         .property =3D "dma_enabled",\
>         .value    =3D "off",\
> +    },{\
> +        .driver   =3D "vmgenid",\
> +        .property =3D "x-write-pointer-available",\
> +        .value    =3D "off",\
>     },
>=20
> #define HW_COMPAT_2_3 \
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 7a3ad17d66ef..c3ddcc8e7cb0 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -205,9 +205,22 @@ static void vmgenid_handle_reset(void *opaque)
>     memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
> }
>=20
> +static Property vmgenid_properties[] =3D {
> +    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
> +                     write_pointer_available, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> static void vmgenid_realize(DeviceState *dev, Error **errp)
> {
>     VmGenIdState *vms =3D VMGENID(dev);
> +
> +    if (!vms->write_pointer_available) {
> +        error_setg(errp, "%s requires DMA write support in fw_cfg, "
> +                   "which this machine type does not provide", =
VMGENID_DEVICE);
> +        return;
> +    }
> +
>     qemu_register_reset(vmgenid_handle_reset, vms);
> }
>=20
> @@ -218,6 +231,7 @@ static void vmgenid_device_class_init(ObjectClass =
*klass, void *data)
>     dc->vmsd =3D &vmstate_vmgenid;
>     dc->realize =3D vmgenid_realize;
>     dc->hotpluggable =3D false;
> +    dc->props =3D vmgenid_properties;
>=20
>     object_class_property_add_str(klass, VMGENID_GUID, NULL,
>                                   vmgenid_set_guid, NULL);
> --=20
> 2.9.3
>=20
>=20
