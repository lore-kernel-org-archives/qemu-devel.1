Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329EDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB04B20774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qA3kiYx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB04B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OS1-0006IL-7g
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3RUQyXwMKCpYI2M6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--scw.bounces.google.com>)
 id 1k5OQ4-0004ug-KZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:00 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:53319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3RUQyXwMKCpYI2M6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--scw.bounces.google.com>)
 id 1k5OQ3-0000kk-1J
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:00 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id d26so15749429yba.20
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=KOl6cq6IjMqpEhD/kHPtyKl8qR4OtmqTxSk98Aj4Ezw=;
 b=qA3kiYx7CMnnRBAOMofzmp6ZPT++yucztp/xlZzbakC5dC8zSvVTtwRBPmPBo99F34
 ++Hm6EF+AKCjzjAErpMW2VyQatr1IlYn2P58vkxsBN80Zs9lUHBF+W2Il1EuI2/mJMg4
 xbJL3MtjsRbXLGvKRkWlRXdwcDFG5M+Ef2Eu4iaq+f0rcI+W3aABIc3WAJT9BvIgs9kX
 bcKYWdf0apz3YPW5yrwj0gFQxb9m3ehW8Fq5SRq4qmkuS01ctEImLHGUENuQio2O4X0O
 dKfBePYgAE56QzVdzRavwYygdM5GOj3lFNg7iRGwwQwnkMCLz9HuElyVrnNohNpV/ZVM
 KW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=KOl6cq6IjMqpEhD/kHPtyKl8qR4OtmqTxSk98Aj4Ezw=;
 b=g0V57tCWa1NctTf8zF2dvCyEZhxWVDecBMiVLqLclPBf7Pp7Dox1ydsk+pJCONs1WD
 m6I71mWu/IWSXrIZWziV75qclS5rY1i/Bd1QSHrSULHnSGAot5bKnH4mkiRKbfWO5pf3
 eUaGPnjcyaUAF9LazzK9v4jbsyJwSR92SDGaI+3VAnobWxpMN8li07Z4O9j3c1fGPGDq
 Z0ubA8oL0U/nyFti1fRvadYLzS4SK4BZVon35gfQTDIJyOfKJcGjVyrTbTdzPr/Dw94p
 bMIqWsJpz0twdhR0h5pQoN4wdNgewY3YcF+bjVtz4nbIJZlx5oM6P3qgHJ3tY5nP1Tup
 ulKQ==
X-Gm-Message-State: AOAM531Ipsa5KXjYF2xkJ0GaNbhxBZQ8yL3qSQmPnnGADkx+b2oJTuPD
 6VsSGiCNC8L/C6PVHo8uIRWXKZrXk6dOkmLRpeV5kn1p524d22yJbc/RYyEHMBNGgHrOQty64rt
 eG57/5O6UCk2ahcXbkgO7q2JWIVYAMjf+cFI+UK2pSc/lxIKO9KP0
X-Google-Smtp-Source: ABdhPJywbTZAZr4pvyFKc4CT+AEyzs28KTLqCHe8wOL1Urxw3v8g5ZU5uYhUch0tPH1IMgjzjt9YnnU=
X-Received: by 2002:a25:83c1:: with SMTP id v1mr44915743ybm.264.1597129797343; 
 Tue, 11 Aug 2020 00:09:57 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:42 -0700
In-Reply-To: <cover.1597129029.git.scw@google.com>
Message-Id: <71ad91e4ee9f41f439086d8f9de60501ad304859.1597129029.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 2/8] linux-user: add missing UDP get/setsockopt option
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3RUQyXwMKCpYI2M6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--scw.bounces.google.com;
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

SOL_UDP manipulate options at UDP level. All six options currently defined
in linux source include/uapi/linux/udp.h take integer values.

Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
v1 -> v2:
  Split out SOL_UDP into own patch.
  Updated do_print_sockopt().

 linux-user/strace.c  | 6 ++++++
 linux-user/syscall.c | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4fff24b880..854b54a2ad 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -7,6 +7,7 @@
 #include <sys/mount.h>
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
+#include <netinet/udp.h>
 #include <linux/if_packet.h>
 #include <linux/netlink.h>
 #include <sched.h>
@@ -2190,6 +2191,11 @@ static void do_print_sockopt(const char *name, abi_long arg1)
         print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
         print_pointer(optval, 0);
         break;
+    case SOL_UDP:
+        qemu_log("SOL_UDP,");
+        print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
+        print_pointer(optval, 0);
+        break;
     case SOL_IP:
         qemu_log("SOL_IP,");
         print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5645862798..177eec5201 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -53,6 +53,7 @@
 //#include <sys/user.h>
 #include <netinet/ip.h>
 #include <netinet/tcp.h>
+#include <netinet/udp.h>
 #include <linux/wireless.h>
 #include <linux/icmp.h>
 #include <linux/icmpv6.h>
@@ -1938,7 +1939,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 
     switch(level) {
     case SOL_TCP:
-        /* TCP options all take an 'int' value.  */
+    case SOL_UDP:
+        /* TCP and UDP options all take an 'int' value.  */
         if (optlen < sizeof(uint32_t))
             return -TARGET_EINVAL;
 
@@ -2586,7 +2588,8 @@ get_timeout:
         }
         break;
     case SOL_TCP:
-        /* TCP options all take an 'int' value.  */
+    case SOL_UDP:
+        /* TCP and UDP options all take an 'int' value.  */
     int_case:
         if (get_user_u32(len, optlen))
             return -TARGET_EFAULT;
-- 
2.28.0.220.ged08abb693-goog


