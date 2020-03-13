Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA814C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8171920409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8171920409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCezR-0003D0-NH
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 03:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jCeyq-0002oS-Fn
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jCeyp-0000XW-8A
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:43:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55050 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jCeyo-000083-Sw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:43:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1115275C35D31BE7AA87;
 Fri, 13 Mar 2020 15:43:29 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Mar 2020 15:43:22 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>, <berrange@redhat.com>, <ehabkost@redhat.com>
Subject: [PATCH] qom-qmp-cmds: remove unnecessary alloc in qmp_object_add to
 fix memleak
Date: Fri, 13 Mar 2020 15:58:58 +0800
Message-ID: <20200313075858.15860-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In qmp_object_add(), user_creatable_add_type() may set errp with some error message and
return NULL. In this case, qmp_object_add() still alloc memory to *ret_data which return
to the caller and causes a memory leak.

This patch do this alloc() action only if obj is not NULL to fix it. And initialize ret_data
in xen-block to avoid a possible uninitialized error.

The Leak stack:
Direct leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7f6106ce5970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f6105e6a49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55d2c58c17fd in qdict_new /mnt/sdb/qemu-new/qemu_test/qemu/qobject/qdict.c:29
    #3 0x55d2c53a0051 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qmp-cmds.c:291
    #4 0x55d2c57b47da in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:132
    #5 0x55d2c57b47da in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:175
    #6 0x55d2c52f1430 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:145
    #7 0x55d2c52f3087 in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:234
    #8 0x55d2c58e6153 in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/util/async.c:136

Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/xen-block.c | 2 +-
 qom/qom-qmp-cmds.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 3885464513..041866b846 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -860,7 +860,7 @@ static XenBlockIOThread *xen_block_iothread_create(const char *id,
     XenBlockIOThread *iothread = g_new(XenBlockIOThread, 1);
     Error *local_err = NULL;
     QDict *opts;
-    QObject *ret_data;
+    QObject *ret_data = NULL;
 
     iothread->id = g_strdup(id);
 
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 435193b036..6bd137ccbf 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp)
     visit_free(v);
     if (obj) {
         object_unref(obj);
+        *ret_data = QOBJECT(qdict_new());
     }
-    *ret_data = QOBJECT(qdict_new());
 }
 
 void qmp_object_del(const char *id, Error **errp)
-- 
2.18.2


