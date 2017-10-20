Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5YlP-0002vw-Sv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5YlL-0004P8-65
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:59:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33230
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e5YlK-0004OD-VH
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:59:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KEwku9104508
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:58:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dqhnhnj65-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:58:58 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 20 Oct 2017 15:58:56 +0100
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
	<0aab6dae-a926-c106-9bc5-68561a9bef5c@redhat.com>
	<0dae2b6c-9164-efc7-5c67-0e4aa5eb4a21@de.ibm.com>
	<fcf03f16-389e-83b5-77bf-d7a50151005c@redhat.com>
	<2bfd5f45-3db1-b6c7-3162-43be564cfa05@de.ibm.com>
	<fb0b2486-706c-c7af-0e38-ddea1faa7b92@redhat.com>
	<90dcd7c4-0a89-df06-90e3-0d8253871395@de.ibm.com>
	<2812651d-6d15-347c-5f1d-40fb0e35f66a@redhat.com>
	<ffef8da1-4824-0940-4dbb-17b7a3de7157@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 20 Oct 2017 16:58:52 +0200
MIME-Version: 1.0
In-Reply-To: <ffef8da1-4824-0940-4dbb-17b7a3de7157@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c05abe6e-2ba6-a678-fe51-4c0c2f828b7e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 10/20/2017 04:12 PM, Christian Borntraeger wrote:
> 
> 
> On 10/20/2017 04:06 PM, David Hildenbrand wrote:
>> On 20.10.2017 16:02, Christian Borntraeger wrote:
>>>
>>>
>>> On 10/20/2017 03:51 PM, David Hildenbrand wrote:
>>> [...]
>>>>> The problem goes much further.
>>>>> A fresh guest with
>>>>>
>>>>>     <os>
>>>>>      <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>>>>>    </os>
>>>>>    <cpu mode='host-model'/>
>>>>>
>>>>> does not start. No migration from an older system is necessary.
>>>>>
>>>>
>>>> Yes, as stated in the documentation "copying host CPU definition from
>>>> capabilities XML" this can not work. And it works just as documented.
>>>> Not saying this is a nice thing :)
>>>>
>>>> I think we should try to fix gs_allowed (if possible) and avoid
>>>> something like that in the future. This would avoid other complexity
>>>> involved when suddenly having X host models.
>>>
>>> Maybe this one is really a proper fix. It will allow the guest to start
>>> and on migration the cpu model will complain if the target cannot provide gs.
>>> Similar things can happen if - for example - the host kernel lacks some features.
>>
>> Right, just what I had in mind.
>>
>>>
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 77169bb..97a08fa 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -430,7 +430,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>>      s390mc->ri_allowed = true;
>>>      s390mc->cpu_model_allowed = true;
>>>      s390mc->css_migration_enabled = true;
>>> -    s390mc->gs_allowed = true;
>>>      mc->init = ccw_init;
>>>      mc->reset = s390_machine_reset;
>>>      mc->hot_add_cpu = s390_hot_add_cpu;
>>> @@ -509,12 +508,6 @@ bool cpu_model_allowed(void)
>>>      return get_machine_class()->cpu_model_allowed;
>>>  }
>>>  
>>> -bool gs_allowed(void)
>>> -{
>>> -    /* for "none" machine this results in true */
>>> -    return get_machine_class()->gs_allowed;
>>> -}
>>> -
>>>  static char *machine_get_loadparm(Object *obj, Error **errp)
>>>  {
>>>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>> @@ -757,7 +750,6 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
>>>  {
>>>      S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>>>  
>>> -    s390mc->gs_allowed = false;
>>>      ccw_machine_2_10_class_options(mc);
>>>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
>>>      s390mc->css_migration_enabled = false;
>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>>> index a9a90c2..1de53b0 100644
>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>> @@ -40,7 +40,6 @@ typedef struct S390CcwMachineClass {
>>>      bool ri_allowed;
>>>      bool cpu_model_allowed;
>>>      bool css_migration_enabled;
>>> -    bool gs_allowed;
>>>  } S390CcwMachineClass;
>>>  
>>>  /* runtime-instrumentation allowed by the machine */
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index a0d5052..3f13fc2 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -362,7 +362,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>              cap_ri = 1;
>>>          }
>>>      }
>>> -    if (gs_allowed()) {
>>> +    if (cpu_model_allowed()) {
>>>          if (kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0) == 0) {
>>>              cap_gs = 1;
>>>          }
>>>
>>
>> And the last hunk makes sure we keep same handling for machines without
>> CPU model support and therefore no way to mask support. For all recent
>> machines, we expect CPU model checks to be in place.
>>
>> Will have to think about this a bit more. Will you send this as a proper
>> patch?
> 
> After thinking about it :-)
> 

I intend to put some brain-power in this too. Probably next week.

My general impression is, that I have a at places different understanding
of how things should work compared to David. Especially when it comes
to this concept of persistent copying, and also an end-user-digestible
definition of what host-model does. (I think this with copying capabilities
from whatever xml which is subject to convoluted caching is a bit too
hard to digest for an end user not involved in the development of qemu
and libvirt).

I had a conversation with Boris a couple of hours ago, and it seems, things
are pretty convoluted.

If I understand the train of thought here (David) it can be summarized like this:
For a certain QEMU binary no aspect of the cpu-models may depend on the
machine type. In particular, compat properties and compat handling is
not alowed to alter cpu-models (whether the available cpu models nor the
capabilities of each of these).

This we would have to make a part of the external interface. That way
one could be sure that the 'cpu capabilities' are machine-type independent
(that is, the same for all the machine types).

Or did I get this completely wrong? (Based on the answer branches my
think).

Halil
