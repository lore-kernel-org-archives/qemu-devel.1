Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C37DC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F320674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAyFhBBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGY5-0000Tm-Lc
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN3-0000gR-Mw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN2-0003Ii-2R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGN1-0003DD-R1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id h6so6538809wrs.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KRu/hQdw0xxxfyyGNoQ9AeZ+IGpH7Hzuo3e1uXmI2BY=;
 b=EAyFhBBOR3t01CO9uElCTQsXLQg5qlfH7wzR75bJc69xi4GSSNHC/pjrR+MLxGsu1t
 d2aKPpSF65r21cYgW3rwPjkurB1lEQ8tob8DmgL3F6PJrQ+76vAzESDvwOlMtFZBPMpi
 EZF/xbWcxIP9+PT7H45V2fgi1s83H1hwLEvdPB4pebExbKizskrQow9WrtPkwyLn4MKL
 +kJKdI9+TTRSY43+ygd7nrhzUwaWbuWDnWPm4wXptjFPjA+fBujuLEpYKkQOnuOY1Yg5
 8mGYzigC+KYjx1yzqxFtHaG+8NaLPrvVjOtDdPtM71R75UEy6YpEPatVSAJ/vHVn/Dv4
 4siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KRu/hQdw0xxxfyyGNoQ9AeZ+IGpH7Hzuo3e1uXmI2BY=;
 b=eQxitGQPz6mu1gyB5G7M9DtV4EX4EuWcn4FZ9IEN4/ckWMpNVeTvS+LFFDoSlOZ8ri
 I3ndsvT4QKWIlBI22faoeYiUtgWWd6K5fwgsLu2foO36NIFL4rm+6HirRCpjDEYQO3sD
 J4V7aoRuAcZ+c5v4rSXBQbbDfvZCP3p3MiGsUlxC2Lhrhq2Clg1i2JWEUxXXEsx/zKt5
 ReD4wvIqqmk3RddBjKXjKHERrVob0Bh8krJ9K+Xj1UhqWkuP/iE68OETpc9TOMaI872D
 RIx7NFRM+5gxJW8hiGWKVFAmLWSJapXiTm0tNdOGdsfN5aBd8q7ccIEQTWhXXVM8OdAn
 4gmA==
X-Gm-Message-State: ANhLgQ2ISi4rwI3Y/j7ZCYjyho5rfJQGF4yfMwsCM4p5P+GKRopWS0br
 2GIUccdwbKu1ou6fTEDaPXZXo8uIgoQ=
X-Google-Smtp-Source: ADFU+vvnjyk/lq/QfRyikqsG6YSiQH7NZnv8+bdLzaTS3beYGLHdv7bgseZDILyynvcw4BXj9uiPhA==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr139232wrc.197.1584467474758; 
 Tue, 17 Mar 2020 10:51:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm5729685wrr.62.2020.03.17.10.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:51:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E66BD1FF9E;
 Tue, 17 Mar 2020 17:50:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/28] target/arm: prepare for multiple dynamic XMLs
Date: Tue, 17 Mar 2020 17:50:40 +0000
Message-Id: <20200317175053.5278-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will want to generate similar dynamic XML for gdbstub support of
SVE registers (the upstream doesn't use XML). To that end lightly
rename a few things to make the distinction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316172155.971-16-alex.bennee@linaro.org>

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ab2cbfd417..0ab82c987c3 100644
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
@@ -749,7 +755,7 @@ struct ARMCPU {
     uint64_t *cpreg_vmstate_values;
     int32_t cpreg_vmstate_array_len;
 
-    DynamicGDBXMLInfo dyn_xml;
+    DynamicGDBXMLInfo dyn_sysreg_xml;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
@@ -974,7 +980,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
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
index c0e1ba17272..b0e2a85b005 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -208,7 +208,7 @@ static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
     const ARMCPRegInfo *ri;
     uint32_t key;
 
-    key = cpu->dyn_xml.cpregs_keys[reg];
+    key = cpu->dyn_sysreg_xml.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
         if (cpreg_field_is_64bit(ri)) {
@@ -7973,7 +7973,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


