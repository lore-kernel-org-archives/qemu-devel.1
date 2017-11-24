Received: from eggs.gnu.org ([2001:4830:134:3::10]:39920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI8s3-0002MN-PP
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI8ry-0007uY-PB
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:57:59 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:44589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI8ry-0007tn-Fy
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:57:54 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 114C5120510
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:57:53 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-2-clg@kaod.org>
	<20171124025100.GA28000@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <20eae742-f6a3-8cfd-ddcf-9de74aa7ada1@kaod.org>
Date: Fri, 24 Nov 2017 08:57:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171124025100.GA28000@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/25] ppc/xics: introduce an icp_create()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/24/2017 03:51 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:31PM +0100, C=E9dric Le Goater wrote:
>> The sPAPR and the PowerNV core objects create the interrupt presenter
>> object of the CPUs in a very similar way. Let's provide a common
>> routine in which we use the presenter 'type' as a child identifier.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> One tiny nit.., apart from that
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>> ---
>>  hw/intc/xics.c          | 22 ++++++++++++++++++++++
>>  hw/ppc/pnv_core.c       | 10 +---------
>>  hw/ppc/spapr_cpu_core.c | 13 ++-----------
>>  include/hw/ppc/xics.h   |  3 +++
>>  4 files changed, 28 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index a1cc0e420c98..e4ccdff8f577 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -384,6 +384,28 @@ static const TypeInfo icp_info =3D {
>>      .class_size =3D sizeof(ICPStateClass),
>>  };
>> =20
>> +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi, Er=
ror **errp)
>> +{
>> +    Object *child =3D OBJECT(cs);
>=20
> In the original context 'child' made sense, since it was the child
> object of the core.  Here, it's misleading, since it's the parent of
> the xics link.  It's only used in a couple of places, so I suggest you
> just opencode OBJECT(cs) in each place.

yes. That was a left over from the copy-paste.

Thanks,

C.


>> +    Error *local_err =3D NULL;
>> +    Object *obj;
>> +
>> +    obj =3D object_new(type);
>> +    object_property_add_child(child, type, obj, &error_abort);
>> +    object_unref(obj);
>> +    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
>> +                                   &error_abort);
>> +    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_a=
bort);
>> +    object_property_set_bool(obj, true, "realized", &local_err);
>> +    if (local_err) {
>> +        object_unparent(obj);
>> +        error_propagate(errp, local_err);
>> +        obj =3D NULL;
>> +    }
>> +
>> +    return obj;
>> +}
>> +
>>  /*
>>   * ICS: Source layer
>>   */
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index 82ff440b3334..a066736846f8 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -126,7 +126,6 @@ static void pnv_core_realize_child(Object *child, =
XICSFabric *xi, Error **errp)
>>      Error *local_err =3D NULL;
>>      CPUState *cs =3D CPU(child);
>>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> -    Object *obj;
>> =20
>>      object_property_set_bool(child, true, "realized", &local_err);
>>      if (local_err) {
>> @@ -134,13 +133,7 @@ static void pnv_core_realize_child(Object *child,=
 XICSFabric *xi, Error **errp)
>>          return;
>>      }
>> =20
>> -    obj =3D object_new(TYPE_PNV_ICP);
>> -    object_property_add_child(child, "icp", obj, NULL);
>> -    object_unref(obj);
>> -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
>> -                                   &error_abort);
>> -    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_a=
bort);
>> -    object_property_set_bool(obj, true, "realized", &local_err);
>> +    icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>> @@ -148,7 +141,6 @@ static void pnv_core_realize_child(Object *child, =
XICSFabric *xi, Error **errp)
>> =20
>>      powernv_cpu_init(cpu, &local_err);
>>      if (local_err) {
>> -        object_unparent(obj);
>>          error_propagate(errp, local_err);
>>          return;
>>      }
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 4ba8563d49e4..f8a520a2fa2d 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -111,7 +111,6 @@ static void spapr_cpu_core_realize_child(Object *c=
hild,
>>      Error *local_err =3D NULL;
>>      CPUState *cs =3D CPU(child);
>>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> -    Object *obj;
>> =20
>>      object_property_set_bool(child, true, "realized", &local_err);
>>      if (local_err) {
>> @@ -123,21 +122,13 @@ static void spapr_cpu_core_realize_child(Object =
*child,
>>          goto error;
>>      }
>> =20
>> -    obj =3D object_new(spapr->icp_type);
>> -    object_property_add_child(child, "icp", obj, &error_abort);
>> -    object_unref(obj);
>> -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
>> -                                   &error_abort);
>> -    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_a=
bort);
>> -    object_property_set_bool(obj, true, "realized", &local_err);
>> +    icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
>>      if (local_err) {
>> -        goto free_icp;
>> +        goto error;
>>      }
>> =20
>>      return;
>> =20
>> -free_icp:
>> -    object_unparent(obj);
>>  error:
>>      error_propagate(errp, local_err);
>>  }
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 2df99be111ce..126b47dec38b 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -212,4 +212,7 @@ typedef struct sPAPRMachineState sPAPRMachineState=
;
>>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>>  void xics_spapr_init(sPAPRMachineState *spapr);
>> =20
>> +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi,
>> +                   Error **errp);
>> +
>>  #endif /* XICS_H */
>=20
