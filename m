Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C95DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CFD2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMmziBcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CFD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtz6C-0003yM-Gg
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PMcIXwMKCusWXmTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jkz.bounces.google.com>)
 id 1jtz5U-0003Wb-U2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:53:37 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:48671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PMcIXwMKCusWXmTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jkz.bounces.google.com>)
 id 1jtz5T-00088R-4M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:53:36 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id i62so6798090ybc.15
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=7Xd0cAZEeRND8Y9NipYmZvGGnX3LVIGNgKJ4By3lC2M=;
 b=uMmziBcyv/SxMy9exLH0+PV2OcUNiilGKiK03N//MM3fT2J7TZ355L08fYnRf5zPa3
 N3xur96TwQnqr0UFPASpAJRTLVYGwZFdovVtXsn8Fmqagq4rRztfzSLVgpVB8HjB5wSj
 /cUSvSWcq4T7UL4g5Sf2zaL4XmmLnjYerkRp4o5pvPYLd2DIL+0+UlXJzT4WgnM+o7gl
 MV4q3SsECjSd6FK8Y6gLKGbV0AfmYgdBKd1H2townNSp9R1uYBUEd3nv8iIX3SJeditd
 oGTIRYvq1NMh7WYVIhHS2t0N0NvjlzL4qENSHjWbUHUyCPkZfiDFWWPODOGn1JA9EAu8
 EICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=7Xd0cAZEeRND8Y9NipYmZvGGnX3LVIGNgKJ4By3lC2M=;
 b=kYWxrrUlqa+IBm6G7+g7App7IZbMxigbN5HKoNkZ4O79EKdFxT/RuXukNR3eKAWwoM
 rR1gH8ceRAfcQB+b39w+e0DKgFuZCIbJiBerufHTJXn1YY/na8fbIFazsI1K6DPe/jJa
 5k/SWNGRIZrK/x99ZEr6DSXwuwQGodkW+1XXzpB6xSj37w4Y7Jq6cNQ6XUioZvjswBmv
 qHgKKSHXqCa+wkdOigpxT3vr9XvSDBbMAOwOkpAoa/xBcq1299no0NrrPS416F+V9OoM
 +cbwe4kamcuqHokhySZ4Vr4EUb2aZgD+Rzzx/DrakEo2aFpwU6WZirM+twcj9SPnP4rn
 irbg==
X-Gm-Message-State: AOAM53004Jf6iiYwxyfbsvR0vU4llOjPREIPmdW6nKJn+ulI+XIMJh1X
 DpTnlXGTvrK7WCeSqAKctYe51STheY8mBAtZVPxhuIfVgx2KQJlFQCpebhGg3RpWbELN9kyC6j5
 z5MiMIPb9c7X6zXygxYH47HFYXqrJJuLmomCm0fax848A1t4dbmET
X-Google-Smtp-Source: ABdhPJx2WeoqyhUeaORuyA5+AsBfiIwFw03pfZykV45sGQcL70pOXDfU+CCOJEetv4OblIytIK2MMwQ=
X-Received: by 2002:a25:a121:: with SMTP id z30mr22952004ybh.408.1594410812606; 
 Fri, 10 Jul 2020 12:53:32 -0700 (PDT)
Date: Fri, 10 Jul 2020 12:53:28 -0700
Message-Id: <20200710195328.587462-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] linux-user: Add several IFTUN ioctls
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3PMcIXwMKCusWXmTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jkz.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

This change includes most widely-available if_tun ioctls that are
integer typed.

Tested by compiling all linux-user emulators. This patch has also been
used successfully to run several binaries that utilize these ioctls for
several months.

Linux Header:
https://github.com/torvalds/linux/blob/dcde237b9b0eb1d19306e6f48c0a4e058907619f/include/uapi/linux/if_tun.h#L31

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/ioctls.h       | 20 ++++++++++++++++++++
 linux-user/syscall.c      |  1 +
 linux-user/syscall_defs.h | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae1311..9b4a67fe84 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -593,3 +593,23 @@
   IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
   IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
 #endif
+
+  IOCTL(TUNGETFEATURES  , IOC_R , TYPE_INT)
+  IOCTL(TUNGETIFF       , IOC_R , TYPE_INT)
+  IOCTL(TUNGETSNDBUF    , IOC_R , TYPE_INT)
+  IOCTL(TUNGETVNETHDRSZ , IOC_R , TYPE_INT)
+  IOCTL(TUNGETVNETLE    , IOC_R , TYPE_INT)
+  IOCTL(TUNSETDEBUG     , IOC_W , TYPE_INT)
+  IOCTL(TUNSETGROUP     , IOC_W , TYPE_INT)
+  IOCTL(TUNSETIFF       , IOC_W , TYPE_INT)
+  IOCTL(TUNSETIFINDEX   , IOC_W , TYPE_INT)
+  IOCTL(TUNSETLINK      , IOC_W , TYPE_INT)
+  IOCTL(TUNSETNOCSUM    , IOC_W , TYPE_INT)
+  IOCTL(TUNSETOFFLOAD   , IOC_W , TYPE_INT)
+  IOCTL(TUNSETOWNER     , IOC_W , TYPE_INT)
+  IOCTL(TUNSETPERSIST   , IOC_W , TYPE_INT)
+  IOCTL(TUNSETQUEUE     , IOC_W , TYPE_INT)
+  IOCTL(TUNSETSNDBUF    , IOC_W , TYPE_INT)
+  IOCTL(TUNSETTXFILTER  , IOC_W , TYPE_INT)
+  IOCTL(TUNSETVNETHDRSZ , IOC_W , TYPE_INT)
+  IOCTL(TUNSETVNETLE    , IOC_W , TYPE_INT)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 98ea86ca81..4ad4b36a84 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -58,6 +58,7 @@
 #include <linux/icmpv6.h>
 #include <linux/errqueue.h>
 #include <linux/random.h>
+#include <linux/if_tun.h>
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..833ef68faf 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -859,6 +859,27 @@ struct target_rtc_pll_info {
 #define TARGET_SIOCSIFPFLAGS   0x8934          /* set extended flags          */
 #define TARGET_SIOCGIFPFLAGS   0x8935          /* get extended flags          */
 
+/* if_tun ioctls */
+#define TARGET_TUNGETFEATURES   TARGET_IOR('T', 207, unsigned int)
+#define TARGET_TUNGETIFF        TARGET_IOR('T', 210, unsigned int)
+#define TARGET_TUNGETSNDBUF     TARGET_IOR('T', 211, int)
+#define TARGET_TUNGETVNETHDRSZ  TARGET_IOR('T', 215, int)
+#define TARGET_TUNGETVNETLE     TARGET_IOR('T', 221, int)
+#define TARGET_TUNSETDEBUG      TARGET_IOW('T', 201, int)
+#define TARGET_TUNSETGROUP      TARGET_IOW('T', 206, int)
+#define TARGET_TUNSETIFF        TARGET_IOW('T', 202, int)
+#define TARGET_TUNSETIFINDEX    TARGET_IOW('T', 218, unsigned int)
+#define TARGET_TUNSETLINK       TARGET_IOW('T', 205, int)
+#define TARGET_TUNSETNOCSUM     TARGET_IOW('T', 200, int)
+#define TARGET_TUNSETOFFLOAD    TARGET_IOW('T', 208, unsigned int)
+#define TARGET_TUNSETOWNER      TARGET_IOW('T', 204, int)
+#define TARGET_TUNSETPERSIST    TARGET_IOW('T', 203, int)
+#define TARGET_TUNSETQUEUE      TARGET_IOW('T', 217, int)
+#define TARGET_TUNSETSNDBUF     TARGET_IOW('T', 212, int)
+#define TARGET_TUNSETTXFILTER   TARGET_IOW('T', 209, unsigned int)
+#define TARGET_TUNSETVNETHDRSZ  TARGET_IOW('T', 216, int)
+#define TARGET_TUNSETVNETLE     TARGET_IOW('T', 220, int)
+
 /* Bridging control calls */
 #define TARGET_SIOCGIFBR       0x8940          /* Bridging support             */
 #define TARGET_SIOCSIFBR       0x8941          /* Set bridging options         */
-- 
2.27.0.383.g050319c2ae-goog


