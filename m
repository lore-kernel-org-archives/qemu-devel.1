Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C03FC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385EC2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX4rYQkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385EC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfUJ-0001tg-9G
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ6-0007BH-Ja
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ4-0002i5-Dy
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQ4-0002dp-3f
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id r10so11851227wrx.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b3lRu2lU9dlRQQ6ScHgKfSG/1eYQg9vd77Swnr8j6IA=;
 b=VX4rYQkbDLJQAzgEhNQU4zCu21NMgPbg7GNdfh8AFd2iMQ7uL2Dm4WX8I2pe1QjjJh
 tPAmG92LF77wtSOpKpoGYSsGDoxLMjgzuYYRldGRcqkFEXgaS4Ib14FegxGT7Kqs2GvZ
 W9pzhAUQIhdeNggKOJwB89oZWa2EhxvNnXvzcth41eUdyzGRCM55dnf9arTuvIjRV5dr
 8HM7WXNFPNt3EG8mvQAgx+xx4BsEwN3MpiBDFRcNO9Xw1RmZpNWxHznZysUUGHP/lH5u
 +tWVKyCCXN8UYL2hTXp49ZI3ns6D/7wfNXb9EQgOg3LYglI9CfD+BCoeo1VSBSdiQgGp
 9Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b3lRu2lU9dlRQQ6ScHgKfSG/1eYQg9vd77Swnr8j6IA=;
 b=gezzMJAUvAeV2aUQfynr7GeDo59wU3eRpQkaJESZ2o+NJkRObMhwV+fheNQ/pAkq5v
 zH/b3tm7PR8QtIweX81PWDHaIrvsYTKRNgfFLgM6WgzUXlOTx5bieifJnDmwR5OBrCbD
 2UKBoCqRVjcfH8VmbRqVDQsRxUZQlN4Nc3OkRmdGeu6Prco7k9LZUEO2G47hDmkGN9ra
 6GpO9qKtKASRwaHuQnHAtbMzBlv3iGUy5gfhfbvqyLmjmtNVVNAdvoY7scFWUvB9sjI1
 2bfgw8I66e8Re+gh8SfwKtkN4/gY0Oe3NLszTP1PBT1etnOeXPuydcBQI6NpfM86VeAz
 ovBw==
X-Gm-Message-State: APjAAAVrSWhan58BnsL83IlDz/wjK8PHkRSQropfy4NOnv5hx9BIRNyU
 HmY1MXBDMON307a6EqY2Eo7uNA==
X-Google-Smtp-Source: APXvYqwUsBlWQVxnzTlbrH0mbq88zgEd3ethII/j4ofEb0yRBPFkKrFFgjt9vQwQCq1pX4PYANul8Q==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr15846457wrq.352.1573839002363; 
 Fri, 15 Nov 2019 09:30:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm12248423wro.84.2019.11.15.09.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC5201FF8C;
 Fri, 15 Nov 2019 17:30:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  01/11] gdbstub: move allocation of GDBState to one place
Date: Fri, 15 Nov 2019 17:29:50 +0000
Message-Id: <20191115173000.21891-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use g_new0() as it is the preferred form for such allocations. We
can also ensure that gdbserver_state is reset in one place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 4cf8af365e2..c5b6701825f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -374,6 +374,13 @@ static int sstep_flags = SSTEP_ENABLE|SSTEP_NOIRQ|SSTEP_NOTIMER;
 
 static GDBState *gdbserver_state;
 
+static GDBState *gdb_allocate_state(void)
+{
+    g_assert(!gdbserver_state);
+    gdbserver_state = g_new0(GDBState, 1);
+    return gdbserver_state;
+}
+
 bool gdb_has_xml;
 
 #ifdef CONFIG_USER_ONLY
@@ -3083,15 +3090,13 @@ static bool gdb_accept(void)
         return false;
     }
 
-    s = g_malloc0(sizeof(GDBState));
+    s = gdb_allocate_state();
     create_default_process(s);
     s->processes[0].attached = true;
     s->c_cpu = gdb_first_attached_cpu(s);
     s->g_cpu = s->c_cpu;
     s->fd = fd;
     gdb_has_xml = false;
-
-    gdbserver_state = s;
     return true;
 }
 
@@ -3359,8 +3364,7 @@ int gdbserver_start(const char *device)
 
     s = gdbserver_state;
     if (!s) {
-        s = g_malloc0(sizeof(GDBState));
-        gdbserver_state = s;
+        s = gdb_allocate_state();
 
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
-- 
2.20.1


