Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3562AC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0627E2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2s8fQP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0627E2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnRt-0004HW-54
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hbmf1-0003TX-Iv
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hbmf0-00080a-H3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:31 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:44773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hbmf0-00080P-Cr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:30 -0400
Received: by mail-qt1-x841.google.com with SMTP id x47so2487206qtk.11
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xaXpncAfIlNPzwxbXg13UxwI8EcQoz2212flgvquBy4=;
 b=U2s8fQP+ylC+Yyy2Py9pWH7gb9fvnxVSWa0nLxKFa8pBTny91pE53gRQb8yYGyP+T9
 ZrZbJzym+reWlh2/9lFXfFNK2cvGa1rJcdRDh3DHeOiBaGnKWucqdRbvY0Pts5Slyieq
 F8X6R16oW1dpd/Pd+zZwiW4+nQyV1+w23mBfeMWeLufr2wgOmqG729jE5C0ICgNvoJwB
 Vzy+VuM3JcqJ2aZmYo4QKenRSU8u7pTP7cY6kXBJBp4jScx/Uyv0UokBgYxH4Ijo1Bdc
 fHg2PccPhbv+COUMBqr4IhDwopRdrKkbTNLYJa6/ukzCTdNcFVU10aRgPBfdiYL1J4q7
 A5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xaXpncAfIlNPzwxbXg13UxwI8EcQoz2212flgvquBy4=;
 b=GZ2xjsgIJZasCYjJR0N0zIRt+ulEYX2Tey8RyaTLp2WpIGnDM1sIYwzhScTQu5dufi
 Uh7Qq9019Sms4OqbWnIYY8P4ShLkV+L/H7BHDA0SJtqAuaF4A62Vv782zQ8lNcZglRh7
 O3AG9q909CFH6W5mCXA5evCdPm1ER2rFgLYsngSW/nPqBVXFNy7IizBUYsFQJliPjzZj
 y0Bjb01djveKYMwHomHTvTq8r6HHeVGj20CW/F6iiPmQ9G59P/j5FQhGIhvmXlcmZabC
 Z7yDbRIhlAMWJDPmrq2vELQFcfYAOQblc4bFmoP86VY14ehfrIWq5B/HpEdYz4VAWV2W
 O1nA==
X-Gm-Message-State: APjAAAVJPPp4qnbYuhJdYWDzidppXnvjSzB5vQcHzju7QPQ8eBB8uGPD
 ScvVJ57NYmVictE+QjSbF3x5ZQaRfAE=
X-Google-Smtp-Source: APXvYqxKGmFIPPcxRHY8ql4h8QE/EjSCVoKoJhTVZxoAdUawwQr8yJPa7wvrCxFXyzBvYahHzY0wug==
X-Received: by 2002:ac8:384c:: with SMTP id r12mr31198945qtb.153.1560520469656; 
 Fri, 14 Jun 2019 06:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548c:f96b:4e5b:86ef:e7bc:c1a0])
 by smtp.googlemail.com with ESMTPSA id 77sm1747150qkd.59.2019.06.14.06.54.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 06:54:29 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 10:53:31 -0300
Message-Id: <20190614135332.12777-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190614135332.12777-1-vandersonmr2@gmail.com>
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [Qemu-Devel][PATCH 3/3] Adding command line option to
 linux-user.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, vandersonmr <vandersonmr2@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added -execfreq to enable execution frequency counting and dump
all the TB's addresses and their execution frequency at the end
of the execution.

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 linux-user/exit.c | 5 +++++
 linux-user/main.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda720553..0c6a2f2d5b 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -26,8 +26,13 @@
 extern void __gcov_dump(void);
 #endif
 
+extern bool enable_freq_count;
+
 void preexit_cleanup(CPUArchState *env, int code)
 {
+    if (enable_freq_count) {
+        tb_dump_all_exec_freq();
+    }
 #ifdef TARGET_GPROF
         _mcleanup();
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 1bf7155670..ece2d8bd8b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -388,6 +388,11 @@ static void handle_arg_trace(const char *arg)
     trace_file = trace_opt_parse(arg);
 }
 
+static void handle_arg_execfreq(const char *arg)
+{
+    enable_freq_count = true;
+}
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -439,6 +444,8 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+    {"execfreq",   "QEMU_EXEC_FREQ",   false,  handle_arg_execfreq,
+     "",           "enable and dump TB's execution frequency counting"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
-- 
2.22.0


