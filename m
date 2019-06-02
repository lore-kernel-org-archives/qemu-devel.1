Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28700C46470
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0C727837
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0C727837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXHWG-0001D0-NU
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 23:50:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSp-0007Dx-MF
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSo-0003A2-7b
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:51836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hXHSo-00035L-1x
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Jun 2019 20:47:17 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by orsmga005.jf.intel.com with ESMTP; 01 Jun 2019 20:47:15 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Date: Sun,  2 Jun 2019 11:42:37 +0800
Message-Id: <20190602034239.23225-5-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <20190602034239.23225-1-chen.zhang@intel.com>
References: <20190602034239.23225-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH 4/6] COLO-compare: Add colo-compare remote
 notify support
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

This patch make colo-compare can send message to remote COLO frame(Xen) when occur checkpoint.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 51 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 16285f4a96..19075c7a66 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -251,6 +251,17 @@ static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
     packet_destroy(pkt, NULL);
 }
 
+static void notify_remote_frame(CompareState *s)
+{
+    char msg[] = "DO_CHECKPOINT";
+    int ret = 0;
+
+    ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+    if (ret < 0) {
+        error_report("Notify Xen COLO-frame failed");
+    }
+}
+
 /*
  * The IP packets sent by primary and secondary
  * will be compared in here
@@ -435,7 +446,11 @@ sec:
         qemu_hexdump((char *)spkt->data, stderr,
                      "colo-compare spkt", spkt->size);
 
-        colo_compare_inconsistency_notify();
+        if (s->notify_dev) {
+            notify_remote_frame(s);
+        } else {
+            colo_compare_inconsistency_notify();
+        }
     }
 }
 
@@ -577,7 +592,7 @@ void colo_compare_unregister_notifier(Notifier *notify)
 }
 
 static int colo_old_packet_check_one_conn(Connection *conn,
-                                           void *user_data)
+                                          CompareState *s)
 {
     GList *result = NULL;
     int64_t check_time = REGULAR_PACKET_CHECK_MS;
@@ -588,7 +603,11 @@ static int colo_old_packet_check_one_conn(Connection *conn,
 
     if (result) {
         /* Do checkpoint will flush old packet */
-        colo_compare_inconsistency_notify();
+        if (s->notify_dev) {
+            notify_remote_frame(s);
+        } else {
+            colo_compare_inconsistency_notify();
+        }
         return 0;
     }
 
@@ -608,7 +627,7 @@ static void colo_old_packet_check(void *opaque)
      * If we find one old packet, stop finding job and notify
      * COLO frame do checkpoint.
      */
-    g_queue_find_custom(&s->conn_list, NULL,
+    g_queue_find_custom(&s->conn_list, s,
                         (GCompareFunc)colo_old_packet_check_one_conn);
 }
 
@@ -637,7 +656,12 @@ static void colo_compare_packet(CompareState *s, Connection *conn,
              */
             trace_colo_compare_main("packet different");
             g_queue_push_head(&conn->primary_list, pkt);
-            colo_compare_inconsistency_notify();
+
+            if (s->notify_dev) {
+                notify_remote_frame(s);
+            } else {
+                colo_compare_inconsistency_notify();
+            }
             break;
         }
     }
@@ -989,7 +1013,24 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 
 static void compare_notify_rs_finalize(SocketReadState *notify_rs)
 {
+    CompareState *s = container_of(notify_rs, CompareState, notify_rs);
+
     /* Get Xen colo-frame's notify and handle the message */
+    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
+    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
+    int ret;
+
+    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
+        ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+        if (ret < 0) {
+            error_report("Notify Xen COLO-frame INIT failed");
+        }
+    }
+
+    if (!strcmp(data, "COLO_CHECKPOINT")) {
+        /* colo-compare do checkpoint, flush pri packet and remove sec packet */
+        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    }
 }
 
 /*
-- 
2.17.GIT


