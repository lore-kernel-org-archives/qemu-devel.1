Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7F920774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MysnBrix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7F920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OTI-0008Uz-By
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3R0QyXwMKCpgK4O8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--scw.bounces.google.com>)
 id 1k5OQ6-0004x2-NV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:02 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:40277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3R0QyXwMKCpgK4O8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--scw.bounces.google.com>)
 id 1k5OQ5-0000ky-2r
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:02 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id l67so15698188ybb.7
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=+M+uJICEFeg+txNwQtx91pgPQOjSg5KEj10o5w9tEBM=;
 b=MysnBrixrRZSukqLhob985+MpOw8BqS/sOAuzlZetszjKXJeVeDyvsZw+xknOfNyOP
 q+ZjmML36OO/jDlwRvVaKMeEB5M3wCMlrG6x1Qto3VJhQ89U9ixpwzBAnOudmvt4gC+P
 XZJoj/ezaaK1JwV+2+TEkkUqQEXZIJGVybRdrxKOyj9VBkzT1Wn3pCIEk+A7ypL4o2tA
 +UCGxrAklG8sQyJJ2/nuLBlztUMk2z14/lDLDNLd4V505Qymypa1EKNQdwvjSF0FsCq6
 W7n+DkdbYL6IYeh7WrxEbdU7B6y7aXn4QaRaXOs6nTuz+B18v0xNPXCLMrYprzdiySD8
 0YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=+M+uJICEFeg+txNwQtx91pgPQOjSg5KEj10o5w9tEBM=;
 b=QT7Ph7DG4wsMwQ+yZ5DuPkSMa4wQFcgNMkXoLGLmeinpoRDvek9EX6zAiynTAJLRzL
 WNVcCdlWQUALEqNF2jPmapspg72QwE8RX9YGFJyxAr5Tzz/sjpWZDZcwX58qLXkZeAD+
 MckVVgkrJtg1O4VoDXtyEZNkH7tqji5v9j2GKsrCNVpfmJVbCCJwdE17NujIJyaNPK3T
 TOGcyRpbxhhbr3DHYTvqYDt50sSP98TZ6s3yox5NjhEoOErADVrJZ587dJcm8urNGkYV
 HDNunkuwCLuJkdlwnjpFwIcTh8CB2QMB/8kFcTl99K52mDQ4IN50juv1Po4mwU5JdFGA
 GFkw==
X-Gm-Message-State: AOAM53386/PCzo8GlyKjxUDOBLvCBlK5vVvgLjZO4hj1znEcECrpUjVa
 YaLNEVwVYIEBkMLm0hsX29P8CXTVO7JmcuvSiMpYKyjlwzy5k0AVTkS0khfVwmYqEACrw8eBLcS
 bJqSE9/R9yt1ccyttV2bZvD6HMWUWe0Mlt0xBxYHFmCSNP+KN/jH2
X-Google-Smtp-Source: ABdhPJxKoxWeJvLmEYlfgZ6I+Ec6rwkk6fUbiDEfAgQa06x60jxY2qcrMD7vnpI5xcCorHO4slwVVwg=
X-Received: by 2002:a5b:b45:: with SMTP id b5mr45443180ybr.294.1597129799243; 
 Tue, 11 Aug 2020 00:09:59 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:43 -0700
In-Reply-To: <cover.1597129029.git.scw@google.com>
Message-Id: <9a8368ac4b1988dbfb2465a926d769bdc23011a1.1597129029.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 3/8] linux-user: add missing IPv6 get/setsockopt option
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3R0QyXwMKCpgK4O8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--scw.bounces.google.com;
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

IPV6_ADDR_PREFERENCES (RFC5014: Source address selection) was not supported.

Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
v1 -> v2:
  Split out IPV6 options into own patch.
  do_print_sockopt() changes added in a separate patch since a large number of
  unrelated changes are involved.

 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 177eec5201..cda194a7cc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -51,6 +51,7 @@
 #include <sys/sysinfo.h>
 #include <sys/signalfd.h>
 //#include <sys/user.h>
+#include <netinet/in.h>
 #include <netinet/ip.h>
 #include <netinet/tcp.h>
 #include <netinet/udp.h>
@@ -2026,6 +2027,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_RECVDSTOPTS:
         case IPV6_2292DSTOPTS:
         case IPV6_TCLASS:
+        case IPV6_ADDR_PREFERENCES:
 #ifdef IPV6_RECVPATHMTU
         case IPV6_RECVPATHMTU:
 #endif
@@ -2680,6 +2682,7 @@ get_timeout:
         case IPV6_RECVDSTOPTS:
         case IPV6_2292DSTOPTS:
         case IPV6_TCLASS:
+        case IPV6_ADDR_PREFERENCES:
 #ifdef IPV6_RECVPATHMTU
         case IPV6_RECVPATHMTU:
 #endif
-- 
2.28.0.220.ged08abb693-goog


