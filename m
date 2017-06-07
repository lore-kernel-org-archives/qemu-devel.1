Received: from eggs.gnu.org ([2001:4830:134:3::10]:60895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIfT7-0004RI-Tw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIfT4-00063L-OO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:14:09 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:36613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIfT4-000630-In
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:14:06 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 379D86F26F
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 20:14:05 +0200 (CEST)
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685583778.12025.272004316108066026.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f1659c4-0bad-a3d1-91fc-a0a802f21fa5@kaod.org>
Date: Wed, 7 Jun 2017 20:14:01 +0200
MIME-Version: 1.0
In-Reply-To: <149685583778.12025.272004316108066026.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] xics: directly register ICPState
 objects to vmstate
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

On 06/07/2017 07:17 PM, Greg Kurz wrote:
> The ICPState objects are currently registered to vmstate as qdev object=
s.
> Their instance ids are hence computed automatically in the migration co=
de,
> and thus depends on the order the CPU cores were plugged.
>=20
> If the destination had its CPU cores plugged in a different order than =
the
> source, then ICPState objects will have different instance_ids and load
> the wrong state.
>=20
> Since CPU objects have a reliable cpu_index which is already used as
> instance_id in vmstate, let's use it for ICPState as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 330441ff7fe8..3d76b43876c5 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -348,10 +348,14 @@ static void icp_realize(DeviceState *dev, Error *=
*errp)
>      }
> =20
>      qemu_register_reset(icp_reset, dev);
> +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, ic=
p);

so, what I just said in the previous email regarding ->cs would break thi=
s=20
patch. Forget about it.=20


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

>  }
> =20
>  static void icp_unrealize(DeviceState *dev, Error **errp)
>  {
> +    ICPState *icp =3D ICP(dev);
> +
> +    vmstate_unregister(NULL, &vmstate_icp_server, icp);
>      qemu_unregister_reset(icp_reset, dev);
>  }
> =20
> @@ -359,7 +363,6 @@ static void icp_class_init(ObjectClass *klass, void=
 *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->vmsd =3D &vmstate_icp_server;
>      dc->realize =3D icp_realize;
>      dc->unrealize =3D icp_unrealize;
>  }
>=20
