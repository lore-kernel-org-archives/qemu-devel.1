Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dJ1Cn-0006NJ-1Y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dJ1Ck-0005RC-A4
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:26:45 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:44110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dJ1Ck-0005Q4-3k
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:26:42 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9964A6C7E9
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 19:26:40 +0200 (CEST)
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
	<018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
	<20170608174559.053df142@bahia.ttt.fr.ibm.com>
	<a5d61649-5e45-7e36-b5ac-06dbf14a71a3@kaod.org>
	<20170608190041.79e55b43@bahia.ttt.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9fdf8493-625a-561f-ca07-e56a3bd797cf@kaod.org>
Date: Thu, 8 Jun 2017 19:26:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170608190041.79e55b43@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/6] xics: introduce macros for ICP/ICS
 link properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/08/2017 07:00 PM, Greg Kurz wrote:
> On Thu, 8 Jun 2017 18:08:44 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>>>>> FWIW, other people do that as well (see hw/i386/pc_q35.c for exampl=
e).   =20
>>>>
>>>> well, I don't see the benefits of changing a string constant by a=20
>>>> define.=20
>>>> =20
>>>
>>> Improved semantics,  especially since the "xics" string appears in=20
>>> many places with different meanings.  =20
>>
>> ah ? If so, we should do a cleanup up. The code seems consistent from=20
>> what I can see. xics is a general name for :
>>
>> 	'PowerPC interrupt controller (type 2)'=20
>>
>> and it is mostly used as a prefix. There are no "xics" object, only a=20
>=20
> I'm only talking about "xics" as a property name actually:
>=20
> $ git grep '"xics"'
> hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xics"=
, &err);
> hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xics"=
, &err);
> hw/ppc/pnv.c:    object_property_add_const_link(OBJECT(&chip->psi), "xi=
cs",
> hw/ppc/pnv.c:        object_property_add_const_link(OBJECT(pnv_core), "=
xics",
> hw/ppc/pnv_core.c:    object_property_add_const_link(obj, "xics", OBJEC=
T(xi), &error_abort);
> hw/ppc/pnv_core.c:    xi =3D object_property_get_link(OBJECT(dev), "xic=
s", &local_err);
> hw/ppc/pnv_psi.c:    obj =3D object_property_get_link(OBJECT(dev), "xic=
s", &err);
> hw/ppc/pnv_psi.c:    object_property_add_const_link(OBJECT(ics), "xics"=
, obj,  &error_abort);
> hw/ppc/spapr.c:    object_property_add_const_link(obj, "xics", OBJECT(s=
papr), &error_abort);
> hw/ppc/spapr_cpu_core.c:    object_property_add_const_link(obj, "xics",=
 OBJECT(spapr), &error_abort);
>=20
> You have to read the code to know which ones are related.

The "xics" property link always point to the same object :=20
the XICSFabric object which is the machine, spapr or pnv.=20

> With this patch applied, it is mostly obvious, even for the newbie:

ah. the goal is to know where in the code the link was set.=20
It can be even more complex with aliases.

Cheers,

C.

>=20
> $ git grep -E 'IC._PROP_XICS|"xics"'
> hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), ICP_PR=
OP_XICS, &err);
> hw/intc/xics.c:        error_setg(errp, "%s: required link '" ICP_PROP_=
XICS "' not found: %s",
> hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), ICS_PR=
OP_XICS, &err);
> hw/intc/xics.c:        error_setg(errp, "%s: required link '" ICS_PROP_=
XICS "' not found: %s",
>=20
> hw/ppc/pnv.c:    object_property_add_const_link(OBJECT(&chip->psi), "xi=
cs",
> hw/ppc/pnv.c:        object_property_add_const_link(OBJECT(pnv_core), "=
xics",
>=20
> these two ^^ are related to...
>=20
> hw/ppc/pnv_core.c:    object_property_add_const_link(obj, ICP_PROP_XICS=
, OBJECT(xi),
>=20
> hw/ppc/pnv_core.c:    xi =3D object_property_get_link(OBJECT(dev), "xic=
s", &local_err);
> hw/ppc/pnv_psi.c:    obj =3D object_property_get_link(OBJECT(dev), "xic=
s", &err);
>=20
> these two ^^
>=20
> hw/ppc/pnv_psi.c:    object_property_add_const_link(OBJECT(ics), ICS_PR=
OP_XICS, obj,
> hw/ppc/spapr.c:    object_property_add_const_link(obj, ICS_PROP_XICS, O=
BJECT(spapr),
> hw/ppc/spapr_cpu_core.c:    object_property_add_const_link(obj, ICP_PRO=
P_XICS, OBJECT(spapr),
> include/hw/ppc/xics.h:#define ICP_PROP_XICS "xics"
> include/hw/ppc/xics.h:#define ICS_PROP_XICS "xics"
>=20
>> XICSFabric which is a QOM interface of the machine with a bunch of=20
>> handlers. It worked out pretty well for sPAPR and PowerNV.
>>
>> It won't be the case for XIVE, the interrupt controller (type 3) for=20
>> the P9. It is more complex and there are quite a lot of internal=20
>> states which will need to be gathered under an object. We can keep=20
>> the ICPState fortunately but the sources are quite different.
>>
>> C.
>>
>=20
