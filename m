Received: from eggs.gnu.org ([2001:4830:134:3::10]:40926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evn6s-00032M-0x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evn6r-0001UC-71
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:49:10 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 13 Mar 2018 16:48:56 +0000
Message-ID: <MWHPR21MB01894A8E274ED18E666D43019ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-8-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-8-peter.maydell@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 7/9] hw/arm/bcm2836: Use correct affinity
 values for BCM2837
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Pekka Enberg <penberg@iki.fi>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Tuesday, 13 March 2018 08:35
>=20
> The BCM2837 sets the Aff1 field of the MPIDR affinity values for the
> CPUs to 0, whereas the BCM2836 uses 0xf. Set this correctly, as it
> is required for Linux to boot.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/bcm2836.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 07d2705f96..7140257c98 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,14 +25,17 @@
>=20
>  struct BCM283XInfo {
>      const char *name;
> +    int clusterid;
>  };
>=20
>  static const BCM283XInfo bcm283x_socs[] =3D {
>      {
>          .name =3D TYPE_BCM2836,
> +        .clusterid =3D 0xf,
>      },
>      {
>          .name =3D TYPE_BCM2837,
> +        .clusterid =3D 0x0,
>      },
>  };
>=20
> @@ -58,6 +61,8 @@ static void bcm2836_init(Object *obj)
>  static void bcm2836_realize(DeviceState *dev, Error **errp)
>  {
>      BCM283XState *s =3D BCM283X(dev);
> +    BCM283XClass *bc =3D BCM283X_GET_CLASS(dev);
> +    const BCM283XInfo *info =3D bc->info;
>      Object *obj;
>      Error *err =3D NULL;
>      int n;
> @@ -119,7 +124,7 @@ static void bcm2836_realize(DeviceState *dev, Error
> **errp)
>          /* Mirror bcm2836, which has clusterid set to 0xf

The first line of this comment should probably move or just be deleted. It'=
s not relevant here.

>           * TODO: this should be converted to a property of ARM_CPU
>           */
> -        s->cpus[n].mp_affinity =3D 0xF00 | n;
> +        s->cpus[n].mp_affinity =3D (info->clusterid << 8) | n;
>=20
>          /* set periphbase/CBAR value for CPU-local registers */
>          object_property_set_int(OBJECT(&s->cpus[n]),

Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
