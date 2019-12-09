Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79AEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 05:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5492120663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 05:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH5F3FmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5492120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieBgA-0001Ud-CS
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 00:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ieBfX-00013e-Jz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ieBfV-00012C-Lt
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:33:15 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ieBfV-0000wK-8M
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:33:13 -0500
Received: by mail-lj1-x241.google.com with SMTP id j6so14142346lja.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 21:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FoVDq3yMHJdAxtDHx1M5Hk0C1QR4+MJjweLUVJ2RqeQ=;
 b=qH5F3FmHjyptFVmn4Ig1ogFN0qG7zbtVeDO1BILTRjw337xLIWzGmT1wQwjNP83bLE
 ETQXjHdpJ7Sg3FwBPM1JVLRQhWqbQtfBIC1NLo98crMz6cJQ+f7v00CxU9To61KzRAk7
 T3iVUuXmUJJ8fWuABl7P3KIBacFI+OtPC0BbYAT2VEFg+bLveQUHz1Cf7yPfA2k78e3d
 rNMfUR2QnUeXB/aujKgLdKrOAjwdd9/rASEO8KgJLk3TMQzPyGdfpRoehtfhvauVVZiL
 M9WpWBzBzRbCfRhFlxmvAtkW0Y1VqE35jb8PcnUPfPSPvZJcLUj4CEG9MVf8XMKS9BtD
 Arxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FoVDq3yMHJdAxtDHx1M5Hk0C1QR4+MJjweLUVJ2RqeQ=;
 b=fuatQ3T0aN0l7bCKRh1MRz/YDXmrGEj17aPVaucn7kQ92j8//gS9Wna/QxNWn7VZdI
 j3W/jag6URmdsts6ClnhsRpLYflsK7kejuaW3TgRlgaoGRf8UXDQP3wjxn1HcEB6uhlH
 FJ88KSTkKdLgIlV8qpKquynAJEKAWCK27z9n4P4bCMWlz8uJRchVwQoezTQbbmJsGFNW
 yh+FLYEQcc/M2lLZgZG9sFYncjt+fmAl0NRePH7kPJGmKXHcKHM/I7FiONLnzoCDuQ5a
 qZ9nWjZ1GqEcLyU6NcWDeSFN/acPXwBJ+MVPzNRJU7YKZxoQHgx9TtihjADCekknZYB8
 aMXA==
X-Gm-Message-State: APjAAAXt47VP0Gu+v/gklJIFaJr9Vs+wPCU2AqEK47pdGQZGjZzmteyt
 BifNNe1KkmohcMKP2UGibwKYHH+f5xtQad5svTU=
X-Google-Smtp-Source: APXvYqyStls4IJ/P5ZfaXRo2/9b6w4TY7WYGJnUsapxq5WoFIBlxqjrShsacYBSPjdBGjSNj6XRjCauacIth7Gkm2io=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr15580007ljj.156.1575869590186; 
 Sun, 08 Dec 2019 21:33:10 -0800 (PST)
MIME-Version: 1.0
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565783446.3897844.13799667957070272380.stgit@bahia.lan>
In-Reply-To: <157565783446.3897844.13799667957070272380.stgit@bahia.lan>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 8 Dec 2019 21:32:43 -0800
Message-ID: <CAKmqyKNy9Jcsy2peir8uTc_MFVWEqzA7Kd-unPgPZkF3hkaEOQ@mail.gmail.com>
Subject: Re: [for-5.0 PATCH 1/3] cpu: Introduce CPUReset callback typedef
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 6, 2019 at 10:50 AM Greg Kurz <groug@kaod.org> wrote:
>
> Use it in include/hw/core/cpu.h and convert all targets to use it as
> well with:
>
> perl -pi \
>  -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
>  $(git ls-files 'target/*.h')
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/core/cpu.h       |    4 +++-
>  target/alpha/cpu-qom.h      |    2 +-
>  target/arm/cpu-qom.h        |    2 +-
>  target/cris/cpu-qom.h       |    2 +-
>  target/hppa/cpu-qom.h       |    2 +-
>  target/i386/cpu-qom.h       |    2 +-
>  target/lm32/cpu-qom.h       |    2 +-
>  target/m68k/cpu-qom.h       |    2 +-
>  target/microblaze/cpu-qom.h |    2 +-
>  target/mips/cpu-qom.h       |    2 +-
>  target/moxie/cpu.h          |    2 +-
>  target/nios2/cpu.h          |    2 +-
>  target/openrisc/cpu.h       |    2 +-
>  target/ppc/cpu-qom.h        |    2 +-
>  target/riscv/cpu.h          |    2 +-
>  target/s390x/cpu-qom.h      |    2 +-
>  target/sh4/cpu-qom.h        |    2 +-
>  target/sparc/cpu-qom.h      |    2 +-
>  target/tilegx/cpu.h         |    2 +-
>  target/tricore/cpu-qom.h    |    2 +-
>  target/xtensa/cpu-qom.h     |    2 +-
>  21 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 77c6f0529903..047e3972ecaf 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -74,6 +74,8 @@ typedef struct CPUWatchpoint CPUWatchpoint;
>
>  struct TranslationBlock;
>
> +typedef void (*CPUReset)(CPUState *cpu);
> +
>  /**
>   * CPUClass:
>   * @class_by_name: Callback to map -cpu command line model name to an
> @@ -165,7 +167,7 @@ typedef struct CPUClass {
>      ObjectClass *(*class_by_name)(const char *cpu_model);
>      void (*parse_features)(const char *typename, char *str, Error **errp);
>
> -    void (*reset)(CPUState *cpu);
> +    CPUReset reset;
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
> diff --git a/target/alpha/cpu-qom.h b/target/alpha/cpu-qom.h
> index 6f0a0adb9efa..0c974805481b 100644
> --- a/target/alpha/cpu-qom.h
> +++ b/target/alpha/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct AlphaCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } AlphaCPUClass;
>
>  typedef struct AlphaCPU AlphaCPU;
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 7f5b244bde35..aeaa84afcc9a 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -51,7 +51,7 @@ typedef struct ARMCPUClass {
>
>      const ARMCPUInfo *info;
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } ARMCPUClass;
>
>  typedef struct ARMCPU ARMCPU;
> diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
> index 308c1f95bdf6..079ffe6bda0a 100644
> --- a/target/cris/cpu-qom.h
> +++ b/target/cris/cpu-qom.h
> @@ -45,7 +45,7 @@ typedef struct CRISCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>
>      uint32_t vr;
>  } CRISCPUClass;
> diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
> index 6367dc479391..5c129de148a8 100644
> --- a/target/hppa/cpu-qom.h
> +++ b/target/hppa/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct HPPACPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } HPPACPUClass;
>
>  typedef struct HPPACPU HPPACPU;
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index 0efab2fc670f..1e962518e68e 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -71,7 +71,7 @@ typedef struct X86CPUClass {
>
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } X86CPUClass;
>
>  typedef struct X86CPU X86CPU;
> diff --git a/target/lm32/cpu-qom.h b/target/lm32/cpu-qom.h
> index dc9ac9ac9f7b..e105a315aa3e 100644
> --- a/target/lm32/cpu-qom.h
> +++ b/target/lm32/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct LM32CPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } LM32CPUClass;
>
>  typedef struct LM32CPU LM32CPU;
> diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
> index b56da8a21374..0a196775e5d1 100644
> --- a/target/m68k/cpu-qom.h
> +++ b/target/m68k/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct M68kCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } M68kCPUClass;
>
>  typedef struct M68kCPU M68kCPU;
> diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
> index 49b07cc697b9..7a4ff4a11e33 100644
> --- a/target/microblaze/cpu-qom.h
> +++ b/target/microblaze/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct MicroBlazeCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } MicroBlazeCPUClass;
>
>  typedef struct MicroBlazeCPU MicroBlazeCPU;
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index a430c0fe4bbf..818401a501cb 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -48,7 +48,7 @@ typedef struct MIPSCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      const struct mips_def_t *cpu_def;
>  } MIPSCPUClass;
>
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index 01dca548e5d5..20dafc80f6ac 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -69,7 +69,7 @@ typedef struct MoxieCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } MoxieCPUClass;
>
>  /**
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 361b06ffeb61..59a07a5d0ee0 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -50,7 +50,7 @@ typedef struct Nios2CPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } Nios2CPUClass;
>
>  #define TARGET_HAS_ICE 1
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 0ad02eab7946..d77976ccce7f 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -48,7 +48,7 @@ typedef struct OpenRISCCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } OpenRISCCPUClass;
>
>  #define TARGET_INSN_START_EXTRA_WORDS 1
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index e499575dc873..9a20e5a1bfea 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -166,7 +166,7 @@ typedef struct PowerPCCPUClass {
>
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      void (*parent_parse_features)(const char *type, char *str, Error **errp);
>
>      uint32_t pvr;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e59343e13c02..2246f95b3f33 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -185,7 +185,7 @@ typedef struct RISCVCPUClass {
>      CPUClass parent_class;
>      /*< public >*/
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } RISCVCPUClass;
>
>  /**
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index b809ec8418e0..cc23edc92198 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -55,7 +55,7 @@ typedef struct S390CPUClass {
>      const char *desc;
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      void (*load_normal)(CPUState *cpu);
>      void (*cpu_reset)(CPUState *cpu);
>      void (*initial_cpu_reset)(CPUState *cpu);
> diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
> index 0c56d055bada..35732a367427 100644
> --- a/target/sh4/cpu-qom.h
> +++ b/target/sh4/cpu-qom.h
> @@ -51,7 +51,7 @@ typedef struct SuperHCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>
>      uint32_t pvr;
>      uint32_t prr;
> diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
> index 7442e2768e88..93165bd24f1c 100644
> --- a/target/sparc/cpu-qom.h
> +++ b/target/sparc/cpu-qom.h
> @@ -49,7 +49,7 @@ typedef struct SPARCCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      sparc_def_t *cpu_def;
>  } SPARCCPUClass;
>
> diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
> index 9cbec247d238..68bd509898d4 100644
> --- a/target/tilegx/cpu.h
> +++ b/target/tilegx/cpu.h
> @@ -118,7 +118,7 @@ typedef struct TileGXCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } TileGXCPUClass;
>
>  /**
> diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
> index 7c1e130b4ede..f613452b00e0 100644
> --- a/target/tricore/cpu-qom.h
> +++ b/target/tricore/cpu-qom.h
> @@ -36,7 +36,7 @@ typedef struct TriCoreCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } TriCoreCPUClass;
>
>  typedef struct TriCoreCPU TriCoreCPU;
> diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
> index 9ac54241bd69..685d7b8d823a 100644
> --- a/target/xtensa/cpu-qom.h
> +++ b/target/xtensa/cpu-qom.h
> @@ -56,7 +56,7 @@ typedef struct XtensaCPUClass {
>      /*< public >*/
>
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>
>      const XtensaConfig *config;
>  } XtensaCPUClass;
>
>

