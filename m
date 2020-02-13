Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CC6C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E67720675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGy8wIBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E67720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NW1-0005yi-En
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKT-00052q-9j
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKR-00042G-8o
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKQ-0003zK-W2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so8049030wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PR3MIDvz3PtDDaollGFXmkX1Ue3lMr6ulNQeQQNdSxU=;
 b=HGy8wIBTjh4t+t0UcTdaF4nKqSFidG8Nzy8TP43VSwJ7xA3QuJwKqzhfg0tOlb+td1
 RhzwZ+hVAHoz7hV2mntzn4VR5vk6q7NLN72XjpUbrmx1sEkQ5Hx8NhHc/VaL5fmMI76i
 FZMlLlSSdCeM4WTi26riXAe5p7rYxa+Gx4LLFOO9XJv+3bCnXbNbwakjLDpoMilcTSkM
 0cxA3f3QnQFq/l8QJmaxls/yeHRS0miiJpLDfzU2PHdDawb8K27y+16taT0X2w8I6wbT
 XWMLXBFXI6GEiAHDNiJrak3o84kR7ZRhTUR2PsnKfFsB/b+FT6KW2W3AnKOq6baH1DjD
 mmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PR3MIDvz3PtDDaollGFXmkX1Ue3lMr6ulNQeQQNdSxU=;
 b=tK6uE3UhUbF9W2FALvPHoa2RXxQ+fRe/uYzYFgJ4JnuPD0uXCBKdVC1ju2McSBdBdB
 EhBrzwz0SvZk2IzIU7AaNlIOCRJp0hjzllynDah7Gx/N8G48oD3J4LYSPkOoZ7M+1Z07
 o/y5uHEnO8Lc3e/Be9u/+DVlVC1vbXejcDdOeFq5rZk8ISpwsvi0PKb/WIpRKgrb2IIg
 4HNZ1N8YayFSovLpLqold34oGvRm4n07ArajkTz7RPqvQSdrp7hsbycJtsSWqqUoNHkB
 WAkIn0VWp/PcZBHVg3eCU2CJLxvpyDTYNfQo32KByWEZPqgpE2NCsS8Wmb/l/5Uui0L9
 u2bA==
X-Gm-Message-State: APjAAAWgj05n401qn5YURZMXI5UZalw69gKAFgNBRI0Ki6TVurRMnPjm
 w8zIkmcMoM4lTO79qqUtkCEj1Q==
X-Google-Smtp-Source: APXvYqxTgiN1o3Q+dQ0mTQfcNpsXh9e+wirhn5EeQL4LcPZiT8+4V4WR27RCBlqDCv3vYRViWcqJ7g==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr276099wmg.143.1581634285619;
 Thu, 13 Feb 2020 14:51:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w15sm4698048wrs.80.2020.02.13.14.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AAAE51FF9C;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/19] tests/plugin: prevent uninitialized warning
Date: Thu, 13 Feb 2020 22:51:02 +0000
Message-Id: <20200213225109.13120-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
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


