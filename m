Received: from eggs.gnu.org ([2001:4830:134:3::10]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7Miz-0006ZT-35
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7Miu-0005b1-TX
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:36:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1g7Miu-0005Zt-IV
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:36:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w92FYNgb004958
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 11:36:31 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mvamhtpnu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 11:36:30 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 2 Oct 2018 16:36:28 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-4-akrowiak@linux.vnet.ibm.com>
	<1bb4b47c-5dda-cbea-ee4e-c6b8645ee288@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 2 Oct 2018 17:36:22 +0200
MIME-Version: 1.0
In-Reply-To: <1bb4b47c-5dda-cbea-ee4e-c6b8645ee288@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f7535c84-e2ed-45ed-0f03-51eb11f9b7ee@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 3/6] s390x/kvm: enable AP instruction
 interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

On 27/09/2018 09:52, David Hildenbrand wrote:
> On 27/09/2018 00:54, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Let's use the KVM_SET_DEVICE_ATTR ioctl to enable hardware
>> interpretation of AP instructions executed on the guest.
>> If the S390_FEAT_AP feature is switched on for the guest,
>> AP instructions must be interpreted by default; otherwise,
>> they will be intercepted.
>>
>> This attribute setting may be overridden by a device. For example,
>> a device may want to provide AP instructions to the guest (i.e.,
>> S390_FEAT_AP turned on), but it may want to emulate them. In this
>> case, the AP instructions executed on the guest must be
>> intercepted; so when the device is realized, it must disable
>> interpretation.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   target/s390x/kvm.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 5277acd79a2c..d55d24abfd78 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2301,6 +2301,16 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *=
model, Error **errp)
>>                  S390_FEAT_MAX);
>>   }
>>  =20
>> +static void kvm_s390_configure_apie(bool interpret)
>> +{
>> +    uint64_t attr =3D interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
>> +                                KVM_S390_VM_CRYPTO_DISABLE_APIE;
>> +
>> +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
>> +            kvm_s390_set_attr(attr);
>=20
> Wrong indentation, apart from that
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
>> +    }
>> +}
>> +
>>   void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **err=
p)
>>   {
>>       struct kvm_s390_vm_cpu_processor prop  =3D {
>> @@ -2350,6 +2360,10 @@ void kvm_s390_apply_cpu_model(const S390CPUMode=
l *model, Error **errp)
>>       if (test_bit(S390_FEAT_CMM, model->features)) {
>>           kvm_s390_enable_cmma();
>>       }
>> +
>> +    if (test_bit(S390_FEAT_AP, model->features)) {
>> +        kvm_s390_configure_apie(true);
>> +    }
>>   }
>>  =20
>>   void kvm_s390_restart_interrupt(S390CPU *cpu)
>>
>=20
>=20


Tested-by: Pierre Morel<pmorel@linux.ibm.com>


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
