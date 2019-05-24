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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB6C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FE920675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZtJYQU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FE920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCou-0005dD-5o
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:13:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCds-0004I4-2Q
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdp-0002Hf-Ux
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdp-00029k-NJ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so10555316wrs.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9CqEJZQFyLkk/ZYymWcSznPDKfDfQZ0RNP4fPMiLpuM=;
	b=DZtJYQU+kmsznDu3TgCCrliCLzd9rjW6uZ7fGnIQtJbAlh0snzOfq5jvyRK7qVXRgc
	yvvhzc/KGBFn3007KmydcB62ZqFLBWCoywaiOpc/H/9IOMXhKVldCdsyhWc6lt56mTBw
	XCpUh99kc5+HN8f9kc31Nmz2dSv36Ept3QWHSZGKD+uuA6Ya2ClJO6fKv9O0R+BP5kns
	uFAhvVHrEXm+tLUVh8HNlheKWQnyvunP8dZW6eevrzHCttmJTwsp9DnDMWSRvtC64DVi
	UV+sNwOD159M/Opgz5ra74VMxFP2XcaqSLaXifJPJtfw7N6f1IhBUqSt7gWDEkIa15Hz
	t+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9CqEJZQFyLkk/ZYymWcSznPDKfDfQZ0RNP4fPMiLpuM=;
	b=B7KikNsSf35fSD0Bp+o8d51kDFn3P+Atprdyj+oeoR5NQyIIkmYAFaSZdEGZcXs1a5
	ZSczj8nybYR5ylD1S87yS0u+tuBcOak0qwaM5jpIIqE6B9rgXiT3VJRSmwyFN0pNTEVe
	6geaoB2aBZPQf6J7VdogUKgQFkDVtdQCB18BiXh4+uidjvd3kEwele0ZkOtQPDcffO1R
	I/izgSihbPhTLhN/Fmr4i15OumPqdDscXpuPItevg0mBNRsWQMdY2X6+7F6tphVrQh4m
	97GfPBowKDzdpC3U5US4mcW54zrrp+f0/fWh13mCdtf7LDexwxFQvkuMrB3AZoAqS4Gt
	ntzQ==
X-Gm-Message-State: APjAAAV0lvqgkLgWcV09n0rZARjwzcCqrUbItbIdt+v9JmIiBT8ILmHz
	m9DE2zyXeZM0ZbVev5HeNPfMxoJv
X-Google-Smtp-Source: APXvYqyVfepDKIc1aZ0jlVMa1O95805/Cz4zxfjHEebZEKTRRPkq8K3GxRgQ+PHsIbPFhWbjVsw97w==
X-Received: by 2002:adf:dd43:: with SMTP id u3mr4007wrm.313.1558713708144;
	Fri, 24 May 2019 09:01:48 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:47 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:13 +0300
Message-Id: <20190524160118.31134-16-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v11 15/20] gdbstub: Implement step (s pkt) with
 new infra
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
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b35acc679c..a8b81121c5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1794,6 +1794,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1926,13 +1936,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &step_cmd_desc;
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.21.0


