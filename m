Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AC32054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW6vD3Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AC32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5Yg-0005iu-5r
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qi-0005EW-S3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qf-0003PD-Ue
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5Qf-0003NV-LT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so7794616wma.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1HpaLHcELOKuPjtThJu7f56C+AUGyKN1UycOs1q17Gw=;
 b=HW6vD3KqiSy869G9W7mvhE0KqffByMyihNiUgP9BAYccIpS/a2HfGKhcQ8GabkbtZb
 5s/JIlKbDmo2BmZoDlXCvSxi1L9+YNcubpqi927+Ui+atUHu/WoGI0pB4yeDCqHxrndQ
 mjAkrAbXcx+/qr2WgOKx/aV11jymftQde/Vxuny4qanOmHxe15Axiz0aFXucWN/Jlyn8
 Cuote+yxOeFBhCNjwolWOXrx45glfa0XtquiPjy0FWXz8cfQ20PljoeF4oqy2aSFfqJV
 Il5hWJSe02aV/yMyfM0qn/IWAGCLYmh1L8JDCLcQ2QFJmZTxeAIU/mfynPnZuqzd9M78
 reRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1HpaLHcELOKuPjtThJu7f56C+AUGyKN1UycOs1q17Gw=;
 b=JjPtZ0CNLWWMVOLuqpSwGJ7Cb2Z8cy/r+Vyv/rKaoETkvNdSrOF8e6WiCDtD1LBNUW
 kxtjzsQ20cNoRw+4KyrRz2DhGz+abZ5LrqbDZIuQWfzWZDVjNCcf54H2iJiFN+/Ru00J
 cbiqLPdLgD4G1ZUcK/Au2yaDZIdTGNs+Dx1HALDlNnhK420mydh+4H8X81dT/hYiTq+y
 WzH4MUQbq2KnuEqMREecHa9M1dXfOWlkQYyz0hv1WB7Qdd/rVLgniVQcA30hQV8++KhA
 qmC8AB0fGahZXSO+ijhwaH8AyQ5XoppR6vx4nJpGEJknb+gEisQyJTMDVkW+Qd07uTAP
 yMWQ==
X-Gm-Message-State: APjAAAUcZ+emDHj4uWix+ZxP5MatgleqbGlR5C5n6H11nlYbcSFCd4sv
 hNtAeqhaZVS5aKKUFffrVVsnvA==
X-Google-Smtp-Source: APXvYqzrM0iWBf9CGjPr7yOfq9DZLBHXGdJqC1bxuIjHIoISvWEc4ICMEiiJg5AoOGIgY8o85vEV2Q==
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr880479wmj.142.1576083936293;
 Wed, 11 Dec 2019 09:05:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 25sm2237549wmi.32.2019.12.11.09.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3173F1FF98;
 Wed, 11 Dec 2019 17:05:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 09/20] target/arm: prepare for multiple dynamic XMLs
Date: Wed, 11 Dec 2019 17:05:09 +0000
Message-Id: <20191211170520.7747-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

We will want to generate similar dynamic XML for gdbstub support of
SVE registers (the upstream doesn't use XML). To that end lightly
rename a few things to make the distinction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h     | 20 +++++++++++++-------
 target/arm/gdbstub.c | 30 +++++++++++++++---------------
 target/arm/helper.c  |  4 ++--
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cf16f915c82..a31c7a36d6b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -128,14 +128,20 @@ enum {
 /**
  * DynamicGDBXMLInfo:
  * @desc: Contains the XML descriptions.
- * @num_cpregs: Number of the Coprocessor registers seen by GDB.
- * @cpregs_keys: Array that contains the corresponding Key of
- * a given cpreg with the same order of the cpreg in the XML description.
+ * @num: Number of the registers in this XML seen by GDB.
+ * @data: A union with data specific to the set of registers
+ *    @cpregs_keys: Array that contains the corresponding Key of
+ *                  a given cpreg with the same order of the cpreg
+ *                  in the XML description.
  */
 typedef struct DynamicGDBXMLInfo {
     char *desc;
-    int num_cpregs;
-    uint32_t *cpregs_keys;
+    int num;
+    union {
+        struct {
+            uint32_t *keys;
+        } cpregs;
+    } data;
 } DynamicGDBXMLInfo;
 
 /* CPU state for each instance of a generic timer (in cp15 c14) */
@@ -748,7 +754,7 @@ struct ARMCPU {
     uint64_t *cpreg_vmstate_values;
     int32_t cpreg_vmstate_array_len;
 
-    DynamicGDBXMLInfo dyn_xml;
+    DynamicGDBXMLInfo dyn_sysreg_xml;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
@@ -955,7 +961,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 /* Dynamically generates for gdb stub an XML description of the sysregs from
  * the cp_regs hashtable. Returns the registered sysregs number.
  */
-int arm_gen_dynamic_xml(CPUState *cpu);
+int arm_gen_dynamic_sysreg_xml(CPUState *cpu);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 4557775d245..1f68ab98c3b 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -106,15 +106,15 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static void arm_gen_one_xml_reg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
-                                    ARMCPRegInfo *ri, uint32_t ri_key,
-                                    int bitsize)
+static void arm_gen_one_xml_sysreg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
+                                       ARMCPRegInfo *ri, uint32_t ri_key,
+                                       int bitsize)
 {
     g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
     g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
     g_string_append_printf(s, " group=\"cp_regs\"/>");
-    dyn_xml->num_cpregs++;
-    dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] = ri_key;
+    dyn_xml->data.cpregs.keys[dyn_xml->num] = ri_key;
+    dyn_xml->num++;
 }
 
 static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
@@ -126,12 +126,12 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     GString *s = param->s;
     ARMCPU *cpu = ARM_CPU(param->cs);
     CPUARMState *env = &cpu->env;
-    DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_xml;
+    DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_sysreg_xml;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 64);
+                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
             }
         } else {
             if (ri->state == ARM_CP_STATE_AA32) {
@@ -140,30 +140,30 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
                     return;
                 }
                 if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 64);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
                 } else {
-                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 32);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32);
                 }
             }
         }
     }
 }
 
-int arm_gen_dynamic_xml(CPUState *cs)
+int arm_gen_dynamic_sysreg_xml(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
     RegisterSysregXmlParam param = {cs, s};
 
-    cpu->dyn_xml.num_cpregs = 0;
-    cpu->dyn_xml.cpregs_keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
+    cpu->dyn_sysreg_xml.num = 0;
+    cpu->dyn_sysreg_xml.data.cpregs.keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
     g_string_printf(s, "<?xml version=\"1.0\"?>");
     g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
     g_string_append_printf(s, "<feature name=\"org.qemu.gdb.arm.sys.regs\">");
     g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_xml, &param);
     g_string_append_printf(s, "</feature>");
-    cpu->dyn_xml.desc = g_string_free(s, false);
-    return cpu->dyn_xml.num_cpregs;
+    cpu->dyn_sysreg_xml.desc = g_string_free(s, false);
+    return cpu->dyn_sysreg_xml.num;
 }
 
 const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
@@ -171,7 +171,7 @@ const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
     ARMCPU *cpu = ARM_CPU(cs);
 
     if (strcmp(xmlname, "system-registers.xml") == 0) {
-        return cpu->dyn_xml.desc;
+        return cpu->dyn_sysreg_xml.desc;
     }
     return NULL;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6476245e789..4bf133e2f42 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -207,7 +207,7 @@ static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
     const ARMCPRegInfo *ri;
     uint32_t key;
 
-    key = cpu->dyn_xml.cpregs_keys[reg];
+    key = cpu->dyn_sysreg_xml.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
         if (cpreg_field_is_64bit(ri)) {
@@ -6995,7 +6995,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


