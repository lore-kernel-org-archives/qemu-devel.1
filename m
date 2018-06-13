Received: from eggs.gnu.org ([2001:4830:134:3::10]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT2IN-0004ZS-Tn
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT2IK-0000W3-0B
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:27 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:56945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT2IJ-0000P2-Nx
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:23 -0400
Received: from player770.ha.ovh.net (unknown [10.109.105.78])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 11A8DB5B56
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:42:15 +0200 (CEST)
Date: Wed, 13 Jun 2018 11:42:07 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613114207.32431053@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
	<20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
	<e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 13 Jun 2018 11:14:57 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> >> index 13ad7d9e04..efb68226bb 100644
> >> --- a/hw/ppc/pnv_core.c
> >> +++ b/hw/ppc/pnv_core.c
> >> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
> >> =20
> >>          snprintf(name, sizeof(name), "thread[%d]", i);
> >>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> >> +        if (local_err) {
> >> +            goto err;
> >> +        }
> >>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> >>                                    "pir", &local_err);
> >>          if (local_err) { =20
> >=20
> > Hmm... the current error path seems to assume failures to be
> > caused by object_property_add_child(). It hence unparents the
> > previously parented CPUs, but not the current one. So we'll
> > miss one call to object_unparent() if object_property_add_alias()
> > fails. =20
>=20
> yes, let's just put NULL or &error_abort instead.
>=20

NULL means we really don't care if the call fails or succeeds.

&error_abort means we consider a failure to be a unrecoverable bug.

So I would rather pass &error_abort here.

But if the guest is already running and functional, and we hit
the error during hotplug, does the guest really deserve to be
aborted or should we just fail the hotplug ?

> C.=20
