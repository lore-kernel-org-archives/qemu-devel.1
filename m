Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72BC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BF720836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA3TKq51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BF720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEXN-0000Cn-I7
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERF-0006GA-CG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERD-0003BJ-OI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUERC-0003AQ-Vh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id r26so3320129wmh.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=toymzPlUD26kqcownJZwCybn3HKvGbNcV/Ovby7lKh0=;
 b=UA3TKq51jiN8jju3lt/e2s4Tw6+F2WwjGMiFtuhMO0RTiJjAZnbem6Me68cwyCTqfh
 HniZx9+hmOMreg+MXn39JhnjrRurMli32Gy/BENikv8J5ivR8jz3JfjyerdjcUOgHiiL
 B30lv3QW+iN47NgwxUVYI7EJm+aTEducPqkcwSPzJDLO82Fd5N77XWGwkTOCDf0ttNe1
 856KpTmj/beLKNl1/RrxkR5tOTVsW1x7x4rEhcRSLBRPuITTwRdE/q01QlC3bfQXv32E
 Zfcqf0OWxASg/Knl5SFcBXUPrN4Ah2cckAI+IEZ7GIv1BlUIgYq4TlVX2sPb5nPfJ4Br
 xQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=toymzPlUD26kqcownJZwCybn3HKvGbNcV/Ovby7lKh0=;
 b=lUMUGSGB01kGoK0kq2LNkrYBek1ilGa4nqGoIKVFoQj84K89F7vbp8NcIgsa1s9jU1
 XPLojL2SDv1V3ZypbMqzsO5jMPG5o6LorR8jbecD2DAG/v4IWG8v4r9Dj+3mmbKr7HxL
 5iEv+NF9FutSnqcza/38yfnW+eTRJtuUK+osWsnRWr0fshMhRwCLDYY3lbvJrZrgIBWm
 raqbv+MTZOlPWDppvlnTMIOpBL+AfmZLm28xirwbS2VDda6rMGwSe4O9MB+bV/MI/N1z
 FmA4ZF6IrSCyJKsHOCV7cGrYX5SXOHPtDuBMr81ME55xRvP3UyQ0+1YdKyWaOKwfe8z9
 x76g==
X-Gm-Message-State: AGi0PuZ3lIiNiegNdG5fC7E1dqFji+h+foUeFLJl3kqvs9pygdlBNLFF
 u94xI1kS/nhGye3CtV1FKWUXA5dXwtU=
X-Google-Smtp-Source: APiQypLkQQz+FwwblWsH56zRPfNoGuTj1IwjpHCtmhXYfzw55xGvfgGlXOb8ZaNMMHXJ71Uaq1qUsg==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr54303wme.58.1588273293116;
 Thu, 30 Apr 2020 12:01:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l4sm852710wrv.60.2020.04.30.12.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 15D011FF91;
 Thu, 30 Apr 2020 20:01:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/9] gdbstub: eliminate gdbserver_fd global
Date: Thu, 30 Apr 2020 20:01:18 +0100
Message-Id: <20200430190122.4592-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
References: <20200430190122.4592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
v1
  - fix coding style issue
---
 gdbstub.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 171e150950..b5381aa520 100644
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
@@ -3137,13 +3135,13 @@ static int gdbserver_open(int port)
 
 int gdbserver_start(int port)
 {
-    gdbserver_fd = gdbserver_open(port);
-    if (gdbserver_fd < 0)
+    int gdb_fd = gdbserver_open(port);
+    if (gdb_fd < 0) {
         return -1;
+    }
     /* accept connections */
-    if (!gdb_accept()) {
-        close(gdbserver_fd);
-        gdbserver_fd = -1;
+    if (!gdb_accept(gdb_fd)) {
+        close(gdb_fd);
         return -1;
     }
     return 0;
@@ -3152,7 +3150,7 @@ int gdbserver_start(int port)
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


