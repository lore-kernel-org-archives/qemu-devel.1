Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E0C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCCA20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCCA20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haI47-0004N9-VR
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1haI1P-0002nQ-Ql
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 06:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1haI1O-00070A-Tb
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 06:59:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:55742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1haI1O-0006xp-LA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 06:59:26 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1haI1I-0002bD-VK; Mon, 10 Jun 2019 13:59:21 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: dgilbert@redhat.com,
	armbru@redhat.com
Date: Mon, 10 Jun 2019 13:59:06 +0300
Message-Id: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] monitor: increase amount of data for monitor
 to read
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
Cc: qemu-devel@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now QMP and HMP monitors read 1 byte at a time from the socket, which
is very inefficient. With 100+ VMs on the host this easily reasults in
a lot of unnecessary system calls and CPU usage in the system.

This patch changes the amount of data to read to 4096 bytes, which matches
buffer size on the channel level. Fortunately, monitor protocol is
synchronous right now thus we should not face side effects in reality.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/monitor/monitor.h | 2 +-
 monitor.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..afa1ed34a4 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -14,7 +14,7 @@ extern __thread Monitor *cur_mon;
 #define MONITOR_USE_CONTROL   0x04
 #define MONITOR_USE_PRETTY    0x08
 
-#define QMP_REQ_QUEUE_LEN_MAX 8
+#define QMP_REQ_QUEUE_LEN_MAX 4096
 
 bool monitor_cur_is_qmp(void);
 
diff --git a/monitor.c b/monitor.c
index 4807bbe811..a08e020b61 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4097,7 +4097,7 @@ static int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return !atomic_mb_read(&mon->suspend_cnt);
+    return !atomic_mb_read(&mon->suspend_cnt) ? 4096 : 0;
 }
 
 /*
-- 
2.17.0


