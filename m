Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIf5D-00014b-FF
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIf5A-0005WK-Tw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:49:27 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:56179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIf5A-0005W2-Nm
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:49:24 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3608F7065A
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:49:23 +0200 (CEST)
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685581222.12025.5541302490723329093.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdabdcdb-c373-f248-95da-676bf30a22ea@kaod.org>
Date: Wed, 7 Jun 2017 19:49:14 +0200
MIME-Version: 1.0
In-Reply-To: <149685581222.12025.5541302490723329093.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] pnv_core: drop reference on
 ICPState object during CPU realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/07/2017 07:16 PM, Greg Kurz wrote:
> Similarly to what was done to spapr with commit 249127d0dfeb, this patc=
h
> ensures that we don't keep an extra reference on the ICPState object. A=
lso
> since the object was just created and not reparented yet, the call to
> object_property_add_child() should never fail: let's pass &error_abort =
to
> make this clear.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  hw/ppc/pnv_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 1b7ec70f033d..e8a9a94d5a24 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -119,7 +119,8 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
>      Object *obj;
> =20
>      obj =3D object_new(TYPE_PNV_ICP);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
> +    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> +    object_unref(obj);
>      object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abo=
rt);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>=20
