Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A82C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBD120665
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eeu8xabl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBD120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayXu-0005cC-HY
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOV-000342-Fe
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOT-0003Pn-MZ
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:23 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOT-0003NF-AN
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:21 -0500
Received: by mail-wm1-x341.google.com with SMTP id u18so16290941wmc.3
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cTqY+VVrIEiDrOiDCyCP2RljFepIcDuXrggPXm+fTw0=;
 b=Eeu8xablyvQPKgKnAxUeQpLvcnfK6LRVEryadBnEFuhl3OHA7rVHLYfzHXq4xHH7wE
 7je6/eFbsynjZXn1LbW8gbiyXbVNq40Be2eRXRz5xLHqbLMI+hLwot/NObmEBDbQOqPk
 uuwJl2BwIHT1zK3/E1eOdZ6Krro9saYLgu18XB3+Clg2Ss0a9K7KHMg5tcs7V2iE0Lrh
 qmMzmdk9hMqUMw5tBaZLQBe4HmXtCVKx5XpF5d28qi1KLMWjqFvnebZSVteog50knAUF
 2HRbF5wvXZm9706rcRHllt9BMTKWzDUVsDVtMS1hvmqQGHoxbEfFbvogk87zqCSmdLTV
 /BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cTqY+VVrIEiDrOiDCyCP2RljFepIcDuXrggPXm+fTw0=;
 b=RYG4T6xWVvNMiWDlWCW/yK7sU/IkfQ3FzSEo4k6qnjTB+L2+GS0Wv/HayjQB0Hr0qP
 ZkiJIEEiFALxtLEkmCbJ3ZznfvX4ToPVMJHK5tM79ynRCAxZO9l9sXN+GAAqdlDSnOnU
 KfoKRE0j+ktytJl+yNIekIBWm48BUpiAl74K8cfCamCCuskeQRmu2HtckTLH1ST2HgWr
 AFEFc9JCVtQ8mKN2hdkITQiW4t1olbI2au10KmZfc03eRTFG0zDoJTJYzA6laB3y/3hd
 T5flBT9QnCOLsoe8rvcnCMc2Q5qdWB469bH31veqljtU3250dt6wliJJSJ7oLU26pkTW
 YlKg==
X-Gm-Message-State: APjAAAXY0hXxEajsrIFDIBjJ+9KdstSpn9SC0xxuvDXseFK6ZQMTAr51
 4PZvNcr7Uu7Nh6q81t5Iq7PvYg==
X-Google-Smtp-Source: APXvYqxsAOon4fLSMCUN14UHR9rpLGEWwEnwRupMIglrYTylO40wKElnQneEjkah/M+tAzI8G/ZoqQ==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr3323755wmk.113.1575103578673; 
 Sat, 30 Nov 2019 00:46:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h15sm31711328wrb.44.2019.11.30.00.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77CF91FF99;
 Sat, 30 Nov 2019 08:46:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 10/14] target/arm: explicitly encode regnum in our XML
Date: Sat, 30 Nov 2019 08:45:58 +0000
Message-Id: <20191130084602.10818-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

This is described as optional but I'm not convinced of the numbering
when multiple target fragments are sent.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - post inc param->n in place so we don't get out count wrong
---
 target/arm/cpu.h     |  2 +-
 target/arm/gdbstub.c | 17 +++++++++++------
 target/arm/helper.c  |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a31c7a36d6b..cc7258d5f1d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -961,7 +961,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 /* Dynamically generates for gdb stub an XML description of the sysregs from
  * the cp_regs hashtable. Returns the registered sysregs number.
  */
-int arm_gen_dynamic_sysreg_xml(CPUState *cpu);
+int arm_gen_dynamic_sysreg_xml(CPUState *cpu, int base_reg);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1f68ab98c3b..69c35462a63 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -24,6 +24,7 @@
 typedef struct RegisterSysregXmlParam {
     CPUState *cs;
     GString *s;
+    int n;
 } RegisterSysregXmlParam;
 
 /* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
@@ -108,10 +109,11 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
 static void arm_gen_one_xml_sysreg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
                                        ARMCPRegInfo *ri, uint32_t ri_key,
-                                       int bitsize)
+                                       int bitsize, int regnum)
 {
     g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
     g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
+    g_string_append_printf(s, " regnum=\"%d\"", regnum);
     g_string_append_printf(s, " group=\"cp_regs\"/>");
     dyn_xml->data.cpregs.keys[dyn_xml->num] = ri_key;
     dyn_xml->num++;
@@ -131,7 +133,8 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
+                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64,
+                                           param->n++);
             }
         } else {
             if (ri->state == ARM_CP_STATE_AA32) {
@@ -140,20 +143,22 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
                     return;
                 }
                 if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64,
+                                               param->n++);
                 } else {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32,
+                                               param->n++);
                 }
             }
         }
     }
 }
 
-int arm_gen_dynamic_sysreg_xml(CPUState *cs)
+int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
-    RegisterSysregXmlParam param = {cs, s};
+    RegisterSysregXmlParam param = {cs, s, base_reg};
 
     cpu->dyn_sysreg_xml.num = 0;
     cpu->dyn_sysreg_xml.data.cpregs.keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4bf133e2f42..d00e4fcca86 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6995,7 +6995,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


