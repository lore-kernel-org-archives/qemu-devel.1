Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3BC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B988C2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KnYrEkAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B988C2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGg70-0001IR-V6
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oobitots@cisco.com>) id 1jGg6M-0000iS-LS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oobitots@cisco.com>) id 1jGg6K-0006L1-0S
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:44:00 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:18492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oobitots@cisco.com>) id 1jGg6J-0006Jm-Nt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=683; q=dns/txt; s=iport;
 t=1585043039; x=1586252639;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tStCHiIBtEshSdvz7dj1+vw99TrZyA4ZlgZVySuhRvs=;
 b=KnYrEkAY1Xylx58b/+V3j8CGY8Q39yNKg+U9oY2wJ/XjMoey1hqI1xME
 KYg2cYuflnTbeC7VwBnPyLy1mD0jsDKI3MwVmiYXw1bla/cqgbnt0nin6
 lifHPiXhWKrqCfYYzyC9ARz7WJkYnaqKEwVFeB2yYjvqzwNFteBc+dizA s=;
X-IronPort-AV: E=Sophos;i="5.72,299,1580774400"; d="scan'208";a="452215138"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
 by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 24 Mar 2020 09:43:58 +0000
Received: from sjc-ads-4584.cisco.com (sjc-ads-4584.cisco.com [10.28.38.104])
 by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id
 02O9hvuM028405; Tue, 24 Mar 2020 09:43:57 GMT
Received: by sjc-ads-4584.cisco.com (Postfix, from userid 500841)
 id 7A28F1391; Tue, 24 Mar 2020 02:43:57 -0700 (PDT)
From: Oleksiy Obitotskyy <oobitots@cisco.com>
To: qemu-devel@nongnu.org
Cc: Oleksiy Obitotskyy <oobitots@cisco.com>
Subject: [PATCH] qemu: Do not include file if not exists
Date: Tue, 24 Mar 2020 02:43:40 -0700
Message-Id: <20200324094340.4344-1-oobitots@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.28.38.104, sjc-ads-4584.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 173.37.142.94
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

Script configure checks for if_alg.h and check failed but
if_alg.h still included.

Upstream-Status: Submitted [<oobitots@cisco.com>]
Signed-off-by: Oleksiy Obitotskyy <oobitots@cisco.com>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 35f4146662..819774af0d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -109,7 +109,9 @@
 #include <linux/blkpg.h>
 #include <netpacket/packet.h>
 #include <linux/netlink.h>
+#if defined(CONFIG_AF_ALG)
 #include <linux/if_alg.h>
+#endif
 #include <linux/rtc.h>
 #include <sound/asound.h>
 #include "linux_loop.h"
-- 
2.19.1


