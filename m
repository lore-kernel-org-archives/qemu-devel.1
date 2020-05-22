Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BF4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474A02072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yswuQWAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxYN-00087X-Fo
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWJ-00023l-7I
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:47 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWI-00055p-Ai
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:46 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ci23so4339821pjb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JQCGgvllP6/zU7ZDrHyu78GSFItc7dHunrM7u5X5NHY=;
 b=yswuQWAAOUpgZQ0p7M/vW8p9+vw1X2m4G5mfZdbfIurqVXZVw/ExYxvIWUwzmJN9X+
 34MJ6pLbTHePAfwHF8k1AuxfhY3D40HMcmVQfvCtotGimQPVqSUt80ueC61UHhXCyjPI
 h7uSddUVRDaYL2fWEthR6jWKNJTuLJ+HmnXJRw2+2l2+zGIued+XsjzpY9aBXRyM27KQ
 eRNOg+Z00DlV7x6IWIxJ1uF/k5dB1t3QAG0SBnkN0J1wUQO05Iah5Y/F0iucqmnHFsEc
 XZSs+nyvQFqPI9I+zeP8AIsNEIa8OdqmfrDMUmY7PzZOXCv7zsUi+vIlDVkqRT5OeLR+
 PqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JQCGgvllP6/zU7ZDrHyu78GSFItc7dHunrM7u5X5NHY=;
 b=SgaVYDm9LO7Ztg7P5ye7V3DGeiLCm0eCDfz0xcGdVrj3xuhsj6U8B+EtWTnW+2Zbp9
 QArJWrz/pVIXPFVHDVOV8JyHkckiG08QvVAV0arq4gDP4K7HgaCaH/y25KF5kNn5U9b+
 RSEYB4ICgI1S1w05eRjpneMDrwj85RNR1fIKN+943yelUsGxNlw/aDkCz3Mc8yg/rdkp
 KbIve9MYF+rKM4hZiGv+dRQ0QOmT8JCQ0RDbv3IkSyORwEb5lflUXvCzebugAGuVepmu
 7wzSJ4nwUXj5/tYuLtwVxJ4R+GTEfJr2miqM6ZwKBtxrgTVSdCozi5/V98l1tPm4+6np
 VV6w==
X-Gm-Message-State: AOAM531Xbhcv9Q9+WJP1jzuGz1Ie4UQMkCZgPEupZ9ka7Hdr6Owpxbv7
 tzn3NWh2tudHbmCfox0BXywgNjEq/JE=
X-Google-Smtp-Source: ABdhPJwWKVMo7qPX8GJbRE7skc8D8TBvSSKSdUpqPAjmFcvn0U6tnlqhcCUcShusAytfo0bb++0/ew==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr11442611pla.99.1590114884611; 
 Thu, 21 May 2020 19:34:44 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/25] Unify master_fd and apprentice_fd to comm_fd
Date: Thu, 21 May 2020 19:34:17 -0700
Message-Id: <20200522023440.26261-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any one invocation cannot be both master and apprentice.
Let's use only one variable for the file descriptor.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/risu.c b/risu.c
index 79b1092..059348f 100644
--- a/risu.c
+++ b/risu.c
@@ -30,7 +30,7 @@
 
 void *memblock;
 
-int apprentice_fd, master_fd;
+static int comm_fd;
 bool trace;
 size_t signal_count;
 
@@ -50,7 +50,7 @@ sigjmp_buf jmpbuf;
 
 int read_sock(void *ptr, size_t bytes)
 {
-    return recv_data_pkt(master_fd, ptr, bytes);
+    return recv_data_pkt(comm_fd, ptr, bytes);
 }
 
 int write_trace(void *ptr, size_t bytes)
@@ -58,9 +58,9 @@ int write_trace(void *ptr, size_t bytes)
     size_t res;
 
 #ifdef HAVE_ZLIB
-    if (master_fd == STDOUT_FILENO) {
+    if (comm_fd == STDOUT_FILENO) {
 #endif
-        res = write(master_fd, ptr, bytes);
+        res = write(comm_fd, ptr, bytes);
 #ifdef HAVE_ZLIB
     } else {
         res = gzwrite(gz_trace_file, ptr, bytes);
@@ -71,14 +71,14 @@ int write_trace(void *ptr, size_t bytes)
 
 void respond_sock(int r)
 {
-    send_response_byte(master_fd, r);
+    send_response_byte(comm_fd, r);
 }
 
 /* Apprentice function */
 
 int write_sock(void *ptr, size_t bytes)
 {
-    return send_data_pkt(apprentice_fd, ptr, bytes);
+    return send_data_pkt(comm_fd, ptr, bytes);
 }
 
 int read_trace(void *ptr, size_t bytes)
@@ -86,9 +86,9 @@ int read_trace(void *ptr, size_t bytes)
     size_t res;
 
 #ifdef HAVE_ZLIB
-    if (apprentice_fd == STDIN_FILENO) {
+    if (comm_fd == STDIN_FILENO) {
 #endif
-        res = read(apprentice_fd, ptr, bytes);
+        res = read(comm_fd, ptr, bytes);
 #ifdef HAVE_ZLIB
     } else {
         res = gzread(gz_trace_file, ptr, bytes);
@@ -218,11 +218,11 @@ int master(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
 #ifdef HAVE_ZLIB
-        if (trace && master_fd != STDOUT_FILENO) {
+        if (trace && comm_fd != STDOUT_FILENO) {
             gzclose(gz_trace_file);
         }
 #endif
-        close(master_fd);
+        close(comm_fd);
         if (trace) {
             fprintf(stderr, "trace complete after %zd checkpoints\n",
                     signal_count);
@@ -244,11 +244,11 @@ int apprentice(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
 #ifdef HAVE_ZLIB
-        if (trace && apprentice_fd != STDIN_FILENO) {
+        if (trace && comm_fd != STDIN_FILENO) {
             gzclose(gz_trace_file);
         }
 #endif
-        close(apprentice_fd);
+        close(comm_fd);
         fprintf(stderr, "finished early after %zd checkpoints\n", signal_count);
         return report_match_status(true);
     }
@@ -375,31 +375,31 @@ int main(int argc, char **argv)
     if (ismaster) {
         if (trace) {
             if (strcmp(trace_fn, "-") == 0) {
-                master_fd = STDOUT_FILENO;
+                comm_fd = STDOUT_FILENO;
             } else {
-                master_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
+                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
 #ifdef HAVE_ZLIB
-                gz_trace_file = gzdopen(master_fd, "wb9");
+                gz_trace_file = gzdopen(comm_fd, "wb9");
 #endif
             }
         } else {
             fprintf(stderr, "master port %d\n", port);
-            master_fd = master_connect(port);
+            comm_fd = master_connect(port);
         }
         return master();
     } else {
         if (trace) {
             if (strcmp(trace_fn, "-") == 0) {
-                apprentice_fd = STDIN_FILENO;
+                comm_fd = STDIN_FILENO;
             } else {
-                apprentice_fd = open(trace_fn, O_RDONLY);
+                comm_fd = open(trace_fn, O_RDONLY);
 #ifdef HAVE_ZLIB
-                gz_trace_file = gzdopen(apprentice_fd, "rb");
+                gz_trace_file = gzdopen(comm_fd, "rb");
 #endif
             }
         } else {
             fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
-            apprentice_fd = apprentice_connect(hostname, port);
+            comm_fd = apprentice_connect(hostname, port);
         }
         return apprentice();
     }
-- 
2.20.1


