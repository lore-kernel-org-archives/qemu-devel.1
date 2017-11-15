Received: from eggs.gnu.org ([2001:4830:134:3::10]:56832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eErPj-0003dX-UO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eErPf-0001oE-Ve
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:43:11 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:44098
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1eErPf-0001my-Li
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:43:07 -0500
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
	<1510625498-4821-8-git-send-email-jasowang@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <e84e4b9f-8a88-5c68-8440-96df5bef1ad5@weilnetz.de>
Date: Wed, 15 Nov 2017 07:43:00 +0100
MIME-Version: 1.0
In-Reply-To: <1510625498-4821-8-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 7/8] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, "Michael S. Tsirkin" <mst@redhat.com>

Hi,

I currently think that this patch is wrong and should be reverted.

It fixes a certain use case by hacking the PCI device id, but does
not model the way how that device id is set on the real hardware
correctly.

As far as I know, all i82559 have a default PCI device id of 0x1229.
It can be changed by the EEPROM configuration, but not all network
cards do have an EEPROM.

See for example this URL for more information:
http://zoo.cs.yale.edu/classes/cs422/2010/ref/82559_eeprom.pdf

The correct solution is modeling the EEPROM and allowing QEMU
users to provide an EEPROM=E2=80=8C file.

Cheers
Stefan

Am 14.11.2017 um 03:11 schrieb Jason Wang:
> From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>=20
> Adds a new PCI ID for the i82559a (0x8086 0x1030) interface. The
> "x-use-alt-device-id" property controls whether this new ID is to be
> used, and is true by default, and set to false in a compat entry.
>=20
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/eepro100.c    | 13 +++++++++++++
>  include/hw/compat.h  |  4 ++++
>  include/hw/pci/pci.h |  1 +
>  qemu-options.hx      |  2 +-
>  4 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 91dd058..a63ed2c 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -132,6 +132,7 @@ typedef struct {
>      const char *name;
>      const char *desc;
>      uint16_t device_id;
> +    uint16_t alt_device_id;
>      uint8_t revision;
>      uint16_t subsystem_vendor_id;
>      uint16_t subsystem_id;
> @@ -276,6 +277,7 @@ typedef struct {
>      /* Quasi static device properties (no need to save them). */
>      uint16_t stats_size;
>      bool has_extended_tcb_support;
> +    bool use_alt_device_id;
>  } EEPRO100State;
> =20
>  /* Word indices in EEPROM. */
> @@ -1855,6 +1857,14 @@ static void e100_nic_realize(PCIDevice *pci_dev,=
 Error **errp)
> =20
>      TRACE(OTHER, logout("\n"));
> =20
> +    /* By default, the i82559a adapter uses the legacy PCI ID (for the
> +     * i82557). This allows the PCI ID to be changed to the alternate
> +     * i82559 ID if needed.
> +     */
> +    if (s->use_alt_device_id && strcmp(info->name, "i82559a") =3D=3D 0=
) {
> +        pci_config_set_device_id(s->dev.config, info->alt_device_id);
> +    }
> +
>      s->device =3D info->device;
> =20
>      e100_pci_reset(s, &local_err);
> @@ -1974,6 +1984,7 @@ static E100PCIDeviceInfo e100_devices[] =3D {
>          .desc =3D "Intel i82559A Ethernet",
>          .device =3D i82559A,
>          .device_id =3D PCI_DEVICE_ID_INTEL_82557,
> +        .alt_device_id =3D PCI_DEVICE_ID_INTEL_82559,
>          .revision =3D 0x06,
>          .stats_size =3D 80,
>          .has_extended_tcb_support =3D true,
> @@ -2067,6 +2078,8 @@ static E100PCIDeviceInfo *eepro100_get_class(EEPR=
O100State *s)
> =20
>  static Property e100_properties[] =3D {
>      DEFINE_NIC_PROPERTIES(EEPRO100State, conf),
> +    DEFINE_PROP_BOOL("x-use-alt-device-id", EEPRO100State, use_alt_dev=
ice_id,
> +                     true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index cf389b4..f96212c 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -10,6 +10,10 @@
>          .driver   =3D "virtio-tablet-device",\
>          .property =3D "wheel-axis",\
>          .value    =3D "false",\
> +    },{\
> +        .driver   =3D "i82559a",\
> +        .property =3D "x-use-alt-device-id",\
> +        .value    =3D "false",\
>      },
> =20
>  #define HW_COMPAT_2_9 \
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 8d02a0a..f30e2cf 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -70,6 +70,7 @@ extern bool pci_available;
>  /* Intel (0x8086) */
>  #define PCI_DEVICE_ID_INTEL_82551IT      0x1209
>  #define PCI_DEVICE_ID_INTEL_82557        0x1229
> +#define PCI_DEVICE_ID_INTEL_82559        0x1030
>  #define PCI_DEVICE_ID_INTEL_82801IR      0x2922
> =20
>  /* Red Hat / Qumranet (for QEMU) -- see pci-ids.txt */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b..a39c7e4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2047,7 +2047,7 @@ that the card should have; this option currently =
only affects virtio cards; set
>  @var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specifie=
d, a single
>  NIC is created.  QEMU can emulate several different models of network =
card.
>  Valid values for @var{type} are
> -@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
> +@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559a}, @code{i8=
2559er},
>  @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
>  @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
>  Not all devices are supported on all targets.  Use @code{-net nic,mode=
l=3Dhelp}
>=20
