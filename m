Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10531C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B8721D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3Cs9/pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B8721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhA2-0000Qy-IP
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRf-0000Q0-9A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRd-0003mc-AN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRd-0003lD-34
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id t14so2967040wmi.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lVlJ9nNpJHZTQ3ZPiUhA/OdyumpiTx8ozKH1nHzGqvU=;
 b=b3Cs9/pf9pPoFRh074WJmPJruEqjiyt+r4erJxLgdtG/wedn5OLaqJEOTcVAYScE+Y
 rIHxtF/rYs4DYxIynDwjp9Ez26ScDS/LRXpOVJkO/SKUkpyWanFQUgL5vmTAhesDI0dD
 KXCTxISPR32tDJNMZaC7yTT82mM3jLyCYYRXjx5U5AZw9T9wEhF3jdDUHizIaCF4A/ux
 +nIb5EM5dfzgf3tpaSBqeiCY54soh1/JcCOkIN9rUHwoifv9pnD//80xo61cpn0hrrFB
 PRCTrkPU1eFYPISd8GQ9MX9l5ld8e5qkBwNoOYMpp9ON5M4Bqg9NmUsS+dVUjVfs/UCP
 1pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lVlJ9nNpJHZTQ3ZPiUhA/OdyumpiTx8ozKH1nHzGqvU=;
 b=lCjTzF+96hMmwrbYxviojyvkBrWSdhH14pUAbTeiS5AbgWm3s0oipwgAod6fDp201s
 HtXGJY6/duUJmcT2urdymYF5vmtfsOlRjhj7DuMAU5TMQjcjvHW7YdSgPJ2sOGSxxnSJ
 nXx+FznY70ladp5Ow1nj1Vq9yyTAa8bKCBLMGo3Q0KtJXCXV3LG0Emjqr82wlUClqhkI
 qrcTNBNdy1LMvDLzUfEL7zVmB+fMh2f8GydjdSehOa8e4uyoM3ZI/bpjVaXiLcXo8kz4
 LeFU7LrCAk81I0qo074747KQIBkTo6nU95Ux6eGIRYaNV7hvDx4XbBPeFKhBbkOWM0/l
 b4fQ==
X-Gm-Message-State: APjAAAWRyfZiHz+aclnFhqv4LhcZ0b52SwerxiKka0sfM/22U2PkDZNY
 T91uai0+FxnjCrEIvgL/XxcbSQ3pFXAGwA==
X-Google-Smtp-Source: APXvYqyC8IY1wf+FQl0sd7nckbl5E6rogjsaglrf0jAFQxjlvUp0KNxQzWFnryKtoopwuHR4AZIKVQ==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr4674298wme.40.1579793455559;
 Thu, 23 Jan 2020 07:30:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] target/arm/arch_dump: Add SVE notes
Date: Thu, 23 Jan 2020 15:30:32 +0000
Message-Id: <20200123153041.4248-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

When dumping a guest with dump-guest-memory also dump the SVE
registers if they are in use.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200120101832.18781-1-drjones@redhat.com
[PMM: fixed checkpatch nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/elf.h          |   1 +
 target/arm/cpu.h       |  25 +++++++++
 target/arm/arch_dump.c | 124 ++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm64.c     |  24 --------
 4 files changed, 148 insertions(+), 26 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index 3501e0c8d03..8fbfe60e09f 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1650,6 +1650,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_HW_BREAK 0x402           /* ARM hardware breakpoint registers */
 #define NT_ARM_HW_WATCH 0x403           /* ARM hardware watchpoint registers */
 #define NT_ARM_SYSTEM_CALL      0x404   /* ARM system call number */
+#define NT_ARM_SVE      0x405           /* ARM Scalable Vector Extension regs */
 
 /*
  * Physical entry point into the kernel.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 40f2c45e17e..c1aedbeac0d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -980,6 +980,31 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
 void aarch64_add_sve_properties(Object *obj);
+
+/*
+ * SVE registers are encoded in KVM's memory in an endianness-invariant format.
+ * The byte at offset i from the start of the in-memory representation contains
+ * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
+ * lowest offsets are stored in the lowest memory addresses, then that nearly
+ * matches QEMU's representation, which is to use an array of host-endian
+ * uint64_t's, where the lower offsets are at the lower indices. To complete
+ * the translation we just need to byte swap the uint64_t's on big-endian hosts.
+ */
+static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    int i;
+
+    for (i = 0; i < nr; ++i) {
+        dst[i] = bswap64(src[i]);
+    }
+
+    return dst;
+#else
+    return src;
+#endif
+}
+
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
 static inline void aarch64_sve_change_el(CPUARMState *env, int o,
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 26a2c098687..2345dec3c2c 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -62,12 +62,23 @@ struct aarch64_user_vfp_state {
 
 QEMU_BUILD_BUG_ON(sizeof(struct aarch64_user_vfp_state) != 528);
 
+/* struct user_sve_header from arch/arm64/include/uapi/asm/ptrace.h */
+struct aarch64_user_sve_header {
+    uint32_t size;
+    uint32_t max_size;
+    uint16_t vl;
+    uint16_t max_vl;
+    uint16_t flags;
+    uint16_t reserved;
+} QEMU_PACKED;
+
 struct aarch64_note {
     Elf64_Nhdr hdr;
     char name[8]; /* align_up(sizeof("CORE"), 4) */
     union {
         struct aarch64_elf_prstatus prstatus;
         struct aarch64_user_vfp_state vfp;
+        struct aarch64_user_sve_header sve;
     };
 } QEMU_PACKED;
 
@@ -76,6 +87,8 @@ struct aarch64_note {
             (AARCH64_NOTE_HEADER_SIZE + sizeof(struct aarch64_elf_prstatus))
 #define AARCH64_PRFPREG_NOTE_SIZE \
             (AARCH64_NOTE_HEADER_SIZE + sizeof(struct aarch64_user_vfp_state))
+#define AARCH64_SVE_NOTE_SIZE(env) \
+            (AARCH64_NOTE_HEADER_SIZE + sve_size(env))
 
 static void aarch64_note_init(struct aarch64_note *note, DumpState *s,
                               const char *name, Elf64_Word namesz,
@@ -128,11 +141,102 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFunction f,
     return 0;
 }
 
+#ifdef TARGET_AARCH64
+static off_t sve_zreg_offset(uint32_t vq, int n)
+{
+    off_t off = sizeof(struct aarch64_user_sve_header);
+    return ROUND_UP(off, 16) + vq * 16 * n;
+}
+
+static off_t sve_preg_offset(uint32_t vq, int n)
+{
+    return sve_zreg_offset(vq, 32) + vq * 16 / 8 * n;
+}
+
+static off_t sve_fpsr_offset(uint32_t vq)
+{
+    off_t off = sve_preg_offset(vq, 17);
+    return ROUND_UP(off, 16);
+}
+
+static off_t sve_fpcr_offset(uint32_t vq)
+{
+    return sve_fpsr_offset(vq) + sizeof(uint32_t);
+}
+
+static uint32_t sve_current_vq(CPUARMState *env)
+{
+    return sve_zcr_len_for_el(env, arm_current_el(env)) + 1;
+}
+
+static size_t sve_size_vq(uint32_t vq)
+{
+    off_t off = sve_fpcr_offset(vq) + sizeof(uint32_t);
+    return ROUND_UP(off, 16);
+}
+
+static size_t sve_size(CPUARMState *env)
+{
+    return sve_size_vq(sve_current_vq(env));
+}
+
+static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
+                                   CPUARMState *env, int cpuid,
+                                   DumpState *s)
+{
+    struct aarch64_note *note;
+    ARMCPU *cpu = env_archcpu(env);
+    uint32_t vq = sve_current_vq(env);
+    uint64_t tmp[ARM_MAX_VQ * 2], *r;
+    uint32_t fpr;
+    uint8_t *buf;
+    int ret, i;
+
+    note = g_malloc0(AARCH64_SVE_NOTE_SIZE(env));
+    buf = (uint8_t *)&note->sve;
+
+    aarch64_note_init(note, s, "LINUX", 6, NT_ARM_SVE, sve_size_vq(vq));
+
+    note->sve.size = cpu_to_dump32(s, sve_size_vq(vq));
+    note->sve.max_size = cpu_to_dump32(s, sve_size_vq(cpu->sve_max_vq));
+    note->sve.vl = cpu_to_dump16(s, vq * 16);
+    note->sve.max_vl = cpu_to_dump16(s, cpu->sve_max_vq * 16);
+    note->sve.flags = cpu_to_dump16(s, 1);
+
+    for (i = 0; i < 32; ++i) {
+        r = sve_bswap64(tmp, &env->vfp.zregs[i].d[0], vq * 2);
+        memcpy(&buf[sve_zreg_offset(vq, i)], r, vq * 16);
+    }
+
+    for (i = 0; i < 17; ++i) {
+        r = sve_bswap64(tmp, r = &env->vfp.pregs[i].p[0],
+                        DIV_ROUND_UP(vq * 2, 8));
+        memcpy(&buf[sve_preg_offset(vq, i)], r, vq * 16 / 8);
+    }
+
+    fpr = cpu_to_dump32(s, vfp_get_fpsr(env));
+    memcpy(&buf[sve_fpsr_offset(vq)], &fpr, sizeof(uint32_t));
+
+    fpr = cpu_to_dump32(s, vfp_get_fpcr(env));
+    memcpy(&buf[sve_fpcr_offset(vq)], &fpr, sizeof(uint32_t));
+
+    ret = f(note, AARCH64_SVE_NOTE_SIZE(env), s);
+    g_free(note);
+
+    if (ret < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+#endif
+
 int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, void *opaque)
 {
     struct aarch64_note note;
-    CPUARMState *env = &ARM_CPU(cs)->env;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     DumpState *s = opaque;
     uint64_t pstate, sp;
     int ret, i;
@@ -163,7 +267,18 @@ int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
         return -1;
     }
 
-    return aarch64_write_elf64_prfpreg(f, env, cpuid, s);
+    ret = aarch64_write_elf64_prfpreg(f, env, cpuid, s);
+    if (ret) {
+        return ret;
+    }
+
+#ifdef TARGET_AARCH64
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret = aarch64_write_elf64_sve(f, env, cpuid, s);
+    }
+#endif
+
+    return ret;
 }
 
 /* struct pt_regs from arch/arm/include/asm/ptrace.h */
@@ -335,6 +450,11 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     if (class == ELFCLASS64) {
         note_size = AARCH64_PRSTATUS_NOTE_SIZE;
         note_size += AARCH64_PRFPREG_NOTE_SIZE;
+#ifdef TARGET_AARCH64
+        if (cpu_isar_feature(aa64_sve, cpu)) {
+            note_size += AARCH64_SVE_NOTE_SIZE(env);
+        }
+#endif
     } else {
         note_size = ARM_PRSTATUS_NOTE_SIZE;
         if (arm_feature(env, ARM_FEATURE_VFP)) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b8fe4..e2da756e65e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -876,30 +876,6 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
     return 0;
 }
 
-/*
- * SVE registers are encoded in KVM's memory in an endianness-invariant format.
- * The byte at offset i from the start of the in-memory representation contains
- * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
- * lowest offsets are stored in the lowest memory addresses, then that nearly
- * matches QEMU's representation, which is to use an array of host-endian
- * uint64_t's, where the lower offsets are at the lower indices. To complete
- * the translation we just need to byte swap the uint64_t's on big-endian hosts.
- */
-static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
-{
-#ifdef HOST_WORDS_BIGENDIAN
-    int i;
-
-    for (i = 0; i < nr; ++i) {
-        dst[i] = bswap64(src[i]);
-    }
-
-    return dst;
-#else
-    return src;
-#endif
-}
-
 /*
  * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
  * and PREGS and the FFR have a slice size of 256 bits. However we simply hard
-- 
2.20.1


