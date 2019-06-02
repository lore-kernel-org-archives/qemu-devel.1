Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA900C28CC4
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C641327833
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C641327833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXHUM-000865-TF
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 23:48:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSp-0007Dw-3g
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSn-00039f-R5
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:51836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hXHSn-00035L-I5
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Jun 2019 20:47:13 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by orsmga005.jf.intel.com with ESMTP; 01 Jun 2019 20:47:11 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Date: Sun,  2 Jun 2019 11:42:35 +0800
Message-Id: <20190602034239.23225-3-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <20190602034239.23225-1-chen.zhang@intel.com>
References: <20190602034239.23225-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH 2/6] COLO-compare: Add remote notification
 chardev handler frame
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Add chardev handler to send notification to remote(current from Xen) colo-frame.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 21849748b6..8b7bd9f0c7 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -87,8 +87,10 @@ typedef struct CompareState {
     CharBackend chr_pri_in;
     CharBackend chr_sec_in;
     CharBackend chr_out;
+    CharBackend chr_notify_dev;
     SocketReadState pri_rs;
     SocketReadState sec_rs;
+    SocketReadState notify_rs;
     bool vnet_hdr;
 
     /*
@@ -745,6 +747,19 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
     }
 }
 
+static void compare_notify_chr(void *opaque, const uint8_t *buf, int size)
+{
+    CompareState *s = COLO_COMPARE(opaque);
+    int ret;
+
+    ret = net_fill_rstate(&s->notify_rs, buf, size);
+    if (ret == -1) {
+        qemu_chr_fe_set_handlers(&s->chr_notify_dev, NULL, NULL, NULL, NULL,
+                                 NULL, NULL, true);
+        error_report("colo-compare notify_dev error");
+    }
+}
+
 /*
  * Check old packet regularly so it can watch for any packets
  * that the secondary hasn't produced equivalents of.
@@ -832,6 +847,11 @@ static void colo_compare_iothread(CompareState *s)
     qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
                              compare_sec_chr_in, NULL, NULL,
                              s, s->worker_context, true);
+    if (s->notify_dev) {
+        qemu_chr_fe_set_handlers(&s->chr_notify_dev, compare_chr_can_read,
+                                 compare_notify_chr, NULL, NULL,
+                                 s, s->worker_context, true);
+    }
 
     colo_compare_timer_init(s);
     s->event_bh = qemu_bh_new(colo_compare_handle_event, s);
@@ -943,6 +963,10 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
     }
 }
 
+static void compare_notify_rs_finalize(SocketReadState *notify_rs)
+{
+    /* Get Xen colo-frame's notify and handle the message */
+}
 
 /*
  * Return 0 is success.
@@ -1013,6 +1037,17 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_hdr);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_hdr);
 
+    /* Try to enable remote notify chardev, currently just for Xen COLO */
+    if (s->notify_dev) {
+        if (find_and_check_chardev(&chr, s->notify_dev, errp) ||
+            !qemu_chr_fe_init(&s->chr_notify_dev, chr, errp)) {
+            return;
+        }
+
+        net_socket_rs_init(&s->notify_rs, compare_notify_rs_finalize,
+                           s->vnet_hdr);
+    }
+
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
 
     g_queue_init(&s->conn_list);
@@ -1091,6 +1126,10 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_deinit(&s->chr_pri_in, false);
     qemu_chr_fe_deinit(&s->chr_sec_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
+    if (s->notify_dev) {
+        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
+    }
+
     if (s->iothread) {
         colo_compare_timer_del(s);
     }
-- 
2.17.GIT


