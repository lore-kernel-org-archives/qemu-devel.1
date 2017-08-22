Received: from eggs.gnu.org ([2001:4830:134:3::10]:41262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dkA74-00018t-Nx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dkA6z-0006lJ-QX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:02 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:41543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dkA6z-0006gv-Jy
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:24:57 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B6B9676D96
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 16:24:49 +0200 (CEST)
References: <1503406059-7280-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dcd40ede-4c47-9f61-6082-c5d85e0903f6@kaod.org>
Date: Tue, 22 Aug 2017 16:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <1503406059-7280-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/aspeed_soc: Mark devices as
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>, qemu-devel@nongnu.org

On 08/22/2017 02:47 PM, Thomas Huth wrote:
> QEMU currently aborts if the user is accidentially trying to
> do something like this:
>=20
> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add ast2400
> Unexpected error in error_set_from_qdev_prop_error()
>  at hw/core/qdev-properties.c:1032:
> Aborted (core dumped)
>=20
> The ast2400 SoC devices are clearly not creatable by the user since
> they are using the serial_hds and nd_table arrays directly in their
> realize function, so mark them with user_creatable =3D false.

yes. I suppose we don't need to instantiate such an object without=20
the machine. And even for unit tests, we would rather use the=20
individual controller models.

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/arm/aspeed_soc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 5529024..7f1be04 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -338,6 +338,8 @@ static void aspeed_soc_class_init(ObjectClass *oc, =
void *data)
> =20
>      sc->info =3D (AspeedSoCInfo *) data;
>      dc->realize =3D aspeed_soc_realize;
> +    /* Reason: Uses serial_hds and nd_table in realize() directly */
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo aspeed_soc_type_info =3D {
>=20
