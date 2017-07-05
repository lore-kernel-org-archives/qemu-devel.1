Received: from eggs.gnu.org ([2001:4830:134:3::10]:59886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dShQV-0007pv-PX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dShQR-0001rw-Qy
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:20:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41384
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dShQR-0001rQ-Jn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:20:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v65AIhaU084719
	for <qemu-devel@nongnu.org>; Wed, 5 Jul 2017 06:20:50 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bgapup34b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 06:20:49 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Jul 2017 04:20:49 -0600
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-5-git-send-email-borntraeger@de.ibm.com>
	<20170704163730.491517ac@dhcp-192-215.str.redhat.com>
	<930cb5d9-83d1-50e7-39a7-f7eea67ef1af@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Jul 2017 12:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <930cb5d9-83d1-50e7-39a7-f7eea67ef1af@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <e00d3b37-a79e-6779-8627-e597685aeb18@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] s390x: fix realize inheritance for
 kvm-flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On 07/04/2017 04:51 PM, Halil Pasic wrote:
> 
> 
> On 07/04/2017 04:37 PM, Cornelia Huck wrote:
>> On Tue,  4 Jul 2017 16:07:56 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>
>>> Commit f6f4ce4211 ("s390x: add property adapter_routes_max_batch",
>>> 2016-12-09) introduces a common realize (intended to be common for all
>>> the subclasses) for flic, but fails to make sure the kvm-flic which had
>>> it's own is actually calling this common realize.
>>
>> s/it's/its/
>>
> 
> Valid. Sorry.
> 
>>>
>>> This omission fortunately does not result in a grave problem. The common
>>> realize was only supposed to catch a possible programming mistake by
>>> validating a value of a property set via the compat machine macros. Since
>>> there was no programming mistake we don't need this fixed for stable.
>>>
>>> Let's fix this problem by making sure kvm flic honors the realize of its
>>> parent class.
>>>
>>> Let us also improve on the error message we would hypothetically emit
>>> when the validation fails.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Fixes: f6f4ce4211 ("s390x: add property adapter_routes_max_batch")
>>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  hw/intc/s390_flic.c     |  4 ++--
>>>  hw/intc/s390_flic_kvm.c | 17 +++++++++++++++++
>>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>>> index a99a350..837158b 100644
>>> --- a/hw/intc/s390_flic.c
>>> +++ b/hw/intc/s390_flic.c
>>> @@ -101,8 +101,8 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
>>>      uint32_t max_batch = S390_FLIC_COMMON(dev)->adapter_routes_max_batch;
>>>  
>>>      if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
>>> -        error_setg(errp, "flic adapter_routes_max_batch too big"
>>> -                   "%d (%d allowed)", max_batch, ADAPTER_ROUTES_MAX_GSI);
>>> +        error_setg(errp, "flic property adapter_routes_max_batch too big"
>>> +                   " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
>>
>> Unrelated message change?
>>
> 
> I've mentioned it in the commit message. It was also introduced by the
> patch I'm fixing. But yes strictly it's two different problems.

I will only fix the patch description ( s/it's/its/) and keep the other things
unchanged. Is that fine with you?
> 
> 
>>>      }
>>>  }
>>>  
>>> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
>>> index bea3997..535d99d 100644
>>> --- a/hw/intc/s390_flic_kvm.c
>>> +++ b/hw/intc/s390_flic_kvm.c
>>> @@ -392,6 +392,17 @@ static const VMStateDescription kvm_s390_flic_vmstate = {
>>>      }
>>>  };
>>>  
>>> +typedef struct KVMS390FLICStateClass {
>>> +    S390FLICStateClass parent_class;
>>> +    DeviceRealize parent_realize;
>>> +} KVMS390FLICStateClass;
>>> +
>>> +#define KVM_S390_FLIC_GET_CLASS(obj) \
>>> +    OBJECT_GET_CLASS(KVMS390FLICStateClass, (obj), TYPE_KVM_S390_FLIC)
>>> +
>>> +#define KVM_S390_FLIC_CLASS(klass) \
>>> +    OBJECT_CLASS_CHECK(KVMS390FLICStateClass, (klass), TYPE_KVM_S390_FLIC)
>>> +
>>>  static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      KVMS390FLICState *flic_state = KVM_S390_FLIC(dev);
>>> @@ -400,6 +411,10 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>>>      int ret;
>>>      Error *errp_local = NULL;
>>>  
>>> +    KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, &errp_local);
>>
>> I usually prefer to introduce a local variable for that, but don't care
>> too much.
>>
>>> +    if (errp_local) {
>>> +        goto fail;
>>> +    }
>>>      flic_state->fd = -1;
>>>      if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
>>>          error_setg_errno(&errp_local, errno, "KVM is missing capability"
>>> @@ -454,6 +469,7 @@ static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
>>>      DeviceClass *dc = DEVICE_CLASS(oc);
>>>      S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
>>>  
>>> +    KVM_S390_FLIC_CLASS(oc)->parent_realize = dc->realize;
>>
>> dito
>>
>>>      dc->realize = kvm_s390_flic_realize;
>>>      dc->vmsd = &kvm_s390_flic_vmstate;
>>>      dc->reset = kvm_s390_flic_reset;
>>> @@ -468,6 +484,7 @@ static const TypeInfo kvm_s390_flic_info = {
>>>      .name          = TYPE_KVM_S390_FLIC,
>>>      .parent        = TYPE_S390_FLIC_COMMON,
>>>      .instance_size = sizeof(KVMS390FLICState),
>>> +    .class_size    = sizeof(KVMS390FLICStateClass),
>>>      .class_init    = kvm_s390_flic_class_init,
>>>  };
>>>  
>>
>>
