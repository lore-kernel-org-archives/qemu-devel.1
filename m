Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C01C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354C220881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354C220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7Iq-0004wP-Cp
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi4BS-0005wf-3p
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi4BQ-0003Hv-UJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:49:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hi4BQ-0003GL-NF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:49:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id e3so5874591wrs.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=10yZI/muh+73lK/04GqqDUvPPHFVE9whFCtaqA1pr88=;
 b=RJsadcok8yPurPlrYieA4PKVhfkiml8eNb0hmoGbfJJLL4CFC2HZD8ZXrDfvuEfTWw
 Kdo39pbVfoKZAOPlsHpIhLIGI4tec0TpWhhLGX6rUh1OL0FmbA0aLIdWMmCrrmu04k/V
 LE7300ZvvVkb/48xyJlOvdRS5zE8PH6HDokZwcKbI3wSTzI3Y2Ps+/3oMPDKxUgjLNjV
 m5WmQ3kI/F1zPzejmbKfgzNCw8Sd1uyx+8EjSpBWqZdLQaEGFzE9gObMWme7f4g6EuUO
 9Ag5K+OfuhBhb8dFSmj/F65UX70Tot0W8Axz6r98K+CvoL648X3maIr+ktGUiUslFNQO
 mF+Q==
X-Gm-Message-State: APjAAAVZ/V9X/Hov7KdNHSnKPzKiXdp4KcyGl3Z5IZSiDRA2XM+k9bdf
 nMbNZIQpdCpnoLsugIDruSpBF0UZVSg=
X-Google-Smtp-Source: APXvYqzt2r1DkpMn3PhTB7ogdQ6ANa0Q6a2okCO1M8rO93+ZJikDEgItmjacHoHpMItWhsv2feijbg==
X-Received: by 2002:adf:f706:: with SMTP id r6mr10399997wrp.23.1561997449027; 
 Mon, 01 Jul 2019 09:10:49 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id p4sm11490618wrx.97.2019.07.01.09.10.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 09:10:47 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190701132516.26392-1-philmd@redhat.com>
 <20190701132516.26392-19-philmd@redhat.com>
 <CAFEAcA_XGuB5x+m5zmdBSE3bQP=jBdfWDzj_v0iBeqWmrETsng@mail.gmail.com>
 <c1d7b9cf-5a31-3c58-0284-97b4249660d7@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1888add4-ae43-43fe-d8c3-8aa447742330@redhat.com>
Date: Mon, 1 Jul 2019 18:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c1d7b9cf-5a31-3c58-0284-97b4249660d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 18/27] target/arm: Restrict semi-hosting
 to TCG
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 5:38 PM, Philippe Mathieu-Daudé wrote:
> On 7/1/19 5:25 PM, Peter Maydell wrote:
>> On Mon, 1 Jul 2019 at 14:26, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> Per Peter Maydell:
>>>
>>>   Semihosting hooks either SVC or HLT instructions, and inside KVM
>>>   both of those go to EL1, ie to the guest, and can't be trapped to
>>>   KVM.
>>>
>>> Let check_for_semihosting() return False when not running on TCG.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> v3: inline call to g_assert_not_reached if !TCG
>>> ---
>>>  target/arm/Makefile.objs | 2 +-
>>>  target/arm/cpu.h         | 7 +++++++
>>>  target/arm/helper.c      | 4 +++-
>>>  3 files changed, 11 insertions(+), 2 deletions(-)
>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index 49a0f05cd1..1b4da7aa45 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -20,7 +20,6 @@
>>>  #include "qemu/qemu-print.h"
>>>  #include "exec/exec-all.h"
>>>  #include "exec/cpu_ldst.h"
>>> -#include "arm_ldst.h"
>>>  #include <zlib.h> /* For crc32 */
>>>  #include "hw/semihosting/semihost.h"
>>>  #include "sysemu/cpus.h"
>>> @@ -29,6 +28,9 @@
>>>  #include "qapi/qapi-commands-target.h"
>>>  #include "qapi/error.h"
>>>  #include "qemu/guest-random.h"
>>> +#ifdef CONFIG_TCG
>>> +#include "arm_ldst.h"
>>> +#endif
>>
>> Should this ifdeffing of the arm_ldst.h include have gone in
>> another patch? It doesn't seem related to the change described
>> in the commit message.
> 
> Surely patch 22 "Move M profile routines to m_helper.c"

The ifdef belongs to this patch, but some part of this patch slipped to
"Move M profile routines to m_helper.c" while rebasing:

-- >8 --
@@ -10401,6 +8260,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState
*cs)

 static inline bool check_for_semihosting(CPUState *cs)
 {
+#ifdef CONFIG_TCG
     /* Check whether this exception is a semihosting call; if so
      * then handle it and return true; otherwise return false.
      */
@@ -10476,6 +8336,9 @@ static inline bool check_for_semihosting(CPUState
*cs)
         env->regs[0] = do_arm_semihosting(env);
         return true;
     }
+#else
+    return false;
+#endif
 }
---

check_for_semihosting() is the only code using the ldst API.

Thanks for noticing this,

Phil.

