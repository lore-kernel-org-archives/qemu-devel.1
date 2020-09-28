Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2859C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D7420774
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D7420774
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt61-0002Wn-Gq
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsn9-0005L9-2C; Mon, 28 Sep 2020 09:02:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:58840 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsn7-0000SJ-13; Mon, 28 Sep 2020 09:02:06 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsmY-001tba-Fm; Mon, 28 Sep 2020 16:01:30 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v9 4/9] copy-on-read: pass base node name to COR driver
Date: Mon, 28 Sep 2020 15:59:56 +0300
Message-Id: <1601298001-774096-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:00:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

To limit the guest's COR operations by the base node in the backing
chain during stream job, pass the base node name to the copy-on-read
driver. The rest of the functionality will be implemented in the patch
that follows.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 3c8231f..e04092f 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -24,19 +24,23 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "block/copy-on-read.h"
 
 
 typedef struct BDRVStateCOR {
     bool active;
+    BlockDriverState *base_bs;
 } BDRVStateCOR;
 
 
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
+    BlockDriverState *base_bs = NULL;
     BDRVStateCOR *state = bs->opaque;
+    const char *base_node = qdict_get_try_str(options, "base");
 
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
@@ -52,7 +56,16 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
 
+    if (base_node) {
+        qdict_del(options, "base");
+        base_bs = bdrv_lookup_bs(NULL, base_node, errp);
+        if (!base_bs) {
+            error_setg(errp, QERR_BASE_NOT_FOUND, base_node);
+            return -EINVAL;
+        }
+    }
     state->active = true;
+    state->base_bs = base_bs;
 
     /*
      * We don't need to call bdrv_child_refresh_perms() now as the permissions
-- 
1.8.3.1


