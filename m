Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3EC28CC2
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE6620848
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE6620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44509 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXHXc-0002LH-Qp
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 23:52:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSp-0007Dz-OL
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSo-0003AG-Bi
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:51833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hXHSo-00030z-1H
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Jun 2019 20:47:15 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by orsmga005.jf.intel.com with ESMTP; 01 Jun 2019 20:47:13 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Date: Sun,  2 Jun 2019 11:42:36 +0800
Message-Id: <20190602034239.23225-4-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <20190602034239.23225-1-chen.zhang@intel.com>
References: <20190602034239.23225-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH 3/6] COLO-compare: Make the compare_chr_send()
 can send notification message.
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

We need use this function to send notification message for remote colo-frame(Xen).
So we add new parameter for this job.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 8b7bd9f0c7..16285f4a96 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -129,7 +129,8 @@ static void colo_compare_inconsistency_notify(void)
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
-                            uint32_t vnet_hdr_len);
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -241,7 +242,8 @@ static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
     ret = compare_chr_send(s,
                            pkt->data,
                            pkt->size,
-                           pkt->vnet_hdr_len);
+                           pkt->vnet_hdr_len,
+                           false);
     if (ret < 0) {
         error_report("colo send primary packet failed");
     }
@@ -671,7 +673,8 @@ static void colo_compare_connection(void *opaque, void *user_data)
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
-                            uint32_t vnet_hdr_len)
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame)
 {
     int ret = 0;
     uint32_t len = htonl(size);
@@ -680,7 +683,14 @@ static int compare_chr_send(CompareState *s,
         return 0;
     }
 
-    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+    if (notify_remote_frame) {
+        ret = qemu_chr_fe_write_all(&s->chr_notify_dev,
+                                    (uint8_t *)&len,
+                                    sizeof(len));
+    } else {
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+    }
+
     if (ret != sizeof(len)) {
         goto err;
     }
@@ -691,13 +701,26 @@ static int compare_chr_send(CompareState *s,
          * know how to parse net packet correctly.
          */
         len = htonl(vnet_hdr_len);
-        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+
+        if (!notify_remote_frame) {
+            ret = qemu_chr_fe_write_all(&s->chr_out,
+                                        (uint8_t *)&len,
+                                        sizeof(len));
+        }
+
         if (ret != sizeof(len)) {
             goto err;
         }
     }
 
-    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+    if (notify_remote_frame) {
+        ret = qemu_chr_fe_write_all(&s->chr_notify_dev,
+                                    (uint8_t *)buf,
+                                    size);
+    } else {
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+    }
+
     if (ret != size) {
         goto err;
     }
@@ -943,7 +966,8 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
         compare_chr_send(s,
                          pri_rs->buf,
                          pri_rs->packet_len,
-                         pri_rs->vnet_hdr_len);
+                         pri_rs->vnet_hdr_len,
+                         false);
     } else {
         /* compare packet in the specified connection */
         colo_compare_connection(conn, s);
@@ -1075,7 +1099,8 @@ static void colo_flush_packets(void *opaque, void *user_data)
         compare_chr_send(s,
                          pkt->data,
                          pkt->size,
-                         pkt->vnet_hdr_len);
+                         pkt->vnet_hdr_len,
+                         false);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
-- 
2.17.GIT


