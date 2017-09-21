Received: from eggs.gnu.org ([2001:4830:134:3::10]:36687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dusMF-0005T4-M5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dusMC-0001b7-J4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:40:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dusMC-0001ZM-DY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:40:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L3dtPk121834
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 23:40:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3w1n3cbs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 23:40:54 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 21:40:53 -0600
Received: from b03ledav001.gho.boulder.ibm.com
	(b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v8L3eoHo3932638
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 20:40:50 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EFDF6E035
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 21:40:50 -0600 (MDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.63])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id A47CA6E038
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 21:40:49 -0600 (MDT)
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-34-git-send-email-borntraeger@de.ibm.com>
	<5eb9a7bd-2761-bea1-738a-da7a6d3fbfcf@de.ibm.com>
	<f6da1ec7-4845-fe78-b6b8-29a71d481458@de.ibm.com>
	<20170920160417.GB3132@work-vm>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:40:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170920160417.GB3132@work-vm>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <f0fcf8d6-e341-c53d-1198-3457ec2a007a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] block ais migration for machines <= 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=D4=DA 2017/9/21 =C9=CF=CE=E712:04, Dr. David Alan Gilbert =D0=B4=B5=C0:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>> Something like the following seems to do the tricks.
>> Needs proper patch description, review, full test with different kerne=
l versions.....
> Without knowing anything about 'ais' - will this break migration from
> 2.10 -> 2.10+this fix?
I think it doesn't break. I will have a try later.
>
> Dave
>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 1c7af39..2ff32ba 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -212,6 +212,7 @@ static void ccw_machine_class_init(ObjectClass *oc=
, void *data)
>>       s390mc->cpu_model_allowed =3D true;
>>       s390mc->css_migration_enabled =3D true;
>>       s390mc->gs_allowed =3D true;
>> +    s390mc->ais_allowed =3D true;
>>       mc->init =3D ccw_init;
>>       mc->reset =3D s390_machine_reset;
>>       mc->hot_add_cpu =3D s390_hot_add_cpu;
>> @@ -305,6 +306,11 @@ bool gs_allowed(void)
>>       return false;
>>   }
>>  =20
>> +bool ais_allowed(void)
>> +{
>> +    return get_machine_class()->ais_allowed;
>> +}
>> +
>>   static char *machine_get_loadparm(Object *obj, Error **errp)
>>   {
>>       S390CcwMachineState *ms =3D S390_CCW_MACHINE(obj);
>> @@ -533,6 +539,7 @@ static void ccw_machine_2_9_class_options(MachineC=
lass *mc)
>>       S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
>>  =20
>>       s390mc->gs_allowed =3D false;
>> +    s390mc->ais_allowed =3D false;
>>       ccw_machine_2_10_class_options(mc);
>>       SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
>>       s390mc->css_migration_enabled =3D false;
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s39=
0-virtio-ccw.h
>> index 41a9d28..bba8660 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>>       bool cpu_model_allowed;
>>       bool css_migration_enabled;
>>       bool gs_allowed;
>> +    bool ais_allowed;
>>   } S390CcwMachineClass;
>>  =20
>>   /* runtime-instrumentation allowed by the machine */
>> @@ -49,6 +50,8 @@ bool ri_allowed(void);
>>   bool cpu_model_allowed(void);
>>   /* guarded-storage allowed by the machine */
>>   bool gs_allowed(void);
>> +/* ais allowed by the machine */
>> +bool ais_allowed(void);
>>  =20
>>   /**
>>    * Returns true if (vmstate based) migration of the channel subsyste=
m
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index c4c5791..531d474 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -309,7 +309,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>       }
>>  =20
>>       /* Try to enable AIS facility */
>> -    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    if (ais_allowed()) {
>> +       kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    }
>>  =20
>>       qemu_mutex_init(&qemu_sigp_mutex);
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
