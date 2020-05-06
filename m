Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA2FC38A24
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4D5206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdxmYPdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4D5206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIte-0000t2-3p
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIoB-0006Rj-U2
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIoA-0001Oq-J7
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id h9so1913738wrt.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iiQCh//VFjxvmb6d7KKNLbr0lXh1jk7zOyRpXGAoAJ0=;
 b=sdxmYPddTxb3LN2vOnBpgGedl2sxGR7QRuWnGYv669AaJNgKAUTU9Tye/YSMxkI3jm
 MzMrY7GwB8nNPBcWOaB2cji+Rzn234pGgGLIJh9G+Mz0y69KkgWj46Nxx8E9AFj7Vhso
 wAi1acVJoXYNmms2agbSzCui58hvu2gQtMR2VNVMfrOVQbisHb2gXA8JI0ABJEzeXnoU
 vfrRErCW1Dk+Xsuw4P5Th9utjhxaNWqFdZXGRxma0tqVP8D2zLdB68DVaWRPXPeF/gUf
 zWmdlMKgAIMKjPr5pfPC5bdrZL8gWatq3FVIhX7c7nBA41wwyiU0w8BJRqLSF/4hxP/0
 EvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iiQCh//VFjxvmb6d7KKNLbr0lXh1jk7zOyRpXGAoAJ0=;
 b=hXeBv2x1EENaQ6MwhNGs+kn11PAUJBRbEUqbU7plo0wZjI2F+pp6zPoLJh/OysLZPG
 q8QexsJpP3/hXlTQ6qRRJdfSKqcxM7fzJ7tgO3wQ38sHT84mneb6LGIZU5k2xD+kQKoi
 t7E4aGi1MC7XnEJmU6amhMXMY8onUXVZzLqVvGRDwAaRRQXZHDoiEh5wZgom5GK06AMl
 rxovqX90mrNEVPII0DZ3hBhAFPNq5GX3QM65PdV7W5zVIOyQPi/C5FTiBrTR1RC4Boo1
 TorpgfFBFgg4mzt47j0XhJlbr+zzb5/NMSgRwCsjhXgQa+0nGcj1d4SmONzU+U4ZypLY
 JrYg==
X-Gm-Message-State: AGi0PuZP5qCA6q/LwoLeFCR/hUcM1q4HqT1Wnj927oMVvVoNmVdWUTiJ
 aQ71fN4Di+848GkJ/7qSl9lHMg==
X-Google-Smtp-Source: APiQypIrfaBNf8xh6nnne+NS1iggKY9AWVxwwHCJzE2XrJ0ZH9EWjWzgTIXPPqK4AtiCMoe2DO4J9w==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr9822818wro.255.1588766749088; 
 Wed, 06 May 2020 05:05:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u12sm2855904wmu.25.2020.05.06.05.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 063761FF9D;
 Wed,  6 May 2020 13:05:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/14] target/m68k: fix gdb for m68xxx
Date: Wed,  6 May 2020 13:05:29 +0100
Message-Id: <20200506120529.18974-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
a coldfire FPU instead of the default m68881 FPU.

This is not OK because the m68881 floats registers are 96 bits wide so it
crashes GDB with the following error message:

(gdb) target remote localhost:7960
Remote debugging using localhost:7960
warning: Register "fp0" has an unsupported size (96 bits)
warning: Register "fp1" has an unsupported size (96 bits)
...
Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
  00000000000[...]0000

With this patch: qemu-system-m68k -M none -cpu m68020 -s -S

(gdb) tar rem :1234
Remote debugging using :1234
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
0x00000000 in ?? ()
(gdb) p $fp0
$1 = nan(0xffffffffffffffff)

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1588094279-17913-3-git-send-email-frederic.konrad@adacore.com>
Message-Id: <20200430190122.4592-10-alex.bennee@linaro.org>

diff --git a/configure b/configure
index c58787100f1..0d69c360c0e 100755
--- a/configure
+++ b/configure
@@ -7825,7 +7825,7 @@ case "$target_name" in
   ;;
   m68k)
     bflt="yes"
-    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
+    gdb_xml_files="cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
     TARGET_SYSTBL_ABI=common
   ;;
   microblaze|microblazeel)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9445fcd6df5..72c545149e9 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -292,16 +292,38 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->tcg_initialize = m68k_tcg_init;
 
     cc->gdb_num_core_regs = 18;
-    cc->gdb_core_xml_file = "cf-core.xml";
 
     dc->vmsd = &vmstate_m68k_cpu;
 }
 
-#define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
-    {                                           \
-        .name = M68K_CPU_TYPE_NAME(cpu_model),  \
-        .instance_init = initfn,                \
-        .parent = TYPE_M68K_CPU,                \
+static void m68k_cpu_class_init_cf_core(ObjectClass *c, void *data)
+{
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_core_xml_file = "cf-core.xml";
+}
+
+#define DEFINE_M68K_CPU_TYPE_CF(model)               \
+    {                                                \
+        .name = M68K_CPU_TYPE_NAME(#model),          \
+        .instance_init = model##_cpu_initfn,         \
+        .parent = TYPE_M68K_CPU,                     \
+        .class_init = m68k_cpu_class_init_cf_core    \
+    }
+
+static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
+{
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_core_xml_file = "m68k-core.xml";
+}
+
+#define DEFINE_M68K_CPU_TYPE_M68K(model)             \
+    {                                                \
+        .name = M68K_CPU_TYPE_NAME(#model),          \
+        .instance_init = model##_cpu_initfn,         \
+        .parent = TYPE_M68K_CPU,                     \
+        .class_init = m68k_cpu_class_init_m68k_core  \
     }
 
 static const TypeInfo m68k_cpus_type_infos[] = {
@@ -314,15 +336,15 @@ static const TypeInfo m68k_cpus_type_infos[] = {
         .class_size = sizeof(M68kCPUClass),
         .class_init = m68k_cpu_class_init,
     },
-    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("any", any_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE_M68K(m68000),
+    DEFINE_M68K_CPU_TYPE_M68K(m68020),
+    DEFINE_M68K_CPU_TYPE_M68K(m68030),
+    DEFINE_M68K_CPU_TYPE_M68K(m68040),
+    DEFINE_M68K_CPU_TYPE_M68K(m68060),
+    DEFINE_M68K_CPU_TYPE_CF(m5206),
+    DEFINE_M68K_CPU_TYPE_CF(m5208),
+    DEFINE_M68K_CPU_TYPE_CF(cfv4e),
+    DEFINE_M68K_CPU_TYPE_CF(any),
 };
 
 DEFINE_TYPES(m68k_cpus_type_infos)
diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
new file mode 100644
index 00000000000..5b092d26de0
--- /dev/null
+++ b/gdb-xml/m68k-core.xml
@@ -0,0 +1,29 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2008 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.m68k.core">
+  <reg name="d0" bitsize="32"/>
+  <reg name="d1" bitsize="32"/>
+  <reg name="d2" bitsize="32"/>
+  <reg name="d3" bitsize="32"/>
+  <reg name="d4" bitsize="32"/>
+  <reg name="d5" bitsize="32"/>
+  <reg name="d6" bitsize="32"/>
+  <reg name="d7" bitsize="32"/>
+  <reg name="a0" bitsize="32" type="data_ptr"/>
+  <reg name="a1" bitsize="32" type="data_ptr"/>
+  <reg name="a2" bitsize="32" type="data_ptr"/>
+  <reg name="a3" bitsize="32" type="data_ptr"/>
+  <reg name="a4" bitsize="32" type="data_ptr"/>
+  <reg name="a5" bitsize="32" type="data_ptr"/>
+  <reg name="fp" bitsize="32" type="data_ptr"/>
+  <reg name="sp" bitsize="32" type="data_ptr"/>
+
+  <reg name="ps" bitsize="32"/>
+  <reg name="pc" bitsize="32" type="code_ptr"/>
+
+</feature>
-- 
2.20.1


