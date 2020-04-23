Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B775C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F5F2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QU4/DDBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F5F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfNk-0004qh-CZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIj-000195-DY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIi-0005XA-Rp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIi-0005WV-EH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id k13so7709927wrw.7
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qwQ9PGD8JYBaJEUwYaNKOztNdvsthQ8POu4+c0qzYlM=;
 b=QU4/DDBSsFHMgP0XBi0ERXtnhHWII6sSAxKElJofcsbfkldNqoRioyReTPu9GXoVRF
 lxSiTqiOET55aXB3x2dlMiWdJAN2XisqNZ5Y2QjBkUqoyx4Ur4o6GwkcpxaOYpmLT9KW
 A0M9NhL3KHLplBsyr4jcZAy8tV5509u7FsjsxCFJrPp06b7FZ7pwaH1nbLnnksgf1L+b
 4umwNrqjWJZmsFmbTzTKUvSLVtR7ROAh/m4qRg5juyjg/BUkXz7GxEUcFr4a+kFWKPWQ
 w8mDoFTt2M98vJXMCy/rgtLF6uaVqfMGTc0YmnMsusN1AxGfVNxsuVb7+RLK66jYZDYe
 mh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qwQ9PGD8JYBaJEUwYaNKOztNdvsthQ8POu4+c0qzYlM=;
 b=dRCBlFZ5n7jIUQZB+RpLK9s7uo2DO4/219wTQSd4U6TO0dha0JSsClXVZ1+E3Jjz4U
 TqloMhpAvvCfvIGy+XYHoax4AtIX6M4nNmi5/jhpG68/22bAO7eFpF3QTWiri3569B1A
 4oDBPm6n4adE7pxuIlYRjqcmu19MPAMG9s9TRGPk4qYDoBgy2O+DRaM4qabHBdzQsDJn
 Y3KB25bpgtIFMUKYiHivBI/8ALaCe7jXx0sQcFD2OIs/TiNjRqbXWvXvQPryJuhMJJW8
 HMNAggpgy7//6ReoousTZ+jG8cnuZRpAMbSFfx75fxo2TgLaGCPwaD+bM8S3EV1ruHXJ
 NQng==
X-Gm-Message-State: AGi0PuZIMnGhT7EOKkNEYhTFvUMg6WPW7D+dyog9+glgLE1vRTQ3o38f
 XtA0fJJzhnyEAOWeRR67BEjFbQ==
X-Google-Smtp-Source: APiQypL+Xkaku2guS8f4MxPeMaFTSg6ctpSkvi0yc1kZzv3BrUDOLwDOKwND9pDbSRyn5LRFCwkD2A==
X-Received: by 2002:adf:afdf:: with SMTP id y31mr5939803wrd.120.1587661570778; 
 Thu, 23 Apr 2020 10:06:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o28sm4531899wra.84.2020.04.23.10.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B8A51FF98;
 Thu, 23 Apr 2020 18:05:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/14] gdbstub: eliminate gdbserver_fd global
Date: Thu, 23 Apr 2020 18:05:52 +0100
Message-Id: <20200423170557.31106-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't really need to track this fd beyond the initial creation of
the socket. We already know if the system has been initialised by
virtue of the gdbserver_state so lets remove it. This makes the later
re-factoring easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 171e150950..8c53cc0e1c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -398,8 +398,6 @@ static void reset_gdbserver_state(void)
 bool gdb_has_xml;
 
 #ifdef CONFIG_USER_ONLY
-/* XXX: This is not thread safe.  Do we care?  */
-static int gdbserver_fd = -1;
 
 static int get_char(void)
 {
@@ -2964,7 +2962,7 @@ void gdb_exit(CPUArchState *env, int code)
       return;
   }
 #ifdef CONFIG_USER_ONLY
-  if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+  if (gdbserver_state.fd < 0) {
       return;
   }
 #endif
@@ -3011,7 +3009,7 @@ gdb_handlesig(CPUState *cpu, int sig)
     char buf[256];
     int n;
 
-    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
         return sig;
     }
 
@@ -3060,7 +3058,7 @@ void gdb_signalled(CPUArchState *env, int sig)
 {
     char buf[4];
 
-    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
         return;
     }
 
@@ -3068,7 +3066,7 @@ void gdb_signalled(CPUArchState *env, int sig)
     put_packet(buf);
 }
 
-static bool gdb_accept(void)
+static bool gdb_accept(int gdb_fd)
 {
     struct sockaddr_in sockaddr;
     socklen_t len;
@@ -3076,7 +3074,7 @@ static bool gdb_accept(void)
 
     for(;;) {
         len = sizeof(sockaddr);
-        fd = accept(gdbserver_fd, (struct sockaddr *)&sockaddr, &len);
+        fd = accept(gdb_fd, (struct sockaddr *)&sockaddr, &len);
         if (fd < 0 && errno != EINTR) {
             perror("accept");
             return false;
@@ -3137,13 +3135,12 @@ static int gdbserver_open(int port)
 
 int gdbserver_start(int port)
 {
-    gdbserver_fd = gdbserver_open(port);
-    if (gdbserver_fd < 0)
+    int gdb_fd = gdbserver_open(port);
+    if (gdb_fd < 0)
         return -1;
     /* accept connections */
-    if (!gdb_accept()) {
-        close(gdbserver_fd);
-        gdbserver_fd = -1;
+    if (!gdb_accept(gdb_fd)) {
+        close(gdb_fd);
         return -1;
     }
     return 0;
@@ -3152,7 +3149,7 @@ int gdbserver_start(int port)
 /* Disable gdb stub for child processes.  */
 void gdbserver_fork(CPUState *cpu)
 {
-    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
         return;
     }
     close(gdbserver_state.fd);
-- 
2.20.1


