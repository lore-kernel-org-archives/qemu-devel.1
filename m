Received: from eggs.gnu.org ([2001:4830:134:3::10]:48242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5z0-0001Oj-Mr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5yw-0006DT-KU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS5yw-0006Cr-Ap
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:21:58 -0400
Date: Mon, 3 Jul 2017 21:21:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703211927-mutt-send-email-mst@kernel.org>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170629132310.18865-2-marcandre.lureau@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, Ben Warren <ben@skyportsystems.com>

On Thu, Jun 29, 2017 at 03:23:04PM +0200, Marc-Andr=E9 Lureau wrote:
> This compat property sole function is to prevent the device from being
> instantiated. Instead of requiring an extra compat property, check if
> fw_cfg has DMA enabled.
>=20
> This has the additional benefit of handling other cases properly, like:
>=20
>   $ qemu-system-x86_64 -device vmgenid -machine none
>   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write suppo=
rt in fw_cfg, which this machine type does not provide
>   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global f=
w_cfg.dma_enabled=3Doff
>   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write suppo=
rt in fw_cfg, which this machine type does not provide
>   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global f=
w_cfg.dma_enabled=3Don
>   [boots normally]
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Looks like this can go in as a stand-alone patch.
I wasn't copied on rest of patchset so I'm not sure
who's merging that, but I think this one can be split out.


> ---
>  include/hw/acpi/bios-linker-loader.h | 2 ++
>  include/hw/compat.h                  | 4 ----
>  hw/acpi/bios-linker-loader.c         | 6 ++++++
>  hw/acpi/vmgenid.c                    | 9 +--------
>  4 files changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bio=
s-linker-loader.h
> index efe17b0b9c..a711dbced8 100644
> --- a/include/hw/acpi/bios-linker-loader.h
> +++ b/include/hw/acpi/bios-linker-loader.h
> @@ -7,6 +7,8 @@ typedef struct BIOSLinker {
>      GArray *file_list;
>  } BIOSLinker;
> =20
> +bool bios_linker_loader_can_write_pointer(void);
> +
>  BIOSLinker *bios_linker_loader_init(void);
> =20
>  void bios_linker_loader_alloc(BIOSLinker *linker,
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 26cd5851a5..36f02179ac 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -150,10 +150,6 @@
>          .driver   =3D "fw_cfg_io",\
>          .property =3D "dma_enabled",\
>          .value    =3D "off",\
> -    },{\
> -        .driver   =3D "vmgenid",\
> -        .property =3D "x-write-pointer-available",\
> -        .value    =3D "off",\
>      },
> =20
>  #define HW_COMPAT_2_3 \
> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.=
c
> index 046183a0f1..587d62cb93 100644
> --- a/hw/acpi/bios-linker-loader.c
> +++ b/hw/acpi/bios-linker-loader.c
> @@ -168,6 +168,12 @@ bios_linker_find_file(const BIOSLinker *linker, co=
nst char *name)
>      return NULL;
>  }
> =20
> +bool bios_linker_loader_can_write_pointer(void)
> +{
> +    FWCfgState *fw_cfg =3D fw_cfg_find();
> +    return fw_cfg && fw_cfg_dma_enabled(fw_cfg);
> +}
> +
>  /*
>   * bios_linker_loader_alloc: ask guest to load file into guest memory.
>   *
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index a32b847fe0..ab5da293fd 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -205,17 +205,11 @@ static void vmgenid_handle_reset(void *opaque)
>      memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
>  }
> =20
> -static Property vmgenid_properties[] =3D {
> -    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
> -                     write_pointer_available, true),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void vmgenid_realize(DeviceState *dev, Error **errp)
>  {
>      VmGenIdState *vms =3D VMGENID(dev);
> =20
> -    if (!vms->write_pointer_available) {
> +    if (!bios_linker_loader_can_write_pointer()) {
>          error_setg(errp, "%s requires DMA write support in fw_cfg, "
>                     "which this machine type does not provide", VMGENID=
_DEVICE);
>          return;
> @@ -239,7 +233,6 @@ static void vmgenid_device_class_init(ObjectClass *=
klass, void *data)
>      dc->vmsd =3D &vmstate_vmgenid;
>      dc->realize =3D vmgenid_realize;
>      dc->hotpluggable =3D false;
> -    dc->props =3D vmgenid_properties;
> =20
>      object_class_property_add_str(klass, VMGENID_GUID, NULL,
>                                    vmgenid_set_guid, NULL);
> --=20
> 2.13.1.395.gf7b71de06
