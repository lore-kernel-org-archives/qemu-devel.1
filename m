Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F68C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C496820872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C496820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCiwe-0008Ki-0m
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iCiva-0007ZX-3y
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iCivY-00032a-O8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:24:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iCivV-00031a-MM; Tue, 24 Sep 2019 07:24:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02A7B7FDE9;
 Tue, 24 Sep 2019 11:24:13 +0000 (UTC)
Received: from [10.36.116.30] (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E365C1B2;
 Tue, 24 Sep 2019 11:24:03 +0000 (UTC)
Subject: Re: [PATCH 2/4] target/arm: Move cortex-m related functions to new
 file v7m.c
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-3-thuth@redhat.com>
 <bd6efd14-9200-98e2-4f76-dda101f85274@redhat.com>
 <8585b93b-e239-829b-d634-b89941f27aed@redhat.com>
 <5b967a2a-e1db-9a9f-7590-fc6905354f7a@redhat.com>
 <240ae462-9f6e-bb1f-3657-1baaba4051ca@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <74706e48-31c9-c7d2-e700-e6b702f7560a@redhat.com>
Date: Tue, 24 Sep 2019 13:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <240ae462-9f6e-bb1f-3657-1baaba4051ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 24 Sep 2019 11:24:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 9/24/19 1:06 PM, Thomas Huth wrote:
> On 24/09/2019 13.02, Auger Eric wrote:
>> Hi Thomas,
>>
>> On 9/23/19 8:09 PM, Thomas Huth wrote:
>>> On 23/09/2019 16.31, Auger Eric wrote:
>>>> Hi Thomas,
>>>>
>>>> On 9/21/19 5:04 PM, Thomas Huth wrote:
>>>>> We are going to make CONFIG_ARM_V7M optional, so the related cortex-m
>>>>> CPUs should only be created if the switch is enabled. This can best
>>>>> be done if the code resides in a separate file, thus move the related
>>>>> functions to a new file v7m.c which only gets compiled if CONFIG_ARM_V7M
>>>>> is enabled.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  target/arm/Makefile.objs |   1 +
>>>>>  target/arm/cpu.c         | 146 -----------------------------
>>>>>  target/arm/v7m.c         | 193 +++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 194 insertions(+), 146 deletions(-)
>>>>>  create mode 100644 target/arm/v7m.c
>>> [...]
>>>>> diff --git a/target/arm/v7m.c b/target/arm/v7m.c
>>>>> new file mode 100644
>>>>> index 0000000000..505043febe
>>>>> --- /dev/null
>>>>> +++ b/target/arm/v7m.c
>>>>> @@ -0,0 +1,193 @@
>>>>> +/*
>>>>> + * ARM v7m helpers.
>>>>> + *
>>>>> + * This code is licensed under the GNU GPL v2 or later.
>>>>> + *
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "qemu/qemu-print.h"
>>>>> +#include "qemu-common.h"
>>>>> +#include "target/arm/idau.h"
>>>>> +#include "qemu/module.h"
>>>>> +#include "qapi/error.h"
>>>>> +#include "qapi/visitor.h"
>>>>> +#include "cpu.h"
>>>>> +#include "internals.h"
>>>>> +#include "exec/exec-all.h"
>>>>> +#include "hw/qdev-properties.h"
>>>>> +#if !defined(CONFIG_USER_ONLY)
>>>>> +#include "hw/loader.h"
>>>>> +#include "hw/boards.h"
>>>>> +#endif
>>>>> +#include "sysemu/sysemu.h"
>>>>> +#include "sysemu/tcg.h"
>>>>> +#include "sysemu/hw_accel.h"
>>>>> +#include "disas/capstone.h"
>>>>> +#include "fpu/softfloat.h"
>>>>
>>>> I guess some of those headers are not needed.
>>>
>>> Yeah, I just copy-n-pasted from the source file ... I'll check what can
>>> be omitted (if this patch series has a chance at all...)
>>>
>>>>> +
>>>>> +#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
>>>>> +
>>>>> +static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>>>> +{
>>>>> +    CPUClass *cc = CPU_GET_CLASS(cs);
>>>>> +    ARMCPU *cpu = ARM_CPU(cs);
>>>>> +    CPUARMState *env = &cpu->env;
>>>>> +    bool ret = false;
>>>>> +
>>>>> +    /*
>>>>> +     * ARMv7-M interrupt masking works differently than -A or -R.
>>>>> +     * There is no FIQ/IRQ distinction. Instead of I and F bits
>>>>> +     * masking FIQ and IRQ interrupts, an exception is taken only
>>>>> +     * if it is higher priority than the current execution priority
>>>>> +     * (which depends on state like BASEPRI, FAULTMASK and the
>>>>> +     * currently active exception).
>>>>> +     */
>>>>> +    if (interrupt_request & CPU_INTERRUPT_HARD
>>>>> +        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
>>>>
>>>> so what is the status wrt m_helper.c which stays unconditionally
>>>> compiled. m_helper functions seem to called from target/arm/translate.c
>>>> mostly. Have you abandoned the stub idea. It may be confusing to have 2
>>>> different helper files. At least a comment explaining where a new helper
>>>> shall go may be useful.
>>>
>>> All the HELPER() functions should definitely stay in m_helper.c. They
>>> are required for linking. Or do you prefer a stub file instead? Then we
>>> could maybe make the whole m_helper.c conditional in the Makefile.objs
>>> instead.
>>
>> I was simply referring to your previous approach:
>>
>> Applying [Qemu-devel] [RFC PATCH 3/3] target/arm: Make m_helper.c
>> optional via CONFIG_ARM_V7M seems to fix the issue
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00333.html
>>
>> It seems to work fine as it removes the call to armv7m_nvic.c functions
>> so no need to move the interrupt controller code?
> 
> Yes, but then we either need stubs in a separate file, or have to put
> lots of #ifdefs into translate.c ... none of those solutions seem to be
> really perfect :-(
Yep, the separate stub file looked cleaner to me.

> Anyway, Philippe is currently respinning his series (I think), so I'll
> postpone my work now to avoid to interfere with him.
OK

Thanks

Eric
> 
>  Thomas
> 

