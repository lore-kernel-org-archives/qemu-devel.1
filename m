Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B3C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8542467B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WboE51Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8542467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Hx-0001bK-QF
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j058I-0000rP-Ai
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j058H-0003yi-4G
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:26 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j058G-0003us-T9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so3064128wrh.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NuT51ChIEQ4Kna0auqW3OS2c6axOB9q/YF3f1QpycFw=;
 b=WboE51SfCbCsN9Z4ZbYGqNSOhCeN32zDKYJ4nQEYHWwgsyeaIWcoZ0BpqncKpZy1Td
 XfE5NPZR9lszSRZ2gtpv8q2lzbV8bVDHKLunBSSaVpJyjl/AS4xBSZotrNNgLAHJ/Z9P
 qWQjilgeTpkXuswEN4LP348xFDlFPcr25CzLSARth60+x/CaHnf/DRYfuy2XpfVSgAXP
 CG4SJnxmw2M0wZs0SuH2bPDhOknMArsFL7baSMOQS4tWzdHye51y0vm0zu76DHiG0B3x
 9mfHKAF9nkInFyD0DoXtfbsuELFBaweHc7rRC12H3mdT8Bs6H741h/ZQA9AVkijpREUl
 7ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NuT51ChIEQ4Kna0auqW3OS2c6axOB9q/YF3f1QpycFw=;
 b=E2fASua470+wEUVWBd7VwUgc4R0Vv/MwiavhWnC10VU0Fki74h1G6omH/lQaAAa7Sp
 5Vl0d0qy7u0u/ScfT7vxd1pZgb0333RYBa74hBTx3jvkBYikO84xJxYdVCdfovcnsOhK
 WKOs3IMDbsAnaWwoDrR7xxGmcavifz1FBeXX7YFqDw2kSnwo9SL51BMoXYW4ADeslfEI
 MAhzDhCp4vBhOtyKTEGnTCFBXNB2RgxHaDZAWTukc09tRdwkrjvda3MQajMNrUUQPeam
 sz6P14xNBVa+WI3rwDn+7QSgvf+nvswCPSnrTAfH0GKfd+cvcC1Siuep3mG8WucRP1Rn
 jkPw==
X-Gm-Message-State: APjAAAXOC7WRB3yqdG03qLv0cztkb6j4wouBvtLZ5mf2RTL2pNkVWg7A
 6LyujzG3gebUrkB0ApI14YHN/9rwgvc=
X-Google-Smtp-Source: APXvYqwP7OaromFXTovkUlQMuqqkoDM7lBwG4jooBu9FcYwRa2tRN3v7UcrQ5UQrq2TaJaAEKaJI6g==
X-Received: by 2002:adf:b193:: with SMTP id q19mr5099864wra.78.1581087683942; 
 Fri, 07 Feb 2020 07:01:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm3706967wrt.90.2020.02.07.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:01:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F7EA1FF90;
 Fri,  7 Feb 2020 15:01:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/5] tests/plugin: prevent uninitialized warning
Date: Fri,  7 Feb 2020 15:01:16 +0000
Message-Id: <20200207150118.23007-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207150118.23007-1-alex.bennee@linaro.org>
References: <20200207150118.23007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 Euler Robot <euler.robot@huawei.com>, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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


