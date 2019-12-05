Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F46C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECC421835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECC421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvG7-00019N-B0
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDG-0007bD-In
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDD-0003X9-S3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:48278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvDC-0003S7-0X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:46 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvD6-00013M-IN; Thu, 05 Dec 2019 20:46:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/21] vnc: drop Error pointer indirection in
 vnc_client_io_error
Date: Thu,  5 Dec 2019 20:46:19 +0300
Message-Id: <20191205174635.18758-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205174635.18758-1-vsementsov@virtuozzo.com>
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: vsementsov@virtuozzo.com, armbru@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need Error **, as all callers pass local Error object, which
isn't used after the call, or NULL. Use Error * instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 ui/vnc.h |  2 +-
 ui/vnc.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index fea79c2fc9..4e2637ce6c 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -547,7 +547,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
 
 /* Protocol stage functions */
 void vnc_client_error(VncState *vs);
-size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
+size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err);
 
 void start_client_init(VncState *vs);
 void start_auth_vnc(VncState *vs);
diff --git a/ui/vnc.c b/ui/vnc.c
index 87b8045afe..4100d6e404 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1312,7 +1312,7 @@ void vnc_disconnect_finish(VncState *vs)
     g_free(vs);
 }
 
-size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
+size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
 {
     if (ret <= 0) {
         if (ret == 0) {
@@ -1320,15 +1320,11 @@ size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
             vnc_disconnect_start(vs);
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
             trace_vnc_client_io_error(vs, vs->ioc,
-                                      errp ? error_get_pretty(*errp) :
-                                      "Unknown");
+                                      err ? error_get_pretty(err) : "Unknown");
             vnc_disconnect_start(vs);
         }
 
-        if (errp) {
-            error_free(*errp);
-            *errp = NULL;
-        }
+        error_free(err);
         return 0;
     }
     return ret;
@@ -1361,10 +1357,9 @@ size_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
 {
     Error *err = NULL;
     ssize_t ret;
-    ret = qio_channel_write(
-        vs->ioc, (const char *)data, datalen, &err);
+    ret = qio_channel_write(vs->ioc, (const char *)data, datalen, &err);
     VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
-    return vnc_client_io_error(vs, ret, &err);
+    return vnc_client_io_error(vs, ret, err);
 }
 
 
@@ -1488,10 +1483,9 @@ size_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
 {
     ssize_t ret;
     Error *err = NULL;
-    ret = qio_channel_read(
-        vs->ioc, (char *)data, datalen, &err);
+    ret = qio_channel_read(vs->ioc, (char *)data, datalen, &err);
     VNC_DEBUG("Read wire %p %zd -> %ld\n", data, datalen, ret);
-    return vnc_client_io_error(vs, ret, &err);
+    return vnc_client_io_error(vs, ret, err);
 }
 
 
-- 
2.21.0


