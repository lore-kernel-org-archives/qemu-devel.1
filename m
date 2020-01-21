Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E54BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCD9206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNrLm2sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCD9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itxPX-0001zP-W9
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 12:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1itxOi-0001Y5-4y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1itxOc-0005FI-Dx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:33:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27450
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1itxOb-0005EZ-Tm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579627977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bYA5camyfeFDYrzRb4vflPYAf2ut+Nf9V8tCGurbKRw=;
 b=iNrLm2svotq3HWw73iu7paQ3ing9qxKoAgcmccU+TgMgpQeBd+q3JRlUIlkVnn4qsfI3aV
 wraDWtCqbF8SdAJVcpZHZycp486NVDUIpei8oSClfTv1kkCl4YniSeLdyz87wd+XOF2t/W
 0HALKB3VtteoE1n/CAB/xEzZ/IypvKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-hJXDFTpvNgOnGQ6QCFsWyA-1; Tue, 21 Jan 2020 12:32:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95A2218CA247;
 Tue, 21 Jan 2020 17:32:51 +0000 (UTC)
Received: from [10.36.118.56] (unknown [10.36.118.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 025E010013A7;
 Tue, 21 Jan 2020 17:32:48 +0000 (UTC)
Subject: Re: [PATCH v4] target/s390x/kvm: Enable adapter interruption
 suppression again
From: David Hildenbrand <david@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
References: <20200121163338.21704-1-thuth@redhat.com>
 <9a63bec5-6b01-c1aa-65cd-44005acae8ef@redhat.com>
 <b614d970-9c92-c66d-664b-0adac063ce1b@redhat.com>
 <def6ce51-4866-8631-493a-758bc59a0677@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <6cb5fc3d-1ba9-7a75-a098-61e8f7bcd655@redhat.com>
Date: Tue, 21 Jan 2020 18:32:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <def6ce51-4866-8631-493a-758bc59a0677@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: hJXDFTpvNgOnGQ6QCFsWyA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 21.01.20 18:06, David Hildenbrand wrote:
> On 21.01.20 17:56, Thomas Huth wrote:
>> On 21/01/2020 17.48, David Hildenbrand wrote:
>>> On 21.01.20 17:33, Thomas Huth wrote:
>>>> The AIS feature has been disabled late in the v2.10 development cycle since
>>>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>>>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>>>> to enable it again for newer machine types, but apparently we forgot to do
>>>> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
>>>>
>>>> While at it, also add a more verbose comment why we need the *_allowed()
>>>> wrappers in s390-virtio-ccw.c.
>>>>
>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  v4: Use kvm_kernel_irqchip_allowed() for avoiding problems when running
>>>>      with -machine s390-ccw-virtio,kernel_irqchip=off
>>>>
>>>>  hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>>>>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>>>>  target/s390x/kvm.c                 |  9 ++++++---
>>>>  3 files changed, 26 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index e0e28139a2..76254e8447 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -452,6 +452,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>>>      s390mc->cpu_model_allowed = true;
>>>>      s390mc->css_migration_enabled = true;
>>>>      s390mc->hpage_1m_allowed = true;
>>>> +    s390mc->kvm_ais_allowed = true;
>>>>      mc->init = ccw_init;
>>>>      mc->reset = s390_machine_reset;
>>>>      mc->hot_add_cpu = s390_hot_add_cpu;
>>>> @@ -505,6 +506,14 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
>>>>  
>>>>  static S390CcwMachineClass *current_mc;
>>>>  
>>>> +/*
>>>> + * Get the class of the s390-ccw-virtio machine that is currently in use.
>>>> + * Note: libvirt is using the "none" machine to probe for the features of the
>>>> + * host CPU, so in case this is called with the "none" machine, the function
>>>> + * returns the TYPE_S390_CCW_MACHINE base class. In this base class, all the
>>>> + * various "*_allowed" variables are enabled, so that the *_allowed() wrappers
>>>> + * below return the correct default value for the "none" machine.
>>>> + */
>>>>  static S390CcwMachineClass *get_machine_class(void)
>>>>  {
>>>>      if (unlikely(!current_mc)) {
>>>> @@ -521,22 +530,24 @@ static S390CcwMachineClass *get_machine_class(void)
>>>>  
>>>>  bool ri_allowed(void)
>>>>  {
>>>> -    /* for "none" machine this results in true */
>>>>      return get_machine_class()->ri_allowed;
>>>>  }
>>>>  
>>>>  bool cpu_model_allowed(void)
>>>>  {
>>>> -    /* for "none" machine this results in true */
>>>>      return get_machine_class()->cpu_model_allowed;
>>>>  }
>>>>  
>>>>  bool hpage_1m_allowed(void)
>>>>  {
>>>> -    /* for "none" machine this results in true */
>>>>      return get_machine_class()->hpage_1m_allowed;
>>>>  }
>>>>  
>>>> +bool kvm_ais_allowed(void)
>>>> +{
>>>> +    return get_machine_class()->kvm_ais_allowed;
>>>> +}
>>>> +
>>>>  static char *machine_get_loadparm(Object *obj, Error **errp)
>>>>  {
>>>>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>>> @@ -658,8 +669,11 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
>>>>  
>>>>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>>>>  {
>>>> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>>>> +
>>>>      ccw_machine_5_0_class_options(mc);
>>>>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>>>> +    s390mc->kvm_ais_allowed = false;
>>>>  }
>>>>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
>>>>  
>>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>>>> index 8aa27199c9..e3ba3b88b1 100644
>>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>>> @@ -40,6 +40,7 @@ typedef struct S390CcwMachineClass {
>>>>      bool cpu_model_allowed;
>>>>      bool css_migration_enabled;
>>>>      bool hpage_1m_allowed;
>>>> +    bool kvm_ais_allowed;
>>>>  } S390CcwMachineClass;
>>>>  
>>>>  /* runtime-instrumentation allowed by the machine */
>>>> @@ -48,6 +49,8 @@ bool ri_allowed(void);
>>>>  bool cpu_model_allowed(void);
>>>>  /* 1M huge page mappings allowed by the machine */
>>>>  bool hpage_1m_allowed(void);
>>>> +/* adapter-interrupt suppression allowed by the machine? */
>>>> +bool kvm_ais_allowed(void);
>>>>  
>>>>  /**
>>>>   * Returns true if (vmstate based) migration of the channel subsystem
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index 15260aeb9a..1602a2c33d 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>>      /*
>>>>       * The migration interface for ais was introduced with kernel 4.13
>>>>       * but the capability itself had been active since 4.12. As migration
>>>> -     * support is considered necessary let's disable ais in the 2.10
>>>> -     * machine.
>>>> +     * support is considered necessary, we only try to enable this for
>>>> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
>>>>       */
>>>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>>>> +    if (kvm_ais_allowed() && kvm_kernel_irqchip_allowed() &&
>>>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>>>> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>>>> +    }
>>>
>>> I just remembered that the availability of CPU features should in
>>> general not depend on the selected machine. We only have compat handling
>>> for pre-cpu-model-support machines (e.g., vx).
>>>
>>> The issue is, that the probed host cpu model is otherwise not guaranteed
>>> to run om a selected machine and you get misleading errors.
>>>
>>> Can someone remind me why we need kvm_ais_allowed() at all and cannot
>>> simply rely on cpu model checks to properly handle this (like all other
>>> features)?
>>
>> Sorry, I don't quite get what you mean here. Which other features are
>> you talking about? KVM_CAP_S390_RI and KVM_CAP_S390_GS are enabled in a
>> very similar way...
> Similar but different.
> 
> If you look closely, that was all being done before we had machines with
> CPU model support
> 
> 2.8 introduced CPU models
> 2.7 introduced RI
> 
> So ri_allowed() is in place because we have to handle compatibility
> thingies with machines before we had cpu_model_allowed().
> 
> Basically, cpu model support invalidated the need for all new flags.
> You can see how it is to be done for KVM_CAP_S390_GS
> 
> So this here should be
> 
> if (cpu_model_allowed() && kvm_kernel_irqchip_allowed() ...
> 
> We do have to make sure that all migration-related things are also glued
> to the actual availability of the feature. Usually, there should be a
> s390_has_feat(ADAPTER_INT_SUPPRESSION) somewhere that guards this (e.g.,
> see target/s390x/machine.c:vregs_needed()).

FWIW, migration should be fine already

fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);

and

bool ais_needed(void *opaque)
{
	S390FLICState *s = opaque;

	return s->ais_supported;
}

-- 
Thanks,

David / dhildenb


