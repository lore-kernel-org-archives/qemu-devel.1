Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF2C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4ED20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwgH2nwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4ED20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfSE-0004xm-LR
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIx-0001mD-C1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIi-0005Wn-3w
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIh-0005W7-LE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id e26so7201688wmk.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aHegfHPgyPs1Wvs1cpXFErjCleZY/bKPEApSTIkCDYM=;
 b=YwgH2nwJzth0i/Drozrc5MqkxpyyRPV4Dkl4+8SJXjBRqkKPf9ZY/ouUwdBSyafLWF
 AZd9U0rXOBSbD6Ot6ipWFOrGlAbvTmowTHgqxihjVq3RR7tupuR5OMJpZOkPfo/9JNGY
 fd1If3Obd4chH9j4lgfPbbDiCpgn9Sx3khqGYFkH9ixQPndURuIeqY2rW8TfWEgzk0z8
 WpE7L084ANuthoIRfYfFCOO6OzJDpRPPBVCISwNRdeSBE3psNMLAskARPadVCMtfjMCj
 rVYjBDwSS1Gxsq5qCbUjns4QRlFPWoo9CIDLLElyeWgj+vy+Zysy8UkERiGsR79aK6FA
 bS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aHegfHPgyPs1Wvs1cpXFErjCleZY/bKPEApSTIkCDYM=;
 b=Q+JHIuwk51Y6D1u070AfQpEFzEvqE32ZD5Lj8pq+o18BLA/0Q5BVGAohpPvXOAR+Cu
 2pCQ/raGJ9n3OEawdXP34x+i0VKauBP25Xf+/ue9TD0lq9OR2rxZn+QvE/I9rtcb00+c
 JdOyKTxzVtnaDWmulvszUCXo7KiRCtslQ5CWaNIoKWgkGQUsBu/EhQnBdFn40BlKxqI0
 yY6qt0RItG9kcPnkn0dFjMAc0vyXumL6uLRBi4G3UHUlN1BAUlmmSXdGNpC2vrEVvrnh
 41x9gx5yn1H6T86udVIdVL1FaYznRyg1BDkBsB56mBIVIVx3ecj5yRT2siY2KOFICPEZ
 dtCw==
X-Gm-Message-State: AGi0PuZTLffzn2bk7tbuz444toH1HGGakPaR2W+n/ZtQUtNS1krv+pqf
 3pTAEDIveBoc8mN/IyWHdv5d5Q==
X-Google-Smtp-Source: APiQypJRPzq9hOMWR+VvfcgPiShkVK70Eu5TCZBg96nIz2C5imBQYXyNxSeON8jTAx77PrpV7F3HZQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5362749wmb.155.1587661569900; 
 Thu, 23 Apr 2020 10:06:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s18sm4766801wra.94.2020.04.23.10.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 38BB91FF99;
 Thu, 23 Apr 2020 18:05:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/14] gdbstub/linux-user: support debugging over a unix
 socket
Date: Thu, 23 Apr 2020 18:05:53 +0100
Message-Id: <20200423170557.31106-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While debugging over TCP is fairly straightforward now we have test
cases that want to orchestrate via make and currently a parallel build
fails as two processes can't use the same listening port. While system
emulation offers a wide cornucopia of connection methods thanks to the
chardev abstraction we are a little more limited for linux user.
Thankfully the programming API for a TCP socket and a local UNIX
socket is pretty much the same once it's set up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h |  14 ++++--
 bsd-user/main.c        |   8 +--
 gdbstub.c              | 107 ++++++++++++++++++++++++++++++++++-------
 linux-user/main.c      |  12 ++---
 4 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 4a2b8e3089..94d8f83e92 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -177,11 +177,15 @@ static inline uint8_t * gdb_get_reg_ptr(GByteArray *buf, int len)
 
 #endif
 
-#ifdef CONFIG_USER_ONLY
-int gdbserver_start(int);
-#else
-int gdbserver_start(const char *port);
-#endif
+/**
+ * gdbserver_start: start the gdb server
+ * @port_or_device: connection spec for gdb
+ *
+ * For CONFIG_USER this is either a tcp port or a path to a fifo. For
+ * system emulation you can use a full chardev spec for your gdbserver
+ * port.
+ */
+int gdbserver_start(const char *port_or_device);
 
 void gdbserver_cleanup(void);
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index aef5531628..0bfe46cff9 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -738,7 +738,7 @@ int main(int argc, char **argv)
     CPUState *cpu;
     int optind;
     const char *r;
-    int gdbstub_port = 0;
+    const char *gdbstub = NULL;
     char **target_environ, **wrk;
     envlist_t *envlist = NULL;
     char *trace_file = NULL;
@@ -814,7 +814,7 @@ int main(int argc, char **argv)
                 exit(1);
             }
         } else if (!strcmp(r, "g")) {
-            gdbstub_port = atoi(argv[optind++]);
+            gdbstub = g_strdup(argv[optind++]);
         } else if (!strcmp(r, "r")) {
             qemu_uname_release = argv[optind++];
         } else if (!strcmp(r, "cpu")) {
@@ -1124,8 +1124,8 @@ int main(int argc, char **argv)
 #error unsupported target CPU
 #endif
 
-    if (gdbstub_port) {
-        gdbserver_start (gdbstub_port);
+    if (gdbstub) {
+        gdbserver_start(gdbstub);
         gdb_handlesig(cpu, 0);
     }
     cpu_loop(env);
diff --git a/gdbstub.c b/gdbstub.c
index 8c53cc0e1c..51e2ab9110 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -355,6 +355,7 @@ typedef struct GDBState {
     int signal;
 #ifdef CONFIG_USER_ONLY
     int fd;
+    char *socket_path;
     int running_state;
 #else
     CharBackend chr;
@@ -2962,6 +2963,9 @@ void gdb_exit(CPUArchState *env, int code)
       return;
   }
 #ifdef CONFIG_USER_ONLY
+  if (gdbserver_state.socket_path) {
+      unlink(gdbserver_state.socket_path);
+  }
   if (gdbserver_state.fd < 0) {
       return;
   }
@@ -3034,7 +3038,6 @@ gdb_handlesig(CPUState *cpu, int sig)
         n = read(gdbserver_state.fd, buf, 256);
         if (n > 0) {
             int i;
-
             for (i = 0; i < n; i++) {
                 gdb_read_byte(buf[i]);
             }
@@ -3066,7 +3069,66 @@ void gdb_signalled(CPUArchState *env, int sig)
     put_packet(buf);
 }
 
-static bool gdb_accept(int gdb_fd)
+static void gdb_accept_init(int fd)
+{
+    init_gdbserver_state();
+    create_default_process(&gdbserver_state);
+    gdbserver_state.processes[0].attached = true;
+    gdbserver_state.c_cpu = gdb_first_attached_cpu();
+    gdbserver_state.g_cpu = gdbserver_state.c_cpu;
+    gdbserver_state.fd = fd;
+    gdb_has_xml = false;
+}
+
+static bool gdb_accept_socket(int gdb_fd)
+{
+    int fd;
+
+    for(;;) {
+        fd = accept(gdb_fd, NULL, NULL);
+        if (fd < 0 && errno != EINTR) {
+            perror("accept socket");
+            return false;
+        } else if (fd >= 0) {
+            qemu_set_cloexec(fd);
+            break;
+        }
+    }
+
+    gdb_accept_init(fd);
+    return true;
+}
+
+static int gdbserver_open_socket(const char *path)
+{
+    struct sockaddr_un sockaddr;
+    int fd, ret;
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return -1;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path)-1, path);
+    ret = bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
+    if (ret < 0) {
+        perror("bind socket");
+        close(fd);
+        return -1;
+    }
+    ret = listen(fd, 1);
+    if (ret < 0) {
+        perror("listen socket");
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+static bool gdb_accept_tcp(int gdb_fd)
 {
     struct sockaddr_in sockaddr;
     socklen_t len;
@@ -3091,17 +3153,11 @@ static bool gdb_accept(int gdb_fd)
         return false;
     }
 
-    init_gdbserver_state();
-    create_default_process(&gdbserver_state);
-    gdbserver_state.processes[0].attached = true;
-    gdbserver_state.c_cpu = gdb_first_attached_cpu();
-    gdbserver_state.g_cpu = gdbserver_state.c_cpu;
-    gdbserver_state.fd = fd;
-    gdb_has_xml = false;
+    gdb_accept_init(fd);
     return true;
 }
 
-static int gdbserver_open(int port)
+static int gdbserver_open_port(int port)
 {
     struct sockaddr_in sockaddr;
     int fd, ret;
@@ -3130,20 +3186,35 @@ static int gdbserver_open(int port)
         close(fd);
         return -1;
     }
+
     return fd;
 }
 
-int gdbserver_start(int port)
+int gdbserver_start(const char *port_or_path)
 {
-    int gdb_fd = gdbserver_open(port);
-    if (gdb_fd < 0)
-        return -1;
-    /* accept connections */
-    if (!gdb_accept(gdb_fd)) {
-        close(gdb_fd);
+    int port = g_ascii_strtoull(port_or_path, NULL, 10);
+    int gdb_fd;
+
+    if (port > 0) {
+        gdb_fd = gdbserver_open_port(port);
+    } else {
+        gdb_fd = gdbserver_open_socket(port_or_path);
+    }
+
+    if (gdb_fd < 0) {
         return -1;
     }
-    return 0;
+
+    if (port > 0 && gdb_accept_tcp(gdb_fd)) {
+        return 0;
+    } else if (gdb_accept_socket(gdb_fd)) {
+        gdbserver_state.socket_path = g_strdup(port_or_path);
+        return 0;
+    }
+
+    /* gone wrong */
+    close(gdb_fd);
+    return -1;
 }
 
 /* Disable gdb stub for child processes.  */
diff --git a/linux-user/main.c b/linux-user/main.c
index 90ad365b43..3597e99bb1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -52,7 +52,7 @@ char *exec_path;
 
 int singlestep;
 static const char *argv0;
-static int gdbstub_port;
+static const char *gdbstub;
 static envlist_t *envlist;
 static const char *cpu_model;
 static const char *cpu_type;
@@ -311,7 +311,7 @@ static void handle_arg_seed(const char *arg)
 
 static void handle_arg_gdb(const char *arg)
 {
-    gdbstub_port = atoi(arg);
+    gdbstub = g_strdup(arg);
 }
 
 static void handle_arg_uname(const char *arg)
@@ -840,10 +840,10 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
-    if (gdbstub_port) {
-        if (gdbserver_start(gdbstub_port) < 0) {
-            fprintf(stderr, "qemu: could not open gdbserver on port %d\n",
-                    gdbstub_port);
+    if (gdbstub) {
+        if (gdbserver_start(gdbstub) < 0) {
+            fprintf(stderr, "qemu: could not open gdbserver on %s\n",
+                    gdbstub);
             exit(EXIT_FAILURE);
         }
         gdb_handlesig(cpu, 0);
-- 
2.20.1


