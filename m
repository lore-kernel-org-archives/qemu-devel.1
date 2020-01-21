Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6641121569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnTOyElw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6641121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwpz-0005bQ-KA
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itwpI-00054h-0I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itwpC-00034d-Kx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:56:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itwpC-000345-GV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579625781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1hRKO5v0CRr/q4CSEG6yPBspwENsZU7JtXcHo1rKgxQ=;
 b=QnTOyElwZVDawtX+Lt4qdI+c+cFDg1ljl6y+NjAEsr+QVVhWDgFk02bC5zLgpyIzmbqvdh
 X2UducVUYsFcu/+u8qbUaHSKjrajrBF2Kd1RqSzXm1hpzugRgIEuD97O4bjk+a5xRhO7I+
 qfEEdOJyNph2Hyw8F9/E7Z2ESteJVA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-srGVAKY1N3a3Af4qB1FjPg-1; Tue, 21 Jan 2020 11:56:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA2198010CA;
 Tue, 21 Jan 2020 16:56:18 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.36.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5406A10013A7;
 Tue, 21 Jan 2020 16:56:14 +0000 (UTC)
Subject: Re: [PATCH v4] target/s390x/kvm: Enable adapter interruption
 suppression again
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
References: <20200121163338.21704-1-thuth@redhat.com>
 <9a63bec5-6b01-c1aa-65cd-44005acae8ef@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b614d970-9c92-c66d-664b-0adac063ce1b@redhat.com>
Date: Tue, 21 Jan 2020 17:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9a63bec5-6b01-c1aa-65cd-44005acae8ef@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: srGVAKY1N3a3Af4qB1FjPg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/2020 17.48, David Hildenbrand wrote:
> On 21.01.20 17:33, Thomas Huth wrote:
>> The AIS feature has been disabled late in the v2.10 development cycle since
>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>> to enable it again for newer machine types, but apparently we forgot to do
>> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
>>
>> While at it, also add a more verbose comment why we need the *_allowed()
>> wrappers in s390-virtio-ccw.c.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v4: Use kvm_kernel_irqchip_allowed() for avoiding problems when running
>>      with -machine s390-ccw-virtio,kernel_irqchip=off
>>
>>  hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>>  target/s390x/kvm.c                 |  9 ++++++---
>>  3 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index e0e28139a2..76254e8447 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -452,6 +452,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>      s390mc->cpu_model_allowed = true;
>>      s390mc->css_migration_enabled = true;
>>      s390mc->hpage_1m_allowed = true;
>> +    s390mc->kvm_ais_allowed = true;
>>      mc->init = ccw_init;
>>      mc->reset = s390_machine_reset;
>>      mc->hot_add_cpu = s390_hot_add_cpu;
>> @@ -505,6 +506,14 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
>>  
>>  static S390CcwMachineClass *current_mc;
>>  
>> +/*
>> + * Get the class of the s390-ccw-virtio machine that is currently in use.
>> + * Note: libvirt is using the "none" machine to probe for the features of the
>> + * host CPU, so in case this is called with the "none" machine, the function
>> + * returns the TYPE_S390_CCW_MACHINE base class. In this base class, all the
>> + * various "*_allowed" variables are enabled, so that the *_allowed() wrappers
>> + * below return the correct default value for the "none" machine.
>> + */
>>  static S390CcwMachineClass *get_machine_class(void)
>>  {
>>      if (unlikely(!current_mc)) {
>> @@ -521,22 +530,24 @@ static S390CcwMachineClass *get_machine_class(void)
>>  
>>  bool ri_allowed(void)
>>  {
>> -    /* for "none" machine this results in true */
>>      return get_machine_class()->ri_allowed;
>>  }
>>  
>>  bool cpu_model_allowed(void)
>>  {
>> -    /* for "none" machine this results in true */
>>      return get_machine_class()->cpu_model_allowed;
>>  }
>>  
>>  bool hpage_1m_allowed(void)
>>  {
>> -    /* for "none" machine this results in true */
>>      return get_machine_class()->hpage_1m_allowed;
>>  }
>>  
>> +bool kvm_ais_allowed(void)
>> +{
>> +    return get_machine_class()->kvm_ais_allowed;
>> +}
>> +
>>  static char *machine_get_loadparm(Object *obj, Error **errp)
>>  {
>>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> @@ -658,8 +669,11 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
>>  
>>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>>  {
>> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>> +
>>      ccw_machine_5_0_class_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>> +    s390mc->kvm_ais_allowed = false;
>>  }
>>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
>>  
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>> index 8aa27199c9..e3ba3b88b1 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -40,6 +40,7 @@ typedef struct S390CcwMachineClass {
>>      bool cpu_model_allowed;
>>      bool css_migration_enabled;
>>      bool hpage_1m_allowed;
>> +    bool kvm_ais_allowed;
>>  } S390CcwMachineClass;
>>  
>>  /* runtime-instrumentation allowed by the machine */
>> @@ -48,6 +49,8 @@ bool ri_allowed(void);
>>  bool cpu_model_allowed(void);
>>  /* 1M huge page mappings allowed by the machine */
>>  bool hpage_1m_allowed(void);
>> +/* adapter-interrupt suppression allowed by the machine? */
>> +bool kvm_ais_allowed(void);
>>  
>>  /**
>>   * Returns true if (vmstate based) migration of the channel subsystem
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 15260aeb9a..1602a2c33d 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      /*
>>       * The migration interface for ais was introduced with kernel 4.13
>>       * but the capability itself had been active since 4.12. As migration
>> -     * support is considered necessary let's disable ais in the 2.10
>> -     * machine.
>> +     * support is considered necessary, we only try to enable this for
>> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
>>       */
>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>> +    if (kvm_ais_allowed() && kvm_kernel_irqchip_allowed() &&
>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    }
> 
> I just remembered that the availability of CPU features should in
> general not depend on the selected machine. We only have compat handling
> for pre-cpu-model-support machines (e.g., vx).
> 
> The issue is, that the probed host cpu model is otherwise not guaranteed
> to run om a selected machine and you get misleading errors.
> 
> Can someone remind me why we need kvm_ais_allowed() at all and cannot
> simply rely on cpu model checks to properly handle this (like all other
> features)?

Sorry, I don't quite get what you mean here. Which other features are
you talking about? KVM_CAP_S390_RI and KVM_CAP_S390_GS are enabled in a
very similar way...

 Thomas


