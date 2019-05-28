Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D92CC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ED220665
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ED220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdx0-0000zx-Gb
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 11:23:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hVduN-00081O-Cz
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hVduJ-0007Dg-Mz
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:20:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangjie88@huawei.com>)
	id 1hVduF-00077A-FD; Tue, 28 May 2019 11:20:52 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
	by Forcepoint Email with ESMTP id 389D1F8DA7F8016F141F;
	Tue, 28 May 2019 23:20:40 +0800 (CST)
Received: from localhost.localdomain (10.175.104.211) by
	dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server
	id 14.3.439.0; Tue, 28 May 2019 23:20:30 +0800
From: Jie Wang <wangjie88@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
Date: Tue, 28 May 2019 21:06:36 +0800
Message-ID: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.211]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.188
Subject: [Qemu-devel] [PATCH] pr-manager-helper: fix pr process been killed
 when reconectting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, eric.fangyi@huawei.com, wangjie88@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

if pr-helper been killed and qemu send disconnect event to libvirt
and libvirt started a new pr-helper process, the new pr-heleper
been killed again when qemu is connectting to the new pr-helper,
qemu will never send disconnect to libvirt, and libvirt will never
receive connected event.

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 scsi/pr-manager-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 438380fced..b7341b8f47 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -120,6 +120,7 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
     if (local_err) {
         object_unref(OBJECT(sioc));
         error_propagate(errp, local_err);
+        pr_manager_send_status_changed_event(pr_mgr);
         return -ENOTCONN;
     }
 
-- 
2.16.2.windows.1


