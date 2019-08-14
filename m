Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C62C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 09:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829D720843
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u63KaraT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829D720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxpSV-0002XE-Bx
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 05:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hxpRn-0001uV-ND
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxpRm-0001YG-CS
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:19:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxpRm-0001Xh-5h
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:19:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id 10so3928446wmp.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GVC3eqOMw6fknTK4q6WWr4vN9hd/YLEAouWGFY8rMTc=;
 b=u63KaraTAAI+H/LraewtxrRE+lmlfi2yNaBTrKJi0wwyTiamIwybI974620899XESm
 gS87+zlmbb8oOxLpuWX53VK9LRT/GI9jvXCB2OO9KrQKeS7x1RNEh8OjLCloECqSKHtC
 k1iWN291t+RE3iSnEJRh2yN1DZhs+p+0hmeGTei1f++gkhMLRnWJGzwnQ8fwbPWAegeo
 1hCCaWgmsSz42EKgc6xk1QF1S7dAoIst+TN4C7RcnXX6fzX0sUqd5obLuz5CdXJKed8W
 FW5oZ9FKs7HEucF4/ARoVL/g+nupTT1b9GHyr3gyKrcnYcxFLbf/lBi4jjJOcRxnQvrI
 5eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GVC3eqOMw6fknTK4q6WWr4vN9hd/YLEAouWGFY8rMTc=;
 b=D7fJx98rL+cOf5kKI73jhm6cMOq7fm3E0/FMOOFGAK532rG1PxSwPT+vsL5qMIkTPB
 itDIM6lfBQbWGR/NsUsc4bDXyjzne5yoBkGzMPEKeH2LcXwjNZCEv5EUz4vOm5cXDv4I
 29xwJty3qrMP88V5kz+L6ecgNK//LaGTmngus93m7KcuvzE/Gtuw9Bx7LlaJU4v2hmt2
 y8t/HYmyIAde0tRl4sTguEMSYtdpMYxXgIjsNhDXqMPifkyDeaQ2QwX/Y32wyN2krNWC
 DKYxx9YJbCsNpOgjcXgU+rGbp32zckfOrM1U3pHTVbzV37UcDV4pSmUGE9uKWmu/v2gq
 queA==
X-Gm-Message-State: APjAAAW/eyj9+F6DzLOp9jHAroFx0X+t6RYp8qLkL1NwU4LyEm1LQhjL
 of6nYdVMzqagUoJJ0gbHdhgbNA==
X-Google-Smtp-Source: APXvYqy0CZetN9PiQK0eciLbMuWeiUd66hSv4+OGiBLeaQmxtR2z7L9sQP2NidstsTVKQB1Cy2060Q==
X-Received: by 2002:a1c:494:: with SMTP id 142mr7204869wme.12.1565774396381;
 Wed, 14 Aug 2019 02:19:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p186sm763581wme.9.2019.08.14.02.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 02:19:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 505CA1FF87;
 Wed, 14 Aug 2019 10:19:55 +0100 (BST)
References: <CAKmqyKNPW=Jtp3PUdwuSzjNE7g58WdureNxAWUnK_KZ-Z17HnQ@mail.gmail.com>
 <mhng-5f5b5d32-dff8-45cd-9644-dd40e502fca1@palmer-si-x1e>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Palmer Dabbelt <palmer@sifive.com>
In-reply-to: <mhng-5f5b5d32-dff8-45cd-9644-dd40e502fca1@palmer-si-x1e>
Date: Wed, 14 Aug 2019 10:19:55 +0100
Message-ID: <87y2zwm7d0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target/riscv: rationalise softfloat
 includes
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Palmer Dabbelt <palmer@sifive.com> writes:

> On Fri, 09 Aug 2019 18:55:42 PDT (-0700), alistair23@gmail.com wrote:
>> On Fri, Aug 9, 2019 at 2:22 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>>
>>> We should avoid including the whole of softfloat headers in cpu.h and
>>> explicitly include it only where we will be calling softfloat
>>> functions. We can use the -types.h and -helpers.h in cpu.h for the few
>>> bits that are global.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> I just reviewed v1, but this also applies to v2:
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Acked-by: Palmer Dabbelt <palmer@sifive.com>
>
> I'm assuming this are going in through another tree, along with the
> rest of the patch set.

It will yes..

>
>>
>> Alistair
>>
>>> ---
>>>  target/riscv/cpu.c        | 1 +
>>>  target/riscv/cpu.h        | 2 +-
>>>  target/riscv/fpu_helper.c | 1 +
>>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index f8d07bd20ad..6d52f97d7c3 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -27,6 +27,7 @@
>>>  #include "qemu/error-report.h"
>>>  #include "hw/qdev-properties.h"
>>>  #include "migration/vmstate.h"
>>> +#include "fpu/softfloat-helpers.h"
>>>
>>>  /* RISC-V CPU definitions */
>>>
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 0adb307f329..240b31e2ebb 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -22,7 +22,7 @@
>>>
>>>  #include "qom/cpu.h"
>>>  #include "exec/cpu-defs.h"
>>> -#include "fpu/softfloat.h"
>>> +#include "fpu/softfloat-types.h"
>>>
>>>  #define TCG_GUEST_DEFAULT_MO 0
>>>
>>> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
>>> index b4f818a6465..0b79562a690 100644
>>> --- a/target/riscv/fpu_helper.c
>>> +++ b/target/riscv/fpu_helper.c
>>> @@ -21,6 +21,7 @@
>>>  #include "qemu/host-utils.h"
>>>  #include "exec/exec-all.h"
>>>  #include "exec/helper-proto.h"
>>> +#include "fpu/softfloat.h"
>>>
>>>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>>>  {
>>> --
>>> 2.20.1


--
Alex Benn=C3=A9e

