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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB77C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 23:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5592C2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 23:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uR58oOGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5592C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jykMp-0006aS-JS
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 19:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34hgaXwMKCnsrbvfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--scw.bounces.google.com>)
 id 1jykMB-00064a-MQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 19:10:31 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:46788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34hgaXwMKCnsrbvfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--scw.bounces.google.com>)
 id 1jykM9-0006E1-JN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 19:10:31 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id n141so8182431yba.13
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=fR+9GR4JP+2ZK6TVYrPcjRr9YqzsNSMFZdzugZy/37g=;
 b=uR58oOGNLL+tGU4otw0NY5JSpyE3p+Cg5lVz7vpyroTa3EnTH4wXJoNlX31ZtUqYTs
 nJZVwkTl7qysS9ceqhZmNRxJWxyFbnAa+EWzWVLXTPi/BXf1DvLMBBgEiDpGIiWeBTI8
 lqYoDukXPW7PVYlf6jHWZruL9NI7BZQ6Iak4wBK38OJBI4ai3C5PzYGz24eqlmeAUXGm
 f4omhgCGZ6zqb0EHpslaIhy7kiXpN5u3MiddPywsxx+z7QB3qM7/mEg7bYn9LR4HUa5w
 yTILiEzaYGSEAjX8/dXmPfEpgPemZTvkAXVwRLmjDra6Y0im04m/yV4xz4zmKp/LOyl6
 83hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=fR+9GR4JP+2ZK6TVYrPcjRr9YqzsNSMFZdzugZy/37g=;
 b=VQqjeOqPC0eMhThJa401oavjRnYs3kT5u1qHueTQsDC45mDgfAhYLR6qXNc79FlKAL
 tof9VwBy0Y3E3AhUHnXtKw3M2gX2U64Bm3E1fMfxzLFI6OusMS9yOhLfgda3mtpMgcVR
 XxBw4ys1YxdWkPn828WCgNraknTsyhdMiLAccuZf+Y3657ybqyB38WjJuz+9fXAz7QMz
 c8Ct3xz7MoSh+jmZbyXnjR1HOIIywR+gnrWgio+6yjJcxNNSmOSuNJn+d1D8LAoqSmVF
 O0Ss6nbA5GfEwbN3tCj6Z+cHDWDmyqzIuC1ZZqB9n64W73ePfg+emP3wAPSGGRNnfjIJ
 dsYw==
X-Gm-Message-State: AOAM532FQ6c5oG2FNaaaGHg1uL6jM0evFIJaCZ3YXzZzZKHf48gxW7ZO
 hHLiX++ZZwfnSJbNjk4h0kXH/Es=
X-Google-Smtp-Source: ABdhPJzEwwKoXu9oeRXyty7yqvVtg7LqNobg9SnxAfufMYYfGR2a6oVPbuhbIM8ARywtLmwwKKML0wQ=
X-Received: by 2002:a25:3355:: with SMTP id z82mr6397731ybz.445.1595545826925; 
 Thu, 23 Jul 2020 16:10:26 -0700 (PDT)
Date: Thu, 23 Jul 2020 16:10:20 -0700
Message-Id: <20200723231020.769893-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2] linux-user: Add most IFTUN ioctls
From: Shu-Chun Weng <scw@google.com>
To: laurent@vivier.eu
Cc: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org, riku.voipio@iki.fi, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=34hgaXwMKCnsrbvfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--scw.bounces.google.com;
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

The three options handling `struct sock_fprog` (TUNATTACHFILTER,
TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel
keeps a user space pointer in them which we cannot correctly handle.

Signed-off-by: Josh Kunz <jkz@google.com>
Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v2:
  Title changed from "linux-user: Add several IFTUN ioctls"

  Properly specify the argument types for various options, including a custom
  implementation for TUNSETTXFILTER.

  #ifdef guards for macros introduced up to 5 years ago.

 linux-user/ioctls.h       | 45 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      | 36 +++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h | 32 ++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae1311..b9fb01f558 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -593,3 +593,48 @@
   IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
   IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
 #endif
+
+  IOCTL(TUNSETDEBUG,     IOC_W, TYPE_INT)
+  IOCTL(TUNSETIFF,       IOC_RW, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(TUNSETPERSIST,   IOC_W, TYPE_INT)
+  IOCTL(TUNSETOWNER,     IOC_W, TYPE_INT)
+  IOCTL(TUNSETLINK,      IOC_W, TYPE_INT)
+  IOCTL(TUNSETGROUP,     IOC_W, TYPE_INT)
+  IOCTL(TUNGETFEATURES,  IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETOFFLOAD,   IOC_W, TYPE_LONG)
+  IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,
+                /*
+                 * We can't represent `struct tun_filter` in thunk so leaving
+                 * this empty. do_ioctl_TUNSETTXFILTER will do the conversion.
+                 */
+                TYPE_NULL)
+  IOCTL(TUNGETIFF,       IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(TUNGETSNDBUF,    IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETSNDBUF,    IOC_W, MK_PTR(TYPE_INT))
+  /*
+   * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel keeps a
+   * user pointer in TUNATTACHFILTER, which we are not able to correctly handle.
+   */
+  IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETQUEUE,     IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(TUNSETIFINDEX ,  IOC_W, MK_PTR(TYPE_INT))
+  /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
+  IOCTL(TUNSETVNETLE,    IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(TUNGETVNETLE,    IOC_R, MK_PTR(TYPE_INT))
+#ifdef TUNSETVNETBE
+  IOCTL(TUNSETVNETBE,    IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(TUNGETVNETBE,    IOC_R, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNSETSTEERINGEBPF
+  IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNSETFILTEREBPF
+  IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNSETCARRIER
+  IOCTL(TUNSETCARRIER,   IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNGETDEVNETNS
+  IOCTL(TUNGETDEVNETNS,  IOC_R, TYPE_NULL)
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..7f1efed189 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -56,6 +56,7 @@
 #include <linux/wireless.h>
 #include <linux/icmp.h>
 #include <linux/icmpv6.h>
+#include <linux/if_tun.h>
 #include <linux/errqueue.h>
 #include <linux/random.h>
 #ifdef CONFIG_TIMERFD
@@ -5422,6 +5423,41 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
 
 #endif
 
+static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                        int fd, int cmd, abi_long arg)
+{
+    struct tun_filter *filter = (struct tun_filter *)buf_temp;
+    struct tun_filter *target_filter;
+    char *target_addr;
+
+    assert(ie->access == IOC_W);
+
+    target_filter = lock_user(VERIFY_READ, arg, sizeof(*filter), 1);
+    if (!target_filter) {
+        return -TARGET_EFAULT;
+    }
+    filter->flags = tswap16(target_filter->flags);
+    filter->count = tswap16(target_filter->count);
+    unlock_user(target_filter, arg, sizeof(*filter));
+
+    if (filter->count) {
+        if (sizeof(*filter) + filter->count * ETH_ALEN > MAX_STRUCT_SIZE) {
+            return -TARGET_EFAULT;
+        }
+
+        target_addr = lock_user(VERIFY_READ, arg + sizeof(*filter),
+                                filter->count * ETH_ALEN, 1);
+        if (!target_addr) {
+            return -TARGET_EFAULT;
+        }
+        memcpy(filter->addr, target_addr, filter->count * ETH_ALEN);
+        unlock_user(target_addr, arg + sizeof(*filter),
+                    filter->count * ETH_ALEN);
+    }
+
+    return get_errno(safe_ioctl(fd, ie->host_cmd, filter));
+}
+
 IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..7ef0ff0328 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -891,6 +891,38 @@ struct target_rtc_pll_info {
 
 #define TARGET_SIOCGIWNAME     0x8B01          /* get name == wireless protocol */
 
+/* From <linux/if_tun.h> */
+
+#define TARGET_TUNSETDEBUG        TARGET_IOW('T', 201, int)
+#define TARGET_TUNSETIFF          TARGET_IOW('T', 202, int)
+#define TARGET_TUNSETPERSIST      TARGET_IOW('T', 203, int)
+#define TARGET_TUNSETOWNER        TARGET_IOW('T', 204, int)
+#define TARGET_TUNSETLINK         TARGET_IOW('T', 205, int)
+#define TARGET_TUNSETGROUP        TARGET_IOW('T', 206, int)
+#define TARGET_TUNGETFEATURES     TARGET_IOR('T', 207, unsigned int)
+#define TARGET_TUNSETOFFLOAD      TARGET_IOW('T', 208, unsigned int)
+#define TARGET_TUNSETTXFILTER     TARGET_IOW('T', 209, unsigned int)
+#define TARGET_TUNGETIFF          TARGET_IOR('T', 210, unsigned int)
+#define TARGET_TUNGETSNDBUF       TARGET_IOR('T', 211, int)
+#define TARGET_TUNSETSNDBUF       TARGET_IOW('T', 212, int)
+/*
+ * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel keeps a
+ * user pointer in TUNATTACHFILTER, which we are not able to correctly handle.
+ */
+#define TARGET_TUNGETVNETHDRSZ    TARGET_IOR('T', 215, int)
+#define TARGET_TUNSETVNETHDRSZ    TARGET_IOW('T', 216, int)
+#define TARGET_TUNSETQUEUE        TARGET_IOW('T', 217, int)
+#define TARGET_TUNSETIFINDEX      TARGET_IOW('T', 218, unsigned int)
+/* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
+#define TARGET_TUNSETVNETLE       TARGET_IOW('T', 220, int)
+#define TARGET_TUNGETVNETLE       TARGET_IOR('T', 221, int)
+#define TARGET_TUNSETVNETBE       TARGET_IOW('T', 222, int)
+#define TARGET_TUNGETVNETBE       TARGET_IOR('T', 223, int)
+#define TARGET_TUNSETSTEERINGEBPF TARGET_IOR('T', 224, int)
+#define TARGET_TUNSETFILTEREBPF   TARGET_IOR('T', 225, int)
+#define TARGET_TUNSETCARRIER      TARGET_IOW('T', 226, int)
+#define TARGET_TUNGETDEVNETNS     TARGET_IO('T', 227)
+
 /* From <linux/random.h> */
 
 #define TARGET_RNDGETENTCNT    TARGET_IOR('R', 0x00, int)
-- 
2.28.0.rc0.142.g3c755180ce-goog


