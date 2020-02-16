Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41B4C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 23:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853C12086A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 23:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/ptAkeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853C12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3TZG-0006Ix-OK
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 18:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j3TYh-0005nD-7V
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 18:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j3TYf-0006xG-NU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 18:42:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j3TYf-0006wB-JD
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 18:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581896560;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWof6CVWogOW3pvdt5XNombSiCK1g8ZWhbCTLP9sfcM=;
 b=G/ptAkeZaaYKrcqF211YuEOqjADkZ5Wc50J7jWLbr55xwmWVKRnAKdzPap7IYetztUO8oz
 kxkhG3MmEsQTq8o3rZWG7MUPM0lC7LpV9Mj+Ey7Jfh0s+QfUf5/tCnK8QWm4hFW3Jcldfp
 q5k0dceJBg02enGkSgypxtTnUeB6nIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-hj5PHfJPMkKVFwWMl08AoQ-1; Sun, 16 Feb 2020 18:42:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 099A8107ACC7;
 Sun, 16 Feb 2020 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-16.bne.redhat.com [10.64.54.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB3BB85735;
 Sun, 16 Feb 2020 23:42:30 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] target/arm: Support SError injection
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200214055950.62477-1-gshan@redhat.com>
 <20200214055950.62477-2-gshan@redhat.com>
 <0c00d0d4-19c5-0802-8fd3-f583bb270709@linaro.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <b0d30a90-7d0e-8bb6-c7f5-7f01cb218122@redhat.com>
Date: Mon, 17 Feb 2020 10:42:28 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0c00d0d4-19c5-0802-8fd3-f583bb270709@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hj5PHfJPMkKVFwWMl08AoQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/16/20 2:41 PM, Richard Henderson wrote:
> On 2/13/20 9:59 PM, Gavin Shan wrote:
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index b0762a76c4..180e29fb83 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -78,7 +78,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>>           && cs->interrupt_request &
>>           (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>>            | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
>> -         | CPU_INTERRUPT_EXITTB);
>> +         | ARM_CPU_SERROR | CPU_INTERRUPT_EXITTB);
> 
> CPU_INTERRUPT_SERROR, not ARM_CPU_SERROR.
> 

Yep, will be corrected in v4.

>> @@ -570,6 +573,16 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>               goto found;
>>           }
>>       }
>> +
>> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
>> +        excp_idx = EXCP_SERROR;
>> +        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
>> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
>> +                              cur_el, secure, hcr_el2)) {
>> +            goto found;
>> +        }
>> +    }
>> +
>>       return false;
>>   
>>    found:
> 
> If you're intending to use Serror for NMI, perhaps it should be the first bit
> tested, not the last.  Otherwise some bug that leaves a normal hard interrupt
> line high will keep delivering the interrupt, and not the Serror.
> 
> As the comment at the top of the function says, the priority is implementation
> defined, so we can put it anywhere we like.
> 

Yes, SError will have highest priority in v4.

>> @@ -594,13 +607,26 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>        * (which depends on state like BASEPRI, FAULTMASK and the
>>        * currently active exception).
>>        */
>> -    if (interrupt_request & CPU_INTERRUPT_HARD
>> -        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
>> -        cs->exception_index = EXCP_IRQ;
>> -        cc->do_interrupt(cs);
>> -        ret = true;
>> +    if (!armv7m_nvic_can_take_pending_exception(env->nvic)) {
>> +        return false;
>> +    }
>> +
>> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
>> +        excp_idx = EXCP_IRQ;
>> +        goto found;
>>       }
>> -    return ret;
>> +
>> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
>> +        excp_idx = EXCP_SERROR;
>> +        goto found;
>> +    }
> 
> Likewise.
> 

Thanks, SError will have highest priority in v4.

>> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
>> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 5);
>>       } else {
>> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
>> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 5);
> 
> I wonder if we should have an ARM_CPU_NUM_IRQ define so that this is more
> automatic.
> 

Yes, It makes sense. ARM_CPU_NUM_IRQ will be introduced in v4.

>> @@ -98,10 +100,11 @@ enum {
>>   #endif
>>   
>>   /* Meanings of the ARMCPU object's four inbound GPIO lines */
>> -#define ARM_CPU_IRQ 0
>> -#define ARM_CPU_FIQ 1
>> -#define ARM_CPU_VIRQ 2
>> -#define ARM_CPU_VFIQ 3
>> +#define ARM_CPU_IRQ    0
>> +#define ARM_CPU_FIQ    1
>> +#define ARM_CPU_VIRQ   2
>> +#define ARM_CPU_VFIQ   3
>> +#define ARM_CPU_SERROR 4
> 
> Comment is now wrong about the count.
> 

Yes, It will be corrected to "ARMCPU object's inbound GPIO lines" in v4.

Thanks,
Gavin


