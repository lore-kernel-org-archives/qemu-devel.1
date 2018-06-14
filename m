Received: from eggs.gnu.org ([2001:4830:134:3::10]:33655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTKmY-000333-7E
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTKmV-0003x6-44
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:26:50 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:39534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTKmU-0003wC-TI
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:26:47 -0400
Received: from player692.ha.ovh.net (unknown [10.109.120.40])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id CE23AE4B1A
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 07:26:44 +0200 (CEST)
References: <20180614044129.13606-1-david@gibson.dropbear.id.au>
	<20180614044129.13606-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <98f639e5-316f-d3c4-ffb2-9762b5b618d8@kaod.org>
Date: Thu, 14 Jun 2018 07:26:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180614044129.13606-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 2/7] pnv: Fix some error handling cpu
 realize()
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

On 06/14/2018 06:41 AM, David Gibson wrote:
> In pnv_core_realize() we call two functions with an Error * parameter i=
n
> succession, which will go badly if they both cause errors.  In fact, a
> failure in either of them indicates a qemu internal error, so we can ju=
st
> use &error_abort in both cases.

Yes. I think that most of the object_property_add_child() could use
&error_abort, object_property_add_const_link() also.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20


> ---
>  hw/ppc/pnv_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 13ad7d9e04..01f47c8037 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -172,12 +172,9 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
>          object_initialize(obj, size, typename);
> =20
>          snprintf(name, sizeof(name), "thread[%d]", i);
> -        object_property_add_child(OBJECT(pc), name, obj, &local_err);
> +        object_property_add_child(OBJECT(pc), name, obj, &error_abort)=
;
>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> -                                  "pir", &local_err);
> -        if (local_err) {
> -            goto err;
> -        }
> +                                  "pir", &error_abort);
>          object_unref(obj);
>      }
> =20
>=20
