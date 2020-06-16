Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05ECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3D82082F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYXg+i+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3D82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5g8-00005U-OG
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5N6-0002BG-LU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:47:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5N4-0005on-AL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592290016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=cyQeNqIxnO+V8kgMoh6CmEf2K7MyHQFKaX0InhJMRGU=;
 b=aYXg+i+LsDHo/0SiUoRT1u2hFsplZIuL3iS/l3ckS+yNIF0Z4atxQwdEdzmiOzRxWaB2vE
 F1pgyOVD3WZRwn3l7FwyNxJrPgW2u7Gjivc5/oyLjGXosBcPibnXgB9kOsG+SdvFOnJqZ2
 UzD5EaKAssqVTWIhlR6cGR80A3r0tj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-slPoMpFxN2eUz5qc6oFemA-1; Tue, 16 Jun 2020 02:46:52 -0400
X-MC-Unique: slPoMpFxN2eUz5qc6oFemA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05BEE184D179;
 Tue, 16 Jun 2020 06:46:51 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F76D8202D;
 Tue, 16 Jun 2020 06:46:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 26/33] net/colo-compare.c: Fix deadlock in compare_chr_send
Date: Tue, 16 Jun 2020 14:45:37 +0800
Message-Id: <1592289944-13727-27-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

The chr_out chardev is connected to a filter-redirector
running in the main loop. qemu_chr_fe_write_all might block
here in compare_chr_send if the (socket-)buffer is full.
If another filter-redirector in the main loop want's to
send data to chr_pri_in it might also block if the buffer
is full. This leads to a deadlock because both event loops
get blocked.

Fix this by converting compare_chr_send to a coroutine and
putting the packets in a send queue.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Tested-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 193 ++++++++++++++++++++++++++++++++++++++++-------------
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 3 files changed, 156 insertions(+), 45 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index e557da7..62ecd38 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -32,6 +32,9 @@
 #include "migration/migration.h"
 #include "util.h"
 
+#include "block/aio-wait.h"
+#include "qemu/coroutine.h"
+
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
     OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
@@ -77,6 +80,23 @@ static int event_unhandled_count;
  *                    |packet  |  |packet  +    |packet  | |packet  +
  *                    +--------+  +--------+    +--------+ +--------+
  */
+
+typedef struct SendCo {
+    Coroutine *co;
+    struct CompareState *s;
+    CharBackend *chr;
+    GQueue send_list;
+    bool notify_remote_frame;
+    bool done;
+    int ret;
+} SendCo;
+
+typedef struct SendEntry {
+    uint32_t size;
+    uint32_t vnet_hdr_len;
+    uint8_t *buf;
+} SendEntry;
+
 typedef struct CompareState {
     Object parent;
 
@@ -91,6 +111,8 @@ typedef struct CompareState {
     SocketReadState pri_rs;
     SocketReadState sec_rs;
     SocketReadState notify_rs;
+    SendCo out_sendco;
+    SendCo notify_sendco;
     bool vnet_hdr;
     uint32_t compare_timeout;
     uint32_t expired_scan_cycle;
@@ -124,10 +146,11 @@ enum {
 
 
 static int compare_chr_send(CompareState *s,
-                            const uint8_t *buf,
+                            uint8_t *buf,
                             uint32_t size,
                             uint32_t vnet_hdr_len,
-                            bool notify_remote_frame);
+                            bool notify_remote_frame,
+                            bool zero_copy);
 
 static bool packet_matches_str(const char *str,
                                const uint8_t *buf,
@@ -145,7 +168,7 @@ static void notify_remote_frame(CompareState *s)
     char msg[] = "DO_CHECKPOINT";
     int ret = 0;
 
-    ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+    ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true, false);
     if (ret < 0) {
         error_report("Notify Xen COLO-frame failed");
     }
@@ -272,12 +295,13 @@ static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
                            pkt->data,
                            pkt->size,
                            pkt->vnet_hdr_len,
-                           false);
+                           false,
+                           true);
     if (ret < 0) {
         error_report("colo send primary packet failed");
     }
     trace_colo_compare_main("packet same and release packet");
-    packet_destroy(pkt, NULL);
+    packet_destroy_partial(pkt, NULL);
 }
 
 /*
@@ -699,65 +723,115 @@ static void colo_compare_connection(void *opaque, void *user_data)
     }
 }
 
-static int compare_chr_send(CompareState *s,
-                            const uint8_t *buf,
-                            uint32_t size,
-                            uint32_t vnet_hdr_len,
-                            bool notify_remote_frame)
+static void coroutine_fn _compare_chr_send(void *opaque)
 {
+    SendCo *sendco = opaque;
+    CompareState *s = sendco->s;
     int ret = 0;
-    uint32_t len = htonl(size);
 
-    if (!size) {
-        return 0;
-    }
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry = g_queue_pop_tail(&sendco->send_list);
+        uint32_t len = htonl(entry->size);
 
-    if (notify_remote_frame) {
-        ret = qemu_chr_fe_write_all(&s->chr_notify_dev,
-                                    (uint8_t *)&len,
-                                    sizeof(len));
-    } else {
-        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
-    }
+        ret = qemu_chr_fe_write_all(sendco->chr, (uint8_t *)&len, sizeof(len));
 
-    if (ret != sizeof(len)) {
-        goto err;
-    }
+        if (ret != sizeof(len)) {
+            g_free(entry->buf);
+            g_slice_free(SendEntry, entry);
+            goto err;
+        }
 
-    if (s->vnet_hdr) {
-        /*
-         * We send vnet header len make other module(like filter-redirector)
-         * know how to parse net packet correctly.
-         */
-        len = htonl(vnet_hdr_len);
+        if (!sendco->notify_remote_frame && s->vnet_hdr) {
+            /*
+             * We send vnet header len make other module(like filter-redirector)
+             * know how to parse net packet correctly.
+             */
+            len = htonl(entry->vnet_hdr_len);
 
-        if (!notify_remote_frame) {
-            ret = qemu_chr_fe_write_all(&s->chr_out,
+            ret = qemu_chr_fe_write_all(sendco->chr,
                                         (uint8_t *)&len,
                                         sizeof(len));
+
+            if (ret != sizeof(len)) {
+                g_free(entry->buf);
+                g_slice_free(SendEntry, entry);
+                goto err;
+            }
         }
 
-        if (ret != sizeof(len)) {
+        ret = qemu_chr_fe_write_all(sendco->chr,
+                                    (uint8_t *)entry->buf,
+                                    entry->size);
+
+        if (ret != entry->size) {
+            g_free(entry->buf);
+            g_slice_free(SendEntry, entry);
             goto err;
         }
+
+        g_free(entry->buf);
+        g_slice_free(SendEntry, entry);
     }
 
+    sendco->ret = 0;
+    goto out;
+
+err:
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry = g_queue_pop_tail(&sendco->send_list);
+        g_free(entry->buf);
+        g_slice_free(SendEntry, entry);
+    }
+    sendco->ret = ret < 0 ? ret : -EIO;
+out:
+    sendco->co = NULL;
+    sendco->done = true;
+    aio_wait_kick();
+}
+
+static int compare_chr_send(CompareState *s,
+                            uint8_t *buf,
+                            uint32_t size,
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame,
+                            bool zero_copy)
+{
+    SendCo *sendco;
+    SendEntry *entry;
+
     if (notify_remote_frame) {
-        ret = qemu_chr_fe_write_all(&s->chr_notify_dev,
-                                    (uint8_t *)buf,
-                                    size);
+        sendco = &s->notify_sendco;
     } else {
-        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+        sendco = &s->out_sendco;
     }
 
-    if (ret != size) {
-        goto err;
+    if (!size) {
+        return 0;
     }
 
-    return 0;
+    entry = g_slice_new(SendEntry);
+    entry->size = size;
+    entry->vnet_hdr_len = vnet_hdr_len;
+    if (zero_copy) {
+        entry->buf = buf;
+    } else {
+        entry->buf = g_malloc(size);
+        memcpy(entry->buf, buf, size);
+    }
+    g_queue_push_head(&sendco->send_list, entry);
+
+    if (sendco->done) {
+        sendco->co = qemu_coroutine_create(_compare_chr_send, sendco);
+        sendco->done = false;
+        qemu_coroutine_enter(sendco->co);
+        if (sendco->done) {
+            /* report early errors */
+            return sendco->ret;
+        }
+    }
 
-err:
-    return ret < 0 ? ret : -EIO;
+    /* assume success */
+    return 0;
 }
 
 static int compare_chr_can_read(void *opaque)
@@ -1063,6 +1137,7 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
                          pri_rs->buf,
                          pri_rs->packet_len,
                          pri_rs->vnet_hdr_len,
+                         false,
                          false);
     } else {
         /* compare packet in the specified connection */
@@ -1093,7 +1168,7 @@ static void compare_notify_rs_finalize(SocketReadState *notify_rs)
     if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
                            notify_rs->buf,
                            notify_rs->packet_len)) {
-        ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+        ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true, false);
         if (ret < 0) {
             error_report("Notify Xen COLO-frame INIT failed");
         }
@@ -1199,6 +1274,20 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
 
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
 
+    s->out_sendco.s = s;
+    s->out_sendco.chr = &s->chr_out;
+    s->out_sendco.notify_remote_frame = false;
+    s->out_sendco.done = true;
+    g_queue_init(&s->out_sendco.send_list);
+
+    if (s->notify_dev) {
+        s->notify_sendco.s = s;
+        s->notify_sendco.chr = &s->chr_notify_dev;
+        s->notify_sendco.notify_remote_frame = true;
+        s->notify_sendco.done = true;
+        g_queue_init(&s->notify_sendco.send_list);
+    }
+
     g_queue_init(&s->conn_list);
 
     qemu_mutex_init(&event_mtx);
@@ -1225,8 +1314,9 @@ static void colo_flush_packets(void *opaque, void *user_data)
                          pkt->data,
                          pkt->size,
                          pkt->vnet_hdr_len,
-                         false);
-        packet_destroy(pkt, NULL);
+                         false,
+                         true);
+        packet_destroy_partial(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
         pkt = g_queue_pop_head(&conn->secondary_list);
@@ -1297,10 +1387,23 @@ static void colo_compare_finalize(Object *obj)
         }
     }
 
+    AioContext *ctx = iothread_get_aio_context(s->iothread);
+    aio_context_acquire(ctx);
+    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+    if (s->notify_dev) {
+        AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+    }
+    aio_context_release(ctx);
+
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
 
     g_queue_clear(&s->conn_list);
+    g_queue_clear(&s->out_sendco.send_list);
+    if (s->notify_dev) {
+        g_queue_clear(&s->notify_sendco.send_list);
+    }
 
     if (s->connection_track_table) {
         g_hash_table_destroy(s->connection_track_table);
diff --git a/net/colo.c b/net/colo.c
index 8196b35..a6c66d8 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -185,6 +185,13 @@ void packet_destroy(void *opaque, void *user_data)
     g_slice_free(Packet, pkt);
 }
 
+void packet_destroy_partial(void *opaque, void *user_data)
+{
+    Packet *pkt = opaque;
+
+    g_slice_free(Packet, pkt);
+}
+
 /*
  * Clear hashtable, stop this hash growing really huge
  */
diff --git a/net/colo.h b/net/colo.h
index 679314b..573ab91 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -102,5 +102,6 @@ bool connection_has_tracked(GHashTable *connection_track_table,
 void connection_hashtable_reset(GHashTable *connection_track_table);
 Packet *packet_new(const void *data, int size, int vnet_hdr_len);
 void packet_destroy(void *opaque, void *user_data);
+void packet_destroy_partial(void *opaque, void *user_data);
 
 #endif /* NET_COLO_H */
-- 
2.5.0


