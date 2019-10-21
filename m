Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF19206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU09G/Hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF19206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWHi-0004m9-AE
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBZ-0005UX-FS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBX-0003B0-E2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBR-000392-Qg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id p4so13598282wrm.8
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dMQ78h47SvHockU3ttNHy6APkGlBQkuPUPTng3logyU=;
 b=CU09G/Hsz+sEJQ4zDhaleaQtFCLKtZyWf2IxCk2Pd2PpNwBI/PW9odvVSXiKSmoFAl
 DisrriQ/tcL5Ys5WnhhrweMZl1PnUAIUqmzrgMQJmr6U7LU8N6fPLlZKbZTwSeEB0IYr
 bY93wmdotRZoKOBmz6Tun8TlTzMh3Y/t4gtgrnuRSZ+m7TPw6MOYmSMra7U0xFnRyi3u
 AezRa/iTZCSoYeT8rwRUcaZpzdpEId0QrzA5zTOCL4ByMEV2Ej43eaNO2uLkQtquABdR
 stvcLDNr771yn3E6gD3FDI302jyi8E3BCxdrZgua4DBDgijQy7/5ZvbpXg4hQpwTXn1Y
 /6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dMQ78h47SvHockU3ttNHy6APkGlBQkuPUPTng3logyU=;
 b=kF+WrSOsBX39FXQFNl5NxXXvdkaX3n0stD+1x7/a7K/UNF4dCAs/a+55uAyi3yZSjJ
 MnNOgWt73eojNKvcvME9Rl0wS4sgM8sqqiSfyEg8C8LgSINZUmWHG6BFttqyqU6sPuTD
 Fhp2x/bqmT4PdHbYsxsIHcM6EMqj33iyNpMjRA9W2rQ0+PZ6YiLBkOyZyXp9Unp6jQSW
 Sdw347zNiRfpfSfQeI8ghdaoei4QSqd+I7bVZPNAmsqK8PgSR1g9aqYKcHu9rd/TrnNn
 49JbjM11OxCn8vYQVryf1E50MzwYAfmcRDQE6tjZGYnYqLda9rcvvYVMnkiPm6LPqfWb
 TeSA==
X-Gm-Message-State: APjAAAXXdlIumKJ2/YYVaZLiWOwjkTpNMOaX1ifWpYT6aOxrap3vIoxM
 +3y6GOPAc8/MClR67rfpJXLB331c
X-Google-Smtp-Source: APXvYqyOd0DZ4TR3zHbiiTzi2IM9Yd6tWSY7M8I5q95YpamU4jVWm6UZsvz6ADUFWOjShSrAHGOXAA==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr14753989wrx.90.1571658548392; 
 Mon, 21 Oct 2019 04:49:08 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 5/9] linux-user/strace: Dump AF_NETLINK sockaddr content
Date: Mon, 21 Oct 2019 13:48:53 +0200
Message-Id: <20191021114857.20538-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
v8: use tswap32 (lvivier)
---
 linux-user/strace.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index fd5596a640..5fa7748427 100644
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
+                     tswap32(nl->nl_pid), tswap32(nl->nl_groups));
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
2.21.0


