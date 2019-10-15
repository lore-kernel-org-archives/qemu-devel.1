Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7657C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 20:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB3E20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 20:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPWAuAYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB3E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKTd0-0002HW-FL
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 16:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eugeni.stepanov@gmail.com>) id 1iKTbu-0001I6-GL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 16:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eugeni.stepanov@gmail.com>) id 1iKTbs-0003rh-Df
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 16:40:02 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <eugeni.stepanov@gmail.com>)
 id 1iKTbs-0003qv-4q; Tue, 15 Oct 2019 16:40:00 -0400
Received: by mail-io1-xd44.google.com with SMTP id h144so49426784iof.7;
 Tue, 15 Oct 2019 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6UstkcjxI+4z5rFiL+3+y+IKkqZJcL3HhwST2wcN60Y=;
 b=mPWAuAYu7ZAWCd/hGcrJJ+aXYBqSWItPKxFJkFJenmULJkO5jQRuG2diygjr6gQ1Q8
 tI3YuVhxmeGChNXs8j7QrOhd4hKLMacntAAloozVMSZkf7OYE7yEqDoE/+skYLEIbDBR
 9jjT92PeTRQDdLu+3MNwkpbEfzfF3ol+Z0IVZuyw1O+8fpD00CZM97ip5+EAZNR4Gnqt
 Cv2U0+YfU/3p4tx+U3GyVYQ8NH8/fEAaR9oZ4ptaWPbZzRAAuLAv9SgWDUAAGlrYuPa8
 9X4sZXB4lsGxbsz81LHb7xYSlZ/Ir/8tUXqINZrNJr+6yTCPL9c2Yei5gk+y/+9+6LPL
 JVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6UstkcjxI+4z5rFiL+3+y+IKkqZJcL3HhwST2wcN60Y=;
 b=Pm8tcWJoCl8nmkN+BS2zUiH584XU00GJV4s8gMAHc0r5YcHNBPqQB+In5LFIAI/71i
 8IvotfRbFDbcML09OlWiFyKyexPwR2Vqa402DyI9kqONJot76YqBTnzytp0JN+XLBq0p
 uZRjM3p+5k2I0WHI2+Txd5iTJhF5iVPcbTeTDiJiit/x3HGTWWPhkedSfMwxUvdJ9VZ8
 wpFDNF/gAA12+Hu2DN2OklEMByusIJKNlZ/OP0qBdPWRsWfz3p9D53tzMb3XXsVnTeUt
 d9/L5wTR2fDi56EM1nkdzijUzvXUmRGSwFGgobc7CChL7vl8uYllrWBrbZJwfpty9jts
 /Rlw==
X-Gm-Message-State: APjAAAUdXKoYS1W09vJNeQPJer7YpehrFtLJWhocxolflTm5UKM0Uc6O
 N26ZTGvL1XIRWrThXLrRbS8mmcPHWyj2TdwDag==
X-Google-Smtp-Source: APXvYqwmw71VRQQvoPUvZGpjYeNn+0TmSNHtZhFwScqEIIiWMRSexYrVIHvX1vi9GetDN5oUNjP4NPO+XaSKFkMXMwk=
X-Received: by 2002:a02:9102:: with SMTP id a2mr43254770jag.108.1571171998572; 
 Tue, 15 Oct 2019 13:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
From: Evgenii Stepanov <eugeni.stepanov@gmail.com>
Date: Tue, 15 Oct 2019 13:39:47 -0700
Message-ID: <CABMLtrhb2n3WbpROs0Qa9hFBObom0Qm60t2nioOyWTtgbpu7HA@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] target/arm: Implement ARMv8.5-MemTag, system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000dbba7a0594f8fc7a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dbba7a0594f8fc7a
Content-Type: text/plain; charset="UTF-8"

Hi,

please find attached three random fixes for instruction translation
and one for syscall emulation.

On Fri, Oct 11, 2019 at 6:48 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is an update of the v4 patch from March.
>
> I believe I've fixed the address space issues that Peter noticed.
> If the board model does not supply tag memory, then I downgrade
> the cpu support to "instructions only" (id_aa64pfr1.mte == 1),
> which does not allow tag memory access to be enabled in the cpu.
>
> I did not update the arm_hcr_el2_eff comment re ARMv8.4, because
> I have not done a complete audit of all of the v8.5 bits.
>
> The hacky kernel testing patch has needed some updates since March.
> The following applies to v5.4-rc2.
>
>
> r~
>
>
> Richard Henderson (22):
>   target/arm: Add MTE_ACTIVE to tb_flags
>   target/arm: Add regime_has_2_ranges
>   target/arm: Add MTE system registers
>   target/arm: Add helper_mte_check{1,2,3}
>   target/arm: Suppress tag check for sp+offset
>   target/arm: Implement the IRG instruction
>   target/arm: Implement ADDG, SUBG instructions
>   target/arm: Implement the GMI instruction
>   target/arm: Implement the SUBP instruction
>   target/arm: Define arm_cpu_do_unaligned_access for CONFIG_USER_ONLY
>   target/arm: Implement LDG, STG, ST2G instructions
>   target/arm: Implement the STGP instruction
>   target/arm: Implement the LDGM and STGM instructions
>   target/arm: Implement the access tag cache flushes
>   target/arm: Clean address for DC ZVA
>   target/arm: Implement data cache set allocation tags
>   target/arm: Set PSTATE.TCO on exception entry
>   target/arm: Enable MTE
>   target/arm: Cache the Tagged bit for a page in MemTxAttrs
>   target/arm: Create tagged ram when MTE is enabled
>   target/arm: Add mmu indexes for tag memory
>   target/arm: Add allocation tag storage for system mode
>
>  target/arm/cpu-param.h     |   2 +-
>  target/arm/cpu.h           |  37 ++-
>  target/arm/helper-a64.h    |  17 ++
>  target/arm/internals.h     |  45 +++
>  target/arm/translate.h     |   2 +
>  hw/arm/virt.c              |  54 ++++
>  target/arm/cpu.c           |  63 +++-
>  target/arm/cpu64.c         |   1 +
>  target/arm/helper.c        | 277 ++++++++++++++---
>  target/arm/mte_helper.c    | 601 +++++++++++++++++++++++++++++++++++++
>  target/arm/tlb_helper.c    |   3 +-
>  target/arm/translate-a64.c | 342 ++++++++++++++++++---
>  target/arm/Makefile.objs   |   1 +
>  13 files changed, 1345 insertions(+), 100 deletions(-)
>  create mode 100644 target/arm/mte_helper.c
>
> --- kernel patch
>
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index f19fe4b9acc4..ee6b7f387a9a 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -52,7 +52,8 @@
>  #define ARM64_HAS_IRQ_PRIO_MASKING             42
>  #define ARM64_HAS_DCPODP                       43
>  #define ARM64_WORKAROUND_1463225               44
> +#define ARM64_HAS_MTE                          45
>
> -#define ARM64_NCAPS                            45
> +#define ARM64_NCAPS                            46
>
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index ddf9d762ac62..5825130bd8eb 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -12,6 +12,7 @@
>  #include <asm/types.h>
>
>  /* Hyp Configuration Register (HCR) bits */
> +#define HCR_ATA                (UL(1) << 56)
>  #define HCR_FWB                (UL(1) << 46)
>  #define HCR_API                (UL(1) << 41)
>  #define HCR_APK                (UL(1) << 40)
> @@ -78,8 +79,8 @@
>                          HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
>                          HCR_FMO | HCR_IMO)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> -#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
> -#define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
> +#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
> +#define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H | HCR_ATA)
>
>  /* TCR_EL2 Registers bits */
>  #define TCR_EL2_RES1           ((1 << 31) | (1 << 23))
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 972d196c7714..2a65831f6e0f 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -482,6 +482,7 @@
>
>  /* Common SCTLR_ELx flags. */
>  #define SCTLR_ELx_DSSBS        (BIT(44))
> +#define SCTLR_ELx_ATA  (BIT(43))
>  #define SCTLR_ELx_ENIA (BIT(31))
>  #define SCTLR_ELx_ENIB (BIT(30))
>  #define SCTLR_ELx_ENDA (BIT(27))
> @@ -510,6 +511,7 @@
>  #endif
>
>  /* SCTLR_EL1 specific flags. */
> +#define SCTLR_EL1_ATA0         (BIT(42))
>  #define SCTLR_EL1_UCI          (BIT(26))
>  #define SCTLR_EL1_E0E          (BIT(24))
>  #define SCTLR_EL1_SPAN         (BIT(23))
> @@ -598,6 +600,7 @@
>  #define ID_AA64PFR0_EL0_32BIT_64BIT    0x2
>
>  /* id_aa64pfr1 */
> +#define ID_AA64PFR1_MTE_SHIFT          8
>  #define ID_AA64PFR1_SSBS_SHIFT         4
>
>  #define ID_AA64PFR1_SSBS_PSTATE_NI     0
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cabebf1a7976..6a122ed7f76b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -171,6 +171,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>  };
>
>  static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
> +       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
>         ARM64_FTR_END,
>  };
> @@ -1261,6 +1262,11 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
>  }
>  #endif
>
> +static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
> +{
> +       sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
> +}
> +
>  static const struct arm64_cpu_capabilities arm64_features[] = {
>         {
>                 .desc = "GIC system register CPU interface",
> @@ -1561,6 +1567,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>                 .min_field_value = 1,
>         },
>  #endif
> +       {
> +               .desc = "Memory Tagging",
> +               .capability = ARM64_HAS_MTE,
> +               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +               .matches = has_cpuid_feature,
> +               .sys_reg = SYS_ID_AA64PFR1_EL1,
> +               .field_pos = ID_AA64PFR1_MTE_SHIFT,
> +               .sign = FTR_UNSIGNED,
> +               .min_field_value = 2,
> +               .cpu_enable = cpu_enable_mte,
> +       },
>         {},
>  };
>
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index a1e0592d1fbc..32cfa35195ae 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -424,14 +424,14 @@ ENTRY(__cpu_setup)
>          *   DEVICE_nGnRE       001     00000100
>          *   DEVICE_GRE         010     00001100
>          *   NORMAL_NC          011     01000100
> -        *   NORMAL             100     11111111
> +        *   NORMAL             100     11110000 (Tag)
>          *   NORMAL_WT          101     10111011
>          */
>         ldr     x5, =MAIR(0x00, MT_DEVICE_nGnRnE) | \
>                      MAIR(0x04, MT_DEVICE_nGnRE) | \
>                      MAIR(0x0c, MT_DEVICE_GRE) | \
>                      MAIR(0x44, MT_NORMAL_NC) | \
> -                    MAIR(0xff, MT_NORMAL) | \
> +                    MAIR(0xf0, MT_NORMAL) | \
>                      MAIR(0xbb, MT_NORMAL_WT)
>         msr     mair_el1, x5
>         /*
>
> --- mte smoke test
>
> /*
>  * Memory tagging, basic pass cases.
>  */
>
> #include <stdio.h>
> #include <assert.h>
> #include <sys/mman.h>
>
> asm(".arch armv8.5-a+memtag");
>
> int data[16 / sizeof(int)] __attribute__((aligned(16)));
>
> int main(int ac, char **av)
> {
>     int *p0 = data;
>     int *p1, *p2;
>     long c;
>
>     if (mlock(data, sizeof(data)) < 0) {
>         perror("mlock");
>         return 1;
>     }
>
>     asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
>     assert(p1 != p0);
>     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
>     assert(c == 0);
>
>     asm("stg %0, [%0]" : : "r"(p1));
>     asm("ldg %0, [%1]" : "=r"(p2) : "r"(p0), "0"(p0));
>     assert(p1 == p2);
>
>     return 0;
> }
>
>

--000000000000dbba7a0594f8fc7a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-Fix-pre-post-index-confusion-in-disas_ldst_tag.patch"
Content-Disposition: attachment; 
	filename="0004-Fix-pre-post-index-confusion-in-disas_ldst_tag.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1sb817o0>
X-Attachment-Id: f_k1sb817o0

RnJvbSA3ZGZlM2Y1M2JjNjA2ZDJjNWJiODFlNTgyOGU2Y2YzMjIyNWY2YjcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmdlbmlpIFN0ZXBhbm92IDxldWdlbmlzQGdvb2dsZS5jb20+
CkRhdGU6IFR1ZSwgMjcgQXVnIDIwMTkgMTY6MTQ6MzcgLTA3MDAKU3ViamVjdDogW1BBVENIIDQv
NF0gRml4IHByZS9wb3N0LWluZGV4IGNvbmZ1c2lvbiBpbiBkaXNhc19sZHN0X3RhZy4KCi0tLQog
dGFyZ2V0L2FybS90cmFuc2xhdGUtYTY0LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90cmFu
c2xhdGUtYTY0LmMgYi90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQuYwppbmRleCBhODViYWUxZjI3
Li41NzI4YjY4Y2NjIDEwMDY0NAotLS0gYS90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQuYworKysg
Yi90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQuYwpAQCAtMzY3OSw3ICszNjc5LDcgQEAgc3RhdGlj
IHZvaWQgZGlzYXNfbGRzdF90YWcoRGlzYXNDb250ZXh0ICpzLCB1aW50MzJfdCBpbnNuKQogICAg
IH0KIAogICAgIGRpcnR5X2FkZHIgPSByZWFkX2NwdV9yZWdfc3Aocywgcm4sIHRydWUpOwotICAg
IGlmIChpbmRleCA8PSAwKSB7CisgICAgaWYgKGluZGV4ID49IDApIHsKICAgICAgICAgLyogcHJl
LWluZGV4IG9yIHNpZ25lZCBvZmZzZXQgKi8KICAgICAgICAgdGNnX2dlbl9hZGRpX2k2NChkaXJ0
eV9hZGRyLCBkaXJ0eV9hZGRyLCBvZmZzZXQpOwogICAgIH0KQEAgLTM3MjYsNyArMzcyNiw3IEBA
IHN0YXRpYyB2b2lkIGRpc2FzX2xkc3RfdGFnKERpc2FzQ29udGV4dCAqcywgdWludDMyX3QgaW5z
bikKIAogICAgIGlmIChpbmRleCAhPSAwKSB7CiAgICAgICAgIC8qIHByZS1pbmRleCBvciBwb3N0
LWluZGV4ICovCi0gICAgICAgIGlmIChpbmRleCA+IDApIHsKKyAgICAgICAgaWYgKGluZGV4IDwg
MCkgewogICAgICAgICAgICAgLyogcG9zdC1pbmRleCAqLwogICAgICAgICAgICAgdGNnX2dlbl9h
ZGRpX2k2NChkaXJ0eV9hZGRyLCBkaXJ0eV9hZGRyLCBvZmZzZXQpOwogICAgICAgICB9Ci0tIAoy
LjIzLjAuNzAwLmc1NmNmNzY3YmRiLWdvb2cKCg==
--000000000000dbba7a0594f8fc7a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-Fix-wrong-field-size-in-disas_ldst_tag.patch"
Content-Disposition: attachment; 
	filename="0003-Fix-wrong-field-size-in-disas_ldst_tag.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1sb818j1>
X-Attachment-Id: f_k1sb818j1

RnJvbSAxZWNmNGY3YmFlZGZlMmRlODBhOTdjNDA4ZmEyY2M2NGNjZDk5ZGJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmdlbmlpIFN0ZXBhbm92IDxldWdlbmlzQGdvb2dsZS5jb20+
CkRhdGU6IFR1ZSwgMjcgQXVnIDIwMTkgMTY6MTM6MjYgLTA3MDAKU3ViamVjdDogW1BBVENIIDMv
NF0gRml4IHdyb25nIGZpZWxkIHNpemUgaW4gZGlzYXNfbGRzdF90YWcuCgotLS0KIHRhcmdldC9h
cm0vdHJhbnNsYXRlLWE2NC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90cmFuc2xhdGUtYTY0LmMg
Yi90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQuYwppbmRleCAwYTE2ODUwNmQyLi5hODViYWUxZjI3
IDEwMDY0NAotLS0gYS90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQuYworKysgYi90YXJnZXQvYXJt
L3RyYW5zbGF0ZS1hNjQuYwpAQCAtMzYxMSw3ICszNjExLDcgQEAgc3RhdGljIHZvaWQgZGlzYXNf
bGRzdF90YWcoRGlzYXNDb250ZXh0ICpzLCB1aW50MzJfdCBpbnNuKQogICAgIGludCBydCA9IGV4
dHJhY3QzMihpbnNuLCAwLCA1KTsKICAgICBpbnQgcm4gPSBleHRyYWN0MzIoaW5zbiwgNSwgNSk7
CiAgICAgdWludDY0X3Qgb2Zmc2V0ID0gc2V4dHJhY3Q2NChpbnNuLCAxMiwgOSkgPDwgTE9HMl9U
QUdfR1JBTlVMRTsKLSAgICBpbnQgb3AyID0gZXh0cmFjdDMyKGluc24sIDEwLCAzKTsKKyAgICBp
bnQgb3AyID0gZXh0cmFjdDMyKGluc24sIDEwLCAyKTsKICAgICBpbnQgb3AxID0gZXh0cmFjdDMy
KGluc24sIDIyLCAyKTsKICAgICBib29sIGlzX2xvYWQgPSBmYWxzZSwgaXNfcGFpciA9IGZhbHNl
LCBpc196ZXJvID0gZmFsc2UsIGlzX211bHQgPSBmYWxzZTsKICAgICBpbnQgaW5kZXggPSAwOwot
LSAKMi4yMy4wLjcwMC5nNTZjZjc2N2JkYi1nb29nCgo=
--000000000000dbba7a0594f8fc7a
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-Fix-STGP-offset-scale.patch"
Content-Disposition: attachment; filename="0001-Fix-STGP-offset-scale.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1sb818l3>
X-Attachment-Id: f_k1sb818l3

RnJvbSBhOGEwMjQyMDJkMWJhODAxNDJlYWNjMDlkYWIxMGM3NzgwODc0NTgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmdlbmlpIFN0ZXBhbm92IDxldWdlbmlzQGdvb2dsZS5jb20+
CkRhdGU6IFRodSwgMjIgQXVnIDIwMTkgMTg6MDU6MzQgLTA3MDAKU3ViamVjdDogW1BBVENIIDEv
NF0gRml4IFNUR1Agb2Zmc2V0IHNjYWxlLgoKLS0tCiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQu
YyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90cmFuc2xhdGUtYTY0LmMgYi90YXJnZXQvYXJtL3Ry
YW5zbGF0ZS1hNjQuYwppbmRleCA5YTU1NDg1NmU5Li4wYTE2ODUwNmQyIDEwMDY0NAotLS0gYS90
YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQuYworKysgYi90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQu
YwpAQCAtMjc2Myw3ICsyNzYzLDggQEAgc3RhdGljIHZvaWQgZGlzYXNfbGRzdF9wYWlyKERpc2Fz
Q29udGV4dCAqcywgdWludDMyX3QgaW5zbikKICAgICAgICAgcmV0dXJuOwogICAgIH0KIAotICAg
IG9mZnNldCA8PD0gc2l6ZTsKKyAgICAvLyBTVEdQIG9mZnNldCBpcyAxNi1zY2FsZWQuCisgICAg
b2Zmc2V0IDw8PSAoc2l6ZSArIHNldF90YWcpOwogCiAgICAgaWYgKHJuID09IDMxKSB7CiAgICAg
ICAgIGdlbl9jaGVja19zcF9hbGlnbm1lbnQocyk7Ci0tIAoyLjIzLjAuNzAwLmc1NmNmNzY3YmRi
LWdvb2cKCg==
--000000000000dbba7a0594f8fc7a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-Untag-userspace-addresses-in-syscall-emulation.patch"
Content-Disposition: attachment; 
	filename="0002-Untag-userspace-addresses-in-syscall-emulation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1sb818k2>
X-Attachment-Id: f_k1sb818k2

RnJvbSBiZGUzMDA3Y2JlMzNjY2JiYmE0NjQ4YzdlZTA5MzUzNGJlMDhjY2QwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmdlbmlpIFN0ZXBhbm92IDxldWdlbmlzQGdvb2dsZS5jb20+
CkRhdGU6IFR1ZSwgMjcgQXVnIDIwMTkgMTY6MTI6MzggLTA3MDAKU3ViamVjdDogW1BBVENIIDIv
NF0gVW50YWcgdXNlcnNwYWNlIGFkZHJlc3NlcyBpbiBzeXNjYWxsIGVtdWxhdGlvbi4KCi0tLQog
bGludXgtdXNlci9xZW11LmggfCAxMyArKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL3Fl
bXUuaCBiL2xpbnV4LXVzZXIvcWVtdS5oCmluZGV4IGFhYzAzMzQ2MjcuLmE4ZjBhOGVlZTkgMTAw
NjQ0Ci0tLSBhL2xpbnV4LXVzZXIvcWVtdS5oCisrKyBiL2xpbnV4LXVzZXIvcWVtdS5oCkBAIC00
NTYsOCArNDU2LDE2IEBAIGV4dGVybiB1bnNpZ25lZCBsb25nIGd1ZXN0X3N0YWNrX3NpemU7CiAj
ZGVmaW5lIFZFUklGWV9SRUFEIDAKICNkZWZpbmUgVkVSSUZZX1dSSVRFIDEgLyogaW1wbGllcyBy
ZWFkIGFjY2VzcyAqLwogCitzdGF0aWMgaW5saW5lIGFiaV91bG9uZyB1bnRhZ2dlZF9hZGRyKGFi
aV91bG9uZyBhZGRyKSB7CisjaWYgVEFSR0VUX0FCSV9CSVRTID09IDY0CisgICAgYWRkciAmPSAo
KChhYmlfdWxvbmcpLTEpID4+IDgpOworI2VuZGlmCisgICAgcmV0dXJuIGFkZHI7Cit9CisKIHN0
YXRpYyBpbmxpbmUgaW50IGFjY2Vzc19vayhpbnQgdHlwZSwgYWJpX3Vsb25nIGFkZHIsIGFiaV91
bG9uZyBzaXplKQogeworICAgIGFkZHIgPSB1bnRhZ2dlZF9hZGRyKGFkZHIpOwogICAgIHJldHVy
biBndWVzdF9hZGRyX3ZhbGlkKGFkZHIpICYmCiAgICAgICAgICAgIChzaXplID09IDAgfHwgZ3Vl
c3RfYWRkcl92YWxpZChhZGRyICsgc2l6ZSAtIDEpKSAmJgogICAgICAgICAgICBwYWdlX2NoZWNr
X3JhbmdlKCh0YXJnZXRfdWxvbmcpYWRkciwgc2l6ZSwKQEAgLTYwMSw2ICs2MDksNyBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgKmxvY2tfdXNlcihpbnQgdHlwZSwgYWJpX3Vsb25nIGd1ZXN0X2FkZHIs
IGxvbmcgbGVuLCBpbnQgY29weQogewogICAgIGlmICghYWNjZXNzX29rKHR5cGUsIGd1ZXN0X2Fk
ZHIsIGxlbikpCiAgICAgICAgIHJldHVybiBOVUxMOworICAgIGd1ZXN0X2FkZHIgPSB1bnRhZ2dl
ZF9hZGRyKGd1ZXN0X2FkZHIpOwogI2lmZGVmIERFQlVHX1JFTUFQCiAgICAgewogICAgICAgICB2
b2lkICphZGRyOwpAQCAtNjQyLDcgKzY1MSw3IEBAIGFiaV9sb25nIHRhcmdldF9zdHJsZW4oYWJp
X3Vsb25nIGdhZGRyKTsKIHN0YXRpYyBpbmxpbmUgdm9pZCAqbG9ja191c2VyX3N0cmluZyhhYmlf
dWxvbmcgZ3Vlc3RfYWRkcikKIHsKICAgICBhYmlfbG9uZyBsZW47Ci0gICAgbGVuID0gdGFyZ2V0
X3N0cmxlbihndWVzdF9hZGRyKTsKKyAgICBsZW4gPSB0YXJnZXRfc3RybGVuKHVudGFnZ2VkX2Fk
ZHIoZ3Vlc3RfYWRkcikpOwogICAgIGlmIChsZW4gPCAwKQogICAgICAgICByZXR1cm4gTlVMTDsK
ICAgICByZXR1cm4gbG9ja191c2VyKFZFUklGWV9SRUFELCBndWVzdF9hZGRyLCAobG9uZykobGVu
ICsgMSksIDEpOwpAQCAtNjUwLDcgKzY1OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCAqbG9ja191
c2VyX3N0cmluZyhhYmlfdWxvbmcgZ3Vlc3RfYWRkcikKIAogLyogSGVscGVyIG1hY3JvcyBmb3Ig
bG9ja2luZy91bmxvY2tpbmcgYSB0YXJnZXQgc3RydWN0LiAgKi8KICNkZWZpbmUgbG9ja191c2Vy
X3N0cnVjdCh0eXBlLCBob3N0X3B0ciwgZ3Vlc3RfYWRkciwgY29weSkJXAotICAgIChob3N0X3B0
ciA9IGxvY2tfdXNlcih0eXBlLCBndWVzdF9hZGRyLCBzaXplb2YoKmhvc3RfcHRyKSwgY29weSkp
CisgICAgKGhvc3RfcHRyID0gbG9ja191c2VyKHR5cGUsIHVudGFnZ2VkX2FkZHIoZ3Vlc3RfYWRk
ciksIHNpemVvZigqaG9zdF9wdHIpLCBjb3B5KSkKICNkZWZpbmUgdW5sb2NrX3VzZXJfc3RydWN0
KGhvc3RfcHRyLCBndWVzdF9hZGRyLCBjb3B5KQkJXAogICAgIHVubG9ja191c2VyKGhvc3RfcHRy
LCBndWVzdF9hZGRyLCAoY29weSkgPyBzaXplb2YoKmhvc3RfcHRyKSA6IDApCiAKLS0gCjIuMjMu
MC43MDAuZzU2Y2Y3NjdiZGItZ29vZwoK
--000000000000dbba7a0594f8fc7a--

