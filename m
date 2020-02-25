Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15EFC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5B121D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGw8Lg/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5B121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZgK-0004H8-Q2
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcZ-0005fR-Qv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcY-0007IE-Lr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcY-0007Ho-F2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so14596305wrt.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PR3MIDvz3PtDDaollGFXmkX1Ue3lMr6ulNQeQQNdSxU=;
 b=pGw8Lg/xVnYtr0lrehL9FkVN/2n4/Ho6Ly0xoHVrpuo6Ee8DMdaUtWxc46FTb6iSGE
 akC3scEjRjW0s0Kezy746JiTmHNAftymMKbX3FUmkCPP867woLwwyF29iksFsB/n5Ygs
 gAlw/Fbvbx99QUzjRbBpY/3/3EIhpSjLKLEUTtiy2kbPtvVlt52YyCD9rvu4TOiuNF5k
 1UG2cbC/xJrGSM9lkuT23xERBK8A8haCSSRLohDJNmLOiAhaxzSoPAXTqS8lJKkDNe9M
 yggpwwqoTR6MqoNYq+cFLwq6p3XeHE0PL2DUGrN269B1KdC1MFXO2go1rZcyjiRdI3FA
 qDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PR3MIDvz3PtDDaollGFXmkX1Ue3lMr6ulNQeQQNdSxU=;
 b=oQ8ZUcmudiXn7HExImOUYFpv1OQQw54QXI/vafxUPfknFAlfEoPH/8JmF4ecbv4NW5
 jfjtCw0uAkKr26QrA1rTsKfv5jG/br5fNe2iHgudIUISb14wDbYzUTiTjVaUSQ5rSal8
 z41C43B4eZWhprjKH+iuxLGHOwFOSCCBZWwOmVxgPVPj1J7BRM7VRWD+dFfju2P/EWpt
 YRsCRmAx9Q8NsRCmc1/vM58b0imMZpPgpiadnT7RAoJIhVce4d46JaLX7eLmMFjYZngk
 oiuDf/JAwCVaEdjtLuA71iCv4jU4oFJ/4kxiJcAIAzxiUU8bgh+iDYc38Cl+D3rUqBwf
 vINQ==
X-Gm-Message-State: APjAAAVLuOvgnI0zv/2mQOv/++nSdNZn5H2QTIcAVsNo5XPWm/q54Oqa
 GY/3OKSojfHHbA2mbrjYobZsEjVnQdU=
X-Google-Smtp-Source: APXvYqxTsLyZjePFmAeRk1az1RrY49/ZVZXDsGSwO3uOWeBdohO77zItX9s3F1smAZfWNPk4Fe3kIQ==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr13478800wro.282.1582634849473; 
 Tue, 25 Feb 2020 04:47:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm23808377wrt.90.2020.02.25.04.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:22 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59D041FF9C;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 12/19] tests/plugin: prevent uninitialized warning
Date: Tue, 25 Feb 2020 12:47:03 +0000
Message-Id: <20200225124710.14152-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 robert.foley@linaro.org, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Euler Robot <euler.robot@huawei.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

According to the glibc function requirements, we need initialise
 the variable. Otherwise there will be compilation warnings:

glib-autocleanups.h:28:3: warning: ‘out’ may be
used uninitialized in this function [-Wmaybe-uninitialized]
   g_free (*pp);
   ^~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
[AJB: uses Thomas's single line allocation]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/plugin/bb.c   | 6 +++---
 tests/plugin/insn.c | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index f30bea08dcc..df19fd359df 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -22,9 +22,9 @@ static bool do_inline;
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    g_autofree gchar *out;
-    out = g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                          bb_count, insn_count);
+    g_autofree gchar *out = g_strdup_printf(
+        "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+        bb_count, insn_count);
     qemu_plugin_outs(out);
 }
 
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 0a8f5a0000e..a9a6e412373 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -44,8 +44,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    g_autofree gchar *out;
-    out = g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
+    g_autofree gchar *out = g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
     qemu_plugin_outs(out);
 }
 
-- 
2.20.1


