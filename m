Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F0C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA8D20856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FIhOp42P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA8D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8O41-0002ar-2E
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8O1u-0000y8-1v
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8O1s-0004pE-CN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:16:53 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:42935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i8O1s-0004nz-4R
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568290612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VvgsGAB7BTrgkm7+yI0yUwdTY5E5FVE/Qy+13qP79B8=;
 b=FIhOp42Pf9EZE62fWyXfyvO3a0zh297D7LkRsC8z6+xyI36nUOef3RBP
 pLhvSnnv1iZEL1/IweXWszEcKfh7FmdFMeDButOVicSZEEZi+zg4prKaR
 lnIjWUVqMHXCdffgam91qAVpPefJPHyw5QnwG3xeGeepvPG7aAXXRYJZQ 4=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=paul.durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 paul.durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="paul.durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: rlJib4CmA0tFeLUbs9BDFI0fMYESysKlsZ6TbnJRAHIJjwCRLOGc5T4u0Rma43e0h+AqAe29M2
 bgMR6a9nPQegYFa8nNOLUUyu02l5mGnqRcb8nKc8c5jXcJOxSkHfnojPsUewmHmqB/MDuCgB/o
 y0VHCIapTWxM1Hop8oPebKcHdj0Cp+quoqyjRcd9rJO5nzU7jOPQ/Dy+TmHxDySmt2XAQd+goR
 Lrn0NlYdp+spgsRX0fMhTjuu1l1JTMnDPcXZrgNI8mDWPK5MCqzVlgBrWIO7gOjTxtXGhWYocj
 mDc=
X-SBRS: 2.7
X-MesageID: 5769901
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,497,1559534400"; 
   d="scan'208";a="5769901"
From: Paul Durrant <paul.durrant@citrix.com>
To: <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>
Date: Thu, 12 Sep 2019 13:16:44 +0100
Message-ID: <20190912121646.29148-2-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20190912121646.29148-1-paul.durrant@citrix.com>
References: <20190912121646.29148-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: [Qemu-devel] [PATCH v2 1/3] xen / notify: introduce a new
 XenWatchList abstraction
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xenstore watch call-backs are already abstracted away from XenBus using
the XenWatch data structure but the associated NotifierList manipulation
and file handle registration is still open coded in various xen_bus_...()
functions.
This patch creates a new XenWatchList data structure to allow these
interactions to be abstracted away from XenBus as well. This is in
preparation for a subsequent patch which will introduce separate watch lists
for XenBus and XenDevice objects.

NOTE: This patch also introduces a new notifier_list_empty() helper function
      for the purposes of adding an assertion that a XenWatchList is not
      freed whilst its associated NotifierList is still occupied.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/trace-events      |   5 +-
 hw/xen/xen-bus.c         | 117 +++++++++++++++++++++++++--------------
 include/hw/xen/xen-bus.h |   3 +-
 include/qemu/notify.h    |   2 +
 util/notify.c            |   5 ++
 5 files changed, 87 insertions(+), 45 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index bc82ecb1a5..ac8d9c20d2 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -19,9 +19,8 @@ xen_bus_unrealize(void) ""
 xen_bus_enumerate(void) ""
 xen_bus_type_enumerate(const char *type) "type: %s"
 xen_bus_backend_create(const char *type, const char *path) "type: %s path: %s"
-xen_bus_add_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
-xen_bus_remove_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
-xen_bus_watch(const char *token) "token: %s"
+xen_bus_add_watch(const char *node, const char *key) "node: %s key: %s"
+xen_bus_remove_watch(const char *node, const char *key) "node: %s key: %s"
 xen_device_realize(const char *type, char *name) "type: %s name: %s"
 xen_device_unrealize(const char *type, char *name) "type: %s name: %s"
 xen_device_backend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 025df5e59f..28efaccff2 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -157,18 +157,60 @@ static void free_watch(XenWatch *watch)
     g_free(watch);
 }
 
-static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
-                                   const char *key, XenWatchHandler handler,
-                                   void *opaque, Error **errp)
+struct XenWatchList {
+    struct xs_handle *xsh;
+    NotifierList notifiers;
+};
+
+static void watch_list_event(void *opaque)
+{
+    XenWatchList *watch_list = opaque;
+    char **v;
+    const char *token;
+
+    v = xs_check_watch(watch_list->xsh);
+    if (!v) {
+        return;
+    }
+
+    token = v[XS_WATCH_TOKEN];
+
+    notifier_list_notify(&watch_list->notifiers, (void *)token);
+
+    free(v);
+}
+
+static XenWatchList *watch_list_create(struct xs_handle *xsh)
+{
+    XenWatchList *watch_list = g_new0(XenWatchList, 1);
+
+    g_assert(xsh);
+
+    watch_list->xsh = xsh;
+    notifier_list_init(&watch_list->notifiers);
+    qemu_set_fd_handler(xs_fileno(watch_list->xsh), watch_list_event, NULL,
+                        watch_list);
+
+    return watch_list;
+}
+
+static void watch_list_destroy(XenWatchList *watch_list)
+{
+    g_assert(notifier_list_empty(&watch_list->notifiers));
+    qemu_set_fd_handler(xs_fileno(watch_list->xsh), NULL, NULL, NULL);
+    g_free(watch_list);
+}
+
+static XenWatch *watch_list_add(XenWatchList *watch_list, const char *node,
+                                const char *key, XenWatchHandler handler,
+                                void *opaque, Error **errp)
 {
     XenWatch *watch = new_watch(node, key, handler, opaque);
     Error *local_err = NULL;
 
-    trace_xen_bus_add_watch(watch->node, watch->key, watch->token);
-
-    notifier_list_add(&xenbus->watch_notifiers, &watch->notifier);
+    notifier_list_add(&watch_list->notifiers, &watch->notifier);
 
-    xs_node_watch(xenbus->xsh, node, key, watch->token, &local_err);
+    xs_node_watch(watch_list->xsh, node, key, watch->token, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
 
@@ -181,18 +223,34 @@ static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
     return watch;
 }
 
-static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch,
-                                 Error **errp)
+static void watch_list_remove(XenWatchList *watch_list, XenWatch *watch,
+                              Error **errp)
 {
-    trace_xen_bus_remove_watch(watch->node, watch->key, watch->token);
-
-    xs_node_unwatch(xenbus->xsh, watch->node, watch->key, watch->token,
+    xs_node_unwatch(watch_list->xsh, watch->node, watch->key, watch->token,
                     errp);
 
     notifier_remove(&watch->notifier);
     free_watch(watch);
 }
 
+static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
+                                   const char *key, XenWatchHandler handler,
+                                   void *opaque, Error **errp)
+{
+    trace_xen_bus_add_watch(node, key);
+
+    return watch_list_add(xenbus->watch_list, node, key, handler, opaque,
+                          errp);
+}
+
+static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch,
+                                 Error **errp)
+{
+    trace_xen_bus_remove_watch(watch->node, watch->key);
+
+    watch_list_remove(xenbus->watch_list, watch, errp);
+}
+
 static void xen_bus_backend_create(XenBus *xenbus, const char *type,
                                    const char *name, char *path,
                                    Error **errp)
@@ -338,35 +396,14 @@ static void xen_bus_unrealize(BusState *bus, Error **errp)
         xenbus->backend_watch = NULL;
     }
 
-    if (!xenbus->xsh) {
-        return;
+    if (xenbus->watch_list) {
+        watch_list_destroy(xenbus->watch_list);
+        xenbus->watch_list = NULL;
     }
 
-    qemu_set_fd_handler(xs_fileno(xenbus->xsh), NULL, NULL, NULL);
-
-    xs_close(xenbus->xsh);
-}
-
-static void xen_bus_watch(void *opaque)
-{
-    XenBus *xenbus = opaque;
-    char **v;
-    const char *token;
-
-    g_assert(xenbus->xsh);
-
-    v = xs_check_watch(xenbus->xsh);
-    if (!v) {
-        return;
+    if (xenbus->xsh) {
+        xs_close(xenbus->xsh);
     }
-
-    token = v[XS_WATCH_TOKEN];
-
-    trace_xen_bus_watch(token);
-
-    notifier_list_notify(&xenbus->watch_notifiers, (void *)token);
-
-    free(v);
 }
 
 static void xen_bus_realize(BusState *bus, Error **errp)
@@ -390,9 +427,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
         xenbus->backend_id = 0; /* Assume lack of node means dom0 */
     }
 
-    notifier_list_init(&xenbus->watch_notifiers);
-    qemu_set_fd_handler(xs_fileno(xenbus->xsh), xen_bus_watch, NULL,
-                        xenbus);
+    xenbus->watch_list = watch_list_create(xenbus->xsh);
 
     module_call_init(MODULE_INIT_XEN_BACKEND);
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 1c2d9dfdb8..88b84e29bb 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -14,6 +14,7 @@
 
 typedef void (*XenWatchHandler)(void *opaque);
 
+typedef struct XenWatchList XenWatchList;
 typedef struct XenWatch XenWatch;
 typedef struct XenEventChannel XenEventChannel;
 
@@ -63,7 +64,7 @@ typedef struct XenBus {
     BusState qbus;
     domid_t backend_id;
     struct xs_handle *xsh;
-    NotifierList watch_notifiers;
+    XenWatchList *watch_list;
     XenWatch *backend_watch;
 } XenBus;
 
diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index a3d73e4bc7..bcfa70fb2e 100644
--- a/include/qemu/notify.h
+++ b/include/qemu/notify.h
@@ -40,6 +40,8 @@ void notifier_remove(Notifier *notifier);
 
 void notifier_list_notify(NotifierList *list, void *data);
 
+bool notifier_list_empty(NotifierList *list);
+
 /* Same as Notifier but allows .notify() to return errors */
 typedef struct NotifierWithReturn NotifierWithReturn;
 
diff --git a/util/notify.c b/util/notify.c
index aee8d93cb0..76bab212ae 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -40,6 +40,11 @@ void notifier_list_notify(NotifierList *list, void *data)
     }
 }
 
+bool notifier_list_empty(NotifierList *list)
+{
+    return QLIST_EMPTY(&list->notifiers);
+}
+
 void notifier_with_return_list_init(NotifierWithReturnList *list)
 {
     QLIST_INIT(&list->notifiers);
-- 
2.20.1.2.gb21ebb6


