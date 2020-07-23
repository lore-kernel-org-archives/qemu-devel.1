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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F0C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE0720825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3YK6G8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE0720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyOz8-0004w1-JY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mdcYXwMKCqocMgQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--scw.bounces.google.com>)
 id 1jyOxa-0003IE-Cr
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:42 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a]:56802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mdcYXwMKCqocMgQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--scw.bounces.google.com>)
 id 1jyOxY-00023x-Q8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:42 -0400
Received: by mail-pj1-x104a.google.com with SMTP id bf1so2553831pjb.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ctbBC/NYMLK1XfCcEYCD8OdI6LV8mo+P9YBFQVgKJ5U=;
 b=Q3YK6G8oDI3JBQx+iyheBvrCFhZYdAFbmS30i+IFWg4oh6yIHS8CKTFP6LOwCkBlqm
 96o51BE595Ufe6nH/4Nm3+4JW8CIrTQb2PmHQdOE/RBKZW/Ww6179kq0JJC4VRwcAiYb
 XfgeqEYJ8XphnnLd2ep4SxCbTc/LeuN72HPUvybBaa5fie0R+LmSGxAfHXA99TCFi4Iy
 fOS2ZnXp3bb6tWXVwE/TdHrRjGmwS5td2dyy/vDuuYyu1QrsteSDRYvxQMIK94ct44PQ
 2LYVoJXj5D6oiSaPnpkivkmg1PZDnBMlViT4QhsRXoynGmbdd6PoGeTFNCtgZ7JWwFju
 ONOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ctbBC/NYMLK1XfCcEYCD8OdI6LV8mo+P9YBFQVgKJ5U=;
 b=rt5DhxCBcVXj7j1zvas+Mt0ymS5pKdG+UDIcfP0G5qWrwroPz4P4stfHL0QD+VnaCx
 gP8Kb69SUeOWE54FpgYF1KEL1qFGXPeSQzjoTnrwlAQ0+L/boKQ9COfZCMtNCtZfI5d3
 Xipq4oTZWdZ4dhSrGCzMGJbncFArp5C/2XAVD4MqlTRcnxZuDUc6SyDJ8UO8iQokBUVe
 A6OZdHwL5Xhtk7g9dqYDfh1tBYm0/X0W1X/i2HmEsSRjLERputmFjQ7iSo/tS+FvjHVM
 hCtjY7PO+ETP4/YcHX5X3tIqLO0X3VPet+K/Vj90meBPOaNKnbm5BPi0oNBY/2GJylyc
 GJ9g==
X-Gm-Message-State: AOAM533F674wFAwtmV6pZVZeDPkgP1QNlKoeylOmsF1D6vdXxxnzhE/C
 Ji3/H0xyuW4I+15GS7ehKnH1tf8hP2NqTHlSeVmApqsxpxHEHtqQqK1eUglvH0IAqkcM9F3Uz53
 DV859g/z3knyo7ps3rmpw/Zo64SMS9LDnp7TDpkqlYUOAFkaAwsaj
X-Google-Smtp-Source: ABdhPJwjbAUPLhV25hadu9tIOhLPpz5jcJFZ7KBMsDlHx7mgdC35KAsIZUeQPBBjCGoOQ2NhF3VwPEM=
X-Received: by 2002:a17:90a:a0a:: with SMTP id
 o10mr1748722pjo.12.1595463577481; 
 Wed, 22 Jul 2020 17:19:37 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:19:11 -0700
In-Reply-To: <cover.1595461447.git.scw@google.com>
Message-Id: <e4d84c6aad51e8f378bd1b3f039412567a25dbe9.1595461447.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595461447.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 2/6] linux-user: add missing UDP and IPv6 get/setsockopt
 options
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3mdcYXwMKCqocMgQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--scw.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

UDP: SOL_UDP manipulate options at UDP level. All six options currently
defined in linux source include/uapi/linux/udp.h take integer values.

IPv6: IPV6_ADDR_PREFERENCES (RFC5014: Source address selection) was not
supported.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/syscall.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f97337b0b4..a53db446d4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -51,8 +51,10 @@
 #include <sys/sysinfo.h>
 #include <sys/signalfd.h>
 //#include <sys/user.h>
+#include <netinet/in.h>
 #include <netinet/ip.h>
 #include <netinet/tcp.h>
+#include <netinet/udp.h>
 #include <linux/wireless.h>
 #include <linux/icmp.h>
 #include <linux/icmpv6.h>
@@ -1945,7 +1947,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 
     switch(level) {
     case SOL_TCP:
-        /* TCP options all take an 'int' value.  */
+    case SOL_UDP:
+        /* TCP and UDP options all take an 'int' value.  */
         if (optlen < sizeof(uint32_t))
             return -TARGET_EINVAL;
 
@@ -2031,6 +2034,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_RECVDSTOPTS:
         case IPV6_2292DSTOPTS:
         case IPV6_TCLASS:
+        case IPV6_ADDR_PREFERENCES:
 #ifdef IPV6_RECVPATHMTU
         case IPV6_RECVPATHMTU:
 #endif
@@ -2593,7 +2597,8 @@ get_timeout:
         }
         break;
     case SOL_TCP:
-        /* TCP options all take an 'int' value.  */
+    case SOL_UDP:
+        /* TCP and UDP options all take an 'int' value.  */
     int_case:
         if (get_user_u32(len, optlen))
             return -TARGET_EFAULT;
@@ -2684,6 +2689,7 @@ get_timeout:
         case IPV6_RECVDSTOPTS:
         case IPV6_2292DSTOPTS:
         case IPV6_TCLASS:
+        case IPV6_ADDR_PREFERENCES:
 #ifdef IPV6_RECVPATHMTU
         case IPV6_RECVPATHMTU:
 #endif
-- 
2.28.0.rc0.105.gf9edc3c819-goog


