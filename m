Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD0CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A223220862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OADnFkSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A223220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaDy-0007V7-Rv
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 18:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56905)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3gsC4XQMKCtkEFUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--jkz.bounces.google.com>)
 id 1iPaCs-0006nB-9y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3gsC4XQMKCtkEFUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--jkz.bounces.google.com>)
 id 1iPaCq-000814-RG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:43:18 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449]:38705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3gsC4XQMKCtkEFUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--jkz.bounces.google.com>)
 id 1iPaCq-0007zB-Jf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:43:16 -0400
Received: by mail-pf1-x449.google.com with SMTP id d126so105940pfd.5
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=A/zRoxcJ70AtPg9UKjvYmlWZ/iLXm2eSiY11LZdX2fQ=;
 b=OADnFkSzM+AaP45sOyfWcn2zrA+FIXo6oGvu1flE0cKhJBbJM3xs6p9K3onLM9YeoQ
 4GhIyYtgOUkSqHMlCgRp6Q6hlxr97fXd5Pm18krt+z/hwEl0niyqZIDPIiLuC2JoHNmm
 ma9Pr9Dh/f3vU6LEGUyqwDXTkS3w0gGtuE4qEqd8ddwrA6b4ndOkYW//8sbjB3DHZMUG
 xeMxrUCIDDNLV3akAFZ9yeZgm9WBabh6dGQGyBJ1gwt+Xj6WtP/zqNqAykVqMrTj3Kja
 RHsYwCHs1MX8k3NDH4W8n38gQaf8AM3k23+ut6AAqGdGGrmYjpzjDbe0DS8/WrZ6eEN+
 0emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=A/zRoxcJ70AtPg9UKjvYmlWZ/iLXm2eSiY11LZdX2fQ=;
 b=pR2LOusd6TA0qLID/n5OPjsXIuYXW5MUfQCEJCjA6o0+taAfoGDUc/n4iUGPVA+z0H
 Z6ZehdWIE9VQM+cnWIjCd9w1G95bwowTqSYDHvbkrYu1yi2XNfJ4WZjCtRRR0zI4wB+1
 gbgjx4DS1cXlBFqc+WlULxWdXEDNCDPhqRTygmxnRgrR0zjDzysLqNrVCiH3n9Mo6/EX
 +abRdA3pGUSTUZQLXonl94xK6z0Y63BY1ANOUxC4kuCgMwMKPAOjKbP/IgWAI+rAPGv4
 MSmy8UTGyfdok3Q0I94cVSNnB4G2EvejbV4r3Mb/zXe6N8WhshBuD+vSQtsrnoW4Jv0y
 v0mg==
X-Gm-Message-State: APjAAAVbxPrimB4eY8l2zY23mAAdS3rP2XoKUDHAd5Bv+rMF08vssg7D
 4ycjEZbTLGnez91GG7TRleEJHQrO1X1GubxQyvCNQFYYigCe4BmLnWY/ALNkJyK0omXdET9nYVm
 kSNsFDiaPA1v5yVmKfESRQnYDBKOQd2A3KgfwpdIsncqWuHTazk9n
X-Google-Smtp-Source: APXvYqwZmKp434rx2dRdCN78kO8Ia/XAQkIH8AWwDE3Zs6+/0pjiKeL6VIlry/xiNPy2Rx0D8ep96h4=
X-Received: by 2002:a63:5d04:: with SMTP id r4mr30143405pgb.22.1572388994492; 
 Tue, 29 Oct 2019 15:43:14 -0700 (PDT)
Date: Tue, 29 Oct 2019 15:43:10 -0700
Message-Id: <20191029224310.164025-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] linux-user: Support for NETLINK socket options
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::449
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

This change includes support for all AF_NETLINK socket options up to about
kernel version 5.4 (5.4 is not formally released at the time of writing).
Socket options that were introduced in kernel versions before the oldest
currently stable kernel version are guarded by kernel version macros.

This change has been built under gcc 8.3, and clang 9.0, and it passes
`make check`. The netlink options have been tested by emulating some
non-trival software that uses NETLINK socket options, but they have
not been exaustively verified.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 530c843303..cbfb8380a9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2247,6 +2247,38 @@ set_timeout:
             return -TARGET_EFAULT;
 	ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
         break;
+#ifdef SOL_NETLINK
+    case SOL_NETLINK:
+        switch (optname) {
+        case NETLINK_PKTINFO:
+        case NETLINK_ADD_MEMBERSHIP:
+        case NETLINK_DROP_MEMBERSHIP:
+        case NETLINK_BROADCAST_ERROR:
+        case NETLINK_NO_ENOBUFS:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
+        case NETLINK_LISTEN_ALL_NSID:
+        case NETLINK_CAP_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
+        case NETLINK_EXT_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
+        case NETLINK_GET_STRICT_CHK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+            break;
+        default:
+            goto unimplemented;
+        }
+        val = 0;
+        if (optlen < sizeof(uint32_t)) {
+            return -TARGET_EINVAL;
+        }
+        if (get_user_u32(val, optval_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(setsockopt(sockfd, SOL_NETLINK, optname, &val, sizeof(val)));
+        break;
+#endif /* SOL_NETLINK */
     default:
     unimplemented:
         gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
@@ -2531,6 +2563,72 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
             break;
         }
         break;
+#ifdef SOL_NETLINK
+    case SOL_NETLINK:
+        switch (optname) {
+        case NETLINK_PKTINFO:
+        case NETLINK_BROADCAST_ERROR:
+        case NETLINK_NO_ENOBUFS:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
+        case NETLINK_LISTEN_ALL_NSID:
+        case NETLINK_CAP_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
+        case NETLINK_EXT_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
+        case NETLINK_GET_STRICT_CHK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len != sizeof(val)) {
+                return -TARGET_EINVAL;
+            }
+            lv = len;
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+            if (ret < 0) {
+                return ret;
+            }
+            if (put_user_u32(lv, optlen)
+                || put_user_u32(val, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
+        case NETLINK_LIST_MEMBERSHIPS:
+        {
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            uint32_t *results = lock_user(VERIFY_WRITE, optval_addr, len, 1);
+            if (!results) {
+                return -TARGET_EFAULT;
+            }
+            lv = len;
+            ret = get_errno(getsockopt(sockfd, level, optname, results, &lv));
+            if (ret < 0) {
+                unlock_user(results, optval_addr, 0);
+                return ret;
+            }
+            /* swap host endianess to target endianess. */
+            for (int i = 0; i < (len / sizeof(uint32_t)); i++) {
+                results[i] = tswap32(results[i]);
+            }
+            if (put_user_u32(lv, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            unlock_user(results, optval_addr, 0);
+            break;
+        }
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
+        default:
+            goto unimplemented;
+        }
+#endif /* SOL_NETLINK */
     default:
     unimplemented:
         gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-- 
2.24.0.rc0.303.g954a862665-goog


