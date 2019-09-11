Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA27AECDE2B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6722168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joRG+76v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6722168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xrH-0003rv-AN
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7xqN-0003NQ-R4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7xqL-0004ck-CW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:19:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7xqL-0004cG-1Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:19:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id q14so23394873wrm.9
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AWSV7ZnKLqDGcd+KB5NLq3SaRjOqYV67qQEROOwQsW4=;
 b=joRG+76vF8WRlxtbDV7nkKkg2svwLTZ29rc9X9Y0/z1m+SubFHuHs2JX/OQW0my7/3
 8lRClnNZxcNz6H2fyEgNTV41a2pRlCEyMMJo/b7Hp/bYlYRD/0iTZa3uN3IK9ZTAkXVd
 krpIeFlcxYnVNCrF+hmr6xp422XclomBxN+b6H5gsN474Q5q3YNP5zrReyp8osDHmc12
 dgzRQeHFFgeIZi8VPwmmywJRpd1U9Ys86M21ZquFXPFinJxVw0OQnG41xyx7cY5qO66x
 Rtuip4bQLCe/K3nxTneDu9nfCeyg8PVS+fCTQ4zbVVw7IHjouQepBvx5fzU+HYK0r1bd
 ONrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AWSV7ZnKLqDGcd+KB5NLq3SaRjOqYV67qQEROOwQsW4=;
 b=UprtV5tfG1rSqmWX5+zsttX/mfZe6itmKdkw7Mu4DcPABjKUcJKdvwzPKgmZQS5AUM
 b3iJbHSBA4galsNpOtIar5hmxVcHqaFufQ+DSFz2TSP+Jt3770cExI/kkAEipeTvFVpn
 VU240ev7MgqEEcRuZg6U7gSKup2V/+MugP75rI8/cOFXQO4QHKAGEXmoW1az2fciZ0vs
 HpJndpEI6D8ErAbBm1kE2fok9NHWDrgz0OTF/xlhXXdE88hParW4UhDZq7BENv83HO//
 RUEzSawjd5sfn5XMJudT7/u5NhSFj7OomDD9D4S/vUu6SuTdFeslU336bUpVbA+bLXef
 K+fA==
X-Gm-Message-State: APjAAAXncb9NyzQ1BdPgitDeeBF4t+71E28B8ascBaAXyWkq5TzWnvV3
 b+12UECGXVA+/lzJNwCBgyoiFA==
X-Google-Smtp-Source: APXvYqzJnBFDaomqOr4iOBox+/CBKOAb5hjtzdpnWi7s+6X5TcAdlz09sOOzduwWuuRe980yaYORXw==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr10725867wrv.274.1568189951364; 
 Wed, 11 Sep 2019 01:19:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm1835653wmf.20.2019.09.11.01.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:19:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AAF261FF87;
 Wed, 11 Sep 2019 09:19:09 +0100 (BST)
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-5-alex.bennee@linaro.org>
 <CAL1e-=gLPs_o0jYB-inWGgWP7yST-k7XzbYgxu110ycGvTzDkg@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
In-reply-to: <CAL1e-=gLPs_o0jYB-inWGgWP7yST-k7XzbYgxu110ycGvTzDkg@mail.gmail.com>
Date: Wed, 11 Sep 2019 09:19:09 +0100
Message-ID: <87a7bb1c02.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: Re: [Qemu-devel] [PATCH v1 4/4] elf: move ELF_ARCH definition to
 elf-arch.h
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> 10.09.2019. 21.34, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> This is preparatory for plugins which will want to report the
>> architecture to plugins. Move the ELF_ARCH definition out of the
>> loader and into its own header.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>
> ELF_ARCH is and has been used exclusively locally within elfload.c, and
> some architectures use it in a specific way, which is perfectly legal in
> the current code organization, and I have certain reservations about this
> attempt to suddenly attach additional responsibility to these
> constants -

It is used locally for elfload (and was duplicated at that - as there is
a bsd and linux version). All it really does is translate the Elf
standard code for a guest architecture into a common symbol for the
benefit of common code. There is perhaps an argument this would be
better set in config-target.mak/h as it is something we could even know
at configure time.

> "reporting" to some unspecified plugin. In simpler words, it seems to me
> that you are trying to use a thing for something it was not meant to.

The discussion around the plugin is in the thread:

  Subject: [PATCH  v4 00/54] plugins for TCG
  Date: Wed, 31 Jul 2019 17:06:25 +0100
  Message-Id: <20190731160719.11396-1-alex.bennee@linaro.org>

but essentially it would be nice if the plugin could be told what the
guest architecture is so it could either not attempt to initialise or
maybe change how it sets itself up. We could either come up with a QEMU
specific enumeration or perhaps report the TARGET_NAME string but given
the Elf spec defines a bunch of constants why not re-use them?

>
> Also, it would be better if you cc-ed corresponding architecture
> submaintainers.

I was relying on get_maintainer.pl but it doesn't really deal with these
common code cases that well. However they should all be CC'd on the main
movement patch as it touches a lot of subdirs:

  [PATCH  v1 2/4] elf: move elf.h to elf/elf.h and split out types

which should hopefully give them visibility of the thread.

>
> Yours, Aleksandar
>
>>  bsd-user/elfload.c     |  13 +----
>>  include/elf/elf-arch.h | 109 +++++++++++++++++++++++++++++++++++++++++
>>  linux-user/elfload.c   |  27 ++--------
>>  3 files changed, 115 insertions(+), 34 deletions(-)
>>  create mode 100644 include/elf/elf-arch.h
>>
>> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
>> index 321ee98b86b..adaae0e0dca 100644
>> --- a/bsd-user/elfload.c
>> +++ b/bsd-user/elfload.c
>> @@ -5,6 +5,7 @@
>>  #include "qemu.h"
>>  #include "disas/disas.h"
>>  #include "qemu/path.h"
>> +#include "elf/elf-arch.h"
>>
>>  #ifdef _ARCH_PPC64
>>  #undef ARCH_DLINFO
>> @@ -12,7 +13,6 @@
>>  #undef ELF_HWCAP
>>  #undef ELF_CLASS
>>  #undef ELF_DATA
>> -#undef ELF_ARCH
>>  #endif
>>
>>  /* from personality.h */
>> @@ -115,7 +115,6 @@ static uint32_t get_elf_hwcap(void)
>>
>>  #define ELF_CLASS      ELFCLASS64
>>  #define ELF_DATA       ELFDATA2LSB
>> -#define ELF_ARCH       EM_X86_64
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -141,7 +140,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>   */
>>  #define ELF_CLASS       ELFCLASS32
>>  #define ELF_DATA        ELFDATA2LSB
>> -#define ELF_ARCH        EM_386
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -176,7 +174,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>  #else
>>  #define ELF_DATA        ELFDATA2LSB
>>  #endif
>> -#define ELF_ARCH        EM_ARM
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -231,7 +228,6 @@ enum
>>
>>  #define ELF_CLASS   ELFCLASS64
>>  #define ELF_DATA    ELFDATA2MSB
>> -#define ELF_ARCH    EM_SPARCV9
>>
>>  #define STACK_BIAS              2047
>>
>> @@ -265,7 +261,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>
>>  #define ELF_CLASS   ELFCLASS32
>>  #define ELF_DATA    ELFDATA2MSB
>> -#define ELF_ARCH    EM_SPARC
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -302,7 +297,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>  #else
>>  #define ELF_DATA        ELFDATA2LSB
>>  #endif
>> -#define ELF_ARCH        EM_PPC
>>
>>  /*
>>   * We need to put in some extra aux table entries to tell glibc what
>> @@ -388,7 +382,6 @@ static inline void init_thread(struct target_pt_regs
> *_regs, struct image_info *
>>  #else
>>  #define ELF_DATA        ELFDATA2LSB
>>  #endif
>> -#define ELF_ARCH    EM_MIPS
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -410,7 +403,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>
>>  #define ELF_CLASS ELFCLASS32
>>  #define ELF_DATA  ELFDATA2LSB
>> -#define ELF_ARCH  EM_SH
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -432,7 +424,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>
>>  #define ELF_CLASS ELFCLASS32
>>  #define ELF_DATA  ELFDATA2LSB
>> -#define ELF_ARCH  EM_CRIS
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -452,7 +443,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>
>>  #define ELF_CLASS       ELFCLASS32
>>  #define ELF_DATA        ELFDATA2MSB
>> -#define ELF_ARCH        EM_68K
>>
>>  /* ??? Does this need to do anything?
>>  #define ELF_PLAT_INIT(_r) */
>> @@ -477,7 +467,6 @@ static inline void init_thread(struct target_pt_regs
> *regs, struct image_info *i
>>
>>  #define ELF_CLASS      ELFCLASS64
>>  #define ELF_DATA       ELFDATA2MSB
>> -#define ELF_ARCH       EM_ALPHA
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> diff --git a/include/elf/elf-arch.h b/include/elf/elf-arch.h
>> new file mode 100644
>> index 00000000000..9e052543c51
>> --- /dev/null
>> +++ b/include/elf/elf-arch.h
>> @@ -0,0 +1,109 @@
>> +/*
>> + * Elf Architecture Definition
>> + *
>> + * This is a simple expansion to define common Elf types for the
>> + * various machines for the various places it's needed in the source
>> + * tree.
>> + *
>> + * Copyright (c) 2019 Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef _ELF_ARCH_H_
>> +#define _ELF_ARCH_H_
>> +
>> +#include "elf/elf.h"
>> +
>> +#ifndef NEED_CPU_H
>> +#error Needs an target definition
>> +#endif
>> +
>> +#ifdef ELF_ARCH
>> +#error ELF_ARCH should only be defined once in this file
>> +#endif
>> +
>> +#ifdef TARGET_I386
>> +#ifdef TARGET_X86_64
>> +#define ELF_ARCH EM_X86_64
>> +#else
>> +#define ELF_ARCH EM_386
>> +#endif
>> +#endif
>> +
>> +#ifdef TARGET_ARM
>> +#ifndef TARGET_AARCH64
>> +#define ELF_ARCH EM_ARM
>> +#else
>> +#define ELF_ARCH EM_AARCH64
>> +#endif
>> +#endif
>> +
>> +#ifdef TARGET_SPARC
>> +#ifdef TARGET_SPARC64
>> +#define ELF_ARCH EM_SPARCV9
>> +#else
>> +#define ELF_ARCH EM_SPARC
>> +#endif
>> +#endif
>> +
>> +#ifdef TARGET_PPC
>> +#define ELF_ARCH EM_PPC
>> +#endif
>> +
>> +#ifdef TARGET_MIPS
>> +#define ELF_ARCH EM_MIPS
>> +#endif
>> +
>> +#ifdef TARGET_MICROBLAZE
>> +#define ELF_ARCH EM_MICROBLAZE
>> +#endif
>> +
>> +#ifdef TARGET_NIOS2
>> +#define ELF_ARCH EM_ALTERA_NIOS2
>> +#endif
>> +
>> +#ifdef TARGET_OPENRISC
>> +#define ELF_ARCH EM_OPENRISC
>> +#endif
>> +
>> +#ifdef TARGET_SH4
>> +#define ELF_ARCH EM_SH
>> +#endif
>> +
>> +#ifdef TARGET_CRIS
>> +#define ELF_ARCH EM_CRIS
>> +#endif
>> +
>> +#ifdef TARGET_M68K
>> +#define ELF_ARCH EM_68K
>> +#endif
>> +
>> +#ifdef TARGET_ALPHA
>> +#define ELF_ARCH EM_ALPHA
>> +#endif
>> +
>> +#ifdef TARGET_S390X
>> +#define ELF_ARCH EM_S390
>> +#endif
>> +
>> +#ifdef TARGET_TILEGX
>> +#define ELF_ARCH EM_TILEGX
>> +#endif
>> +
>> +#ifdef TARGET_RISCV
>> +#define ELF_ARCH EM_RISCV
>> +#endif
>> +
>> +#ifdef TARGET_HPPA
>> +#define ELF_ARCH EM_PARISC
>> +#endif
>> +
>> +#ifdef TARGET_XTENSA
>> +#define ELF_ARCH EM_XTENSA
>> +#endif
>> +
>> +#endif /* _ELF_ARCH_H_ */
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 59a0d21c6f1..3ac7016a7e3 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -8,10 +8,15 @@
>>  #include "qemu.h"
>>  #include "disas/disas.h"
>>  #include "elf/elf.h"
>> +#include "elf/elf-arch.h"
>>  #include "qemu/path.h"
>>  #include "qemu/queue.h"
>>  #include "qemu/guest-random.h"
>>
>> +#ifndef ELF_ARCH
>> +#error something got missed
>> +#endif
>> +
>>  #ifdef _ARCH_PPC64
>>  #undef ARCH_DLINFO
>>  #undef ELF_PLATFORM
>> @@ -19,7 +24,6 @@
>>  #undef ELF_HWCAP2
>>  #undef ELF_CLASS
>>  #undef ELF_DATA
>> -#undef ELF_ARCH
>>  #endif
>>
>>  #define ELF_OSABI   ELFOSABI_SYSV
>> @@ -148,7 +152,6 @@ static uint32_t get_elf_hwcap(void)
>>  #define ELF_START_MMAP 0x2aaaaab000ULL
>>
>>  #define ELF_CLASS      ELFCLASS64
>> -#define ELF_ARCH       EM_X86_64
>>
>>  static inline void init_thread(struct target_pt_regs *regs, struct
> image_info *infop)
>>  {
>> @@ -211,7 +214,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs, const CPUX86State *en
>>   * These are used to set parameters in the core dumps.
>>   */
>>  #define ELF_CLASS       ELFCLASS32
>> -#define ELF_ARCH        EM_386
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -273,7 +275,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs, const CPUX86State *en
>>
>>  #define ELF_START_MMAP 0x80000000
>>
>> -#define ELF_ARCH        EM_ARM
>>  #define ELF_CLASS       ELFCLASS32
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>> @@ -539,7 +540,6 @@ static const char *get_elf_platform(void)
>>  /* 64 bit ARM definitions */
>>  #define ELF_START_MMAP 0x80000000
>>
>> -#define ELF_ARCH        EM_AARCH64
>>  #define ELF_CLASS       ELFCLASS64
>>  #ifdef TARGET_WORDS_BIGENDIAN
>>  # define ELF_PLATFORM    "aarch64_be"
>> @@ -667,7 +667,6 @@ static uint32_t get_elf_hwcap(void)
>>  #endif
>>
>>  #define ELF_CLASS   ELFCLASS64
>> -#define ELF_ARCH    EM_SPARCV9
>>
>>  #define STACK_BIAS              2047
>>
>> @@ -696,7 +695,6 @@ static inline void init_thread(struct target_pt_regs
> *regs,
>>                      | HWCAP_SPARC_MULDIV)
>>
>>  #define ELF_CLASS   ELFCLASS32
>> -#define ELF_ARCH    EM_SPARC
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -728,8 +726,6 @@ static inline void init_thread(struct target_pt_regs
> *regs,
>>
>>  #endif
>>
>> -#define ELF_ARCH        EM_PPC
>> -
>>  /* Feature masks for the Aux Vector Hardware Capabilities (AT_HWCAP).
>>     See arch/powerpc/include/asm/cputable.h.  */
>>  enum {
>> @@ -921,7 +917,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs, const CPUPPCState *en
>>  #else
>>  #define ELF_CLASS   ELFCLASS32
>>  #endif
>> -#define ELF_ARCH    EM_MIPS
>>
>>  #define elf_check_arch(x) ((x) =3D=3D EM_MIPS || (x) =3D=3D EM_NANOMIPS)
>>
>> @@ -1014,7 +1009,6 @@ static uint32_t get_elf_hwcap(void)
>>  #define elf_check_arch(x) ( (x) =3D=3D EM_MICROBLAZE || (x) =3D=3D
> EM_MICROBLAZE_OLD)
>>
>>  #define ELF_CLASS   ELFCLASS32
>> -#define ELF_ARCH    EM_MICROBLAZE
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -1053,7 +1047,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs, const CPUMBState *env
>>  #define elf_check_arch(x) ((x) =3D=3D EM_ALTERA_NIOS2)
>>
>>  #define ELF_CLASS   ELFCLASS32
>> -#define ELF_ARCH    EM_ALTERA_NIOS2
>>
>>  static void init_thread(struct target_pt_regs *regs, struct image_info
> *infop)
>>  {
>> @@ -1107,7 +1100,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs,
>>
>>  #define ELF_START_MMAP 0x08000000
>>
>> -#define ELF_ARCH EM_OPENRISC
>>  #define ELF_CLASS ELFCLASS32
>>  #define ELF_DATA  ELFDATA2MSB
>>
>> @@ -1146,7 +1138,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs,
>>  #define ELF_START_MMAP 0x80000000
>>
>>  #define ELF_CLASS ELFCLASS32
>> -#define ELF_ARCH  EM_SH
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -1228,7 +1219,6 @@ static uint32_t get_elf_hwcap(void)
>>  #define ELF_START_MMAP 0x80000000
>>
>>  #define ELF_CLASS ELFCLASS32
>> -#define ELF_ARCH  EM_CRIS
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -1245,7 +1235,6 @@ static inline void init_thread(struct
> target_pt_regs *regs,
>>  #define ELF_START_MMAP 0x80000000
>>
>>  #define ELF_CLASS       ELFCLASS32
>> -#define ELF_ARCH        EM_68K
>>
>>  /* ??? Does this need to do anything?
>>     #define ELF_PLAT_INIT(_r) */
>> @@ -1296,7 +1285,6 @@ static void elf_core_copy_regs(target_elf_gregset_t
> *regs, const CPUM68KState *e
>>  #define ELF_START_MMAP (0x30000000000ULL)
>>
>>  #define ELF_CLASS      ELFCLASS64
>> -#define ELF_ARCH       EM_ALPHA
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -1316,7 +1304,6 @@ static inline void init_thread(struct
> target_pt_regs *regs,
>>
>>  #define ELF_CLASS      ELFCLASS64
>>  #define ELF_DATA       ELFDATA2MSB
>> -#define ELF_ARCH       EM_S390
>>
>>  #define ELF_HWCAP get_elf_hwcap()
>>
>> @@ -1362,7 +1349,6 @@ static inline void init_thread(struct
> target_pt_regs *regs, struct image_info *i
>>
>>  #define ELF_CLASS   ELFCLASS64
>>  #define ELF_DATA    ELFDATA2LSB
>> -#define ELF_ARCH    EM_TILEGX
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> @@ -1379,7 +1365,6 @@ static inline void init_thread(struct
> target_pt_regs *regs,
>>  #ifdef TARGET_RISCV
>>
>>  #define ELF_START_MMAP 0x80000000
>> -#define ELF_ARCH  EM_RISCV
>>
>>  #ifdef TARGET_RISCV32
>>  #define ELF_CLASS ELFCLASS32
>> @@ -1402,7 +1387,6 @@ static inline void init_thread(struct
> target_pt_regs *regs,
>>
>>  #define ELF_START_MMAP  0x80000000
>>  #define ELF_CLASS       ELFCLASS32
>> -#define ELF_ARCH        EM_PARISC
>>  #define ELF_PLATFORM    "PARISC"
>>  #define STACK_GROWS_DOWN 0
>>  #define STACK_ALIGNMENT  64
>> @@ -1427,7 +1411,6 @@ static inline void init_thread(struct
> target_pt_regs *regs,
>>  #define ELF_START_MMAP 0x20000000
>>
>>  #define ELF_CLASS       ELFCLASS32
>> -#define ELF_ARCH        EM_XTENSA
>>
>>  static inline void init_thread(struct target_pt_regs *regs,
>>                                 struct image_info *infop)
>> --
>> 2.20.1
>>
>>


--
Alex Benn=C3=A9e

