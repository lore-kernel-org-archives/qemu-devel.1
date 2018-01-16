Received: from eggs.gnu.org ([2001:4830:134:3::10]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebFWc-0006Sg-VP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebFWZ-0007eL-Rk
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:54:51 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebFWZ-0007e3-Lf
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:54:47 -0500
Received: by mail-qt0-x242.google.com with SMTP id u42so16350119qte.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:54:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b706db4f-b103-9433-9973-762c7c594005@amsat.org>
Date: Mon, 15 Jan 2018 21:54:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="BN1wGFmM8zKlJ4uWfjOhiJ1wWSuOrJSFJ"
Subject: Re: [Qemu-devel] [PATCH] sun4u: implement power device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BN1wGFmM8zKlJ4uWfjOhiJ1wWSuOrJSFJ
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <b706db4f-b103-9433-9973-762c7c594005@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] sun4u: implement power device
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

CC'ing PCI maintainers.

Hi Mark,

On 01/15/2018 05:58 PM, Mark Cave-Ayland wrote:
> This inbuilt device contains a single 4-byte register, of which bit 24 =
is used
> to power down the machine on a real Ultra 5.
>=20
> The power device exists at offset 0x724000 on a real machine, but due t=
o the
> current configuration of the BARs in QEMU it must be located lower in P=
CI IO
> space.
Is is some issue in pci_bar_address()?

>=20
> For the moment we place the power device at offset 0x7240 as a reminder=
 of its
> original location and raise the base PCI IO address from 0x4000 to 0x80=
00.

If we can't fix it, I rather prefer a #define with a comment in the
code, IMHO this is safer and easier to remember than looking in git histo=
ry.

>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc64/sun4u.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index ec45ec2801..26ab6e9a9c 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -205,6 +205,59 @@ typedef struct ResetData {
>      uint64_t prom_addr;
>  } ResetData;
> =20
> +#define TYPE_SUN4U_POWER "power"
> +#define SUN4U_POWER(obj) OBJECT_CHECK(PowerDevice, (obj), TYPE_SUN4U_P=
OWER)
> +
> +typedef struct PowerDevice {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion power_mmio;
> +} PowerDevice;
> +
> +/* Power */
> +static void power_mem_write(void *opaque, hwaddr addr,
> +                            uint64_t val, unsigned size)
> +{
> +    /* According to a real Ultra 5, bit 24 controls the power */
> +    if (val & 0x1000000) {
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    }
> +}
> +
> +static const MemoryRegionOps power_mem_ops =3D {
> +    .write =3D power_mem_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void power_realize(DeviceState *dev, Error **errp)
> +{
> +    PowerDevice *d =3D SUN4U_POWER(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&d->power_mmio, OBJECT(dev), &power_mem_ops,=
 d,
> +                          "power", sizeof(uint32_t));
> +
> +    sysbus_init_mmio(sbd, &d->power_mmio);
> +}
> +
> +static void power_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D power_realize;
> +}
> +
> +static const TypeInfo power_info =3D {
> +    .name          =3D TYPE_SUN4U_POWER,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(PowerDevice),
> +    .class_init    =3D power_class_init,
> +};
> +
>  static void ebus_isa_irq_handler(void *opaque, int n, int level)
>  {
>      EbusState *s =3D EBUS(opaque);
> @@ -221,6 +274,7 @@ static void ebus_isa_irq_handler(void *opaque, int =
n, int level)
>  static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      EbusState *s =3D EBUS(pci_dev);
> +    SysBusDevice *sbd;
>      DeviceState *dev;
>      qemu_irq *isa_irq;
>      DriveInfo *fd[MAX_FD];
> @@ -270,6 +324,13 @@ static void ebus_realize(PCIDevice *pci_dev, Error=
 **errp)
>      qdev_prop_set_uint32(dev, "dma", -1);
>      qdev_init_nofail(dev);
> =20
> +    /* Power */
> +    dev =3D qdev_create(NULL, TYPE_SUN4U_POWER);
> +    qdev_init_nofail(dev);
> +    sbd =3D SYS_BUS_DEVICE(dev);
> +    memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240,=

> +                                sysbus_mmio_get_region(sbd, 0));
> +
>      /* PCI */
>      pci_dev->config[0x04] =3D 0x06; // command =3D bus master, pci mem=

>      pci_dev->config[0x05] =3D 0x00;
> @@ -282,7 +343,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error =
**errp)
>                               0, 0x1000000);
>      pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->ba=
r0);
>      memory_region_init_alias(&s->bar1, OBJECT(s), "bar1", get_system_i=
o(),
> -                             0, 0x4000);
> +                             0, 0x8000);

What about using 2 MR, bar1_lo/bar1_hi, registering bar1_lo at offset @0
and bar1_hi at @0x724000?

>      pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);=

>  }
> =20
> @@ -693,6 +754,7 @@ static const TypeInfo sun4v_type =3D {
> =20
>  static void sun4u_register_types(void)
>  {
> +    type_register_static(&power_info);
>      type_register_static(&ebus_info);
>      type_register_static(&prom_info);
>      type_register_static(&ram_info);
>=20


--BN1wGFmM8zKlJ4uWfjOhiJ1wWSuOrJSFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpdTU4ACgkQ4+MsLN6t
wN6zUBAAl5mmRa2fBspbnVZxPhDeuxYhh5ZVUQ9oUXmel/YQxTOzZyJvNq9tL7bD
K1FJkUDSDH0qu1AU3zIqdxGU/Xzsvr9w1OvzPuRM73JPogxsST/sNhhyQLPBM8Hc
WbRpaVsOEOIulT3HFbL1S8SiChxcjQIFiHjI0EDu474AJ0UFcrhzz7B3641rrbOO
ptv14RJRlpq2mb2CgztS8H2y4lgyKIK7QCzPIlEWBGZhIrmRtg7RpFA0NowNDAL+
lFD8NXLtqyEgoN/mnyAG0IHWzugAhH8St3wxcsT487C/BFxZueMCCyl/xwvr8Fi7
kpZzyzqHqzZkioTF8feX9jO+TL4S/4AAAJnw4P7s7x6zSSzl1dVcTFtNruZSauWH
P8Nckvtb79Jd64Zws3qmQTSgw+3Sc5wx8CSAcqJB92vl8d7UA6ADZ17zafGxzswi
Ko6RQ75rl+gRt94GP2lOCIuSGPmgL/yLGR5rm9DJQ2YI2yilwWuiL8mhA4EXeTjG
3krXJJWyBNig6+YafdnJtinNPB/dFLXYt2OZhnIo77MpTimSnxkBoTyUb1HW75pq
o9WFJoVeRzGpZIpTx5OFYMvZDJADlmBmik/P2hNMnacYSN7XSyK6vVIVKCGLQQJ4
hEyhm6UA7aJuI4qv9MSptQ3S56B9mLEemJNdATQxmJmTSfGtyr4=
=Z2wI
-----END PGP SIGNATURE-----

--BN1wGFmM8zKlJ4uWfjOhiJ1wWSuOrJSFJ--
