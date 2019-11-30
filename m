Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD9C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9962075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IStjQTjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9962075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayXQ-00050B-NP
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOX-000371-MR
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOT-0003Pv-OX
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:25 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOT-0003Oc-Al
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:21 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so11526844wma.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ujzbndND8NjiH15OVRuTFT18fcXE0bSLkq8cdkW8KII=;
 b=IStjQTjBd6fBvuXWffA1mxNsaF1e0Ahawl/jLx61rTga40zzAFrs3pc2UO1t7sT8NG
 9BjKPe3wrLj0acd//uTejn/Is+cKa+d4mzlnhOzVGuBSd4W6uuQJpejCYlOwqpieQiDO
 Sww1TnLGDn9Oywu8yQXhHkfqO8+OeET1ySqKN8Vfb8LO7FUWG40+mDHDO/IV5y5Joh8q
 QCPxcYPvrM7hPrnF7O83I54BXsEpfouS/MJ6gs6gXSC/0DX5OqBVfAwzUBp4dwiU/Tz5
 9bltizxuPlkZK3Rq6KBAw0fgz8LlMUggs9Fs3HZFlvfDD9kP46cfPqLcqglSE56vX6e5
 5Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ujzbndND8NjiH15OVRuTFT18fcXE0bSLkq8cdkW8KII=;
 b=JEoILGbxIQzY9BBz4SBl4iVhzFqFJ7H0/muQw5msl+crp6YuETxEehlVgHg9CO25O9
 F3S7itdfJsAWyYmqA4dmaneEec4A1REw4SrOwpLOXL964v0+XDHNA0JwV5MZPwp3D5mz
 8P7+xPqehIP0kzGoMLz+Ss8VSpyjZ9YWL4EuZdBdNNtuht1iS7i6vudSMFFcFwyW0ton
 yAREF999IvU8cxE5BPK4BzoIyGqGRQ4VZuCwlb0Y/DVmc9ZFdVO1fKRYZfTJa6dbMbik
 3Zkr7/Du68t6z6+gEVT3wuG/7E6CV4UNp31hdSk8s605ohnsT3XnKczoVE8GaKLhnpUL
 +8CQ==
X-Gm-Message-State: APjAAAUqlAYgBtTjIwheWvjbzBL8FTLwnBZgbhMIcesrRBq2x6gCL+z3
 h3RwFSV+305RH6wfbNZ5G5O2FA==
X-Google-Smtp-Source: APXvYqw9nWDisyLAcc/ErQ0RtgoZcEPwyHnp/9PZ6uoq4eg0DZUTi0tg3fDbJfeLWt+SbKISRyASTw==
X-Received: by 2002:a1c:3c86:: with SMTP id
 j128mr18648978wma.137.1575103580046; 
 Sat, 30 Nov 2019 00:46:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m1sm30344152wrv.37.2019.11.30.00.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC9441FF9B;
 Sat, 30 Nov 2019 08:46:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/14] target/arm: generate xml description of our SVE
 registers
Date: Sat, 30 Nov 2019 08:46:00 +0000
Message-Id: <20191130084602.10818-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We also expose a the helpers to read/write the the registers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - instead of zNpM expose zN at sve_max_vq width
  - wrap union in union q(us), d(usf), s(usf), h(usf), b(us)
---
 target/arm/cpu.h     |  10 +++-
 target/arm/gdbstub.c | 130 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c  | 110 +++++++++++++++++++++++++++++++++++-
 3 files changed, 245 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cc7258d5f1d..bd4d5b4445b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -141,6 +141,9 @@ typedef struct DynamicGDBXMLInfo {
         struct {
             uint32_t *keys;
         } cpregs;
+        struct {
+            int fpsr_pos;
+        } sve;
     } data;
 } DynamicGDBXMLInfo;
 
@@ -755,6 +758,7 @@ struct ARMCPU {
     int32_t cpreg_vmstate_array_len;
 
     DynamicGDBXMLInfo dyn_sysreg_xml;
+    DynamicGDBXMLInfo dyn_svereg_xml;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
@@ -958,10 +962,12 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
-/* Dynamically generates for gdb stub an XML description of the sysregs from
- * the cp_regs hashtable. Returns the registered sysregs number.
+/*
+ * Helpers to dynamically generates XML descriptions of the sysregs
+ * and SVE registers. Returns the number of registers in each set.
  */
 int arm_gen_dynamic_sysreg_xml(CPUState *cpu, int base_reg);
+int arm_gen_dynamic_svereg_xml(CPUState *cpu, int base_reg);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 69c35462a63..6567f746c47 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -171,12 +171,142 @@ int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
     return cpu->dyn_sysreg_xml.num;
 }
 
+struct TypeSize {
+    const char *gdb_type;
+    int  size;
+    const char sz, suffix;
+};
+
+static struct TypeSize vec_lanes[] = {
+    /* quads */
+    { "uint128", 128, 'q', 'u' },
+    { "int128", 128, 'q', 's' },
+    /* 64 bit */
+    { "uint64", 64, 'd', 'u' },
+    { "int64", 64, 'd', 's' },
+    { "ieee_double", 64, 'd', 'f' },
+    /* 32 bit */
+    { "uint32", 32, 's', 'u' },
+    { "int32", 32, 's', 's' },
+    { "ieee_single", 32, 's', 'f' },
+    /* 16 bit */
+    { "uint16", 16, 'h', 'u' },
+    { "int16", 16, 'h', 's' },
+    { "ieee_half", 16, 'h', 'f' },
+    /* bytes */
+    { "uint8", 8, 'b', 'u' },
+    { "int8", 8, 'b', 's' },
+};
+
+
+int arm_gen_dynamic_svereg_xml(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GString *s = g_string_new(NULL);
+    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+    g_autoptr(GString) ts = g_string_new("");
+    g_autoptr(GString) us = g_string_new("");
+    int i, bits, reg_width = (cpu->sve_max_vq * 128);
+    info->num = 0;
+    g_string_printf(s, "<?xml version=\"1.0\"?>");
+    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
+    g_string_append_printf(s, "<feature name=\"org.qemu.gdb.aarch64.sve\">");
+
+    /* First define types and totals in a whole VL */
+    for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+        int count = reg_width / vec_lanes[i].size;
+        g_string_printf(ts, "vq%d%c%c", count,
+                        vec_lanes[i].sz, vec_lanes[i].suffix);
+        g_string_append_printf(s,
+                               "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
+                               ts->str, vec_lanes[i].gdb_type, count);
+    }
+    /*
+     * Now define a union for each size group containing unsigned and
+     * signed and potentially float versions of each size from 128 to
+     * 8 bits.
+     */
+    for (bits = 128; bits >= 8; bits = bits/2) {
+        int count = reg_width / bits;
+        g_string_append_printf(s, "<union id=\"vq%dn\">", count);
+        for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+            if (vec_lanes[i].size == bits) {
+                g_string_append_printf(s, "<field name=\"%c\" type=\"vq%d%c%c\"/>",
+                                       vec_lanes[i].suffix,
+                                       count,
+                                       vec_lanes[i].sz, vec_lanes[i].suffix);
+            }
+        }
+        g_string_append(s, "</union>");
+    }
+    /* And now the final union of unions */
+    g_string_append(s, "<union id=\"vq\">");
+    for (bits = 128; bits >= 8; bits = bits/2) {
+        int count = reg_width / bits;
+        for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+            if (vec_lanes[i].size == bits) {
+                g_string_append_printf(s, "<field name=\"%c\" type=\"vq%dn\"/>",
+                                       vec_lanes[i].sz, count);
+                break;
+            }
+        }
+    }
+    g_string_append(s, "</union>");
+
+    /* Then define each register in parts for each vq */
+    for (i = 0; i < 32; i++) {
+        g_string_append_printf(s,
+                               "<reg name=\"z%d\" bitsize=\"%d\""
+                               " regnum=\"%d\" group=\"vector\""
+                               " type=\"vq\"/>",
+                               i, reg_width, base_reg++);
+        info->num++;
+    }
+    /* fpscr & status registers */
+    info->data.sve.fpsr_pos = info->num;
+    g_string_append_printf(s, "<reg name=\"fpsr\" bitsize=\"32\""
+                           " regnum=\"%d\" group=\"float\""
+                           " type=\"int\"/>", base_reg++);
+    g_string_append_printf(s, "<reg name=\"fpcr\" bitsize=\"32\""
+                           " regnum=\"%d\" group=\"float\""
+                           " type=\"int\"/>", base_reg++);
+    info->num += 2;
+    /*
+     * Predicate registers aren't so big they are worth splitting up
+     * but we do need to define a type to hold the array of quad
+     * references.
+     */
+    g_string_append_printf(s,
+                           "<vector id=\"vqp\" type=\"uint16\" count=\"%d\"/>",
+                           cpu->sve_max_vq);
+    for (i = 0; i < 16; i++) {
+        g_string_append_printf(s,
+                               "<reg name=\"p%d\" bitsize=\"%d\""
+                               " regnum=\"%d\" group=\"vector\""
+                               " type=\"vqp\"/>",
+                               i, cpu->sve_max_vq * 16, base_reg++);
+        info->num++;
+    }
+    g_string_append_printf(s,
+                           "<reg name=\"ffr\" bitsize=\"%d\""
+                           " regnum=\"%d\" group=\"vector\""
+                           " type=\"vqp\"/>",
+                           cpu->sve_max_vq * 16, base_reg++);
+    info->num++;
+    g_string_append_printf(s, "</feature>");
+    cpu->dyn_svereg_xml.desc = g_string_free(s, false);
+    return cpu->dyn_svereg_xml.num;
+}
+
+
 const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
     if (strcmp(xmlname, "system-registers.xml") == 0) {
         return cpu->dyn_sysreg_xml.desc;
+    } else if (strcmp(xmlname, "sve-registers.xml") == 0) {
+        return cpu->dyn_svereg_xml.desc;
     }
     return NULL;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d00e4fcca86..f78dd3b5fe3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -201,6 +201,15 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+/**
+ * arm_get/set_gdb_*: get/set a gdb register
+ * @env: the CPU state
+ * @buf: a buffer to copy to/from
+ * @reg: register number (offset from start of group)
+ *
+ * We return the number of bytes copied
+ */
+
 static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -224,6 +233,87 @@ static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
+#ifdef TARGET_AARCH64
+static int arm_gdb_get_svereg(CPUARMState *env, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+
+    /* The first 32 registers are the zregs */
+    if (reg < 32) {
+        int vq, len = 0;
+        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+            len += gdb_get_reg128(buf,
+                                  env->vfp.zregs[reg].d[vq * 2 + 1],
+                                  env->vfp.zregs[reg].d[vq * 2]);
+        }
+        return len;
+    }
+    switch (reg - info->data.sve.fpsr_pos) {
+    case 0:
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+    case 1:
+        return gdb_get_reg32(buf, vfp_get_fpcr(env));
+    case 2 ... 19:
+    {
+        int preg = reg - info->data.sve.fpsr_pos - 2;
+        int vq, len = 0;
+        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
+            len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
+        }
+        return len;
+    }
+    default:
+        /* gdbstub asked for something out our range */
+        break;
+    }
+
+    return 0;
+}
+
+static int arm_gdb_set_svereg(CPUARMState *env, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+
+    /* The first 32 registers are the zregs */
+    if (reg < 32) {
+        int vq, len = 0;
+        uint64_t *p = (uint64_t *) buf;
+        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+            env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
+            env->vfp.zregs[reg].d[vq * 2] = *p++;
+            len += 16;
+        }
+        return len;
+    }
+    switch (reg - info->data.sve.fpsr_pos) {
+    case 0:
+        vfp_set_fpsr(env, *(uint32_t *)buf);
+        return 4;
+    case 1:
+        vfp_set_fpcr(env, *(uint32_t *)buf);
+        return 4;
+    case 2 ... 19:
+    {
+        int preg = reg - info->data.sve.fpsr_pos - 2;
+        int vq, len = 0;
+        uint64_t *p = (uint64_t *) buf;
+        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
+            env->vfp.pregs[preg].p[vq / 4] = *p++;
+            len += 8;
+        }
+        return len;
+    }
+    default:
+        /* gdbstub asked for something out our range */
+        break;
+    }
+
+    return 0;
+}
+#endif /* TARGET_AARCH64 */
+
 static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 {
    /* Return true if the regdef would cause an assertion if you called
@@ -6981,9 +7071,22 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        gdb_register_coprocessor(cs, aarch64_fpu_gdb_get_reg,
-                                 aarch64_fpu_gdb_set_reg,
-                                 34, "aarch64-fpu.xml", 0);
+        /*
+         * The lower part of each SVE register aliases to the FPU
+         * registers so we don't need to include both.
+         */
+#ifdef TARGET_AARCH64
+        if (isar_feature_aa64_sve(&cpu->isar)) {
+            gdb_register_coprocessor(cs, arm_gdb_get_svereg, arm_gdb_set_svereg,
+                                     arm_gen_dynamic_svereg_xml(cs, cs->gdb_num_regs),
+                                     "sve-registers.xml", 0);
+        } else
+#endif
+        {
+            gdb_register_coprocessor(cs, aarch64_fpu_gdb_get_reg,
+                                     aarch64_fpu_gdb_set_reg,
+                                     34, "aarch64-fpu.xml", 0);
+        }
     } else if (arm_feature(env, ARM_FEATURE_NEON)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  51, "arm-neon.xml", 0);
@@ -6997,6 +7100,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
                              arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
+
 }
 
 /* Sort alphabetically by type name, except for "any". */
-- 
2.20.1


