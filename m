Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2140720825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTaP7tyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2140720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyP1E-0007zx-BS
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ntcYXwMKCq8hRlVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--scw.bounces.google.com>)
 id 1jyOxh-0003Me-C3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:50 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:51917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ntcYXwMKCq8hRlVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--scw.bounces.google.com>)
 id 1jyOxc-00024I-7V
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:49 -0400
Received: by mail-yb1-xb49.google.com with SMTP id l17so4440745ybe.18
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=flHUWQsTG5TkvofUeP5c8g/c6Px7De3nC5lYfrojDj8=;
 b=HTaP7tylh3+6Gemltd/yC+CqhJhNuwVpmWJ3in/RvO3aHMYhNLhAtD+JE9EJB2E7tn
 7NyuT3J2DtySUQdIqeQzpNKbO8zD4E7PyyJDqyAFmOHM12UcQC0ADnFHi5K25KcFMRA8
 2a0qBiRex4/jCEQu6ExIy88qtzVg7ssGBgp4+uVOfEP6Aqu9gvOUAyJv7dfsDmsYQ3Yx
 Jgk6NHESRwl1LdagWKamBR3o52JhdRT6eo6o2MHOqBsI+vQpeGYtVHofQPAwE4q6FGPh
 LjAPE9cBGy0lP28EXjAw0WpUu4VqLOufarORZCLseQQE+h8SfKhSp9/YUDflgc4Hkarj
 9O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=flHUWQsTG5TkvofUeP5c8g/c6Px7De3nC5lYfrojDj8=;
 b=ivWFCD0Qy2JV+f1qppPy1K3J4qktixEI7cT7J+aNOlBYVfhnjW7Y+40Qbb8dLoMQ4Z
 StXjY3hNKUdEhZ6/SrciQ13QZWkyZemxF/tQOPlSndJm8J9ruva39pqSLsTzUhVIckoR
 VYm5yVU/SvS/yAkpF39W1g5nO04doC73C5+ZoHBv9oe4OSllP4gIIjkOLi2/HqwCDchS
 k/735R5gLMZMq9KFozN/kipp5BFHmZUo1Al3sF0VMnZRMoc8u4q7ZQN+uRn+UNWug36J
 Fw4M8wLZtuQInunz/SQ0IxCnCpT49VvTBGPMIOcrkBpPK0Ug/bo6bPfyJGN6/C3fdyxu
 h5Vg==
X-Gm-Message-State: AOAM532+74HxgmVV+6xJRHKNRQMQbT7IPfZwgmdk8w0RlhDn3VHhbaSl
 zvl/HJ5zlB9B8qIc2ussuHl2BJytOCjjMgAhIPsDYQKXXCL8rHrAg3eO2hDcTBUncYB8dBtNyXX
 pfM6FpBZ6C6EAJ2uOyWDOgjYAR8gp4o0/jRwynibGkZRtMn3NEYDi
X-Google-Smtp-Source: ABdhPJyU8ozF8IoKyCKPo/kbfNvSVIUQ7L/fxO9K71yANHYaFKBWMXcdOZaAPfmzzmER6wIBeMmfzwY=
X-Received: by 2002:a25:da87:: with SMTP id n129mr3206345ybf.149.1595463582787; 
 Wed, 22 Jul 2020 17:19:42 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:19:13 -0700
In-Reply-To: <cover.1595461447.git.scw@google.com>
Message-Id: <85839c0b66e423f42be587229534587b3954a126.1595461447.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595461447.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 4/6] linux-user: setsockopt() SO_TIMESTAMPNS and
 SO_TIMESTAMPING
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ntcYXwMKCq8hRlVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

This change supports SO_TIMESTAMPNS_OLD/NEW and SO_TIMESTAMPING_OLD/NEW
for setsocketopt() with SOL_SOCKET. Based on the SO_TIMESTAMP_OLD/NEW
framework. The three pairs share the same flag `SOCK_TSTAMP_NEW` in
linux kernel for deciding if the old or the new format is used.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/alpha/sockbits.h            |  13 +-
 linux-user/generic/sockbits.h          |   8 +
 linux-user/hppa/sockbits.h             |  12 +-
 linux-user/mips/sockbits.h             |   8 +
 linux-user/sparc/sockbits.h            |  13 +-
 linux-user/strace.c                    |  12 +
 linux-user/syscall.c                   | 119 ++++++-
 tests/tcg/multiarch/socket_timestamp.c | 458 +++++++++++++++++++------
 8 files changed, 521 insertions(+), 122 deletions(-)

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index 40f0644df0..c2c88f432b 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -51,8 +51,6 @@
 
 #define TARGET_SO_PEERSEC       30
 #define TARGET_SO_PASSSEC       34
-#define TARGET_SO_TIMESTAMPNS       35
-#define TARGET_SCM_TIMESTAMPNS      TARGET_SO_TIMESTAMPNS
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define TARGET_SO_SECURITY_AUTHENTICATION       19
@@ -61,9 +59,6 @@
 
 #define TARGET_SO_MARK          36
 
-#define TARGET_SO_TIMESTAMPING      37
-#define TARGET_SCM_TIMESTAMPING TARGET_SO_TIMESTAMPING
-
 #define TARGET_SO_RXQ_OVFL             40
 
 #define TARGET_SO_WIFI_STATUS       41
@@ -75,9 +70,17 @@
 
 #define TARGET_SO_TIMESTAMP_OLD        29
 #define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+#define TARGET_SO_TIMESTAMPNS_OLD      35
+#define TARGET_SCM_TIMESTAMPNS_OLD     TARGET_SO_TIMESTAMPNS_OLD
+#define TARGET_SO_TIMESTAMPING_OLD     37
+#define TARGET_SCM_TIMESTAMPING_OLD    TARGET_SO_TIMESTAMPING_OLD
 
 #define TARGET_SO_TIMESTAMP_NEW        63
 #define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SCM_TIMESTAMPNS_NEW     TARGET_SO_TIMESTAMPNS_NEW
+#define TARGET_SO_TIMESTAMPING_NEW     65
+#define TARGET_SCM_TIMESTAMPING_NEW    TARGET_SO_TIMESTAMPING_NEW
 
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index 532cf2d3dc..a0496d8751 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -56,8 +56,16 @@
 
 #define TARGET_SO_TIMESTAMP_OLD        29
 #define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+#define TARGET_SO_TIMESTAMPNS_OLD      35
+#define TARGET_SCM_TIMESTAMPNS_OLD     TARGET_SO_TIMESTAMPNS_OLD
+#define TARGET_SO_TIMESTAMPING_OLD     37
+#define TARGET_SCM_TIMESTAMPING_OLD    TARGET_SO_TIMESTAMPING_OLD
 
 #define TARGET_SO_TIMESTAMP_NEW        63
 #define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SCM_TIMESTAMPNS_NEW     TARGET_SO_TIMESTAMPNS_NEW
+#define TARGET_SO_TIMESTAMPING_NEW     65
+#define TARGET_SCM_TIMESTAMPING_NEW    TARGET_SO_TIMESTAMPING_NEW
 
 #endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 284a47e74e..d7e9aa340d 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -29,8 +29,6 @@
 #define TARGET_SO_BSDCOMPAT    0x400e
 #define TARGET_SO_PASSCRED     0x4010
 #define TARGET_SO_PEERCRED     0x4011
-#define TARGET_SO_TIMESTAMPNS  0x4013
-#define TARGET_SCM_TIMESTAMPNS TARGET_SO_TIMESTAMPNS
 
 #define TARGET_SO_SECURITY_AUTHENTICATION              0x4016
 #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x4017
@@ -44,8 +42,6 @@
 #define TARGET_SO_PEERSEC              0x401d
 #define TARGET_SO_PASSSEC              0x401e
 #define TARGET_SO_MARK                 0x401f
-#define TARGET_SO_TIMESTAMPING         0x4020
-#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
 #define TARGET_SO_RXQ_OVFL             0x4021
 #define TARGET_SO_WIFI_STATUS          0x4022
 #define TARGET_SCM_WIFI_STATUS         TARGET_SO_WIFI_STATUS
@@ -67,9 +63,17 @@
 
 #define TARGET_SO_TIMESTAMP_OLD        0x4012
 #define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+#define TARGET_SO_TIMESTAMPNS_OLD      0x4013
+#define TARGET_SCM_TIMESTAMPNS_OLD     TARGET_SO_TIMESTAMPNS_OLD
+#define TARGET_SO_TIMESTAMPING_OLD     0x4020
+#define TARGET_SCM_TIMESTAMPING_OLD    TARGET_SO_TIMESTAMPING_OLD
 
 #define TARGET_SO_TIMESTAMP_NEW        0x4038
 #define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+#define TARGET_SO_TIMESTAMPNS_NEW      0x4039
+#define TARGET_SCM_TIMESTAMPNS_NEW     TARGET_SO_TIMESTAMPNS_NEW
+#define TARGET_SO_TIMESTAMPING_NEW     0x403A
+#define TARGET_SCM_TIMESTAMPING_NEW    TARGET_SO_TIMESTAMPING_NEW
 
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index b4c39d9588..49524e23ac 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -69,9 +69,17 @@
 
 #define TARGET_SO_TIMESTAMP_OLD        29
 #define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+#define TARGET_SO_TIMESTAMPNS_OLD      35
+#define TARGET_SCM_TIMESTAMPNS_OLD     TARGET_SO_TIMESTAMPNS_OLD
+#define TARGET_SO_TIMESTAMPING_OLD     37
+#define TARGET_SCM_TIMESTAMPING_OLD    TARGET_SO_TIMESTAMPING_OLD
 
 #define TARGET_SO_TIMESTAMP_NEW        63
 #define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SCM_TIMESTAMPNS_NEW     TARGET_SO_TIMESTAMPNS_NEW
+#define TARGET_SO_TIMESTAMPING_NEW     65
+#define TARGET_SCM_TIMESTAMPING_NEW    TARGET_SO_TIMESTAMPING_NEW
 
 /** sock_type - Socket types
  *
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 07440efd14..c5fade3ad1 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -51,14 +51,9 @@
 
 #define TARGET_SO_PEERSEC              0x001e
 #define TARGET_SO_PASSSEC              0x001f
-#define TARGET_SO_TIMESTAMPNS          0x0021
-#define TARGET_SCM_TIMESTAMPNS         TARGET_SO_TIMESTAMPNS
 
 #define TARGET_SO_MARK                 0x0022
 
-#define TARGET_SO_TIMESTAMPING         0x0023
-#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
-
 #define TARGET_SO_RXQ_OVFL             0x0024
 
 #define TARGET_SO_WIFI_STATUS          0x0025
@@ -104,9 +99,17 @@
 
 #define TARGET_SO_TIMESTAMP_OLD        0x001d
 #define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
+#define TARGET_SO_TIMESTAMPNS_OLD      0x0021
+#define TARGET_SCM_TIMESTAMPNS_OLD     TARGET_SO_TIMESTAMPNS_OLD
+#define TARGET_SO_TIMESTAMPING_OLD     0x0023
+#define TARGET_SCM_TIMESTAMPING_OLD    TARGET_SO_TIMESTAMPING_OLD
 
 #define TARGET_SO_TIMESTAMP_NEW        0x0046
 #define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
+#define TARGET_SO_TIMESTAMPNS_NEW      0x0042
+#define TARGET_SCM_TIMESTAMPNS_NEW     TARGET_SO_TIMESTAMPNS_NEW
+#define TARGET_SO_TIMESTAMPING_NEW     0x0043
+#define TARGET_SCM_TIMESTAMPING_NEW    TARGET_SO_TIMESTAMPING_NEW
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define TARGET_SO_SECURITY_AUTHENTICATION              0x5001
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 369cfcd7bd..603723d6c8 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2216,9 +2216,21 @@ print_optint:
         case TARGET_SO_TIMESTAMP_OLD:
             qemu_log("SO_TIMESTAMP_OLD,");
             goto print_optint;
+        case TARGET_SO_TIMESTAMPNS_OLD:
+            qemu_log("SO_TIMESTAMPNS_OLD,");
+            goto print_optint;
+        case TARGET_SO_TIMESTAMPING_OLD:
+            qemu_log("SO_TIMESTAMPING_OLD,");
+            goto print_optint;
         case TARGET_SO_TIMESTAMP_NEW:
             qemu_log("SO_TIMESTAMP_NEW,");
             goto print_optint;
+        case TARGET_SO_TIMESTAMPNS_NEW:
+            qemu_log("SO_TIMESTAMPNS_NEW,");
+            goto print_optint;
+        case TARGET_SO_TIMESTAMPING_NEW:
+            qemu_log("SO_TIMESTAMPING_NEW,");
+            goto print_optint;
         case TARGET_SO_RCVLOWAT:
             qemu_log("SO_RCVLOWAT,");
             goto print_optint;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7f95ccda7f..483f8ce48f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1764,6 +1764,28 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     target_cmsg->cmsg_type = tswap32(TARGET_SCM_TIMESTAMP_OLD);
                 }
                 break;
+            case SCM_TIMESTAMPNS:
+                if (target_uses_timeval64) {
+                    tgt_len = sizeof(struct target__kernel_timespec);
+                    target_cmsg->cmsg_type =
+                        tswap32(TARGET_SCM_TIMESTAMPNS_NEW);
+                } else {
+                    tgt_len = sizeof(struct target_timespec);
+                    target_cmsg->cmsg_type =
+                        tswap32(TARGET_SCM_TIMESTAMPNS_OLD);
+                }
+                break;
+            case SCM_TIMESTAMPING:
+                if (target_uses_timeval64) {
+                    tgt_len = sizeof(struct target__kernel_timespec[3]);
+                    target_cmsg->cmsg_type =
+                        tswap32(TARGET_SCM_TIMESTAMPING_NEW);
+                } else {
+                    tgt_len = sizeof(struct target_timespec[3]);
+                    target_cmsg->cmsg_type =
+                        tswap32(TARGET_SCM_TIMESTAMPING_OLD);
+                }
+                break;
             default:
                 break;
             }
@@ -1824,6 +1846,67 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 }
                 break;
             }
+            case SCM_TIMESTAMPNS:
+            {
+                struct timespec *ts = (struct timespec *)data;
+                if (len != sizeof(struct timespec)) {
+                    goto unimplemented;
+                }
+
+                if (target_uses_timeval64) {
+                    struct target__kernel_timespec *target_ts =
+                        (struct target__kernel_timespec *)target_data;
+                    if (tgt_len != sizeof(struct target__kernel_timespec)) {
+                        goto unimplemented;
+                    }
+
+                    __put_user(ts->tv_sec, &target_ts->tv_sec);
+                    __put_user(ts->tv_nsec, &target_ts->tv_nsec);
+                } else {
+                    struct target_timespec *target_ts =
+                        (struct target_timespec *)target_data;
+                    if (tgt_len != sizeof(struct target_timespec)) {
+                        goto unimplemented;
+                    }
+
+                    __put_user(ts->tv_sec, &target_ts->tv_sec);
+                    __put_user(ts->tv_nsec, &target_ts->tv_nsec);
+                }
+                break;
+            }
+            case SCM_TIMESTAMPING:
+            {
+                int i;
+                struct timespec *ts = (struct timespec *)data;
+                if (len != sizeof(struct timespec[3])) {
+                    goto unimplemented;
+                }
+
+                if (target_uses_timeval64) {
+                    struct target__kernel_timespec *target_ts =
+                        (struct target__kernel_timespec *)target_data;
+                    if (tgt_len != sizeof(struct target__kernel_timespec[3])) {
+                        goto unimplemented;
+                    }
+
+                    for (i = 0; i < 3; ++i) {
+                        __put_user(ts[i].tv_sec, &target_ts[i].tv_sec);
+                        __put_user(ts[i].tv_nsec, &target_ts[i].tv_nsec);
+                    }
+                } else {
+                    struct target_timespec *target_ts =
+                        (struct target_timespec *)target_data;
+                    if (tgt_len != sizeof(struct target_timespec[3])) {
+                        goto unimplemented;
+                    }
+
+                    for (i = 0; i < 3; ++i) {
+                        __put_user(ts[i].tv_sec, &target_ts[i].tv_sec);
+                        __put_user(ts[i].tv_nsec, &target_ts[i].tv_nsec);
+                    }
+                }
+                break;
+            }
             case SCM_CREDENTIALS:
             {
                 struct ucred *cred = (struct ucred *)data;
@@ -2362,6 +2445,18 @@ set_timeout:
                 timestamp_format_is_new = (optname == TARGET_SO_TIMESTAMP_NEW);
                 optname = SO_TIMESTAMP;
                 break;
+        case TARGET_SO_TIMESTAMPNS_OLD:
+        case TARGET_SO_TIMESTAMPNS_NEW:
+                timestamp_format_is_new =
+                    (optname == TARGET_SO_TIMESTAMPNS_NEW);
+                optname = SO_TIMESTAMPNS;
+                break;
+        case TARGET_SO_TIMESTAMPING_OLD:
+        case TARGET_SO_TIMESTAMPING_NEW:
+                timestamp_format_is_new =
+                    (optname == TARGET_SO_TIMESTAMPING_NEW);
+                optname = SO_TIMESTAMPING;
+                break;
         case TARGET_SO_RCVLOWAT:
 		optname = SO_RCVLOWAT;
 		break;
@@ -2374,7 +2469,9 @@ set_timeout:
 	if (get_user_u32(val, optval_addr))
             return -TARGET_EFAULT;
 	ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
-        if (!is_error(ret) && optname == SO_TIMESTAMP) {
+        if (!is_error(ret) &&
+            (optname == SO_TIMESTAMP || optname == SO_TIMESTAMPNS ||
+             optname == SO_TIMESTAMPING)) {
             fd_trans_mark_socket_timestamp_new(sockfd, timestamp_format_is_new);
         }
         break;
@@ -2615,6 +2712,20 @@ get_timeout:
                  (optname == TARGET_SO_TIMESTAMP_NEW));
             optname = SO_TIMESTAMP;
             goto int_case;
+        case TARGET_SO_TIMESTAMPNS_OLD:
+        case TARGET_SO_TIMESTAMPNS_NEW:
+            timestamp_format_matches =
+                (fd_trans_socket_timestamp_new(sockfd) ==
+                 (optname == TARGET_SO_TIMESTAMPNS_NEW));
+            optname = SO_TIMESTAMPNS;
+            goto int_case;
+        case TARGET_SO_TIMESTAMPING_OLD:
+        case TARGET_SO_TIMESTAMPING_NEW:
+            timestamp_format_matches =
+                (fd_trans_socket_timestamp_new(sockfd) ==
+                 (optname == TARGET_SO_TIMESTAMPING_NEW));
+            optname = SO_TIMESTAMPING;
+            goto int_case;
         case TARGET_SO_RCVLOWAT:
             optname = SO_RCVLOWAT;
             goto int_case;
@@ -2639,9 +2750,9 @@ get_timeout:
             return ret;
         if (optname == SO_TYPE) {
             val = host_to_target_sock_type(val);
-        }
-        if (optname == SO_TIMESTAMP) {
-            val = val && timestamp_format_matches;
+        } else if ((optname == SO_TIMESTAMP || optname == SO_TIMESTAMPNS ||
+                    optname == SO_TIMESTAMPING) && !timestamp_format_matches) {
+            val = 0;
         }
         if (len > lv)
             len = lv;
diff --git a/tests/tcg/multiarch/socket_timestamp.c b/tests/tcg/multiarch/socket_timestamp.c
index fd2833e5c8..fe6059226b 100644
--- a/tests/tcg/multiarch/socket_timestamp.c
+++ b/tests/tcg/multiarch/socket_timestamp.c
@@ -1,5 +1,6 @@
 #include <assert.h>
 #include <errno.h>
+#include <linux/net_tstamp.h>
 #include <linux/types.h>
 #include <netinet/in.h>
 #include <stdint.h>
@@ -11,6 +12,7 @@
 #include <sys/time.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <time.h>
 #include <unistd.h>
 
 #ifdef __kernel_old_timeval
@@ -29,6 +31,38 @@ struct kernel_sock_timeval
     int64_t tv_usec;
 };
 
+struct kernel_old_timespec
+{
+    __kernel_long_t tv_sec;
+    long            tv_nsec;
+};
+
+struct kernel_timespec
+{
+    int64_t   tv_sec;
+    long long tv_nsec;
+};
+
+struct scm_timestamping
+{
+    struct timespec ts[3];
+};
+
+struct scm_old_timestamping
+{
+    struct kernel_old_timespec ts[3];
+};
+
+struct scm_timestamping64
+{
+    struct kernel_timespec ts[3];
+};
+
+const int so_timestamping_flags =
+    SOF_TIMESTAMPING_RX_HARDWARE |
+    SOF_TIMESTAMPING_RX_SOFTWARE |
+    SOF_TIMESTAMPING_SOFTWARE;
+
 int create_udp_socket(struct sockaddr_in *sockaddr)
 {
     socklen_t sockaddr_len;
@@ -62,43 +96,47 @@ int create_udp_socket(struct sockaddr_in *sockaddr)
 /* Checks that the timestamp in the message is not after the reception timestamp
  * as well as the reception time is within 10 seconds of the message time.
  */
-void check_timestamp_difference(const struct timeval *msg_tv,
-                                const struct timeval *pkt_tv)
+void check_timestamp_difference(const struct timespec *msg_ts,
+                                const struct timespec *pkt_ts)
 {
-    if (pkt_tv->tv_sec < msg_tv->tv_sec ||
-        (pkt_tv->tv_sec == msg_tv->tv_sec && pkt_tv->tv_usec < msg_tv->tv_usec))
+    if (pkt_ts->tv_sec < msg_ts->tv_sec ||
+        (pkt_ts->tv_sec == msg_ts->tv_sec && pkt_ts->tv_nsec < msg_ts->tv_nsec))
     {
         fprintf(stderr,
-                "Packet received before sent: %lld.%06lld < %lld.%06lld\n",
-                (long long)pkt_tv->tv_sec, (long long)pkt_tv->tv_usec,
-                (long long)msg_tv->tv_sec, (long long)msg_tv->tv_usec);
+                "Packet received before sent: %lld.%06lld < %lld.%09lld\n",
+                (long long)pkt_ts->tv_sec, (long long)pkt_ts->tv_nsec,
+                (long long)msg_ts->tv_sec, (long long)msg_ts->tv_nsec);
         exit(-1);
     }
 
-    if (pkt_tv->tv_sec > msg_tv->tv_sec + 10 ||
-        (pkt_tv->tv_sec == msg_tv->tv_sec + 10 &&
-         pkt_tv->tv_usec > msg_tv->tv_usec)) {
+    if (pkt_ts->tv_sec > msg_ts->tv_sec + 10 ||
+        (pkt_ts->tv_sec == msg_ts->tv_sec + 10 &&
+         pkt_ts->tv_nsec > msg_ts->tv_nsec)) {
         fprintf(stderr,
                 "Packet received more than 10 seconds after sent: "
-                "%lld.%06lld > %lld.%06lld + 10\n",
-                (long long)pkt_tv->tv_sec, (long long)pkt_tv->tv_usec,
-                (long long)msg_tv->tv_sec, (long long)msg_tv->tv_usec);
+                "%lld.%06lld > %lld.%09lld + 10\n",
+                (long long)pkt_ts->tv_sec, (long long)pkt_ts->tv_nsec,
+                (long long)msg_ts->tv_sec, (long long)msg_ts->tv_nsec);
         exit(-1);
     }
 }
 
 void send_current_time(int sock, struct sockaddr_in server_sockaddr)
 {
-    struct timeval tv = {0, 0};
-    gettimeofday(&tv, NULL);
-    sendto(sock, &tv, sizeof(tv), 0, (struct sockaddr *)&server_sockaddr,
+    struct timespec ts = {0, 0};
+    clock_gettime(CLOCK_REALTIME, &ts);
+#ifdef MSG_CONFIRM
+    const int flags = MSG_CONFIRM;
+#else
+    const int flags = 0;
+#endif
+    sendto(sock, &ts, sizeof(ts), flags, (struct sockaddr *)&server_sockaddr,
            sizeof(server_sockaddr));
 }
 
-typedef void (*get_timeval_t)(const struct cmsghdr *cmsg, struct timeval *tv);
-
+typedef void (*get_timespec_t)(const struct cmsghdr *cmsg, struct timespec *tv);
 
-void receive_packet(int sock, get_timeval_t get_timeval)
+void receive_packet(int sock, get_timespec_t get_timespec)
 {
     struct msghdr msg = {0};
 
@@ -106,12 +144,14 @@ void receive_packet(int sock, get_timeval_t get_timeval)
     struct iovec iov;
 
     union {
-        /* 128 bytes should cover all imaginable timeval/timespec*/
+        /* 128 bytes are enough for all existing
+         * timeval/timespec/scm_timestamping structures.
+         */
         char cmsg_buf[CMSG_SPACE(128)];
         struct cmsghdr align;
     } u;
     struct cmsghdr *cmsg;
-    struct timeval msg_tv, pkt_tv;
+    struct timespec msg_ts, pkt_ts;
 
     int res;
 
@@ -126,160 +166,370 @@ void receive_packet(int sock, get_timeval_t get_timeval)
     if ((res = recvmsg(sock, &msg, 0)) < 0) {
         int err = errno;
         fprintf(stderr, "Failed to receive packet: %s\n", strerror(err));
-        exit(-err);
+        exit(err);
     }
 
     assert(res == sizeof(struct timeval));
     assert(iov.iov_base == iobuf);
-    memcpy(&msg_tv, iov.iov_base, sizeof(msg_tv));
-    printf("Message timestamp: %lld.%06lld\n",
-           (long long)msg_tv.tv_sec, (long long)msg_tv.tv_usec);
+    memcpy(&msg_ts, iov.iov_base, sizeof(msg_ts));
+    printf("Message timestamp: %lld.%09lld\n",
+           (long long)msg_ts.tv_sec, (long long)msg_ts.tv_nsec);
 
     cmsg = CMSG_FIRSTHDR(&msg);
     assert(cmsg);
-    (*get_timeval)(cmsg, &pkt_tv);
-    printf("Packet timestamp: %lld.%06lld\n",
-           (long long)pkt_tv.tv_sec, (long long)pkt_tv.tv_usec);
+    (*get_timespec)(cmsg, &pkt_ts);
+    printf("Packet timestamp: %lld.%09lld\n",
+           (long long)pkt_ts.tv_sec, (long long)pkt_ts.tv_nsec);
 
-    check_timestamp_difference(&msg_tv, &pkt_tv);
+    check_timestamp_difference(&msg_ts, &pkt_ts);
 }
 
-void get_timeval_from_so_timestamp(const struct cmsghdr *cmsg,
-                                   struct timeval *tv)
+void get_timespec_from_so_timestamp(const struct cmsghdr *cmsg,
+                                    struct timespec *ts)
 {
+    struct timeval tv;
     assert(cmsg->cmsg_level == SOL_SOCKET);
     assert(cmsg->cmsg_type == SCM_TIMESTAMP);
-    assert(cmsg->cmsg_len >= CMSG_LEN(sizeof(struct timeval)));
-    memcpy(tv, CMSG_DATA(cmsg), sizeof(*tv));
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(tv)));
+
+    memcpy(&tv, CMSG_DATA(cmsg), sizeof(tv));
+    ts->tv_sec = tv.tv_sec;
+    ts->tv_nsec = tv.tv_usec * 1000LL;
 }
 
 #ifdef SO_TIMESTAMP_OLD
-void get_timeval_from_so_timestamp_old(const struct cmsghdr *cmsg,
-                                       struct timeval *tv)
+void get_timespec_from_so_timestamp_old(const struct cmsghdr *cmsg,
+                                        struct timespec *ts)
 {
     struct kernel_old_timeval old_tv;
     assert(cmsg->cmsg_level == SOL_SOCKET);
     assert(cmsg->cmsg_type == SO_TIMESTAMP_OLD);
-    assert(cmsg->cmsg_len >= CMSG_LEN(sizeof(old_tv)));
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(old_tv)));
 
     memcpy(&old_tv, CMSG_DATA(cmsg), sizeof(old_tv));
-    tv->tv_sec = old_tv.tv_sec;
-    tv->tv_usec = old_tv.tv_usec;
+    ts->tv_sec = old_tv.tv_sec;
+    ts->tv_nsec = old_tv.tv_usec * 1000LL;
 }
 
 #ifdef SO_TIMESTAMP_NEW
-void get_timeval_from_so_timestamp_new(const struct cmsghdr *cmsg,
-                                       struct timeval *tv)
+void get_timespec_from_so_timestamp_new(const struct cmsghdr *cmsg,
+                                        struct timespec *ts)
 {
     struct kernel_sock_timeval sock_tv;
     assert(cmsg->cmsg_level == SOL_SOCKET);
     assert(cmsg->cmsg_type == SO_TIMESTAMP_NEW);
-    assert(cmsg->cmsg_len >= CMSG_LEN(sizeof(sock_tv)));
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(sock_tv)));
 
     memcpy(&sock_tv, CMSG_DATA(cmsg), sizeof(sock_tv));
-    tv->tv_sec = sock_tv.tv_sec;
-    tv->tv_usec = sock_tv.tv_usec;
+    ts->tv_sec = sock_tv.tv_sec;
+    ts->tv_nsec = sock_tv.tv_usec * 1000LL;
 }
 #endif /* defined(SO_TIMESTAMP_NEW) */
 #endif /* defined(SO_TIMESTAMP_OLD) */
 
-void set_socket_option(int sock, int sockopt, int on)
+void get_timespec_from_so_timestampns(const struct cmsghdr *cmsg,
+                                      struct timespec *ts)
+{
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SCM_TIMESTAMPNS);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(*ts)));
+
+    memcpy(ts, CMSG_DATA(cmsg), sizeof(*ts));
+}
+
+#ifdef SO_TIMESTAMPNS_OLD
+void get_timespec_from_so_timestampns_old(const struct cmsghdr *cmsg,
+                                          struct timespec *ts)
+{
+    struct kernel_old_timespec old_ts;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SO_TIMESTAMPNS_OLD);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(old_ts)));
+
+    memcpy(&old_ts, CMSG_DATA(cmsg), sizeof(old_ts));
+    ts->tv_sec = old_ts.tv_sec;
+    ts->tv_nsec = old_ts.tv_nsec;
+}
+
+#ifdef SO_TIMESTAMPNS_NEW
+void get_timespec_from_so_timestampns_new(const struct cmsghdr *cmsg,
+                                          struct timespec *ts)
+{
+    struct kernel_timespec sock_ts;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SO_TIMESTAMPNS_NEW);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(sock_ts)));
+
+    memcpy(&sock_ts, CMSG_DATA(cmsg), sizeof(sock_ts));
+    ts->tv_sec = sock_ts.tv_sec;
+    ts->tv_nsec = sock_ts.tv_nsec;
+}
+#endif /* defined(SO_TIMESTAMPNS_NEW) */
+#endif /* defined(SO_TIMESTAMPNS_OLD) */
+
+void get_timespec_from_so_timestamping(const struct cmsghdr *cmsg,
+                                       struct timespec *ts)
+{
+    int i;
+    struct scm_timestamping tss;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SCM_TIMESTAMPING);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(tss)));
+
+    memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
+
+    for (i = 0; i < 3; ++i) {
+        if (tss.ts[i].tv_sec || tss.ts[i].tv_nsec) {
+            *ts = tss.ts[i];
+            return;
+        }
+    }
+    assert(!"All three entries in scm_timestamping are empty");
+}
+
+#ifdef SO_TIMESTAMPING_OLD
+void get_timespec_from_so_timestamping_old(const struct cmsghdr *cmsg,
+                                           struct timespec *ts)
+{
+    int i;
+    struct scm_old_timestamping tss;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SO_TIMESTAMPING_OLD);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(tss)));
+
+    memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
+
+    for (i = 0; i < 3; ++i) {
+        if (tss.ts[i].tv_sec || tss.ts[i].tv_nsec) {
+            ts->tv_sec = tss.ts[i].tv_sec;
+            ts->tv_nsec = tss.ts[i].tv_nsec;
+            return;
+        }
+    }
+    assert(!"All three entries in scm_old_timestamping are empty");
+}
+
+#ifdef SO_TIMESTAMPING_NEW
+void get_timespec_from_so_timestamping_new(const struct cmsghdr *cmsg,
+                                           struct timespec *ts)
+{
+    int i;
+    struct scm_timestamping64 tss;
+    assert(cmsg->cmsg_level == SOL_SOCKET);
+    assert(cmsg->cmsg_type == SO_TIMESTAMPING_NEW);
+    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(tss)));
+
+    memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
+    for (i = 0; i < 3; ++i) {
+        if (tss.ts[i].tv_sec || tss.ts[i].tv_nsec) {
+            ts->tv_sec = tss.ts[i].tv_sec;
+            ts->tv_nsec = tss.ts[i].tv_nsec;
+            return;
+        }
+    }
+    assert(!"All three entries in scm_timestamp64 are empty");
+}
+#endif /* defined(SO_TIMESTAMPING_NEW) */
+#endif /* defined(SO_TIMESTAMPING_OLD) */
+
+void set_socket_option(int sock, int sockopt, int set_to)
 {
     socklen_t len;
-    int val = on;
+    int val = set_to;
     if (setsockopt(sock, SOL_SOCKET, sockopt, &val, sizeof(val)) < 0) {
         int err = errno;
-        fprintf(stderr, "Failed to setsockopt %d (%s): %s\n",
-                sockopt, on ? "on" : "off", strerror(err));
+        fprintf(stderr, "Failed at setsockopt(%d, SOL_SOCKET, %d, %d): %s\n",
+                sock, sockopt, set_to, strerror(err));
         exit(err);
     }
 
+#ifdef SO_TIMESTAMPING_NEW
+    if (sockopt == SO_TIMESTAMPING_NEW) {
+        /* `getsockopt(sock, SOL_SOCKET, SO_TIMESTAMPING_NEW)` not implemented
+         * as of linux kernel v5.8-rc4.
+         */
+        return;
+    }
+#endif
+
     len = sizeof(val);
     val = -1;
     if (getsockopt(sock, SOL_SOCKET, sockopt, &val, &len) < 0) {
         int err = errno;
-        fprintf(stderr, "Failed to getsockopt (%d): %s\n", sock, strerror(err));
+        fprintf(stderr, "Failed at getsockopt(%d, SOL_SOCKET, %d): %s\n",
+                sock, sockopt, strerror(err));
         exit(err);
     }
     assert(len == sizeof(val));
-    assert(val == on);
+    assert(val == set_to);
+}
+
+void child_steps(int sock, struct sockaddr_in addr, int run_old)
+{
+    /* Test 1: SO_TIMESTAMP */
+    send_current_time(sock, addr);
+
+    /* Test 2: SO_TIMESTAMPNS */
+    printf("Test 2: SO_TIMESTAMPNS\n");
+    set_socket_option(sock, SO_TIMESTAMPNS, 1);
+    receive_packet(sock, &get_timespec_from_so_timestampns);
+    set_socket_option(sock, SO_TIMESTAMPNS, 0);
+
+    /* Test 3: SO_TIMESTAMPING */
+    send_current_time(sock, addr);
+
+    if (!run_old) {
+        return;
+    }
+
+#ifdef SO_TIMESTAMP_OLD
+    if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
+        /* Test 4a: SO_TIMESTAMP_OLD */
+        printf("Test 4a: SO_TIMESTAMP_OLD\n");
+        set_socket_option(sock, SO_TIMESTAMP_OLD, 1);
+        receive_packet(sock, &get_timespec_from_so_timestamp_old);
+        set_socket_option(sock, SO_TIMESTAMP_OLD, 0);
+    }
+#ifdef SO_TIMESTAMP_NEW
+    else {
+        /* Test 4b: SO_TIMESTAMP_NEW */
+        printf("Test 4b: SO_TIMESTAMP_NEW\n");
+        set_socket_option(sock, SO_TIMESTAMP_NEW, 1);
+        receive_packet(sock, &get_timespec_from_so_timestamp_new);
+        set_socket_option(sock, SO_TIMESTAMP_NEW, 0);
+    }
+#endif /* defined(SO_TIMESTAMP_NEW) */
+#endif /* defined(SO_TIMESTAMP_OLD) */
+
+#ifdef SO_TIMESTAMPNS_OLD
+    if (SO_TIMESTAMPNS_OLD != SO_TIMESTAMPNS) {
+        /* Test 5a: SO_TIMESTAMPNS_OLD */
+        send_current_time(sock, addr);
+    }
+#ifdef SO_TIMESTAMPNS_NEW
+    else {
+        /* Test 5b: SO_TIMESTAMPNS_NEW */
+        send_current_time(sock, addr);
+    }
+#endif /* defined(SO_TIMESTAMPNS_NEW) */
+#endif /* defined(SO_TIMESTAMPNS_OLD) */
+
+#ifdef SO_TIMESTAMPING_OLD
+    if (SO_TIMESTAMPING_OLD != SO_TIMESTAMPING) {
+        /* Test 6a: SO_TIMESTAMPING_OLD */
+        printf("Test 6a: SO_TIMESTAMPING_OLD\n");
+        set_socket_option(sock, SO_TIMESTAMPING_OLD, so_timestamping_flags);
+        receive_packet(sock, &get_timespec_from_so_timestamping_old);
+        set_socket_option(sock, SO_TIMESTAMPING_OLD, 0);
+    }
+#ifdef SO_TIMESTAMPING_NEW
+    else {
+        /* Test 6b: SO_TIMESTAMPING_NEW */
+        printf("Test 6b: SO_TIMESTAMPING_NEW\n");
+        set_socket_option(sock, SO_TIMESTAMPING_NEW, so_timestamping_flags);
+        receive_packet(sock, &get_timespec_from_so_timestamping_new);
+        set_socket_option(sock, SO_TIMESTAMPING_NEW, 0);
+    }
+#endif /* defined(SO_TIMESTAMPING_NEW) */
+#endif /* defined(SO_TIMESTAMPING_OLD) */
+}
+
+void parent_steps(int sock, struct sockaddr_in addr, int run_old)
+{
+    /* Test 1: SO_TIMESTAMP */
+    printf("Test 1: SO_TIMESTAMP\n");
+    set_socket_option(sock, SO_TIMESTAMP, 1);
+    receive_packet(sock, &get_timespec_from_so_timestamp);
+    set_socket_option(sock, SO_TIMESTAMP, 0);
+
+    /* Test 2: SO_TIMESTAMPNS */
+    send_current_time(sock, addr);
+
+    /* Test 3: SO_TIMESTAMPING */
+    printf("Test 3: SO_TIMESTAMPING\n");
+    set_socket_option(sock, SO_TIMESTAMPING, so_timestamping_flags);
+    receive_packet(sock, &get_timespec_from_so_timestamping);
+    set_socket_option(sock, SO_TIMESTAMPING, 0);
+
+    if (!run_old) {
+        return;
+    }
+
+#ifdef SO_TIMESTAMP_OLD
+    if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
+        /* Test 4a: SO_TIMESTAMP_OLD */
+        send_current_time(sock, addr);
+    }
+#ifdef SO_TIMESTAMP_NEW
+    else {
+        /* Test 4b: SO_TIMESTAMP_NEW */
+        send_current_time(sock, addr);
+    }
+#endif /* defined(SO_TIMESTAMP_NEW) */
+#endif /* defined(SO_TIMESTAMP_OLD) */
+
+#ifdef SO_TIMESTAMPNS_OLD
+    if (SO_TIMESTAMPNS_OLD != SO_TIMESTAMPNS) {
+        /* Test 5a: SO_TIMESTAMPNS_OLD */
+        printf("Test 5a: SO_TIMESTAMPNS_OLD\n");
+        set_socket_option(sock, SO_TIMESTAMPNS_OLD, 1);
+        receive_packet(sock, &get_timespec_from_so_timestampns_old);
+        set_socket_option(sock, SO_TIMESTAMPNS_OLD, 0);
+    }
+#ifdef SO_TIMESTAMPNS_NEW
+    else {
+        /* Test 5b: SO_TIMESTAMPNS_NEW */
+        printf("Test 5b: SO_TIMESTAMPNS_NEW\n");
+        set_socket_option(sock, SO_TIMESTAMPNS_NEW, 1);
+        receive_packet(sock, &get_timespec_from_so_timestampns_new);
+        set_socket_option(sock, SO_TIMESTAMPNS_NEW, 0);
+    }
+#endif /* defined(SO_TIMESTAMPNS_NEW) */
+#endif /* defined(SO_TIMESTAMPNS_OLD) */
+
+#ifdef SO_TIMESTAMPING_OLD
+    if (SO_TIMESTAMPING_OLD != SO_TIMESTAMPING) {
+        /* Test 6a: SO_TIMESTAMPING_OLD */
+        send_current_time(sock, addr);
+    }
+#ifdef SO_TIMESTAMPING_NEW
+    else {
+        /* Test 6b: SO_TIMESTAMPING_NEW */
+        send_current_time(sock, addr);
+    }
+#endif /* defined(SO_TIMESTAMPING_NEW) */
+#endif /* defined(SO_TIMESTAMPING_OLD) */
 }
 
 int main(int argc, char **argv)
 {
     int parent_sock, child_sock;
     struct sockaddr_in parent_sockaddr, child_sockaddr;
-    int pid;
+    int pid, run_old;
     struct timeval tv = {0, 0};
     gettimeofday(&tv, NULL);
 
+    /* Too close to y2038 old systems may not work. */
+    run_old = tv.tv_sec < 0x7fffff00;
+
     parent_sock = create_udp_socket(&parent_sockaddr);
     child_sock = create_udp_socket(&child_sockaddr);
 
     printf("Parent sock bound to port %d\nChild sock bound to port %d\n",
            parent_sockaddr.sin_port, child_sockaddr.sin_port);
 
-    if ((pid = fork()) == -2) {
+    if ((pid = fork()) < 0) {
         fprintf(stderr, "SKIPPED. Failed to fork: %s\n", strerror(errno));
     } else if (pid == 0) {
-        close(child_sock);
-
-        /* Test 1: SO_TIMESTAMP */
-        send_current_time(parent_sock, child_sockaddr);
-
-        if (tv.tv_sec > 0x7fffff00) {
-            /* Too close to y2038 problem, old system may not work. */
-            close(parent_sock);
-            return 0;
-        }
-
-#ifdef SO_TIMESTAMP_OLD
-        if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
-            /* Test 2a: SO_TIMESTAMP_OLD */
-            set_socket_option(parent_sock, SO_TIMESTAMP_OLD, 1);
-            receive_packet(parent_sock, &get_timeval_from_so_timestamp_old);
-            set_socket_option(parent_sock, SO_TIMESTAMP_OLD, 0);
-        }
-#ifdef SO_TIMESTAMP_NEW
-        else {
-            /* Test 2b: SO_TIMESTAMP_NEW */
-            set_socket_option(parent_sock, SO_TIMESTAMP_NEW, 1);
-            receive_packet(parent_sock, &get_timeval_from_so_timestamp_new);
-            set_socket_option(parent_sock, SO_TIMESTAMP_NEW, 0);
-        }
-#endif /* defined(SO_TIMESTAMP_NEW) */
-#endif /* defined(SO_TIMESTAMP_OLD) */
-
         close(parent_sock);
+        child_steps(child_sock, parent_sockaddr, run_old);
+        close(child_sock);
     } else {
         int child_status;
-        close(parent_sock);
-
-        /* Test 1: SO_TIMESTAMP */
-        set_socket_option(child_sock, SO_TIMESTAMP, 1);
-        receive_packet(child_sock, &get_timeval_from_so_timestamp);
-        set_socket_option(child_sock, SO_TIMESTAMP, 0);
-
-        if (tv.tv_sec > 0x7fffff00) {
-            /* Too close to y2038 problem, old system may not work. */
-            close(child_sock);
-            return 0;
-        }
-
-#ifdef SO_TIMESTAMP_OLD
-        if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
-            /* Test 2a: SO_TIMESTAMP_OLD */
-            send_current_time(child_sock, parent_sockaddr);
-        }
-#ifdef SO_TIMESTAMP_NEW
-        else {
-            /* Test 2b: SO_TIMESTAMP_NEW */
-            send_current_time(child_sock, parent_sockaddr);
-        }
-#endif /* defined(SO_TIMESTAMP_NEW) */
-#endif /* defined(SO_TIMESTAMP_OLD) */
 
         close(child_sock);
+        parent_steps(parent_sock, child_sockaddr, run_old);
+        close(parent_sock);
 
         if (waitpid(pid, &child_status, 0) < 0) {
             int err = errno;
-- 
2.28.0.rc0.105.gf9edc3c819-goog


