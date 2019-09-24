Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC412C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB8D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB8D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCr9w-0002Yd-Dw
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCr84-0000Mb-1c
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCr82-0002oO-AE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:38016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCr82-0002nL-3F
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:42 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCr7z-0001Mk-Pq; Tue, 24 Sep 2019 23:09:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/25] errp: rename errp to errp_in where it is IN-argument
Date: Tue, 24 Sep 2019 23:08:38 +0300
Message-Id: <20190924200902.4703-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924200902.4703-1-vsementsov@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: vsementsov@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Error **errp is almost always OUT-argument: it's assumed to be NULL, or
pointer to NULL-initialized pointer, or pointer to error_abort or
error_fatal, for callee to report error.

But very few functions instead get Error **errp as IN-argument:
it's assumed to be set, and callee should clean it.
In such cases, rename errp to errp_in.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/monitor/hmp.h |  2 +-
 include/qapi/error.h  |  2 +-
 ui/vnc.h              |  2 +-
 monitor/hmp-cmds.c    |  8 ++++----
 ui/vnc.c              | 10 +++++-----
 util/error.c          |  8 ++++----
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index a0e9511440..f929814f1a 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,7 +16,7 @@
 
 #include "qemu/readline.h"
 
-void hmp_handle_error(Monitor *mon, Error **errp);
+void hmp_handle_error(Monitor *mon, Error **errp_in);
 
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
diff --git a/include/qapi/error.h b/include/qapi/error.h
index 3f95141a01..9376f59c35 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -283,7 +283,7 @@ void error_free(Error *err);
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-void error_free_or_abort(Error **errp);
+void error_free_or_abort(Error **errp_in);
 
 /*
  * Convenience function to warn_report() and free @err.
diff --git a/ui/vnc.h b/ui/vnc.h
index fea79c2fc9..00e0b48f2f 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -547,7 +547,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
 
 /* Protocol stage functions */
 void vnc_client_error(VncState *vs);
-size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
+size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp_in);
 
 void start_client_init(VncState *vs);
 void start_auth_vnc(VncState *vs);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..941d5d0a45 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -60,11 +60,11 @@
 #include <spice/enums.h>
 #endif
 
-void hmp_handle_error(Monitor *mon, Error **errp)
+void hmp_handle_error(Monitor *mon, Error **errp_in)
 {
-    assert(errp);
-    if (*errp) {
-        error_reportf_err(*errp, "Error: ");
+    assert(errp_in);
+    if (*errp_in) {
+        error_reportf_err(*errp_in, "Error: ");
     }
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 87b8045afe..9d6384d9b1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1312,7 +1312,7 @@ void vnc_disconnect_finish(VncState *vs)
     g_free(vs);
 }
 
-size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
+size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp_in)
 {
     if (ret <= 0) {
         if (ret == 0) {
@@ -1320,14 +1320,14 @@ size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
             vnc_disconnect_start(vs);
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
             trace_vnc_client_io_error(vs, vs->ioc,
-                                      errp ? error_get_pretty(*errp) :
+                                      errp_in ? error_get_pretty(*errp_in) :
                                       "Unknown");
             vnc_disconnect_start(vs);
         }
 
-        if (errp) {
-            error_free(*errp);
-            *errp = NULL;
+        if (errp_in) {
+            error_free(*errp_in);
+            *errp_in = NULL;
         }
         return 0;
     }
diff --git a/util/error.c b/util/error.c
index d4532ce318..b3ff3832d6 100644
--- a/util/error.c
+++ b/util/error.c
@@ -271,11 +271,11 @@ void error_free(Error *err)
     }
 }
 
-void error_free_or_abort(Error **errp)
+void error_free_or_abort(Error **errp_in)
 {
-    assert(errp && *errp);
-    error_free(*errp);
-    *errp = NULL;
+    assert(errp_in && *errp_in);
+    error_free(*errp_in);
+    *errp_in = NULL;
 }
 
 void error_propagate(Error **dst_errp, Error *local_err)
-- 
2.21.0


