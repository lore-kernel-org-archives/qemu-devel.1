Received: from eggs.gnu.org ([2001:4830:134:3::10]:38202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evmyu-0004H9-Cf
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evmyq-0006bD-0d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:40:56 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 13 Mar 2018 16:40:38 +0000
Message-ID: <MWHPR21MB01892B2C5E46E3189C9898A49ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-5-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-5-peter.maydell@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/9] hw/arm/bcm2386: Fix parent type of
 bcm2386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

> From: Qemu-devel <qemu-devel-
> bounces+andrew.baumann=3Dmicrosoft.com@nongnu.org> On Behalf Of Peter
> Maydell
> Sent: Tuesday, 13 March 2018 08:35
>=20
> The TypeInfo and state struct for bcm2386 disagree about what the
> parent class is -- the TypeInfo says it's TYPE_SYS_BUS_DEVICE,
> but the BCM2386State struct only defines the parent_obj field
> as DeviceState. This would have caused problems if anything
> actually tried to treat the object as a TYPE_SYS_BUS_DEVICE.
> Fix the TypeInfo to use TYPE_DEVICE as the parent, since we don't
> need any of the additional functionality TYPE_SYS_BUS_DEVICE
> provides.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I noticed this when I tried to make the type into one which
> has its own class struct, because we hit the assert that the
> child's class struct had better be bigger than the parent's.
> ---
>  hw/arm/bcm2836.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 40e8b25a46..9266f27c14 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -165,7 +165,7 @@ static void bcm2836_class_init(ObjectClass *oc, void
> *data)
>=20
>  static const TypeInfo bcm2836_type_info =3D {
>      .name =3D TYPE_BCM2836,
> -    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .parent =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(BCM2836State),
>      .instance_init =3D bcm2836_init,
>      .class_init =3D bcm2836_class_init,

Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>

Thanks for catching this -- it looks like bcm2835.c (which never got merged=
) has the same bug, and I copied it along.
