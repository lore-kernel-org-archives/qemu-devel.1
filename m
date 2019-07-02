Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1084DC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC921216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC921216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiALI-0002OR-SN
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aT-0005Cf-QR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aS-0003mu-Ny
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aS-0003la-EL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9C3788E5F;
 Tue,  2 Jul 2019 02:32:03 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1490860C43;
 Tue,  2 Jul 2019 02:32:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:26 +0800
Message-Id: <1562034689-6539-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 02 Jul 2019 02:32:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/17] COLO-compare: Add remote notification
 chardev handler frame
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Add chardev handler to send notification to remote(current from Xen) colo-frame.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10fae2b..fda55d5 100644
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
2.5.0


