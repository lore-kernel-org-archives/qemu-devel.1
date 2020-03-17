Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B76C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DEE206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hov/rdBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DEE206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59265 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAfR-0001O0-RQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEAcq-0005CL-Qp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEAco-0000Iy-36
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:43:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEAcn-0000Bc-Rx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584445389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20ZdneqOSlTomJxxeURY4Yn0mYCpnAG9b5XaayzYKQs=;
 b=hov/rdBeTqlhFQz4eKyw7c8cVTDzQg+o7NmncI8Att9mC7VeRvQKYv0YBstcGZat8qx147
 5b5EP30gwcrhiCU2srI5TwgR0EL9oMk47+pGTU2GBkbODOj+XIxf20rhXSrlDRBNc3cf2s
 69sow6eI1oZHIWbB/LnSGArEYDKQXzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-iLWyYdoWNvij9kXyGQKxOA-1; Tue, 17 Mar 2020 07:43:05 -0400
X-MC-Unique: iLWyYdoWNvij9kXyGQKxOA-1
Received: by mail-wm1-f71.google.com with SMTP id y7so7032983wmd.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WM8S8npTsS02n37DFAyG5zxa+Q37hBP7LfiJwp+F5w8=;
 b=UtZizHjPlfK7byiEOVQzjk1TP7KGuv7IpdZT2wE/EKwnE8HvTgy/KniF1d+Tww2gUh
 fQzhxAnxajvtg3z6wzll/coT3qCYkEYPGYv1qgblUy+ESj9MiqNQ0g5VmhchJ/v2RDLJ
 LOb+bXKxgrRYutJ5klqPOrJq2amMbUv77hkSjgKRqGFGTOpprlvEd8py+d12EqpSI6Um
 ZWPOW7TDVIbhn7SD/0BCEUiW85welgi1jqTCE+dx0+XSCVKr2vcrl/6FVz0PWkm+bVWr
 Wv/AvtJAh92L7mJm6RGBxAQExmCnFhCXA0ZGaSW5yCtiJGalq4gzjz3uMDEs4ciXuJQf
 5Vvw==
X-Gm-Message-State: ANhLgQ1IAeHMDsObkEjY/IHvVBja80OL9kcnI6WYSuvgnrrf3HN1HGhb
 ztT5pKcc9O/DAh2Ubo9bZyvvZPQr4kUkr2KJ4KMM78Z4KBh5FmpWgJyBTxU2SZxhSClJApW6BxT
 t7R8bv5hkmzhfZ5Y=
X-Received: by 2002:a1c:bb86:: with SMTP id l128mr4839142wmf.41.1584445383853; 
 Tue, 17 Mar 2020 04:43:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vto9M9/cdzSGWcCjIbpDeytsQdg6Ir8AdGjsHyuD1KGMKZ5cj+otErPvKynV1dW4U19EEdnLw==
X-Received: by 2002:a1c:bb86:: with SMTP id l128mr4839110wmf.41.1584445383444; 
 Tue, 17 Mar 2020 04:43:03 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b10sm4341649wrm.30.2020.03.17.04.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 04:43:02 -0700 (PDT)
Subject: Re: [PATCH v1 20/28] tests/tcg/aarch64: userspace system register test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-21-alex.bennee@linaro.org>
 <18254420-c4a6-b8b6-a8cd-cad3b1d6e38b@redhat.com> <87lfnzjlax.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17987391-ad3c-5671-831f-0d36aa2c93b2@redhat.com>
Date: Tue, 17 Mar 2020 12:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87lfnzjlax.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On 3/17/20 12:03 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
>>> This tests a bunch of registers that the kernel allows userspace to
>>> read including the CPUID registers. We need a SVE aware compiler as we
>>> are testing the id_aa64zfr0_el1 register in the set.
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-Id: <20190205190224.2198-7-alex.bennee@linaro.org>
>>> ---
>>> vgdbstub
>>>     - don't build unless using docker or CROSS_CC_HAS_SVE
>>> ---
>>>    tests/tcg/aarch64/sysregs.c       | 172 ++++++++++++++++++++++++++++=
++
>>>    tests/tcg/aarch64/Makefile.target |   6 ++
>>>    2 files changed, 178 insertions(+)
>>>    create mode 100644 tests/tcg/aarch64/sysregs.c
>>> diff --git a/tests/tcg/aarch64/sysregs.c
>>> b/tests/tcg/aarch64/sysregs.c
>>> new file mode 100644
>>> index 00000000000..40cf8d2877e
>>> --- /dev/null
>>> +++ b/tests/tcg/aarch64/sysregs.c
>>> @@ -0,0 +1,172 @@
>>> +/*
>>> + * Check emulated system register access for linux-user mode.
>>> + *
>>> + * See: https://www.kernel.org/doc/Documentation/arm64/cpu-feature-reg=
isters.txt
>>> + *
>>> + * Copyright (c) 2019 Linaro
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
>>> + * See the COPYING file in the top-level directory.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include <asm/hwcap.h>
>>> +#include <stdio.h>
>>> +#include <sys/auxv.h>
>>> +#include <signal.h>
>>> +#include <string.h>
>>> +#include <stdbool.h>
>>> +
>>> +#ifndef HWCAP_CPUID
>>> +#define HWCAP_CPUID (1 << 11)
>>> +#endif
>>> +
>>> +int failed_bit_count;
>>> +
>>> +/* Read and print system register `id' value */
>>> +#define get_cpu_reg(id) ({                                      \
>>> +            unsigned long __val =3D 0xdeadbeef;                   \
>>> +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
>>> +            printf("%-20s: 0x%016lx\n", #id, __val);            \
>>> +            __val;                                               \
>>> +        })
>>> +
>>> +/* As above but also check no bits outside of `mask' are set*/
>>> +#define get_cpu_reg_check_mask(id, mask) ({                     \
>>> +            unsigned long __cval =3D get_cpu_reg(id);             \
>>> +            unsigned long __extra =3D __cval & ~mask;             \
>>> +            if (__extra) {                                      \
>>> +                printf("%-20s: 0x%016lx\n", "  !!extra bits!!", __extr=
a);   \
>>> +                failed_bit_count++;                            \
>>> +            }                                                   \
>>> +})
>>> +
>>> +/* As above but check RAZ */
>>> +#define get_cpu_reg_check_zero(id) ({                           \
>>> +            unsigned long __val =3D 0xdeadbeef;                   \
>>> +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
>>> +            if (__val) {                                        \
>>> +                printf("%-20s: 0x%016lx (not RAZ!)\n", #id, __val);   =
     \
>>> +                failed_bit_count++;                            \
>>> +            }                                                   \
>>> +})
>>> +
>>> +/* Chunk up mask into 63:48, 47:32, 31:16, 15:0 to ease counting */
>>> +#define _m(a, b, c, d) (0x ## a ## b ## c ## d ##ULL)
>>> +
>>> +bool should_fail;
>>> +int should_fail_count;
>>> +int should_not_fail_count;
>>> +uintptr_t failed_pc[10];
>>> +
>>> +void sigill_handler(int signo, siginfo_t *si, void *data)
>>> +{
>>> +    ucontext_t *uc =3D (ucontext_t *)data;
>>> +
>>> +    if (should_fail) {
>>> +        should_fail_count++;
>>> +    } else {
>>> +        uintptr_t pc =3D (uintptr_t) uc->uc_mcontext.pc;
>>> +        failed_pc[should_not_fail_count++] =3D  pc;
>>> +    }
>>> +    uc->uc_mcontext.pc +=3D 4;
>>> +}
>>> +
>>> +int main(void)
>>> +{
>>> +    struct sigaction sa;
>>> +
>>> +    /* Hook in a SIGILL handler */
>>> +    memset(&sa, 0, sizeof(struct sigaction));
>>> +    sa.sa_flags =3D SA_SIGINFO;
>>> +    sa.sa_sigaction =3D &sigill_handler;
>>> +    sigemptyset(&sa.sa_mask);
>>> +
>>> +    if (sigaction(SIGILL, &sa, 0) !=3D 0) {
>>> +        perror("sigaction");
>>> +        return 1;
>>> +    }
>>> +
>>> +    /* Counter values have been exposed since Linux 4.12 */
>>> +    printf("Checking Counter registers\n");
>>> +
>>> +    get_cpu_reg(ctr_el0);
>>> +    get_cpu_reg(cntvct_el0);
>>> +    get_cpu_reg(cntfrq_el0);
>>> +
>>> +    /* HWCAP_CPUID indicates we can read feature registers, since Linu=
x 4.11 */
>>> +    if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
>>> +        printf("CPUID registers unavailable\n");
>>> +        return 1;
>>> +    } else {
>>> +        printf("Checking CPUID registers\n");
>>> +    }
>>> +
>>> +    /*
>>> +     * Some registers only expose some bits to user-space. Anything
>>> +     * that is IMPDEF is exported as 0 to user-space. The _mask checks
>>> +     * assert no extra bits are set.
>>> +     *
>>> +     * This check is *not* comprehensive as some fields are set to
>>> +     * minimum valid fields - for the purposes of this check allowed
>>> +     * to have non-zero values.
>>> +     */
>>> +    get_cpu_reg_check_mask(id_aa64isar0_el1, _m(00ff,ffff,f0ff,fff0));
>>> +    get_cpu_reg_check_mask(id_aa64isar1_el1, _m(0000,00f0,ffff,ffff));
>>> +    /* TGran4 & TGran64 as pegged to -1 */
>>> +    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(0000,0000,ff00,0000));
>>> +    get_cpu_reg_check_zero(id_aa64mmfr1_el1);
>>> +    /* EL1/EL0 reported as AA64 only */
>>> +    get_cpu_reg_check_mask(id_aa64pfr0_el1,  _m(000f,000f,00ff,0011));
>>> +    get_cpu_reg_check_mask(id_aa64pfr1_el1,  _m(0000,0000,0000,00f0));
>>> +    /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
>>> +    get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
>>> +    get_cpu_reg_check_zero(id_aa64dfr1_el1);
>>> +    get_cpu_reg_check_zero(id_aa64zfr0_el1);
>>> +
>>> +    get_cpu_reg_check_zero(id_aa64afr0_el1);
>>> +    get_cpu_reg_check_zero(id_aa64afr1_el1);
>>> +
>>> +    get_cpu_reg_check_mask(midr_el1,         _m(0000,0000,ffff,ffff));
>>> +    /* mpidr sets bit 31, everything else hidden */
>>> +    get_cpu_reg_check_mask(mpidr_el1,        _m(0000,0000,8000,0000));
>>> +    /* REVIDR is all IMPDEF so should be all zeros to user-space */
>>> +    get_cpu_reg_check_zero(revidr_el1);
>>> +
>>> +    /*
>>> +     * There are a block of more registers that are RAZ in the rest of
>>> +     * the Op0=3D3, Op1=3D0, CRn=3D0, CRm=3D0,4,5,6,7 space. However f=
or
>>> +     * brevity we don't check stuff that is currently un-allocated
>>> +     * here. Feel free to add them ;-)
>>> +     */
>>> +
>>> +    printf("Remaining registers should fail\n");
>>> +    should_fail =3D true;
>>> +
>>> +    /* Unexposed register access causes SIGILL */
>>> +    get_cpu_reg(id_mmfr0_el1);
>>> +    get_cpu_reg(id_mmfr1_el1);
>>> +    get_cpu_reg(id_mmfr2_el1);
>>> +    get_cpu_reg(id_mmfr3_el1);
>>> +
>>> +    get_cpu_reg(mvfr0_el1);
>>> +    get_cpu_reg(mvfr1_el1);
>>> +
>>> +    if (should_not_fail_count > 0) {
>>> +        int i;
>>> +        for (i =3D 0; i < should_not_fail_count; i++) {
>>> +            uintptr_t pc =3D failed_pc[i];
>>> +            uint32_t insn =3D *(uint32_t *) pc;
>>> +            printf("insn %#x @ %#lx unexpected FAIL\n", insn, pc);
>>> +        }
>>> +        return 1;
>>> +    }
>>> +
>>> +    if (failed_bit_count > 0) {
>>> +        printf("Extra information leaked to user-space!\n");
>>> +        return 1;
>>> +    }
>>> +
>>> +    return should_fail_count =3D=3D 6 ? 0 : 1;
>>> +}
>>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Make=
file.target
>>> index 8ed477d0d51..a25afc071cc 100644
>>> --- a/tests/tcg/aarch64/Makefile.target
>>> +++ b/tests/tcg/aarch64/Makefile.target
>>> @@ -42,4 +42,10 @@ run-semiconsole: semiconsole
>>>    run-plugin-semiconsole-with-%:
>>>    =09$(call skip-test, $<, "MANUAL ONLY")
>>>    +ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
>>> +# System Registers Tests
>>> +AARCH64_TESTS +=3D sysregs
>>> +sysregs: CFLAGS+=3D-march=3Darmv8.1-a+sve
>>> +endif
>>> +
>>>    TESTS +=3D $(AARCH64_TESTS)
>>>
>>
>> warning: while parsing target description (at line 47): Vector
>> "vq128hf" references undefined type "ieee_half"
>> warning: Could not load XML target description; ignoring
>> *** stack smashing detected ***: <unknown> terminated
>=20
> How? That test doesn't even use the gdbstub.

This is a bug in my gdb :/

GNU gdb (GDB) Fedora 8.3-7.fc30
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later=20
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from sysregs...
Remote debugging using localhost:1234
warning: while parsing target description (at line 47): Vector "vq128hf"=20
references undefined type "ieee_half"
warning: Could not load XML target description; ignoring
0x0000000000400498 in _start ()
PASS: connected to aarch64
x0             0x0                 0
x1             0x0                 0
x2             0x0                 0
x3             0x0                 0
x4             0x0                 0
x5             0x0                 0
x6             0x0                 0
x7             0x0                 0
x8             0x0                 0
x9             0x0                 0
x10            0x0                 0
x11            0x0                 0
x12            0x0                 0
x13            0x0                 0
x14            0x0                 0
x15            0x0                 0
x16            0x0                 0
x17            0x0                 0
x18            0x0                 0
x19            0x0                 0
x20            0x0                 0
x21            0x0                 0
x22            0x0                 0
x23            0x0                 0
x24            0x0                 0
x25            0x0                 0
x26            0x0                 0
x27            0x0                 0
x28            0x0                 0
x29            0x0                 0
x30            0x0                 0
sp             0x40007ff0d0        0x40007ff0d0
pc             0x400498            0x400498 <_start>
cpsr           0x40000000          [ EL=3D0 Z ]
fpsr           0x0                 0
fpcr           0x0                 0
PASS: info registers
*** stack smashing detected ***: <unknown> terminated
Aborted (core dumped)

(gdb) bt
#0  0x00007f9036e02e35 in raise () from /lib64/libc.so.6
#1  0x00007f9036ded895 in abort () from /lib64/libc.so.6
#2  0x00007f9036e4608f in __libc_message () from /lib64/libc.so.6
#3  0x00007f9036ed6ce5 in __fortify_fail_abort () from /lib64/libc.so.6
#4  0x00007f9036ed6c98 in __stack_chk_fail () from /lib64/libc.so.6
#5  0x0000562619e27191 in remote_target::fetch_register_using_p=20
(this=3D<optimized out>, regcache=3D0x56261ab84430, reg=3D0x56261ab09140) a=
t=20
../../gdb/remote.c:7959
#6  0x0000000000000000 in ?? ()

>=20
>>
>> (GCC 9.2.1, Fedora 30)
>=20
>=20


