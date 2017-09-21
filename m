Received: from eggs.gnu.org ([2001:4830:134:3::10]:60352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duw7V-0004D2-PJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duw7S-0003zS-Gu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:42:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44660
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1duw7S-0003zB-A5
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:41:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L7eWBt097524
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 03:41:57 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d48cgj8w4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 03:41:57 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 21 Sep 2017 08:41:55 +0100
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-34-git-send-email-borntraeger@de.ibm.com>
	<5eb9a7bd-2761-bea1-738a-da7a6d3fbfcf@de.ibm.com>
	<f6da1ec7-4845-fe78-b6b8-29a71d481458@de.ibm.com>
	<20170920160417.GB3132@work-vm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 21 Sep 2017 09:41:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170920160417.GB3132@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f7a2284d-7ac5-001c-ad36-1894ec97a3e9@de.ibm.com>
Subject: Re: [Qemu-devel] block ais migration for machines <= 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 09/20/2017 06:04 PM, Dr. David Alan Gilbert wrote:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>> Something like the following seems to do the tricks.
>> Needs proper patch description, review, full test with different kernel versions.....
> 
> Without knowing anything about 'ais' - will this break migration from
> 2.10 -> 2.10+this fix?

The problem only happens if the source system has kernel >= 4.12 thats why it
somehow missed my testing during the 2.10 freeze.

Now: "2.10" -> "2.10+this fix" will works fine for the 2.10 machine, but it does 
fail for the combination of qemu-2.10 with an older machine type like 2.8 and 2.9.

qemu-system-s390x: Failed to load s390-flic/ais:tmp
qemu-system-s390x: error while loading state for instance 0x0 of device 's390-flic'
qemu-system-s390x: load of migration failed: Function not implemented

We do run into an explicit check from hw/intc/s390_flic_kvm.c (see the return ENOSYS)

e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 443) static int kvm_flic_ais_post_load(void *opaque, int version_id)
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 444) {
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 445)     KVMS390FLICStateMigTmp *tmp = opaque;
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 446)     KVMS390FLICState *flic = tmp->parent;
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 447)     struct kvm_s390_ais_all ais = {
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 448)         .simm = tmp->simm,
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 449)         .nimm = tmp->nimm,
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 450)     };
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 451)     struct kvm_device_attr attr = {
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 452)         .group = KVM_DEV_FLIC_AISM_ALL,
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 453)         .addr = (uint64_t)&ais,
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 454)     };
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 455) 
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 456)     /* This can happen when the user mis-configures its guests in an
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 457)      * incompatible fashion or without a CPU model. For example using
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 458)      * qemu with -cpu host (which is not migration safe) and do a
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 459)      * migration from a host that has AIS to a host that has no AIS.
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 460)      * In that case the target system will reject the migration here.
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 461)      */
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 462)     if (!ais_needed(flic)) {
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 463)         return -ENOSYS;
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 464)     }
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 465) 
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 466)     return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
e7be8d49 (Yi Min Zhao       2017-05-16 18:58:44 +0800 467) }

So I think if we fix this we should definitely add this to 2.10.1 
to minimize the affected qemu versions. Not fixing it will break
migrations from 4.12/2.10 to older versions. 
 
> 
> Dave
> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 1c7af39..2ff32ba 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -212,6 +212,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>      s390mc->cpu_model_allowed = true;
>>      s390mc->css_migration_enabled = true;
>>      s390mc->gs_allowed = true;
>> +    s390mc->ais_allowed = true;
>>      mc->init = ccw_init;
>>      mc->reset = s390_machine_reset;
>>      mc->hot_add_cpu = s390_hot_add_cpu;
>> @@ -305,6 +306,11 @@ bool gs_allowed(void)
>>      return false;
>>  }
>>  
>> +bool ais_allowed(void)
>> +{
>> +    return get_machine_class()->ais_allowed;
>> +}
>> +
>>  static char *machine_get_loadparm(Object *obj, Error **errp)
>>  {
>>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> @@ -533,6 +539,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
>>      S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>>  
>>      s390mc->gs_allowed = false;
>> +    s390mc->ais_allowed = false;
>>      ccw_machine_2_10_class_options(mc);
>>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
>>      s390mc->css_migration_enabled = false;
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>> index 41a9d28..bba8660 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>>      bool cpu_model_allowed;
>>      bool css_migration_enabled;
>>      bool gs_allowed;
>> +    bool ais_allowed;
>>  } S390CcwMachineClass;
>>  
>>  /* runtime-instrumentation allowed by the machine */
>> @@ -49,6 +50,8 @@ bool ri_allowed(void);
>>  bool cpu_model_allowed(void);
>>  /* guarded-storage allowed by the machine */
>>  bool gs_allowed(void);
>> +/* ais allowed by the machine */
>> +bool ais_allowed(void);
>>  
>>  /**
>>   * Returns true if (vmstate based) migration of the channel subsystem
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index c4c5791..531d474 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -309,7 +309,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      }
>>  
>>      /* Try to enable AIS facility */
>> -    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    if (ais_allowed()) {
>> +       kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    }
>>  
>>      qemu_mutex_init(&qemu_sigp_mutex);
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
