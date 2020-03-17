Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9FAC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5B20757
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpjaduBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA1O-000192-4H
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEA06-0008Nl-DA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEA04-00010K-04
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEA03-0000nj-KD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id y2so9550746wrn.11
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0xnLWpO4Bf4H1OTQhvthcIH/niGVxDr0olqLnN0/Rwg=;
 b=hpjaduBU1HaTr3JKHjWZHobW5dz0eKP8VnL5eGfHQnJqav+fbjl3IBEkD3uwzIBuAe
 4ya6JwiXxqI6Pi94phHoHAG7cSKlnnH5xajFLSGltBPjryIEUHDng1Lx/JQOAu6KGFy/
 yks08J5AcayV4FiOK0usyVLrTh3DvO/Oip+kgoIX3bcfvG8aFAZPJOsZE7CqGZEKJlfo
 ksbAn2DPQqaGUmCPwI7azZvOr0ssmO508zsfXyGrJgdGnGIQvXbRoxTmgzqVzCkUAp7P
 zf2CIHIqiD9TmsJzs4c8ZxQkjKNfqirDw9z60lStij55wecamoH8fvxAN+FIYq14cwVi
 rIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0xnLWpO4Bf4H1OTQhvthcIH/niGVxDr0olqLnN0/Rwg=;
 b=kAXGPkCZgJgY3BkDUtKui8nDqC//JTF9ECxWZdpyZkGw25bneMbt+8VoPJ/9wC3d/c
 b+sgHvb4vtBFPfa9j9KQBF5kEml8uSPTqQhKA+ojmgrLbgdffwWNWmbyiHCqEwYY0lfN
 4047RLlN9Mx/Wl2RrkS2WeOeiBFJ+gWd0GEua+pZILtmd7nyUOZZ0kUd3BGL5n+XBFtC
 y2CuxSwNT/uRY0Fbf4kg7xJ8C5YFpF9I9HqSYiNJeEgxshjGXOnAOyJ2+ccmEFglx/ig
 YZF039UkhrTXQa/9Sv8/NcWuDxLe3dibJ18sLnLzxvnv9pMvDIOYiFo0UZv07OoBNyPM
 UA2w==
X-Gm-Message-State: ANhLgQ09by7MvZZat19ru2j6cWmUF06nD6eHze8P915LftF3IqJmc936
 WpBTktxNod43kkRHkDni+zScmw==
X-Google-Smtp-Source: ADFU+vumwO/Ukvm5MKWPCZGIqv94BmGEz5L7FxcaEDBgvCzkN+R3zQrha9WsPHDT2OigRgebxB9Vkw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr5386023wrj.196.1584442984713; 
 Tue, 17 Mar 2020 04:03:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b202sm3576049wmd.15.2020.03.17.04.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:03:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4236D1FF7E;
 Tue, 17 Mar 2020 11:03:02 +0000 (GMT)
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-21-alex.bennee@linaro.org>
 <18254420-c4a6-b8b6-a8cd-cad3b1d6e38b@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 20/28] tests/tcg/aarch64: userspace system register test
In-reply-to: <18254420-c4a6-b8b6-a8cd-cad3b1d6e38b@redhat.com>
Date: Tue, 17 Mar 2020 11:03:02 +0000
Message-ID: <87lfnzjlax.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
>> This tests a bunch of registers that the kernel allows userspace to
>> read including the CPUID registers. We need a SVE aware compiler as we
>> are testing the id_aa64zfr0_el1 register in the set.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20190205190224.2198-7-alex.bennee@linaro.org>
>> ---
>> vgdbstub
>>    - don't build unless using docker or CROSS_CC_HAS_SVE
>> ---
>>   tests/tcg/aarch64/sysregs.c       | 172 ++++++++++++++++++++++++++++++
>>   tests/tcg/aarch64/Makefile.target |   6 ++
>>   2 files changed, 178 insertions(+)
>>   create mode 100644 tests/tcg/aarch64/sysregs.c
>> diff --git a/tests/tcg/aarch64/sysregs.c
>> b/tests/tcg/aarch64/sysregs.c
>> new file mode 100644
>> index 00000000000..40cf8d2877e
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/sysregs.c
>> @@ -0,0 +1,172 @@
>> +/*
>> + * Check emulated system register access for linux-user mode.
>> + *
>> + * See: https://www.kernel.org/doc/Documentation/arm64/cpu-feature-regi=
sters.txt
>> + *
>> + * Copyright (c) 2019 Linaro
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <asm/hwcap.h>
>> +#include <stdio.h>
>> +#include <sys/auxv.h>
>> +#include <signal.h>
>> +#include <string.h>
>> +#include <stdbool.h>
>> +
>> +#ifndef HWCAP_CPUID
>> +#define HWCAP_CPUID (1 << 11)
>> +#endif
>> +
>> +int failed_bit_count;
>> +
>> +/* Read and print system register `id' value */
>> +#define get_cpu_reg(id) ({                                      \
>> +            unsigned long __val =3D 0xdeadbeef;                   \
>> +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
>> +            printf("%-20s: 0x%016lx\n", #id, __val);            \
>> +            __val;                                               \
>> +        })
>> +
>> +/* As above but also check no bits outside of `mask' are set*/
>> +#define get_cpu_reg_check_mask(id, mask) ({                     \
>> +            unsigned long __cval =3D get_cpu_reg(id);             \
>> +            unsigned long __extra =3D __cval & ~mask;             \
>> +            if (__extra) {                                      \
>> +                printf("%-20s: 0x%016lx\n", "  !!extra bits!!", __extra=
);   \
>> +                failed_bit_count++;                            \
>> +            }                                                   \
>> +})
>> +
>> +/* As above but check RAZ */
>> +#define get_cpu_reg_check_zero(id) ({                           \
>> +            unsigned long __val =3D 0xdeadbeef;                   \
>> +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
>> +            if (__val) {                                        \
>> +                printf("%-20s: 0x%016lx (not RAZ!)\n", #id, __val);    =
    \
>> +                failed_bit_count++;                            \
>> +            }                                                   \
>> +})
>> +
>> +/* Chunk up mask into 63:48, 47:32, 31:16, 15:0 to ease counting */
>> +#define _m(a, b, c, d) (0x ## a ## b ## c ## d ##ULL)
>> +
>> +bool should_fail;
>> +int should_fail_count;
>> +int should_not_fail_count;
>> +uintptr_t failed_pc[10];
>> +
>> +void sigill_handler(int signo, siginfo_t *si, void *data)
>> +{
>> +    ucontext_t *uc =3D (ucontext_t *)data;
>> +
>> +    if (should_fail) {
>> +        should_fail_count++;
>> +    } else {
>> +        uintptr_t pc =3D (uintptr_t) uc->uc_mcontext.pc;
>> +        failed_pc[should_not_fail_count++] =3D  pc;
>> +    }
>> +    uc->uc_mcontext.pc +=3D 4;
>> +}
>> +
>> +int main(void)
>> +{
>> +    struct sigaction sa;
>> +
>> +    /* Hook in a SIGILL handler */
>> +    memset(&sa, 0, sizeof(struct sigaction));
>> +    sa.sa_flags =3D SA_SIGINFO;
>> +    sa.sa_sigaction =3D &sigill_handler;
>> +    sigemptyset(&sa.sa_mask);
>> +
>> +    if (sigaction(SIGILL, &sa, 0) !=3D 0) {
>> +        perror("sigaction");
>> +        return 1;
>> +    }
>> +
>> +    /* Counter values have been exposed since Linux 4.12 */
>> +    printf("Checking Counter registers\n");
>> +
>> +    get_cpu_reg(ctr_el0);
>> +    get_cpu_reg(cntvct_el0);
>> +    get_cpu_reg(cntfrq_el0);
>> +
>> +    /* HWCAP_CPUID indicates we can read feature registers, since Linux=
 4.11 */
>> +    if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
>> +        printf("CPUID registers unavailable\n");
>> +        return 1;
>> +    } else {
>> +        printf("Checking CPUID registers\n");
>> +    }
>> +
>> +    /*
>> +     * Some registers only expose some bits to user-space. Anything
>> +     * that is IMPDEF is exported as 0 to user-space. The _mask checks
>> +     * assert no extra bits are set.
>> +     *
>> +     * This check is *not* comprehensive as some fields are set to
>> +     * minimum valid fields - for the purposes of this check allowed
>> +     * to have non-zero values.
>> +     */
>> +    get_cpu_reg_check_mask(id_aa64isar0_el1, _m(00ff,ffff,f0ff,fff0));
>> +    get_cpu_reg_check_mask(id_aa64isar1_el1, _m(0000,00f0,ffff,ffff));
>> +    /* TGran4 & TGran64 as pegged to -1 */
>> +    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(0000,0000,ff00,0000));
>> +    get_cpu_reg_check_zero(id_aa64mmfr1_el1);
>> +    /* EL1/EL0 reported as AA64 only */
>> +    get_cpu_reg_check_mask(id_aa64pfr0_el1,  _m(000f,000f,00ff,0011));
>> +    get_cpu_reg_check_mask(id_aa64pfr1_el1,  _m(0000,0000,0000,00f0));
>> +    /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
>> +    get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
>> +    get_cpu_reg_check_zero(id_aa64dfr1_el1);
>> +    get_cpu_reg_check_zero(id_aa64zfr0_el1);
>> +
>> +    get_cpu_reg_check_zero(id_aa64afr0_el1);
>> +    get_cpu_reg_check_zero(id_aa64afr1_el1);
>> +
>> +    get_cpu_reg_check_mask(midr_el1,         _m(0000,0000,ffff,ffff));
>> +    /* mpidr sets bit 31, everything else hidden */
>> +    get_cpu_reg_check_mask(mpidr_el1,        _m(0000,0000,8000,0000));
>> +    /* REVIDR is all IMPDEF so should be all zeros to user-space */
>> +    get_cpu_reg_check_zero(revidr_el1);
>> +
>> +    /*
>> +     * There are a block of more registers that are RAZ in the rest of
>> +     * the Op0=3D3, Op1=3D0, CRn=3D0, CRm=3D0,4,5,6,7 space. However for
>> +     * brevity we don't check stuff that is currently un-allocated
>> +     * here. Feel free to add them ;-)
>> +     */
>> +
>> +    printf("Remaining registers should fail\n");
>> +    should_fail =3D true;
>> +
>> +    /* Unexposed register access causes SIGILL */
>> +    get_cpu_reg(id_mmfr0_el1);
>> +    get_cpu_reg(id_mmfr1_el1);
>> +    get_cpu_reg(id_mmfr2_el1);
>> +    get_cpu_reg(id_mmfr3_el1);
>> +
>> +    get_cpu_reg(mvfr0_el1);
>> +    get_cpu_reg(mvfr1_el1);
>> +
>> +    if (should_not_fail_count > 0) {
>> +        int i;
>> +        for (i =3D 0; i < should_not_fail_count; i++) {
>> +            uintptr_t pc =3D failed_pc[i];
>> +            uint32_t insn =3D *(uint32_t *) pc;
>> +            printf("insn %#x @ %#lx unexpected FAIL\n", insn, pc);
>> +        }
>> +        return 1;
>> +    }
>> +
>> +    if (failed_bit_count > 0) {
>> +        printf("Extra information leaked to user-space!\n");
>> +        return 1;
>> +    }
>> +
>> +    return should_fail_count =3D=3D 6 ? 0 : 1;
>> +}
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makef=
ile.target
>> index 8ed477d0d51..a25afc071cc 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -42,4 +42,10 @@ run-semiconsole: semiconsole
>>   run-plugin-semiconsole-with-%:
>>   	$(call skip-test, $<, "MANUAL ONLY")
>>   +ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
>> +# System Registers Tests
>> +AARCH64_TESTS +=3D sysregs
>> +sysregs: CFLAGS+=3D-march=3Darmv8.1-a+sve
>> +endif
>> +
>>   TESTS +=3D $(AARCH64_TESTS)
>>=20
>
> warning: while parsing target description (at line 47): Vector
> "vq128hf" references undefined type "ieee_half"
> warning: Could not load XML target description; ignoring
> *** stack smashing detected ***: <unknown> terminated

How? That test doesn't even use the gdbstub.

>
> (GCC 9.2.1, Fedora 30)


--=20
Alex Benn=C3=A9e

