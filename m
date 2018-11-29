Received: from eggs.gnu.org ([2001:4830:134:3::10]:36817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPIq-0006dK-2b
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPIk-0006XM-3H
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:36:35 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:52252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSPIj-0006WI-Py
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:36:29 -0500
Received: from player695.ha.ovh.net (unknown [10.109.159.157])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7F80A1080C1
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:36:27 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-29-clg@kaod.org>
	<20181129040806.GE14697@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <59605f25-7208-1b57-874b-282c39120b18@kaod.org>
Date: Thu, 29 Nov 2018 17:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181129040806.GE14697@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 28/36] ppc/xics: introduce a
 icp_kvm_init() routine
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

On 11/29/18 5:08 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:21AM +0100, C=E9dric Le Goater wrote:
>> This routine gathers all the KVM initialization of the XICS KVM
>> presenter. It will be useful when the initialization of the KVM XICS
>> device is moved to a global routine.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I dislike calling things *_init() because it's not clear which of
> qemu's many "init" hooks it belongs with.

we could use 'icp_kvm_connect' instead. Which was QEMU is doing,=20
connecting a QEMU model to a KVM one.

C.

=20
>> ---
>>  hw/intc/xics_kvm.c | 29 +++++++++++++++++++----------
>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>> index e8fa9a53aeba..efad1b19d821 100644
>> --- a/hw/intc/xics_kvm.c
>> +++ b/hw/intc/xics_kvm.c
>> @@ -123,11 +123,8 @@ static void icp_kvm_reset(DeviceState *dev)
>>      icp_set_kvm_state(ICP(dev), 1);
>>  }
>> =20
>> -static void icp_kvm_realize(DeviceState *dev, Error **errp)
>> +static void icp_kvm_init(ICPState *icp, Error **errp)
>>  {
>> -    ICPState *icp =3D ICP(dev);
>> -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
>> -    Error *local_err =3D NULL;
>>      CPUState *cs;
>>      KVMEnabledICP *enabled_icp;
>>      unsigned long vcpu_id;
>> @@ -137,12 +134,6 @@ static void icp_kvm_realize(DeviceState *dev, Err=
or **errp)
>>          abort();
>>      }
>> =20
>> -    icpc->parent_realize(dev, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        return;
>> -    }
>> -
>>      cs =3D icp->cs;
>>      vcpu_id =3D kvm_arch_vcpu_id(cs);
>> =20
>> @@ -168,6 +159,24 @@ static void icp_kvm_realize(DeviceState *dev, Err=
or **errp)
>>      QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
>>  }
>> =20
>> +static void icp_kvm_realize(DeviceState *dev, Error **errp)
>> +{
>> +    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
>> +    Error *local_err =3D NULL;
>> +
>> +    icpc->parent_realize(dev, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    icp_kvm_init(ICP(dev), &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +}
>> +
>>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
