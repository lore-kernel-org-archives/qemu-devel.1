Received: from eggs.gnu.org ([2001:4830:134:3::10]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0w7-00080K-7P
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0w2-0000dv-7l
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:15:23 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT0w1-0000ca-Td
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:15:18 -0400
Received: from player697.ha.ovh.net (unknown [10.109.105.21])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6ED43107C99
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:15:16 +0200 (CEST)
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdf40ba1-b9da-cc37-32fa-8aec4e6e254f@kaod.org>
Date: Wed, 13 Jun 2018 10:15:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180613065707.30766-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during
 cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/13/2018 08:57 AM, David Gibson wrote:
> In pnv_core_realize() we call two functions with an Error * parameter i=
n
> succession, which means if they both cause errors we'll lose the first =
one.
> Add an extra test/escape to fix this.

I tend now to pass just NULL or &error_abort to object_property_add_child=
()=20
and object_property_add_const_link(). These calls should just not fail.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 13ad7d9e04..efb68226bb 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> =20
>          snprintf(name, sizeof(name), "thread[%d]", i);
>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> +        if (local_err) {
> +            goto err;
> +        }
>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
>                                    "pir", &local_err);
>          if (local_err) {
>=20
