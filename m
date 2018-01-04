Received: from eggs.gnu.org ([2001:4830:134:3::10]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eX8K6-0007zF-Da
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eX8Ju-0006tM-T0
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:24:54 -0500
Date: Thu, 4 Jan 2018 16:24:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180104162400.GB2618@work-vm>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180104144046.30793-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] hw/net/e1000: real device name is
 'e1000-82540em', 'e1000' is an alias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/net/e1000.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 05a00cba31..2280f7fdf9 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1648,6 +1648,7 @@ typedef struct E1000Info {
>      uint16_t   device_id;
>      uint8_t    revision;
>      uint16_t   phy_id2;
> +    const char **aliases;
>  } E1000Info;
> =20
>  static void e1000_class_init(ObjectClass *klass, void *data)
> @@ -1695,10 +1696,11 @@ static const TypeInfo e1000_base_info =3D {
> =20
>  static const E1000Info e1000_devices[] =3D {
>      {
> -        .name      =3D "e1000",
> +        .name      =3D "e1000-82540em",
>          .device_id =3D E1000_DEV_ID_82540EM,
>          .revision  =3D 0x03,
>          .phy_id2   =3D E1000_PHY_ID2_8254xx_DEFAULT,
> +        .aliases   =3D (const char * []) {"e1000", NULL},
>      },
>      {
>          .name      =3D "e1000-82544gc",
> @@ -1725,6 +1727,7 @@ static void e1000_register_types(void)
> =20
>          type_info.name =3D info->name;
>          type_info.parent =3D TYPE_E1000_BASE;
> +        type_info.aliases =3D info->aliases;
>          type_info.class_data =3D (void *)info;
>          type_info.class_init =3D e1000_class_init;
>          type_info.instance_init =3D e1000_instance_init;

Can you just check that this doesn't break migration compatibility
either way please;  I think there's some alias code somewhere but I
can't remember the details.

One thing I do remember that broke when it previously changed was
entries in PC_COMPAT_* tables like the one in hw/i386/pc_piix.c's
PC_COMPAT_1_3 - so check with an 'info qtree' that the property is OK.

Dave

> --=20
> 2.15.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
