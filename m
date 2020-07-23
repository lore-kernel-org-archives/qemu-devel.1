Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE06C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B93020825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lm8qd7v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B93020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyP2B-0000wC-Uk
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nNcYXwMKCq0fPjTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--scw.bounces.google.com>)
 id 1jyOxh-0003Mb-9a
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:49 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049]:53664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nNcYXwMKCq0fPjTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--scw.bounces.google.com>)
 id 1jyOxa-000244-5P
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:48 -0400
Received: by mail-pj1-x1049.google.com with SMTP id q5so2565392pjd.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=pAA4nB6roOaN0E7DQOrnAePzVa3wqjeaCookitLRQ5I=;
 b=lm8qd7v7qFnTRNb0qQGAH7xjIbG+Hm5qErHjGwlQJOHrPunOdQ9vrec1MYB2WDy6yB
 wwoaKHYuxsh2ju57YK9TVnUDrGzVGJPjlpr/OwbLE9xRtuMEXHaK8QOT1vXT1bsvGeRF
 BGz4hjx5bBhJGuyCEdrkvNOMRHOP9d5iQ4cGoky5gmIsIkPgirzU54A4ZMztY2cIysE/
 qctU28fkddtzb++OPbaaOyBl+jRY/wnHTr+4NO1iQJ5Hi9Z1S/RLKCDkxYNRRDWLPL03
 IVIrYB/Gf09PderPsuTKsnrglGZ6OolhnWQLOHbUmkdCAyYFs8/IkrtVBfocUa8GXly5
 swMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=pAA4nB6roOaN0E7DQOrnAePzVa3wqjeaCookitLRQ5I=;
 b=JeUinmLEGo3RU9yPoUngJcp85QVZGTAkx6caJ31c/MOu8TczEjNSs+a+97OCMtnpte
 lizOd+YlfVEm5MBnvkECNT4G1bMynDpjUGdzmruoIN8W9gD8td3dTpNJdbmDFonRLR19
 QtUukqOpqcqsQHWL45o5YXx5S9IkEWLOaEIJsnlnib/keDx4w5Gj0/pMBYIzzpipajg8
 pJBJuB1tsQXdt5QVf/tvKFh24AZ8ZE4v4FdQtLBmEWCnAn5zVi7MJRWX3qe4GLedcXJ1
 /W7VmHhQ1QtiQF5Nqp1apLnLY88GRSi9Sr1WpxdhFe2wgiUKS7DUcnhtX/ZmhtWOR3tX
 t+2A==
X-Gm-Message-State: AOAM532rkdcEAV20nXt/l9KFKS21tX9FYMwBTUUdqrDyQZ6BJjjAxywp
 3zNzZZEzhhkOGg37ioIfoBOTokF6xqciL6+MdSUslUZdoyp0icBm3xQuPE0dF3NL6xwZNzNrTq7
 Fc90j33FcFBe9wgm0A0XpzUPrkzG08kXTeikLDcSTqERV6Cgq5LG5
X-Google-Smtp-Source: ABdhPJy//NjRzbau7qwfITgMdf2IoUWId9bSOgy3bc4Tw7D4OwnksZDVfqu6ddylwtnoFNAMtOci4eA=
X-Received: by 2002:a62:387:: with SMTP id 129mr1948041pfd.187.1595463580194; 
 Wed, 22 Jul 2020 17:19:40 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:19:12 -0700
In-Reply-To: <cover.1595461447.git.scw@google.com>
Message-Id: <945da0d5e224e70c42bd7085d44bb2440168f60d.1595461447.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595461447.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 3/6] linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3nNcYXwMKCq0fPjTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--scw.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

Both guest options map to host SO_TIMESTAMP while keeping a bit in
fd_trans to remember if the guest expects the old or the new format.

Added a multiarch test to verify.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/alpha/sockbits.h            |   8 +-
 linux-user/fd-trans.h                  |  41 +++-
 linux-user/generic/sockbits.h          |   9 +-
 linux-user/hppa/sockbits.h             |   8 +-
 linux-user/mips/sockbits.h             |   8 +-
 linux-user/sparc/sockbits.h            |   8 +-
 linux-user/strace.c                    |   7 +-
 linux-user/syscall.c                   |  69 ++++--
 tests/tcg/multiarch/socket_timestamp.c | 292 +++++++++++++++++++++++++
 9 files changed, 419 insertions(+), 31 deletions(-)
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
diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index a3fcdaabc7..8ab650dfd2 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -22,6 +22,16 @@ typedef struct TargetFdTrans {
     TargetFdDataFunc host_to_target_data;
     TargetFdDataFunc target_to_host_data;
     TargetFdAddrFunc target_to_host_addr;
+
+    /* If `true`, this struct is dynamically allocated and should be
+     * `g_free()`ed when unregistering.
+     */
+    bool free_when_unregister;
+
+    /* The socket's timestamp option (`SO_TIMESTAMP`, `SO_TIMESTAMPNS`, and
+     * `SO_TIMESTAMPING`) is using the `_NEW` version.
+     */
+    bool socket_timestamp_new;
 } TargetFdTrans;
 
 extern TargetFdTrans **target_fd_trans;
@@ -52,6 +62,14 @@ static inline TargetFdAddrFunc fd_trans_target_to_host_addr(int fd)
     return NULL;
 }
 
+static inline bool fd_trans_socket_timestamp_new(int fd)
+{
+    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
+        return target_fd_trans[fd]->socket_timestamp_new;
+    }
+    return false;
+}
+
 static inline void fd_trans_register(int fd, TargetFdTrans *trans)
 {
     unsigned int oldmax;
@@ -70,6 +88,9 @@ static inline void fd_trans_register(int fd, TargetFdTrans *trans)
 static inline void fd_trans_unregister(int fd)
 {
     if (fd >= 0 && fd < target_fd_max) {
+        if (target_fd_trans[fd] && target_fd_trans[fd]->free_when_unregister) {
+            g_free(target_fd_trans[fd]);
+        }
         target_fd_trans[fd] = NULL;
     }
 }
@@ -78,8 +99,26 @@ static inline void fd_trans_dup(int oldfd, int newfd)
 {
     fd_trans_unregister(newfd);
     if (oldfd < target_fd_max && target_fd_trans[oldfd]) {
-        fd_trans_register(newfd, target_fd_trans[oldfd]);
+        TargetFdTrans *trans = target_fd_trans[oldfd];
+        if (trans->free_when_unregister) {
+            trans = g_new(TargetFdTrans, 1);
+            *trans = *target_fd_trans[oldfd];
+        }
+        fd_trans_register(newfd, trans);
+    }
+}
+
+static inline void fd_trans_mark_socket_timestamp_new(int fd, bool value)
+{
+    if (fd < 0) return;
+    if (fd >= target_fd_max || target_fd_trans[fd] == NULL) {
+        if (!value) return; /* default is false */
+
+        TargetFdTrans* trans = g_new0(TargetFdTrans, 1);
+        trans->free_when_unregister = true;
+        fd_trans_register(fd, trans);
     }
+    target_fd_trans[fd]->socket_timestamp_new = value;
 }
 
 extern TargetFdTrans target_packet_trans;
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
index 13981341b3..369cfcd7bd 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2213,8 +2213,11 @@ print_optint:
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
index a53db446d4..7f95ccda7f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1705,7 +1705,8 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
 }
 
 static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
-                                           struct msghdr *msgh)
+                                           struct msghdr *msgh,
+                                           bool target_uses_timeval64)
 {
     struct cmsghdr *cmsg = CMSG_FIRSTHDR(msgh);
     abi_long msg_controllen;
@@ -1754,8 +1755,14 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
         switch (cmsg->cmsg_level) {
         case SOL_SOCKET:
             switch (cmsg->cmsg_type) {
-            case SO_TIMESTAMP:
-                tgt_len = sizeof(struct target_timeval);
+            case SCM_TIMESTAMP:
+                if (target_uses_timeval64) {
+                    tgt_len = sizeof(struct target__kernel_sock_timeval);
+                    target_cmsg->cmsg_type = tswap32(TARGET_SCM_TIMESTAMP_NEW);
+                } else {
+                    tgt_len = sizeof(struct target_timeval);
+                    target_cmsg->cmsg_type = tswap32(TARGET_SCM_TIMESTAMP_OLD);
+                }
                 break;
             default:
                 break;
@@ -1789,20 +1796,32 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
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
+                if (target_uses_timeval64) {
+                    struct target__kernel_sock_timeval *target_tv =
+                        (struct target__kernel_sock_timeval *)target_data;
+                    if (tgt_len != sizeof(struct target__kernel_sock_timeval)) {
+                        goto unimplemented;
+                    }
+
+                    __put_user(tv->tv_sec, &target_tv->tv_sec);
+                    __put_user(tv->tv_usec, &target_tv->tv_usec);
+                } else {
+                    struct target_timeval *target_tv =
+                        (struct target_timeval *)target_data;
+                    if (tgt_len != sizeof(struct target_timeval)) {
+                        goto unimplemented;
+                    }
+
+                    __put_user(tv->tv_sec, &target_tv->tv_sec);
+                    __put_user(tv->tv_usec, &target_tv->tv_usec);
+                }
                 break;
             }
             case SCM_CREDENTIALS:
@@ -1941,7 +1960,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                               abi_ulong optval_addr, socklen_t optlen)
 {
     abi_long ret;
-    int val;
+    int val, timestamp_format_is_new;
     struct ip_mreqn *ip_mreq;
     struct ip_mreq_source *ip_mreq_source;
 
@@ -2338,9 +2357,11 @@ set_timeout:
         case TARGET_SO_PASSSEC:
                 optname = SO_PASSSEC;
                 break;
-        case TARGET_SO_TIMESTAMP:
-		optname = SO_TIMESTAMP;
-		break;
+        case TARGET_SO_TIMESTAMP_OLD:
+        case TARGET_SO_TIMESTAMP_NEW:
+                timestamp_format_is_new = (optname == TARGET_SO_TIMESTAMP_NEW);
+                optname = SO_TIMESTAMP;
+                break;
         case TARGET_SO_RCVLOWAT:
 		optname = SO_RCVLOWAT;
 		break;
@@ -2353,6 +2374,9 @@ set_timeout:
 	if (get_user_u32(val, optval_addr))
             return -TARGET_EFAULT;
 	ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
+        if (!is_error(ret) && optname == SO_TIMESTAMP) {
+            fd_trans_mark_socket_timestamp_new(sockfd, timestamp_format_is_new);
+        }
         break;
 #ifdef SOL_NETLINK
     case SOL_NETLINK:
@@ -2403,6 +2427,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     abi_long ret;
     int len, val;
     socklen_t lv;
+    int timestamp_format_matches = 0;
 
     switch(level) {
     case TARGET_SOL_SOCKET:
@@ -2583,7 +2608,11 @@ get_timeout:
         case TARGET_SO_PASSCRED:
             optname = SO_PASSCRED;
             goto int_case;
-        case TARGET_SO_TIMESTAMP:
+        case TARGET_SO_TIMESTAMP_OLD:
+        case TARGET_SO_TIMESTAMP_NEW:
+            timestamp_format_matches =
+                (fd_trans_socket_timestamp_new(sockfd) ==
+                 (optname == TARGET_SO_TIMESTAMP_NEW));
             optname = SO_TIMESTAMP;
             goto int_case;
         case TARGET_SO_RCVLOWAT:
@@ -2611,6 +2640,9 @@ get_timeout:
         if (optname == SO_TYPE) {
             val = host_to_target_sock_type(val);
         }
+        if (optname == SO_TIMESTAMP) {
+            val = val && timestamp_format_matches;
+        }
         if (len > lv)
             len = lv;
         if (len == 4) {
@@ -3162,7 +3194,8 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
                 ret = fd_trans_host_to_target_data(fd)(msg.msg_iov->iov_base,
                                                MIN(msg.msg_iov->iov_len, len));
             } else {
-                ret = host_to_target_cmsg(msgp, &msg);
+                ret = host_to_target_cmsg(msgp, &msg,
+                                          fd_trans_socket_timestamp_new(fd));
             }
             if (!is_error(ret)) {
                 msgp->msg_namelen = tswap32(msg.msg_namelen);
diff --git a/tests/tcg/multiarch/socket_timestamp.c b/tests/tcg/multiarch/socket_timestamp.c
new file mode 100644
index 0000000000..fd2833e5c8
--- /dev/null
+++ b/tests/tcg/multiarch/socket_timestamp.c
@@ -0,0 +1,292 @@
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
+struct kernel_old_timeval
+{
+    __kernel_long_t tv_sec;
+    __kernel_long_t tv_usec;
+};
+#endif
+
+struct kernel_sock_timeval
+{
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
+/* Checks that the timestamp in the message is not after the reception timestamp
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
+        /* 128 bytes should cover all imaginable timeval/timespec*/
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
+    if ((res = recvmsg(sock, &msg, 0)) < 0) {
+        int err = errno;
+        fprintf(stderr, "Failed to receive packet: %s\n", strerror(err));
+        exit(-err);
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
+    assert(cmsg->cmsg_len >= CMSG_LEN(sizeof(struct timeval)));
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
+    assert(cmsg->cmsg_len >= CMSG_LEN(sizeof(old_tv)));
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
+    assert(cmsg->cmsg_len >= CMSG_LEN(sizeof(sock_tv)));
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
+    if ((pid = fork()) == -2) {
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
2.28.0.rc0.105.gf9edc3c819-goog


