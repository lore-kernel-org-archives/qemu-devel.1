Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F39C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3D620675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ6r7ER2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3D620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCm9-0002k8-R8
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:10:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdZ-00040t-GN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdX-0001z6-Rg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdX-0001x6-EX
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so9755789wmo.2
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BFsWi5CBOk/GZ+c1NR/rK6GiEU7F52KQ0WRdytQizHE=;
	b=RJ6r7ER2UvoXSdEePpYrlVaI+V37Tf8bAc5q/lIIN0zW7ozjdy6zFH+NAe4U+0JemU
	BIFmP+rHnp0aukH88Sq25es65FvtxO7ICReELSoEk+D05Eyvpk/8LhYSP5sF2t3ZXRZ7
	cIyC7X167ETlW6s4/2rkgGfiQFE/r6J6kCHGqwpjgnVg+CMlC74djeqtvIoaZDjxMaIy
	TR14gPQvlz4faCGGVbSgQjLSVzFFxrMM9HQUuEeI5b+Ivxy2U9KVVjdGbBeNAT0zvzmy
	z/L6huFOjxv/u7brTgV0f0N3/IOvPgtGXT0bZ5MpYJ347VYYidZAE21eIUArrjbCv0Td
	Nnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BFsWi5CBOk/GZ+c1NR/rK6GiEU7F52KQ0WRdytQizHE=;
	b=HcKQPHDIOAv+hlxI51sNrb2rD2XydjQbZwbKQR3hV5bkH5hzcAGiPZebcsfc7ENAXQ
	J9wVauXzY/MXc0phJQwrLJ0hkl7acWOzme8iHjNUpOPm+aFedC7PO7euWb4HotujtTsT
	3tGeoIM4T5H5jfYmt6Cng2W+cUOBM4RtEyUOVeRmS3TuwL4CIyqo1ke8U2V91y84wZLe
	zVdjTC3OU4W7MVQr4gTmWbPLcyMtld8EkD+/FFV30YNX4oAtrInBMJSLlbzlFVYrZJLw
	jbuOwZ7LDr+DCE+UajQClITAjqxAkgFiyyg+/3X2Xw3PFXFyjtj0jXFE6CPlOxyVOmuj
	PJig==
X-Gm-Message-State: APjAAAU+O/7M4oD0lseiYHZrGch/szyzN+kAn9YHcPL8yP2SDWxuwS+c
	mcqa0D/BaO+yQvOgXJc5m7bEIJSj
X-Google-Smtp-Source: APXvYqwiA+Y4OAkrETuLPbXVGmPn8m1LbZd+WxsrWdshSW10Dka08FZtmUzqww8rNtaVi4EgfhwkmA==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr447244wmi.114.1558713697046; 
	Fri, 24 May 2019 09:01:37 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:36 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:04 +0300
Message-Id: <20190524160118.31134-7-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v11 06/20] gdbstub: Implement set_thread (H
 pkt) with new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 83 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f74a30da03..129a47230f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1546,6 +1546,51 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind != GDB_ONE_THREAD) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
+                      gdb_ctx->params[1].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /*
+     * Note: This command is deprecated and modern gdb's will be using the
+     *       vCont command instead.
+     */
+    switch (gdb_ctx->params[0].opcode) {
+    case 'c':
+        gdb_ctx->s->c_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    case 'g':
+        gdb_ctx->s->g_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    default:
+        put_packet(gdb_ctx->s, "E22");
+        break;
+    }
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1559,7 +1604,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -1822,35 +1866,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, "E22");
         break;
     case 'H':
-        type = *p++;
-
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-
-        if (thread_kind != GDB_ONE_THREAD) {
-            put_packet(s, "OK");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-        if (cpu == NULL) {
-            put_packet(s, "E22");
-            break;
-        }
-        switch (type) {
-        case 'c':
-            s->c_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        case 'g':
-            s->g_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        default:
-             put_packet(s, "E22");
-             break;
+        {
+            static const GdbCmdParseEntry set_thread_cmd_desc = {
+                .handler = handle_set_thread,
+                .cmd = "H",
+                .cmd_startswith = 1,
+                .schema = "o.t0"
+            };
+            cmd_parser = &set_thread_cmd_desc;
         }
         break;
     case 'T':
-- 
2.21.0


