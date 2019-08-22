Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BC5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9A82173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FLu97IIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9A82173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wN1-0000Sd-ST
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53980)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <37yFfXQMKCqASCWGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--scw.bounces.google.com>)
 id 1i0wIE-0003Yj-6L
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <37yFfXQMKCqASCWGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--scw.bounces.google.com>)
 id 1i0wID-0007lg-76
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:14:58 -0400
Received: from mail-yw1-xc4a.google.com ([2607:f8b0:4864:20::c4a]:32942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <37yFfXQMKCqASCWGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--scw.bounces.google.com>)
 id 1i0wID-0007kl-3k
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:14:57 -0400
Received: by mail-yw1-xc4a.google.com with SMTP id j132so5241718ywa.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wjAAokdz+BjWOrP6H30Bj42YsWMqshehdtDNsRq7YK8=;
 b=FLu97IIqMrnv5IXsDnUWMYqmE2u9JgQuy0QfXdtzfgV4ysmf+AA1VmbPVoj1QSV2Zz
 FzNwwwp0/+2qq6ySKXq3oc5/9P42BxZ9gORLXyx/8WOozJAAiM4ofoDt/t6CVKap1xDN
 NPiRsIxtzwihjqLwiW8Q0+IfjqS212ebrrjS1F4ujpjfcWT+xco7a/B8UrtVpnWj85HF
 5ggds/LzOo66jyR2mr1BUYz9LEVhfFX9ttbBhvqAdD0bITADOM8G2lfoig66JFIZNkLM
 aNCFAjYuG0eQ5O95CJhfsn5aLG354pGZU2P1w9YiNCNUf6jK/I/dixFpo8LIESInoAot
 mLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wjAAokdz+BjWOrP6H30Bj42YsWMqshehdtDNsRq7YK8=;
 b=bJwC8XgaYUm6u4sFFL02/XPfBD/8DK+tAO5AOSFnrlX1k7PHzgywwpmCW/ONIiqGbi
 HA6a9YH5AkwO4Ahib+IKvA+g1REnjqgaJL03Rvk1edmLKCc/4AeZXl4Aonwj3olVSA6x
 v64aQl9gmO9m6orOI9vHMbOP7GwHtLAOAkLL3WvHeqms4yIAoyOsW9rWWaDAnNsHYvLu
 yboj+fZPZuWLB3XfoEEZ7VBZk15JXgPHQajYDRJB4A8Hev2iLRHrxfZdwNv6bCR1YzZ9
 VcwUT6ui8QJL/mQyqohuBHUaB/11isKTz3AL31aiJdqmSRrxxm6JyhpSPReHiLVPFuOF
 Z57g==
X-Gm-Message-State: APjAAAWFSySr7QpKp9ZJqSJhv024Gs3HJbxwO85guS9KLl1NHlyifN3F
 BQdfUUUcQlJUFhCKFMIcv3tONxA=
X-Google-Smtp-Source: APXvYqxPS7mnYfHCiNZUyhbutPZ82qHtoLtEtL77YWEGtBS9pzaOLrEC+VB1TNOq35w1Z7+OqQWwwBs=
X-Received: by 2002:a81:4c55:: with SMTP id z82mr1292478ywa.367.1566515695253; 
 Thu, 22 Aug 2019 16:14:55 -0700 (PDT)
Date: Thu, 22 Aug 2019 16:14:42 -0700
In-Reply-To: <20190822231443.172099-1-scw@google.com>
Message-Id: <20190822231443.172099-2-scw@google.com>
Mime-Version: 1.0
References: <20190822231443.172099-1-scw@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c4a
Subject: [Qemu-devel] [PATCH 1/2] linux-user: add missing UDP and IPv6
 setsockopt options
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UDP: SOL_UDP manipulate options at UDP level. All six options currently
defined in linux source include/uapi/linux/udp.h take integer values.

IPv6: IPV6_ADDR_PREFERENCES (RFC5014: Source address selection) was not
supported.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/syscall.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb138d..8dc4255f12 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -49,8 +49,10 @@
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
@@ -1837,7 +1839,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 
     switch(level) {
     case SOL_TCP:
-        /* TCP options all take an 'int' value.  */
+    case SOL_UDP:
+        /* TCP and UDP options all take an 'int' value.  */
         if (optlen < sizeof(uint32_t))
             return -TARGET_EINVAL;
 
@@ -2488,6 +2491,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         case IPV6_RECVDSTOPTS:
         case IPV6_2292DSTOPTS:
         case IPV6_TCLASS:
+        case IPV6_ADDR_PREFERENCES:
 #ifdef IPV6_RECVPATHMTU
         case IPV6_RECVPATHMTU:
 #endif
-- 
2.23.0.187.g17f5b7556c-goog


