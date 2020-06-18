Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B6EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6E6207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV3/3zN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E6207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlujq-0001Gk-Sq
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVr-000844-UO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVq-0005t1-4o
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=q+Zson716eA2srJK2dRNURIuqK9Cb9Ivl3c8K1m1iM8=;
 b=NV3/3zN5U72n5M7XGfpnDXh8qt2vX+auvEZ5ersjyYbBuLGrRq7IUM5gtBOQXOEuPJ6R47
 KYf8Nw/N3qH00Yu62Rq/X7qWGHh2rPC3YfXVZbUC3/6ZDwiaJIx9QhhrXdtrMEPqAlIsnU
 v0qObh8c6TGaMoJZoHoyqyQOjbdlcDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-HF8_IFTDPVKGynu4tdZCkg-1; Thu, 18 Jun 2020 09:23:23 -0400
X-MC-Unique: HF8_IFTDPVKGynu4tdZCkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 329C8835B41;
 Thu, 18 Jun 2020 13:23:22 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45C425BAC1;
 Thu, 18 Jun 2020 13:23:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 28/33] net/colo-compare.c: Check that colo-compare is active
Date: Thu, 18 Jun 2020 21:21:43 +0800
Message-Id: <1592486508-6135-29-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Lukas Straub <lukasstraub2@web.de>
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
Tested-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a609f49..c30dbfb 100644
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
@@ -906,6 +908,12 @@ static void check_old_packet_regular(void *opaque)
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
@@ -919,6 +927,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
     }
 
     qemu_mutex_unlock(&event_mtx);
+    qemu_mutex_unlock(&colo_compare_mutex);
 }
 
 static void colo_compare_timer_init(CompareState *s)
@@ -1274,7 +1283,14 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
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
@@ -1292,9 +1308,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
 
     g_queue_init(&s->conn_list);
 
-    qemu_mutex_init(&event_mtx);
-    qemu_cond_init(&event_complete_cond);
-
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
                                                       g_free,
@@ -1382,12 +1395,19 @@ static void colo_compare_finalize(Object *obj)
 
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
@@ -1415,15 +1435,18 @@ static void colo_compare_finalize(Object *obj)
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
 
+static void __attribute__((__constructor__)) colo_compare_init_globals(void)
+{
+    colo_compare_active = false;
+    qemu_mutex_init(&colo_compare_mutex);
+}
+
 static const TypeInfo colo_compare_info = {
     .name = TYPE_COLO_COMPARE,
     .parent = TYPE_OBJECT,
-- 
2.5.0


