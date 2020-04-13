Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37487C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016A620735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT433gA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016A620735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtY7-000827-7K
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtXD-0007E9-Sz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtXC-0001gE-5m
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:29:35 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtXA-0001fX-84
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:29:33 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kx8so3484146pjb.5
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ihFiTVvzRtHlOYNilBTdu4VXvEKqopA+rTa1ABFZips=;
 b=ZT433gA8TI3lVZ6hM2x5/wpT3HOPJYiCemSB2jIpjydRnpGCF3sgQjnv/yiiKyYUiv
 3mXjNxZug4pK6T/1OPdgFInz/vmU6GOrxNZyZDkxeJzaJ7UQxIMbzqAN2lzFqszYhYA+
 crZ4tpe+gN9Q7MvLkSyrSguYMfCyXJFKF2SX+/IbmvneSfMF8DZBw2Ehn2MS94MLKqUb
 9QeYXb8l+3I1tB1UvEfODIbjaI7Cd1cXy1+NGvSSAW7uAdrdmAifVuxhfeapdyqWMWya
 sdjH+WjU0oV/2Kws+7QfBuRHkWCmuDl5k9xE89n/RfNmZl/pwYNhf83pjuGD9vKf7Y87
 NmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ihFiTVvzRtHlOYNilBTdu4VXvEKqopA+rTa1ABFZips=;
 b=DpdoxcngSmJ6KurBQg1qM6Dss2FPzHCzWEaiMiCcVh5uj6xnU8+djzTuxkdG+lrWUI
 Q6BeAHRVs/7nQe9paFMC+X+HRBNFtPDsp6QEfoCHZGVmH0K5mNW0b7+HFLy9d6RoeHvY
 BskcQYr0zsovDx2gZePb4hfeAqui5uP3TlWuX0w6rzHyRNEaIaRHDESAF/YX4BXxAPnT
 27UprWLrOLhejphKjCfhb44bjeoRC5yY6Hkx4L7bdllWvlepOLb3yGmG3gI9bvlu6bc4
 lqVd3QxgfxEc3UGFxns4+1Oni/uADwLin9MBDgOfvuwSGmopSzsXSFx/TvnAadX5IzzE
 Qc2g==
X-Gm-Message-State: AGi0PuYPeiJgE5s6BOfgri3MYicXVT6NM74gtQNnLg/yQTdeUsgBW0Rf
 +LtbRztZhVqP1p/q6cbRbHk=
X-Google-Smtp-Source: APiQypKGSQzTY/Yqn4uNxJB1FylNvhg2qrqd07ISl3307l2NMVR7+TPKm7pPQ/YBi10MHrTHU06f9g==
X-Received: by 2002:a17:902:7581:: with SMTP id
 j1mr16781460pll.171.1586762970255; 
 Mon, 13 Apr 2020 00:29:30 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.29.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:29:29 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 13/15] KVM: MIPS: Add CONFIG6 and DIAG registers emulation
Date: Mon, 13 Apr 2020 15:30:22 +0800
Message-Id: <1586763024-12197-14-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 has CONFIG6 and DIAG registers which need to be emulate.
CONFIG6 is mostly used to enable/disable FTLB and SFB, while DIAG is
mostly used to flush BTB, ITLB, DTLB, VTLB and FTLB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/kvm_host.h |  5 ++++
 arch/mips/include/asm/mipsregs.h |  7 +++++
 arch/mips/kvm/tlb.c              | 39 +++++++++++++++++++++++++++
 arch/mips/kvm/vz.c               | 58 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c291767..3ef6ca8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -68,9 +68,11 @@
 #define KVM_REG_MIPS_CP0_CONFIG3	MIPS_CP0_32(16, 3)
 #define KVM_REG_MIPS_CP0_CONFIG4	MIPS_CP0_32(16, 4)
 #define KVM_REG_MIPS_CP0_CONFIG5	MIPS_CP0_32(16, 5)
+#define KVM_REG_MIPS_CP0_CONFIG6	MIPS_CP0_32(16, 6)
 #define KVM_REG_MIPS_CP0_CONFIG7	MIPS_CP0_32(16, 7)
 #define KVM_REG_MIPS_CP0_MAARI		MIPS_CP0_64(17, 2)
 #define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
+#define KVM_REG_MIPS_CP0_DIAG		MIPS_CP0_32(22, 0)
 #define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
 #define KVM_REG_MIPS_CP0_KSCRATCH1	MIPS_CP0_64(31, 2)
 #define KVM_REG_MIPS_CP0_KSCRATCH2	MIPS_CP0_64(31, 3)
@@ -256,6 +258,7 @@ struct mips_coproc {
 #define MIPS_CP0_WATCH_LO	18
 #define MIPS_CP0_WATCH_HI	19
 #define MIPS_CP0_TLB_XCONTEXT	20
+#define MIPS_CP0_DIAG		22
 #define MIPS_CP0_ECC		26
 #define MIPS_CP0_CACHE_ERR	27
 #define MIPS_CP0_TAG_LO		28
@@ -927,6 +930,8 @@ void kvm_vz_save_guesttlb(struct kvm_mips_tlb *buf, unsigned int index,
 			  unsigned int count);
 void kvm_vz_load_guesttlb(const struct kvm_mips_tlb *buf, unsigned int index,
 			  unsigned int count);
+void kvm_loongson_clear_guest_vtlb(void);
+void kvm_loongson_clear_guest_ftlb(void);
 #endif
 
 void kvm_mips_suspend_mm(int cpu);
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 796fe47..ce40fbf 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -674,6 +674,9 @@
 #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
 #define MIPS_CONF5_K		(_ULCAST_(1) << 30)
 
+#define MIPS_CONF6_INTIMER	(_ULCAST_(1) << 6)
+#define MIPS_CONF6_EXTIMER	(_ULCAST_(1) << 7)
+#define MIPS_CONF6_SFBEN	(_ULCAST_(1) << 8)
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
 /* proAptiv FTLB on/off bit */
 #define MIPS_CONF6_FTLBEN	(_ULCAST_(1) << 15)
@@ -993,6 +996,8 @@
 /* Disable Branch Return Cache */
 #define R10K_DIAG_D_BRC		(_ULCAST_(1) << 22)
 
+/* Flush BTB */
+#define LOONGSON_DIAG_BTB	(_ULCAST_(1) << 1)
 /* Flush ITLB */
 #define LOONGSON_DIAG_ITLB	(_ULCAST_(1) << 2)
 /* Flush DTLB */
@@ -2825,7 +2830,9 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config6)
 __BUILD_SET_C0(config7)
+__BUILD_SET_C0(diag)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 7cd9216..1efb9a0 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -20,6 +20,7 @@
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
+#include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -622,6 +623,44 @@ void kvm_vz_load_guesttlb(const struct kvm_mips_tlb *buf, unsigned int index,
 }
 EXPORT_SYMBOL_GPL(kvm_vz_load_guesttlb);
 
+void kvm_loongson_clear_guest_vtlb(void)
+{
+	int idx = read_gc0_index();
+
+	/* Set root GuestID for root probe and write of guest TLB entry */
+	set_root_gid_to_guest_gid();
+
+	write_gc0_index(0);
+	guest_tlbinvf();
+	write_gc0_index(idx);
+
+	clear_root_gid();
+	set_c0_diag(LOONGSON_DIAG_ITLB | LOONGSON_DIAG_DTLB);
+}
+EXPORT_SYMBOL_GPL(kvm_loongson_clear_guest_vtlb);
+
+void kvm_loongson_clear_guest_ftlb(void)
+{
+	int i;
+	int idx = read_gc0_index();
+
+	/* Set root GuestID for root probe and write of guest TLB entry */
+	set_root_gid_to_guest_gid();
+
+	for (i = current_cpu_data.tlbsizevtlb;
+	     i < (current_cpu_data.tlbsizevtlb +
+		     current_cpu_data.tlbsizeftlbsets);
+	     i++) {
+		write_gc0_index(i);
+		guest_tlbinvf();
+	}
+	write_gc0_index(idx);
+
+	clear_root_gid();
+	set_c0_diag(LOONGSON_DIAG_ITLB | LOONGSON_DIAG_DTLB);
+}
+EXPORT_SYMBOL_GPL(kvm_loongson_clear_guest_ftlb);
+
 #endif
 
 /**
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 0772565..2ea1f13 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -127,6 +127,11 @@ static inline unsigned int kvm_vz_config5_guest_wrmask(struct kvm_vcpu *vcpu)
 	return mask;
 }
 
+static inline unsigned int kvm_vz_config6_guest_wrmask(struct kvm_vcpu *vcpu)
+{
+	return MIPS_CONF6_INTIMER | MIPS_CONF6_EXTIMER | MIPS_CONF6_SYND;
+}
+
 /*
  * VZ optionally allows these additional Config bits to be written by root:
  * Config:	M, [MT]
@@ -181,6 +186,12 @@ static inline unsigned int kvm_vz_config5_user_wrmask(struct kvm_vcpu *vcpu)
 	return kvm_vz_config5_guest_wrmask(vcpu) | MIPS_CONF5_MRP;
 }
 
+static inline unsigned int kvm_vz_config6_user_wrmask(struct kvm_vcpu *vcpu)
+{
+	return kvm_vz_config6_guest_wrmask(vcpu) |
+		MIPS_CONF6_SFBEN | MIPS_CONF6_FTLBEN | MIPS_CONF6_FTLBDIS;
+}
+
 static gpa_t kvm_vz_gva_to_gpa_cb(gva_t gva)
 {
 	/* VZ guest has already converted gva to gpa */
@@ -930,7 +941,8 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 				    (sel == 2 ||	/* SRSCtl */
 				     sel == 3)) ||	/* SRSMap */
 				   (rd == MIPS_CP0_CONFIG &&
-				    (sel == 7)) ||	/* Config7 */
+				    (sel == 6 ||	/* Config6 */
+				     sel == 7)) ||	/* Config7 */
 				   (rd == MIPS_CP0_LLADDR &&
 				    (sel == 2) &&	/* MAARI */
 				    cpu_guest_has_maar &&
@@ -938,6 +950,9 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 				   (rd == MIPS_CP0_ERRCTL &&
 				    (sel == 0))) {	/* ErrCtl */
 				val = cop0->reg[rd][sel];
+			} else if (rd == MIPS_CP0_DIAG &&
+				   (sel == 0)) {	/* Diag */
+				val = cop0->reg[rd][sel];
 			} else {
 				val = 0;
 				er = EMULATE_FAIL;
@@ -1000,9 +1015,38 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 				   cpu_guest_has_maar &&
 				   !cpu_guest_has_dyn_maar) {
 				kvm_write_maari(vcpu, val);
+			} else if (rd == MIPS_CP0_CONFIG &&
+				   (sel == 6)) {
+				cop0->reg[rd][sel] = (int)val;
 			} else if (rd == MIPS_CP0_ERRCTL &&
 				   (sel == 0)) {	/* ErrCtl */
 				/* ignore the written value */
+			} else if (rd == MIPS_CP0_DIAG &&
+				   (sel == 0)) {	/* Diag */
+				unsigned long flags;
+
+				local_irq_save(flags);
+				if (val & LOONGSON_DIAG_BTB) {
+					/* Flush BTB */
+					set_c0_diag(LOONGSON_DIAG_BTB);
+				}
+				if (val & LOONGSON_DIAG_ITLB) {
+					/* Flush ITLB */
+					set_c0_diag(LOONGSON_DIAG_ITLB);
+				}
+				if (val & LOONGSON_DIAG_DTLB) {
+					/* Flush DTLB */
+					set_c0_diag(LOONGSON_DIAG_DTLB);
+				}
+				if (val & LOONGSON_DIAG_VTLB) {
+					/* Flush VTLB */
+					kvm_loongson_clear_guest_vtlb();
+				}
+				if (val & LOONGSON_DIAG_FTLB) {
+					/* Flush FTLB */
+					kvm_loongson_clear_guest_ftlb();
+				}
+				local_irq_restore(flags);
 			} else {
 				er = EMULATE_FAIL;
 			}
@@ -1665,6 +1709,7 @@ static u64 kvm_vz_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_CONFIG3,
 	KVM_REG_MIPS_CP0_CONFIG4,
 	KVM_REG_MIPS_CP0_CONFIG5,
+	KVM_REG_MIPS_CP0_CONFIG6,
 #ifdef CONFIG_64BIT
 	KVM_REG_MIPS_CP0_XCONTEXT,
 #endif
@@ -1992,6 +2037,9 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 		*v = read_gc0_config5();
 		break;
+	case KVM_REG_MIPS_CP0_CONFIG6:
+		*v = kvm_read_sw_gc0_config6(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_MAAR(0) ... KVM_REG_MIPS_CP0_MAAR(0x3f):
 		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
 			return -EINVAL;
@@ -2261,6 +2309,14 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 			write_gc0_config5(v);
 		}
 		break;
+	case KVM_REG_MIPS_CP0_CONFIG6:
+		cur = kvm_read_sw_gc0_config6(cop0);
+		change = (cur ^ v) & kvm_vz_config6_user_wrmask(vcpu);
+		if (change) {
+			v = cur ^ change;
+			kvm_write_sw_gc0_config6(cop0, (int)v);
+		}
+		break;
 	case KVM_REG_MIPS_CP0_MAAR(0) ... KVM_REG_MIPS_CP0_MAAR(0x3f):
 		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
 			return -EINVAL;
-- 
2.7.0


