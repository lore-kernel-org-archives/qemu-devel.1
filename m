Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B24C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831C6207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831C6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8cQ-0006Ec-M7
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 16:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jb8bf-0004Jq-4o
 for qemu-devel@nongnu.org; Tue, 19 May 2020 16:12:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:59953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jb8be-0008A4-1q
 for qemu-devel@nongnu.org; Tue, 19 May 2020 16:12:54 -0400
IronPort-SDR: nCN07tMGBimySkUeawXcH3VMuRIVB4342j8O8VFn8WSB3AEJVgha4BwdzVMlf8mEUM4pT4LI1F
 yc5UPbV68KEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 13:12:50 -0700
IronPort-SDR: gd48eiiwx+sIarx8zolZMyzpCNnpFK8mBej0mMgIdFGf55DV90WpKRjUIGcvqfqVX05YKvYyZo
 2PLcgXSKEDXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; d="scan'208";a="268007885"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga006.jf.intel.com with ESMTP; 19 May 2020 13:12:48 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 6/7] net/colo-compare.c,
 softmmu/vl.c: Check that colo-compare is active
Date: Wed, 20 May 2020 04:02:06 +0800
Message-Id: <20200519200207.17773-7-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519200207.17773-1-chen.zhang@intel.com>
References: <20200519200207.17773-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 16:12:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

If the colo-compare object is removed before failover and a
checkpoint happens, qemu crashes because it tries to lock
the destroyed event_mtx in colo_notify_compares_event.

Fix this by checking if everything is initialized by
introducing a new variable colo_compare_active which
is protected by a new mutex colo_compare_mutex. The new mutex
also protects against concurrent access of the net_compares
list and makes sure that colo_notify_compares_event isn't
active while we destroy event_mtx and event_complete_cond.

With this it also is again possible to use colo without
colo-compare (periodic mode) and to use multiple colo-compare
for multiple network interfaces.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
 net/colo-compare.h |  1 +
 softmmu/vl.c       |  2 ++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index db536c9419..1ee8b9dc3c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =
 #define REGULAR_PACKET_CHECK_MS 3000
 #define DEFAULT_TIME_OUT_MS 3000
 
+static QemuMutex colo_compare_mutex;
+static bool colo_compare_active;
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
 static int event_unhandled_count;
@@ -913,6 +915,12 @@ static void check_old_packet_regular(void *opaque)
 void colo_notify_compares_event(void *opaque, int event, Error **errp)
 {
     CompareState *s;
+    qemu_mutex_lock(&colo_compare_mutex);
+
+    if (!colo_compare_active) {
+        qemu_mutex_unlock(&colo_compare_mutex);
+        return;
+    }
 
     qemu_mutex_lock(&event_mtx);
     QTAILQ_FOREACH(s, &net_compares, next) {
@@ -926,6 +934,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
     }
 
     qemu_mutex_unlock(&event_mtx);
+    qemu_mutex_unlock(&colo_compare_mutex);
 }
 
 static void colo_compare_timer_init(CompareState *s)
@@ -1281,7 +1290,14 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
                            s->vnet_hdr);
     }
 
+    qemu_mutex_lock(&colo_compare_mutex);
+    if (!colo_compare_active) {
+        qemu_mutex_init(&event_mtx);
+        qemu_cond_init(&event_complete_cond);
+        colo_compare_active = true;
+    }
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
+    qemu_mutex_unlock(&colo_compare_mutex);
 
     s->out_sendco.s = s;
     s->out_sendco.chr = &s->chr_out;
@@ -1299,9 +1315,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
 
     g_queue_init(&s->conn_list);
 
-    qemu_mutex_init(&event_mtx);
-    qemu_cond_init(&event_complete_cond);
-
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
                                                       g_free,
@@ -1389,12 +1402,19 @@ static void colo_compare_finalize(Object *obj)
 
     qemu_bh_delete(s->event_bh);
 
+    qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
         if (tmp == s) {
             QTAILQ_REMOVE(&net_compares, s, next);
             break;
         }
     }
+    if (QTAILQ_EMPTY(&net_compares)) {
+        colo_compare_active = false;
+        qemu_mutex_destroy(&event_mtx);
+        qemu_cond_destroy(&event_complete_cond);
+    }
+    qemu_mutex_unlock(&colo_compare_mutex);
 
     AioContext *ctx = iothread_get_aio_context(s->iothread);
     aio_context_acquire(ctx);
@@ -1422,15 +1442,18 @@ static void colo_compare_finalize(Object *obj)
         object_unref(OBJECT(s->iothread));
     }
 
-    qemu_mutex_destroy(&event_mtx);
-    qemu_cond_destroy(&event_complete_cond);
-
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
     g_free(s->notify_dev);
 }
 
+void colo_compare_init_globals(void)
+{
+    colo_compare_active = false;
+    qemu_mutex_init(&colo_compare_mutex);
+}
+
 static const TypeInfo colo_compare_info = {
     .name = TYPE_COLO_COMPARE,
     .parent = TYPE_OBJECT,
diff --git a/net/colo-compare.h b/net/colo-compare.h
index 22ddd512e2..eb483ac586 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -17,6 +17,7 @@
 #ifndef QEMU_COLO_COMPARE_H
 #define QEMU_COLO_COMPARE_H
 
+void colo_compare_init_globals(void);
 void colo_notify_compares_event(void *opaque, int event, Error **errp);
 void colo_compare_register_notifier(Notifier *notify);
 void colo_compare_unregister_notifier(Notifier *notify);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index ae5451bc23..81602c12b5 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -112,6 +112,7 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
+#include "net/colo-compare.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
+    colo_compare_init_globals();
 
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
-- 
2.17.1


