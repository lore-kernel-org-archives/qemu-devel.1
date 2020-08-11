Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F464C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1AF20774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGpkjbK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1AF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OVT-0002B4-BJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3S0QyXwMKCpwO8SCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--scw.bounces.google.com>)
 id 1k5OQF-00053E-H0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:12 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:36932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3S0QyXwMKCpwO8SCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--scw.bounces.google.com>)
 id 1k5OQC-0000lO-Jr
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:11 -0400
Received: by mail-pg1-x549.google.com with SMTP id x3so2809984pga.4
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=fVISdSL7SAJXIAhsvIFI0k3nRGfVddtDxh8lna7beHE=;
 b=JGpkjbK6mQEmWi0MfJvr22Rep72csiZp1ei1jhprBf4ADIdIq7X6CgTTsO9WXYMNg1
 8JRUuboKXkBk5WrFXcx/H2gYM6PlHBGd9eBrott7aLdrxc2f1kGz0Q07pXahk1APyhJy
 nfI6pF8l74FXUswGs7YVFHjXZGNqQ0rowwMa55LFRWZkiWdsh2h6Z0yqFyjZ1P5qhW6x
 rGhWFthkFumiVT2CoAY/iRIOJyL1fu3ojONRq59cUE82uN7cbMBHcGt3kKpt+JWV/UNg
 aGXgydYveTJPV8kafSGhDc16OriJa25/rOPJFsQVyGE3CpFPERvejfPomZnkD2p3BAMt
 Z0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=fVISdSL7SAJXIAhsvIFI0k3nRGfVddtDxh8lna7beHE=;
 b=lIa3aJdFysZIbxvmgWeJPzZ1SQY7RYAsgB0q+/IjfjYzZN+AoK/P5rd5frYFWT6bs+
 yrljIvMdz774Np7dS0fBCtBYoYD2NVTfXJDYWeDrtWoZQ9ZrmelHLkULnAgEZtUdSEpD
 AX04NzD8pJtPQ7Tly7c1Putce5QyMxe/al+1HiTpiNE77i65u7fJf+v6hHcEL5ufSjov
 WnPtTg9U4jeDh/KMRAzEZ62qpmWJ8s9nBNf4e2lu2/Qu50Uo6zrdpyzMCmyR539oruLm
 6L+vTY9+Y3+3fjPRAxxSgawZwAAODV+f0jOFVtkbSU7R1ioZvisyeMug0ft+qZJkFsVF
 PQmA==
X-Gm-Message-State: AOAM531zBs7VL9+dY2UtELKWwfi+HSorifmaoAwkAd5XGGPuxI5j0kJb
 +jARaXfoCLOsCLal0qf1sChGobnLjRnC4ZllvcJfo5R2YRihP4afKW2LOu9zeLtiZJaNMF/5c56
 /x9mmlCG3xAraPAwupo/psG7u/0JcBoCsj16MBiD+peXxOug4PMVg
X-Google-Smtp-Source: ABdhPJx/NtwZ1UMPr7MkwTrX/HHBUcm2gkeANgpp3t9Jg0pnU/oEiexadAYN8Sfy8TdNWzaIPGnclvE=
X-Received: by 2002:a17:90a:9b88:: with SMTP id
 g8mr3275892pjp.143.1597129803232; 
 Tue, 11 Aug 2020 00:10:03 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:45 -0700
In-Reply-To: <cover.1597129029.git.scw@google.com>
Message-Id: <611db81c87911cb38a35e5f761e11b76e1f0d538.1597129029.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 5/8] linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3S0QyXwMKCpwO8SCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--scw.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both guest options map to host SO_TIMESTAMP while keeping a global bit to
remember if the guest expects the old or the new format. Don't support
programs mixing two formats.

Added a multiarch test to verify.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v1 -> v2:
  Only keep track of old or new format globally, remove support for different
  sockets mixing different formats.
  Fix style problems.

 linux-user/alpha/sockbits.h            |   8 +-
 linux-user/generic/sockbits.h          |   9 +-
 linux-user/hppa/sockbits.h             |   8 +-
 linux-user/mips/sockbits.h             |   8 +-
 linux-user/sparc/sockbits.h            |   8 +-
 linux-user/strace.c                    |   7 +-
 linux-user/syscall.c                   |  91 ++++++--
 tests/tcg/multiarch/socket_timestamp.c | 296 +++++++++++++++++++++++++
 8 files changed, 408 insertions(+), 27 deletions(-)
 create mode 100644 tests/tcg/multiarch/socket_timestamp.c

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index d54dc98c09..40f0644df0 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -48,8 +48,6 @@
 #define TARGET_SO_DETACH_FILTER        27
 
 #define TARGET_SO_PEERNAME      28
-#define TARGET_SO_TIMESTAMP     29
-#define TARGET_SCM_TIMESTAMP        TARGET_SO_TIMESTAMP
 
 #define TARGET_SO_PEERSEC       30
 #define TARGET_SO_PASSSEC       34
@@ -75,6 +73,12 @@
 /* Instruct lower device to use last 4-bytes of skb data as FCS */
 #define TARGET_SO_NOFCS     43
 
+#define TARGET_SO_TIMESTAMP_OLD        29
+#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index e44733c601..532cf2d3dc 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -49,10 +49,15 @@
 #define TARGET_SO_DETACH_FILTER        27
 
 #define TARGET_SO_PEERNAME             28
-#define TARGET_SO_TIMESTAMP            29
-#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
 
 #define TARGET_SO_ACCEPTCONN           30
 
 #define TARGET_SO_PEERSEC              31
+
+#define TARGET_SO_TIMESTAMP_OLD        29
+#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+
 #endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 23f69a3293..284a47e74e 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -29,8 +29,6 @@
 #define TARGET_SO_BSDCOMPAT    0x400e
 #define TARGET_SO_PASSCRED     0x4010
 #define TARGET_SO_PEERCRED     0x4011
-#define TARGET_SO_TIMESTAMP    0x4012
-#define TARGET_SCM_TIMESTAMP   TARGET_SO_TIMESTAMP
 #define TARGET_SO_TIMESTAMPNS  0x4013
 #define TARGET_SCM_TIMESTAMPNS TARGET_SO_TIMESTAMPNS
 
@@ -67,6 +65,12 @@
 
 #define TARGET_SO_CNX_ADVICE           0x402E
 
+#define TARGET_SO_TIMESTAMP_OLD        0x4012
+#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+
+#define TARGET_SO_TIMESTAMP_NEW        0x4038
+#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 0f022cd598..b4c39d9588 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -61,14 +61,18 @@
 #define TARGET_SO_DETACH_FILTER        27
 
 #define TARGET_SO_PEERNAME             28
-#define TARGET_SO_TIMESTAMP            29
-#define SCM_TIMESTAMP          SO_TIMESTAMP
 
 #define TARGET_SO_PEERSEC              30
 #define TARGET_SO_SNDBUFFORCE          31
 #define TARGET_SO_RCVBUFFORCE          33
 #define TARGET_SO_PASSSEC              34
 
+#define TARGET_SO_TIMESTAMP_OLD        29
+#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+
 /** sock_type - Socket types
  *
  * Please notice that for binary compat reasons MIPS has to
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 0a822e3e1f..07440efd14 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -48,8 +48,6 @@
 #define TARGET_SO_GET_FILTER           TARGET_SO_ATTACH_FILTER
 
 #define TARGET_SO_PEERNAME             0x001c
-#define TARGET_SO_TIMESTAMP            0x001d
-#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
 
 #define TARGET_SO_PEERSEC              0x001e
 #define TARGET_SO_PASSSEC              0x001f
@@ -104,6 +102,12 @@
 
 #define TARGET_SO_ZEROCOPY             0x003e
 
+#define TARGET_SO_TIMESTAMP_OLD        0x001d
+#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+
+#define TARGET_SO_TIMESTAMP_NEW        0x0046
+#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define TARGET_SO_SECURITY_AUTHENTICATION              0x5001
 #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x5002
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 089fb3968e..a11a5e9e86 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2257,8 +2257,11 @@ print_optint:
         case TARGET_SO_PASSCRED:
             qemu_log("SO_PASSCRED,");
             goto print_optint;
-        case TARGET_SO_TIMESTAMP:
-            qemu_log("SO_TIMESTAMP,");
+        case TARGET_SO_TIMESTAMP_OLD:
+            qemu_log("SO_TIMESTAMP_OLD,");
+            goto print_optint;
+        case TARGET_SO_TIMESTAMP_NEW:
+            qemu_log("SO_TIMESTAMP_NEW,");
             goto print_optint;
         case TARGET_SO_RCVLOWAT:
             qemu_log("SO_RCVLOWAT,");
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cda194a7cc..e6b1a18cc0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1697,6 +1697,18 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
     return 0;
 }
 
+/*
+ * Linux kernel actually keeps track of whether the old version (potentially
+ * 32-bit time_t) or the new version is used for each socket. Instead of
+ * replicate it will all the complexity, we only keep track of one global state,
+ * which is enough for guest programs that don't intentionally mix the two
+ * versions.
+ */
+static enum TargetTimestampVersion {
+    TARGET_TIMESTAMP_OLD,
+    TARGET_TIMESTAMP_NEW,
+} target_expected_timestamp_version = TARGET_TIMESTAMP_OLD;
+
 static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                                            struct msghdr *msgh)
 {
@@ -1747,8 +1759,17 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
         switch (cmsg->cmsg_level) {
         case SOL_SOCKET:
             switch (cmsg->cmsg_type) {
-            case SO_TIMESTAMP:
-                tgt_len = sizeof(struct target_timeval);
+            case SCM_TIMESTAMP:
+                switch (target_expected_timestamp_version) {
+                case TARGET_TIMESTAMP_OLD:
+                    tgt_len = sizeof(struct target_timeval);
+                    target_cmsg->cmsg_type = tswap32(TARGET_SCM_TIMESTAMP_OLD);
+                    break;
+                case TARGET_TIMESTAMP_NEW:
+                    tgt_len = sizeof(struct target__kernel_sock_timeval);
+                    target_cmsg->cmsg_type = tswap32(TARGET_SCM_TIMESTAMP_NEW);
+                    break;
+                }
                 break;
             default:
                 break;
@@ -1782,20 +1803,39 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 }
                 break;
             }
-            case SO_TIMESTAMP:
+            case SCM_TIMESTAMP:
             {
                 struct timeval *tv = (struct timeval *)data;
-                struct target_timeval *target_tv =
-                    (struct target_timeval *)target_data;
-
-                if (len != sizeof(struct timeval) ||
-                    tgt_len != sizeof(struct target_timeval)) {
+                if (len != sizeof(struct timeval)) {
                     goto unimplemented;
                 }
 
-                /* copy struct timeval to target */
-                __put_user(tv->tv_sec, &target_tv->tv_sec);
-                __put_user(tv->tv_usec, &target_tv->tv_usec);
+                switch (target_expected_timestamp_version) {
+                case TARGET_TIMESTAMP_OLD:
+                {
+                    struct target_timeval *target_tv =
+                        (struct target_timeval *)target_data;
+                    if (tgt_len != sizeof(struct target_timeval)) {
+                        goto unimplemented;
+                    }
+
+                    __put_user(tv->tv_sec, &target_tv->tv_sec);
+                    __put_user(tv->tv_usec, &target_tv->tv_usec);
+                    break;
+                }
+                case TARGET_TIMESTAMP_NEW:
+                {
+                    struct target__kernel_sock_timeval *target_tv =
+                        (struct target__kernel_sock_timeval *)target_data;
+                    if (tgt_len != sizeof(struct target__kernel_sock_timeval)) {
+                        goto unimplemented;
+                    }
+
+                    __put_user(tv->tv_sec, &target_tv->tv_sec);
+                    __put_user(tv->tv_usec, &target_tv->tv_usec);
+                    break;
+                }
+                }
                 break;
             }
             case SCM_CREDENTIALS:
@@ -1937,6 +1977,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
     int val;
     struct ip_mreqn *ip_mreq;
     struct ip_mreq_source *ip_mreq_source;
+    enum TargetTimestampVersion target_timestamp_version =
+        target_expected_timestamp_version;
 
     switch(level) {
     case SOL_TCP:
@@ -2331,9 +2373,14 @@ set_timeout:
         case TARGET_SO_PASSSEC:
                 optname = SO_PASSSEC;
                 break;
-        case TARGET_SO_TIMESTAMP:
-		optname = SO_TIMESTAMP;
-		break;
+        case TARGET_SO_TIMESTAMP_OLD:
+                target_timestamp_version = TARGET_TIMESTAMP_OLD;
+                optname = SO_TIMESTAMP;
+                break;
+        case TARGET_SO_TIMESTAMP_NEW:
+                target_timestamp_version = TARGET_TIMESTAMP_NEW;
+                optname = SO_TIMESTAMP;
+                break;
         case TARGET_SO_RCVLOWAT:
 		optname = SO_RCVLOWAT;
 		break;
@@ -2346,6 +2393,9 @@ set_timeout:
 	if (get_user_u32(val, optval_addr))
             return -TARGET_EFAULT;
 	ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
+        if (!is_error(ret) && optname == SO_TIMESTAMP) {
+            target_expected_timestamp_version = target_timestamp_version;
+        }
         break;
 #ifdef SOL_NETLINK
     case SOL_NETLINK:
@@ -2396,6 +2446,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     abi_long ret;
     int len, val;
     socklen_t lv;
+    int timestamp_format_matches = 0;
 
     switch(level) {
     case TARGET_SOL_SOCKET:
@@ -2576,7 +2627,14 @@ get_timeout:
         case TARGET_SO_PASSCRED:
             optname = SO_PASSCRED;
             goto int_case;
-        case TARGET_SO_TIMESTAMP:
+        case TARGET_SO_TIMESTAMP_OLD:
+            timestamp_format_matches =
+                (target_expected_timestamp_version == TARGET_TIMESTAMP_OLD);
+            optname = SO_TIMESTAMP;
+            goto int_case;
+        case TARGET_SO_TIMESTAMP_NEW:
+            timestamp_format_matches =
+                (target_expected_timestamp_version == TARGET_TIMESTAMP_NEW);
             optname = SO_TIMESTAMP;
             goto int_case;
         case TARGET_SO_RCVLOWAT:
@@ -2604,6 +2662,9 @@ get_timeout:
         if (optname == SO_TYPE) {
             val = host_to_target_sock_type(val);
         }
+        if (optname == SO_TIMESTAMP) {
+            val = val && timestamp_format_matches;
+        }
         if (len > lv)
             len = lv;
         if (len == 4) {
diff --git a/tests/tcg/multiarch/socket_timestamp.c b/tests/tcg/multiarch/socket_timestamp.c
new file mode 100644
index 0000000000..71ab1845de
--- /dev/null
+++ b/tests/tcg/multiarch/socket_timestamp.c
@@ -0,0 +1,296 @@
+#include <assert.h>
+#include <errno.h>
+#include <linux/types.h>
+#include <netinet/in.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#ifdef __kernel_old_timeval
+#define kernel_old_timeval __kernel_old_timeval
+#else
+struct kernel_old_timeval {
+    __kernel_long_t tv_sec;
+    __kernel_long_t tv_usec;
+};
+#endif
+
+struct kernel_sock_timeval {
+    int64_t tv_sec;
+    int64_t tv_usec;
+};
+
+int create_udp_socket(struct sockaddr_in *sockaddr)
+{
+    socklen_t sockaddr_len;
+    int sock = socket(AF_INET, SOCK_DGRAM, 0);
+    if (sock < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to create server socket: %s\n", strerror(err));
+        exit(err);
+    }
+
+    memset(sockaddr, 0, sizeof(*sockaddr));
+    sockaddr->sin_family = AF_INET;
+    sockaddr->sin_port = htons(0);  /* let kernel select a port for us */
+    sockaddr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+
+    if (bind(sock, (struct sockaddr *)sockaddr, sizeof(*sockaddr)) < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to bind server socket: %s\n", strerror(err));
+        exit(err);
+    }
+
+    sockaddr_len = sizeof(*sockaddr);
+    if (getsockname(sock, (struct sockaddr *)sockaddr, &sockaddr_len) < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to get socket name: %s\n", strerror(err));
+        exit(err);
+    }
+    return sock;
+}
+
+/*
+ * Checks that the timestamp in the message is not after the reception timestamp
+ * as well as the reception time is within 10 seconds of the message time.
+ */
+void check_timestamp_difference(const struct timeval *msg_tv,
+                                const struct timeval *pkt_tv)
+{
+    if (pkt_tv->tv_sec < msg_tv->tv_sec ||
+        (pkt_tv->tv_sec == msg_tv->tv_sec && pkt_tv->tv_usec < msg_tv->tv_usec))
+    {
+        fprintf(stderr,
+                "Packet received before sent: %lld.%06lld < %lld.%06lld\n",
+                (long long)pkt_tv->tv_sec, (long long)pkt_tv->tv_usec,
+                (long long)msg_tv->tv_sec, (long long)msg_tv->tv_usec);
+        exit(-1);
+    }
+
+    if (pkt_tv->tv_sec > msg_tv->tv_sec + 10 ||
+        (pkt_tv->tv_sec == msg_tv->tv_sec + 10 &&
+         pkt_tv->tv_usec > msg_tv->tv_usec)) {
+        fprintf(stderr,
+                "Packet received more than 10 seconds after sent: "
+                "%lld.%06lld > %lld.%06lld + 10\n",
+                (long long)pkt_tv->tv_sec, (long long)pkt_tv->tv_usec,
+                (long long)msg_tv->tv_sec, (long long)msg_tv->tv_usec);
+        exit(-1);
+    }
+}
+
+void send_current_time(int sock, struct sockaddr_in server_sockaddr)
+{
+    struct timeval tv = {0, 0};
+    gettimeofday(&tv, NULL);
+    sendto(sock, &tv, sizeof(tv), 0, (struct sockaddr *)&server_sockaddr,
+           sizeof(server_sockaddr));
+}
+
+typedef void (*get_timeval_t)(const struct cmsghdr *cmsg, struct timeval *tv);
+
+
+void receive_packet(int sock, get_timeval_t get_timeval)
+{
+    struct msghdr msg = {0};
+
+    char iobuf[1024];
+    struct iovec iov;
+
+    union {
+        /*
+         * 128 bytes are enough for all existing
+         * timeval/timespec/scm_timestamping structures.
+         */
+        char cmsg_buf[CMSG_SPACE(128)];
+        struct cmsghdr align;
+    } u;
+    struct cmsghdr *cmsg;
+    struct timeval msg_tv, pkt_tv;
+
+    int res;
+
+    iov.iov_base = iobuf;
+    iov.iov_len = sizeof(iobuf);
+
+    msg.msg_iov = &iov;
+    msg.msg_iovlen = 1;
+    msg.msg_control = (caddr_t)u.cmsg_buf;
+    msg.msg_controllen = sizeof(u.cmsg_buf);
+
+    res = recvmsg(sock, &msg, 0);
+    if (res < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to receive packet: %s\n", strerror(err));
+        exit(err);
+    }
+
+    assert(res == sizeof(struct timeval));
+    assert(iov.iov_base == iobuf);
+    memcpy(&msg_tv, iov.iov_base, sizeof(msg_tv));
+    printf("Message timestamp: %lld.%06lld\n",
+           (long long)msg_tv.tv_sec, (long long)msg_tv.tv_usec);
+
+    cmsg = CMSG_FIRSTHDR(&msg);
+    assert(cmsg);
+    (*get_timeval)(cmsg, &pkt_tv);
+    printf("Packet timestamp: %lld.%06lld\n",
+           (long long)pkt_tv.tv_sec, (long long)pkt_tv.tv_usec);
+
+    check_timestamp_difference(&msg_tv, &pkt_tv);
+}
+
+void get_timeval_from_so_timestamp(const struct cmsghdr *cmsg,
+                                   struct timeval *tv)
+{
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SCM_TIMESTAMP);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(struct timeval)));
+    memcpy(tv, CMSG_DATA(cmsg), sizeof(*tv));
+}
+
+#ifdef SO_TIMESTAMP_OLD
+void get_timeval_from_so_timestamp_old(const struct cmsghdr *cmsg,
+                                       struct timeval *tv)
+{
+    struct kernel_old_timeval old_tv;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SO_TIMESTAMP_OLD);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(old_tv)));
+
+    memcpy(&old_tv, CMSG_DATA(cmsg), sizeof(old_tv));
+    tv->tv_sec = old_tv.tv_sec;
+    tv->tv_usec = old_tv.tv_usec;
+}
+
+#ifdef SO_TIMESTAMP_NEW
+void get_timeval_from_so_timestamp_new(const struct cmsghdr *cmsg,
+                                       struct timeval *tv)
+{
+    struct kernel_sock_timeval sock_tv;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SO_TIMESTAMP_NEW);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(sock_tv)));
+
+    memcpy(&sock_tv, CMSG_DATA(cmsg), sizeof(sock_tv));
+    tv->tv_sec = sock_tv.tv_sec;
+    tv->tv_usec = sock_tv.tv_usec;
+}
+#endif /* defined(SO_TIMESTAMP_NEW) */
+#endif /* defined(SO_TIMESTAMP_OLD) */
+
+void set_socket_option(int sock, int sockopt, int on)
+{
+    socklen_t len;
+    int val = on;
+    if (setsockopt(sock, SOL_SOCKET, sockopt, &val, sizeof(val)) < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to setsockopt %d (%s): %s\n",
+                sockopt, on ? "on" : "off", strerror(err));
+        exit(err);
+    }
+
+    len = sizeof(val);
+    val = -1;
+    if (getsockopt(sock, SOL_SOCKET, sockopt, &val, &len) < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to getsockopt (%d): %s\n", sock, strerror(err));
+        exit(err);
+    }
+    assert(len == sizeof(val));
+    assert(val == on);
+}
+
+int main(int argc, char **argv)
+{
+    int parent_sock, child_sock;
+    struct sockaddr_in parent_sockaddr, child_sockaddr;
+    int pid;
+    struct timeval tv = {0, 0};
+    gettimeofday(&tv, NULL);
+
+    parent_sock = create_udp_socket(&parent_sockaddr);
+    child_sock = create_udp_socket(&child_sockaddr);
+
+    printf("Parent sock bound to port %d\nChild sock bound to port %d\n",
+           parent_sockaddr.sin_port, child_sockaddr.sin_port);
+
+    pid = fork();
+    if (pid < 0) {
+        fprintf(stderr, "SKIPPED. Failed to fork: %s\n", strerror(errno));
+    } else if (pid == 0) {
+        close(child_sock);
+
+        /* Test 1: SO_TIMESTAMP */
+        send_current_time(parent_sock, child_sockaddr);
+
+        if (tv.tv_sec > 0x7fffff00) {
+            /* Too close to y2038 problem, old system may not work. */
+            close(parent_sock);
+            return 0;
+        }
+
+#ifdef SO_TIMESTAMP_OLD
+        if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
+            /* Test 2a: SO_TIMESTAMP_OLD */
+            set_socket_option(parent_sock, SO_TIMESTAMP_OLD, 1);
+            receive_packet(parent_sock, &get_timeval_from_so_timestamp_old);
+            set_socket_option(parent_sock, SO_TIMESTAMP_OLD, 0);
+        }
+#ifdef SO_TIMESTAMP_NEW
+        else {
+            /* Test 2b: SO_TIMESTAMP_NEW */
+            set_socket_option(parent_sock, SO_TIMESTAMP_NEW, 1);
+            receive_packet(parent_sock, &get_timeval_from_so_timestamp_new);
+            set_socket_option(parent_sock, SO_TIMESTAMP_NEW, 0);
+        }
+#endif /* defined(SO_TIMESTAMP_NEW) */
+#endif /* defined(SO_TIMESTAMP_OLD) */
+
+        close(parent_sock);
+    } else {
+        int child_status;
+        close(parent_sock);
+
+        /* Test 1: SO_TIMESTAMP */
+        set_socket_option(child_sock, SO_TIMESTAMP, 1);
+        receive_packet(child_sock, &get_timeval_from_so_timestamp);
+        set_socket_option(child_sock, SO_TIMESTAMP, 0);
+
+        if (tv.tv_sec > 0x7fffff00) {
+            /* Too close to y2038 problem, old system may not work. */
+            close(child_sock);
+            return 0;
+        }
+
+#ifdef SO_TIMESTAMP_OLD
+        if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
+            /* Test 2a: SO_TIMESTAMP_OLD */
+            send_current_time(child_sock, parent_sockaddr);
+        }
+#ifdef SO_TIMESTAMP_NEW
+        else {
+            /* Test 2b: SO_TIMESTAMP_NEW */
+            send_current_time(child_sock, parent_sockaddr);
+        }
+#endif /* defined(SO_TIMESTAMP_NEW) */
+#endif /* defined(SO_TIMESTAMP_OLD) */
+
+        close(child_sock);
+
+        if (waitpid(pid, &child_status, 0) < 0) {
+            int err = errno;
+            fprintf(stderr, "Final wait() failed: %s\n", strerror(err));
+            return err;
+        }
+        return child_status;
+    }
+    return 0;
+}
-- 
2.28.0.220.ged08abb693-goog


