Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dRVGi-0003cO-2A
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dRVGe-0000z4-PU
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:09:52 -0400
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:35630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dRVGe-0000yP-J4
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:09:48 -0400
Received: by mail-it0-x22f.google.com with SMTP id v202so75547929itb.0
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 20:09:47 -0700 (PDT)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <319FA821-7EF0-4670-BA23-74C6E44D4477@skyportsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sat, 1 Jul 2017 23:09:45 -0400
In-Reply-To: <20170629132310.18865-2-marcandre.lureau@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-2-marcandre.lureau@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] vmgenid: replace
 x-write-pointer-available hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

Nice improvement!
> On Jun 29, 2017, at 9:23 AM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@redhat.com> wrote:
>=20
> This compat property sole function is to prevent the device from being
> instantiated. Instead of requiring an extra compat property, check if
> fw_cfg has DMA enabled.
>=20
> This has the additional benefit of handling other cases properly, =
like:
>=20
>  $ qemu-system-x86_64 -device vmgenid -machine none
>  qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write =
support in fw_cfg, which this machine type does not provide
>  $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global =
fw_cfg.dma_enabled=3Doff
>  qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write =
support in fw_cfg, which this machine type does not provide
>  $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global =
fw_cfg.dma_enabled=3Don
>  [boots normally]
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com <mailto:mst@redhat.com>>
> ---
> include/hw/acpi/bios-linker-loader.h | 2 ++
> include/hw/compat.h                  | 4 ----
> hw/acpi/bios-linker-loader.c         | 6 ++++++
> hw/acpi/vmgenid.c                    | 9 +--------
> 4 files changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/hw/acpi/bios-linker-loader.h =
b/include/hw/acpi/bios-linker-loader.h
> index efe17b0b9c..a711dbced8 100644
> --- a/include/hw/acpi/bios-linker-loader.h
> +++ b/include/hw/acpi/bios-linker-loader.h
> @@ -7,6 +7,8 @@ typedef struct BIOSLinker {
>     GArray *file_list;
> } BIOSLinker;
>=20
> +bool bios_linker_loader_can_write_pointer(void);
> +
> BIOSLinker *bios_linker_loader_init(void);
>=20
> void bios_linker_loader_alloc(BIOSLinker *linker,
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 26cd5851a5..36f02179ac 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -150,10 +150,6 @@
>         .driver   =3D "fw_cfg_io",\
>         .property =3D "dma_enabled",\
>         .value    =3D "off",\
> -    },{\
> -        .driver   =3D "vmgenid",\
> -        .property =3D "x-write-pointer-available",\
> -        .value    =3D "off",\
>     },
>=20
> #define HW_COMPAT_2_3 \
> diff --git a/hw/acpi/bios-linker-loader.c =
b/hw/acpi/bios-linker-loader.c
> index 046183a0f1..587d62cb93 100644
> --- a/hw/acpi/bios-linker-loader.c
> +++ b/hw/acpi/bios-linker-loader.c
> @@ -168,6 +168,12 @@ bios_linker_find_file(const BIOSLinker *linker, =
const char *name)
>     return NULL;
> }
>=20
> +bool bios_linker_loader_can_write_pointer(void)
> +{
> +    FWCfgState *fw_cfg =3D fw_cfg_find();
> +    return fw_cfg && fw_cfg_dma_enabled(fw_cfg);
> +}
> +
> /*
>  * bios_linker_loader_alloc: ask guest to load file into guest memory.
>  *
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index a32b847fe0..ab5da293fd 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -205,17 +205,11 @@ static void vmgenid_handle_reset(void *opaque)
>     memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
> }
>=20
> -static Property vmgenid_properties[] =3D {
> -    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
> -                     write_pointer_available, true),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> static void vmgenid_realize(DeviceState *dev, Error **errp)
> {
>     VmGenIdState *vms =3D VMGENID(dev);
>=20
> -    if (!vms->write_pointer_available) {
> +    if (!bios_linker_loader_can_write_pointer()) {
>         error_setg(errp, "%s requires DMA write support in fw_cfg, "
>                    "which this machine type does not provide", =
VMGENID_DEVICE);
>         return;
> @@ -239,7 +233,6 @@ static void vmgenid_device_class_init(ObjectClass =
*klass, void *data)
>     dc->vmsd =3D &vmstate_vmgenid;
>     dc->realize =3D vmgenid_realize;
>     dc->hotpluggable =3D false;
> -    dc->props =3D vmgenid_properties;
>=20
>     object_class_property_add_str(klass, VMGENID_GUID, NULL,
>                                   vmgenid_set_guid, NULL);
> --=20
> 2.13.1.395.gf7b71de06
>=20
