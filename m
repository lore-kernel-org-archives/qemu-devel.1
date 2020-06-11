Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15BE20792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15BE20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQlI-0007fd-1W
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jjQk6-0005Sl-IF; Thu, 11 Jun 2020 13:11:54 -0400
Received: from relay.sw.ru ([185.231.240.75]:35191 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jjQk3-0000qk-6z; Thu, 11 Jun 2020 13:11:54 -0400
Received: from [192.168.15.81] (helo=iris.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jjQjs-0000BN-Ou; Thu, 11 Jun 2020 20:11:40 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] migration/savevm: respect qemu_fclose() error code in
 save_snapshot()
Date: Thu, 11 Jun 2020 20:11:40 +0300
Message-Id: <20200611171143.21589-2-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611171143.21589-1-den@openvz.org>
References: <20200611171143.21589-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 13:11:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_fclose() could return error, f.e. if bdrv_co_flush() will return
the error.

This validation will become more important once we will start waiting of
asynchronous IO operations, started from bdrv_write_vmstate(), which are
coming soon.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c00a6807d9..0ff5bb40ed 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2628,7 +2628,7 @@ int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
-    int ret = -1;
+    int ret = -1, ret2;
     QEMUFile *f;
     int saved_vm_running;
     uint64_t vm_state_size;
@@ -2712,10 +2712,14 @@ int save_snapshot(const char *name, Error **errp)
     }
     ret = qemu_savevm_state(f, errp);
     vm_state_size = qemu_ftell(f);
-    qemu_fclose(f);
+    ret2 = qemu_fclose(f);
     if (ret < 0) {
         goto the_end;
     }
+    if (ret2 < 0) {
+        ret = ret2;
+        goto the_end;
+    }
 
     /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
      * for itself.  BDRV_POLL_WHILE() does not support nested locking because
-- 
2.17.1


