Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9205C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A43220663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuCqw/To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyKe-0000OF-TI
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy28-0006YI-1i
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy26-00055Z-Jo
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy25-000533-SR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so16758710wmd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSezH/dLGIYf9I3MKQlHUWilPU0vUTftD3XFAejcu6Q=;
 b=ZuCqw/ToHQqiBrH2Jr7laqx6Z1ZC/NWGvgaMXrNrFR+oKqrshk8S89iseJkzXH85kc
 oKvIwC+P7HJsGlxCuPMED6wKHkjei3PpkOQEH42y3zgNTX/TYkc3o8+Mohdk7ga0Fshk
 e27Qq4od8WI2ig8ZDjcERiF64/2a/mjiGmsXF2nxkObvg1mz4uOB2usrhjP4O9ixiGYM
 /KwJ5MaIEJHZIylo/owwyTlds8tMsm+2G5nrX/vlgfFEzKYAnqyWmVFGFJnaQSz8MbUG
 B6rYXy3OoLEsqrsuoEKOCCtZAj8kIAgspvKx2J/cfVQ6XdFM07apLvpjPbbDr++VAOOe
 SzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QSezH/dLGIYf9I3MKQlHUWilPU0vUTftD3XFAejcu6Q=;
 b=qpS0HHcyS3cCsVhjo4fBqg8sJbMs3czQIHvYVAPN2DX55aba8/+SkCxilxisz3S1ty
 NUZbhGeCqsl2ByuZwXtdw/PjHXRuufLYPzjzS7w/M7BfisvFFqTawUDf2KwhZqS99PIj
 M/mZ3pt9wTdVGe89U8Yu8swrVpGINmH6wJY0sW40m5OLD/eLNWfWpJPS2dlZqhbebWPo
 Z61WV7le0fKj+29NgDIISGdEU78RvT2sIwmgr9/BFS/XiZIIEHT7ofoMmBQG/W8KlKPd
 4Rnx0ViFlGg8ZUKXxGcKRO17DPrODN1AI9aBlliXMvr47qU8veey60aBT2W3P8F/NZ+p
 ON1Q==
X-Gm-Message-State: APjAAAVParRPRxYfepc/nbiDiK42ZkDRur+/immRzUJzhTFCqaGtFamJ
 92ojJksJtQUYL5OrPPHT/IrbGA==
X-Google-Smtp-Source: APXvYqyXsyt49ITo/v2kTA8+4p8u8tTJYPoipqKRZ+w65SDsls5e71eiEF8vIp5EUXEIQS8iW7y9jg==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr13605669wmj.22.1571050615867; 
 Mon, 14 Oct 2019 03:56:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r12sm19450722wrq.88.2019.10.14.03.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99C661FFD8;
 Mon, 14 Oct 2019 11:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 52/55] plugins: make howvec plugin more generic
Date: Mon, 14 Oct 2019 11:49:45 +0100
Message-Id: <20191014104948.4291-53-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now the plugins interface indicates what guest architecture we are
running we can attempt to select the instruction classification based
on it. For now we still only classify aarch64 instructions and fall
back to decoding individual instructions. We also wave our hands about
irregular instruction encoding.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/howvec.c | 76 +++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 3b1d177ef3..5f7c740833 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -4,8 +4,7 @@
  * How vectorised is this code?
  *
  * Attempt to measure the amount of vectorisation that has been done
- * on some code by counting classes of instruction. This is very much
- * ARM specific.
+ * on some code by counting classes of instruction.
  *
  * License: GNU GPL, version 2 or later.
  *   See the COPYING file in the top-level directory.
@@ -61,7 +60,7 @@ typedef struct {
  *
  * 31..28 27..24 23..20 19..16 15..12 11..8 7..4 3..0
  */
-InsnClassExecCount insn_classes[] = {
+InsnClassExecCount aarch64_insn_classes[] = {
     /* "Reserved"" */
     { "  UDEF",              "udef",   0xffff0000, 0x00000000, COUNT_NONE},
     { "  SVE",               "sve",    0x1e000000, 0x04000000, COUNT_CLASS},
@@ -110,9 +109,29 @@ InsnClassExecCount insn_classes[] = {
     /* Scalar FP */
     { "Scalar FP ",          "fpsimd", 0x0e000000, 0x0e000000, COUNT_CLASS},
     /* Unclassified */
-    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_CLASS}
+    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_CLASS},
 };
 
+/* Default matcher for currently unclassified architectures */
+InsnClassExecCount default_insn_classes[] = {
+    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_INDIVIDUAL},
+};
+
+typedef struct {
+    const char *qemu_target;
+    InsnClassExecCount *table;
+    int table_sz;
+} ClassSelector;
+
+ClassSelector class_tables[] =
+{
+    { "aarch64", aarch64_insn_classes, ARRAY_SIZE(aarch64_insn_classes) },
+    { NULL, default_insn_classes, ARRAY_SIZE(default_insn_classes) },
+};
+
+static InsnClassExecCount *class_table;
+static int class_table_sz;
+
 static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     InsnExecCount *ea = (InsnExecCount *) a;
@@ -125,23 +144,25 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     GString *report = g_string_new("Instruction Classes:\n");
     int i;
     GList *counts;
+    InsnClassExecCount *class = NULL;
 
-    for (i = 0; i < ARRAY_SIZE(insn_classes); i++) {
-        switch (insn_classes[i].what) {
+    for (i = 0; i < class_table_sz; i++) {
+        class = &class_table[i];
+        switch (class->what) {
         case COUNT_CLASS:
-            if (insn_classes[i].count || verbose) {
+            if (class->count || verbose) {
                 g_string_append_printf(report, "Class: %-24s\t(%ld hits)\n",
-                                       insn_classes[i].class,
-                                       insn_classes[i].count);
+                                       class->class,
+                                       class->count);
             }
             break;
         case COUNT_INDIVIDUAL:
             g_string_append_printf(report, "Class: %-24s\tcounted individually\n",
-                                   insn_classes[i].class);
+                                   class->class);
             break;
         case COUNT_NONE:
             g_string_append_printf(report, "Class: %-24s\tnot counted\n",
-                                   insn_classes[i].class);
+                                   class->class);
             break;
         default:
             break;
@@ -190,14 +211,18 @@ static uint64_t * find_counter(struct qemu_plugin_insn *insn)
     uint32_t opcode;
     InsnClassExecCount *class = NULL;
 
-    /* we expect all instructions to by 32 bits for ARM */
-    g_assert(qemu_plugin_insn_size(insn) == 4);
+    /*
+     * We only match the first 32 bits of the instruction which is
+     * fine for most RISCs but a bit limiting for CISC architectures.
+     * They would probably benefit from a more tailored plugin.
+     * However we can fall back to individual instruction counting.
+     */
     opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
 
-    for (i = 0; !cnt && i < ARRAY_SIZE(insn_classes); i++) {
-        uint32_t masked_bits = opcode & insn_classes[i].mask;
-        if (masked_bits == insn_classes[i].pattern) {
-            class = &insn_classes[i];
+    for (i = 0; !cnt && i < class_table_sz; i++) {
+        class = &class_table[i];
+        uint32_t masked_bits = opcode & class->mask;
+        if (masked_bits == class->pattern) {
             break;
         }
     }
@@ -270,6 +295,17 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 {
     int i;
 
+    /* Select a class table appropriate to the guest architecture */
+    for (i = 0; i < ARRAY_SIZE(class_tables); i++) {
+        ClassSelector *entry = &class_tables[i];
+        if (!entry->qemu_target ||
+            strcmp(entry->qemu_target, info->target_name) == 0) {
+            class_table = entry->table;
+            class_table_sz = entry->table_sz;
+            break;
+        }
+    }
+
     for (i = 0; i < argc; i++) {
         char *p = argv[i];
         if (strcmp(p, "inline") == 0) {
@@ -283,9 +319,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 type = COUNT_NONE;
                 p++;
             }
-            for (j = 0; j < ARRAY_SIZE(insn_classes); j++) {
-                if (strcmp(p, insn_classes[j].opt) == 0) {
-                    insn_classes[j].what = type;
+            for (j = 0; j < class_table_sz; j++) {
+                if (strcmp(p, class_table[j].opt) == 0) {
+                    class_table[j].what = type;
                     break;
                 }
             }
-- 
2.20.1


