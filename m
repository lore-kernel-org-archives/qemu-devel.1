Received: from eggs.gnu.org ([209.51.188.92]:37370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hBgtD-0004rb-R9
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hBgtC-00011J-G0
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:29:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hBgtB-00010B-W6
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:29:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x33EQRc9020595
	for <qemu-devel@nongnu.org>; Wed, 3 Apr 2019 10:29:15 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rmxkd02p6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 10:29:15 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 3 Apr 2019 15:29:14 +0100
From: Collin Walling <walling@linux.ibm.com>
References: <20190401214847.27600-1-walling@linux.ibm.com>
	<77d41944-2ed2-bcdd-c434-faea3ec28486@redhat.com>
	<20190403143046.0e33f605.cohuck@redhat.com>
	<c76a38d9-fff2-e4eb-258a-bea5c8649677@linux.ibm.com>
Date: Wed, 3 Apr 2019 10:29:08 -0400
MIME-Version: 1.0
In-Reply-To: <c76a38d9-fff2-e4eb-258a-bea5c8649677@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <20fe3c78-1558-3254-f1a3-2910217cf09e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390: diagnose 318 info reset and
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 4/3/19 10:16 AM, Collin Walling wrote:
> On 4/3/19 8:30 AM, Cornelia Huck wrote:
>> On Wed, 3 Apr 2019 13:46:07 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 01.04.19 23:48, Collin Walling wrote:
>>>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>>>> be intercepted by SIE and handled via KVM. Let's introduce some
>>>> functions to communicate between QEMU and KVM via ioctls. These
>>>> will be used to get/set the diag318 related information (also known
>>>> as the "Control Program Code" or "CPC"), as well as check the system
>>>> if KVM supports handling this instruction.
>>>>
>>>> Diag318 must also be reset on a load normal and modified clear, so
>>>> we use the set function (wrapped in a reset function) to explicitly
>>>> set the diag318 info to 0 for these cases.
>>>>
>>>> Lastly, we want to ensure the diag318 info is migrated. The diag318
>>>> info migration is handled via a VMStateDescription. This feature is
>>>> only supported on QEMU machines 4.0 and later.
>>>
>>> This has to become 4.1
>>>
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>
>>>> This version is posted in tandem with a new kernel patch that change=
s
>>>> how the execution of the diag 0x318 instruction is handled. A link t=
o
>>>> this series will be attached as a reply to this series for convenien=
ce.
>>>>
>>>> Changelog:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 v3
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - removed CPU model=
 code
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - removed RSCPI and=
 SCLP code
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - reverted max cpus=
 back to 248 (previous patches limited this
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 to 247)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - introduced VMStat=
eDescription handlers for migration
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - disabled migratio=
n of diag318 info for machines 3.1 and=20
>>>> older
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - a warning is printed if migration is disabled and KVM
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 supports handling this instruction
>>>>
>>>> ---
>>>> =C2=A0 hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0 |=C2=A0 6 ++++
>>>> =C2=A0 linux-headers/asm-s390/kvm.h |=C2=A0 4 +++
>>>> =C2=A0 target/s390x/diag.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 63=20
>>>> ++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 target/s390x/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 5 ++-
>>>> =C2=A0 target/s390x/kvm-stub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++=
+++++++
>>>> =C2=A0 target/s390x/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 32 ++++++++++++++++++
>>>> =C2=A0 target/s390x/kvm_s390x.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>>> =C2=A0 7 files changed, 127 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index d11069b860..2a50868496 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -36,6 +36,7 @@
>>>> =C2=A0 #include "cpu_models.h"
>>>> =C2=A0 #include "hw/nmi.h"
>>>> =C2=A0 #include "hw/s390x/tod.h"
>>>> +#include "internal.h"
>>>> =C2=A0 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>>> =C2=A0 {
>>>> @@ -302,6 +303,8 @@ static void ccw_init(MachineState *machine)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* init the TOD clock */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_init_tod();
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 diag318_register_migration();
>>>> =C2=A0 }
>>>> =C2=A0 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>>>> @@ -352,6 +355,7 @@ static void s390_machine_reset(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subsystem_res=
et();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_crypto_r=
eset();
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diag318_reset();
>>>
>>> Shouldn't this go into subsystem_reset?
>>>
>>> Aren't you missing resets during external/reipl resets?
>>>

Certainly makes sense to do this during reipl as well. The diag318 info=20
is to be reset during a clear, power-on, and load normal. I'll look into
it as I investigate this "fake device" route.

>>> Also, I was wondering if this would be worth creating a fake device l=
ike
>>> diag288. The resets can be handled similar to diag288. Resets during
>>> external/reipl reset would come natural.
>=20
> I'll look into it.
>=20
>>
>> I like the idea of adding a new device. Would also make the migration
>> code nicer (as you suggested below).
>>
>=20
> Right. I always forget this step.
>=20

Whoops -- Meant that response to be under the "linux header" comment.

>>>> =C2=A0 static void ccw_machine_3_1_class_options(MachineClass *mc)
>>>> diff --git a/linux-headers/asm-s390/kvm.h=20
>>>> b/linux-headers/asm-s390/kvm.h
>>>> index 0265482f8f..735f5a46e8 100644
>>>> --- a/linux-headers/asm-s390/kvm.h
>>>> +++ b/linux-headers/asm-s390/kvm.h
>>
>> Updates of linux headers should always go into a separate patch that
>> can be replaced by a proper headers update when applying.
>>
>>>> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>>>> =C2=A0 #define KVM_S390_VM_CRYPTO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2
>>>> =C2=A0 #define KVM_S390_VM_CPU_MODEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 3
>>>> =C2=A0 #define KVM_S390_VM_MIGRATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 4
>>>> +#define KVM_S390_VM_MISC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
5
>>>> =C2=A0 /* kvm attributes for mem_ctrl */
>>>> =C2=A0 #define KVM_S390_VM_MEM_ENABLE_CMMA=C2=A0=C2=A0=C2=A0 0
>>>> @@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
>>>> =C2=A0 #define KVM_S390_VM_MIGRATION_START=C2=A0=C2=A0=C2=A0 1
>>>> =C2=A0 #define KVM_S390_VM_MIGRATION_STATUS=C2=A0=C2=A0=C2=A0 2
>>>> +/* kvm attributes for KVM_S390_VM_MISC */
>>>> +#define KVM_S390_VM_MISC_CPC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
>>>> +
>>>> =C2=A0 /* for KVM_GET_REGS and KVM_SET_REGS */
>>>> =C2=A0 struct kvm_regs {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* general purpose regs for s390 */
>>
>=20
>=20
