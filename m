Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA197C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA81221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA81221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP8pf-0006nJ-M9
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 14:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slyfox@gentoo.org>) id 1jP8oS-0006Fi-Hw
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slyfox@gentoo.org>) id 1jP8oQ-0001Xj-Ib
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:00:31 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:36322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slyfox@gentoo.org>) id 1jP8oQ-0001Wt-DJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:00:30 -0400
Received: from sf.home (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net
 [IPv6:2001:470:1f1c:3e6::2])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested) (Authenticated sender: slyfox)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 39A3534F022;
 Thu, 16 Apr 2020 18:00:28 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
 id 9419D5A22061; Thu, 16 Apr 2020 19:00:04 +0100 (BST)
From: Sergei Trofimovich <slyfox@gentoo.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/strace.list: fix epoll_create{,1} -strace output
Date: Thu, 16 Apr 2020 18:59:57 +0100
Message-Id: <20200416175957.1274882-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 140.211.166.183
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Sergei Trofimovich <slyfox@gentoo.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix syscall name and parameters priinter.

Before the change:

```
$ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /t=
mp/a
...
1274697 %s(%d)(2097152,274903156744,274903156760,274905840712,27487790888=
0,274903235616) =3D 3
1274697 exit_group(0)
```

After the change:

```
$ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /t=
mp/a
...
1273719 epoll_create1(2097152) =3D 3
1273719 exit_group(0)
```

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a8..9281c0a758 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -125,10 +125,10 @@
 { TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create
-{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
+{ TARGET_NR_epoll_create, "epoll_create", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create1
-{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
+{ TARGET_NR_epoll_create1, "epoll_create1", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_ctl
 { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
--=20
2.26.1


