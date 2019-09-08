Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D25BC4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4DC206A1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrd6Gd2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4DC206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qZE-0000NC-DG
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUL-0002of-Gl
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUK-0002Sh-7r
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUK-0002SN-09
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so629419wrx.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zL+JGwTWbnruC6Rrb4bH9cT15d2BHUEa74MGadYA6l0=;
 b=Qrd6Gd2VsZhA4NLFMDqfzB8H7aJ2M6O4ciHlD0UxvrgvsSSBel+BMWWbTfldetY5jr
 6Yem9g+Fl0GlM2AsM60Qh+6BWsgrygoAiNiwp62UwSt6v3U6tZf/0KW7xIAFpF+uxqTL
 RIZ0yILzTzIa67xLboviBfKgTiKkgH2mDQMgeSZ/h5aCxtKSny5QIYMR7x0XADjwPAWL
 N7hHcedsettyw5M3VLIhuezowwtsTp3LMIoK4fnLjUxKI88qHZOsSQT9/80kjWWx0NHs
 RJJM3Sh0R56bnC3KKX47sl6yLlrQFkQeSL7z2VLP9pSNiAhf8z3k4t7KRPeWHSgLSUhy
 /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zL+JGwTWbnruC6Rrb4bH9cT15d2BHUEa74MGadYA6l0=;
 b=lxJdFvnUuj48+Lh1xHohuvF+xd7a3qWjVKgv07VZuyVKYlA1aifwoJdEXbSYi2r216
 VFIifejLUPER5R5EEzq2opiTsW9RIqOf7Stc9X2+ffqmW8FB77lXAGgzNQSP7j6GVe5z
 xiozU/HFF2/eT5WbU7Zg8BO8RZ8LJ2xYULUES/LEDhutd8LPAmrkM4LG85iqee1juay2
 bVJecbM05REenhRD0J/17HCu68dCDzpWbMpmujP1ztB9FNEAA8c7NqoBmibMK7olC3Q/
 TmfjBTdBDxqqxjwYAb++rkot9yTVYXLHurXIBvn8xLCOLjGbRtUGo4vRPBIfoAafq5rq
 qyFA==
X-Gm-Message-State: APjAAAUM21Z27UZzt0qwkB3bjySJ8C4dqcC3hWjJLtesVCkCPPAPcQOD
 hjk/U3MLC8rA7WpY7yr9GK6IWJ3N
X-Google-Smtp-Source: APXvYqwDv7Fvth0Vg2DcMGmyEFv0ilizpWnbpajZ58gX+Pe8F7B+WnrpSUBXQDbaaF/VMWoBOYUDAQ==
X-Received: by 2002:adf:8b13:: with SMTP id n19mr10555160wra.203.1567923350938; 
 Sat, 07 Sep 2019 23:15:50 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:40 +0200
Message-Id: <20190908061543.25136-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v6 5/8] linux-user/strace: Dump AF_NETLINK
 sockaddr content
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
---
 linux-user/strace.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index dcf843b360..77d7f6a97a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -8,6 +8,7 @@
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
+#include <linux/netlink.h>
 #include <sched.h>
 #include "qemu.h"
 
@@ -398,6 +399,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
             gemu_log("}");
             break;
         }
+        case AF_NETLINK: {
+            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
+            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
+                     nl->nl_pid, nl->nl_groups);
+            break;
+        }
         default:
             gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
             for (i = 0; i < 13; i++) {
@@ -424,6 +431,9 @@ print_socket_domain(int domain)
     case PF_INET:
         gemu_log("PF_INET");
         break;
+    case PF_NETLINK:
+        gemu_log("PF_NETLINK");
+        break;
     case PF_PACKET:
         gemu_log("PF_PACKET");
         break;
@@ -473,6 +483,33 @@ print_socket_protocol(int domain, int type, int protocol)
         return;
     }
 
+    if (domain == PF_NETLINK) {
+        switch (protocol) {
+        case NETLINK_ROUTE:
+            gemu_log("NETLINK_ROUTE");
+            break;
+        case NETLINK_AUDIT:
+            gemu_log("NETLINK_AUDIT");
+            break;
+        case NETLINK_NETFILTER:
+            gemu_log("NETLINK_NETFILTER");
+            break;
+        case NETLINK_KOBJECT_UEVENT:
+            gemu_log("NETLINK_KOBJECT_UEVENT");
+            break;
+        case NETLINK_RDMA:
+            gemu_log("NETLINK_RDMA");
+            break;
+        case NETLINK_CRYPTO:
+            gemu_log("NETLINK_CRYPTO");
+            break;
+        default:
+            gemu_log("%d", protocol);
+            break;
+        }
+        return;
+    }
+
     switch (protocol) {
     case IPPROTO_IP:
         gemu_log("IPPROTO_IP");
-- 
2.20.1


