Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB01C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6ED22253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JKmZ25Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6ED22253
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoX4-0003Zj-25
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTw-00088f-3t
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:04 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:49467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTt-0007Dz-V4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1603188181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OpXFFycQpm63jLyG0eJbtosSLwARUWOqqFYJe8oF60I=;
 b=JKmZ25XmE5x56kv2Y/5SJUnpIbbozN9mk0JuZFKD/L+Rj8D2wnm5j/3Y
 5AhvW7T4EMd6HsujuNrWNpvkJSEZ6BeICUfHtRClqAxENMEwNhk2eiVvI
 XBiD4RO6ncCysy8saaph95t7I7X6Obad3PtGvPB8aSOTBJdYkIwIMTqsc U=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: HUdtSCvk176Hqd5za+zmg5siqa+utctAw0qDn5VOihY2m3fWBEkzyDek0qB7FeC/8NVbXQq6Ns
 X1WhSO0X9B78I7Ez7jYVV9P3po9ayOsPasOoVxYcSPGQeUZY1XrA8KVMsvjSHt+13/wrTY1YDr
 +cf2FiamsVjK8u7hLS0mZQOaCYDG9FNP0nTGDAE0KqnmtM9MSLzA+3OixVQV1zBWzc/eptn8KD
 v8F2jfZwSzt3zUJ+bjDH6IHbItNqiQ5WXAYmGL4ZUq2exeXZxlfqp6jMty28R2xTdxy5LVImFF
 mjE=
X-SBRS: None
X-MesageID: 30419947
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,396,1596513600"; d="scan'208";a="30419947"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant
 <pdurrant@amazon.com>, Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 3/4] xen-bus: reduce scope of backend watch
Date: Tue, 20 Oct 2020 11:02:38 +0100
Message-ID: <20201020100239.272748-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020100239.272748-1-anthony.perard@citrix.com>
References: <20201020100239.272748-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:02:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

From: Paul Durrant <pdurrant@amazon.com>

Currently a single watch on /local/domain/X/backend is registered by each
QEMU process running in service domain X (where X is usually 0). The purpose
of this watch is to ensure that QEMU is notified when the Xen toolstack
creates a new device backend area.
Such a backend area is specific to a single frontend area created for a
specific guest domain and, since each QEMU process is also created to service
a specfic guest domain, it is unnecessary and inefficient to notify all QEMU
processes.
Only the QEMU process associated with the same guest domain need
receive the notification. This patch re-factors the watch registration code
such that notifications are targetted appropriately.

Reported-by: Jerome Leseinne <jerome.leseinne@gmail.com>
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20201001081500.1026-1-paul@xen.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-backend.c         | 11 ++++++++++
 hw/xen/xen-bus.c             | 40 ++++++++++++++++++++++++++++--------
 include/hw/xen/xen-backend.h |  1 +
 include/hw/xen/xen-bus.h     |  3 ++-
 4 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
index 10199fb58d10..5b0fb76eaeb3 100644
--- a/hw/xen/xen-backend.c
+++ b/hw/xen/xen-backend.c
@@ -41,6 +41,12 @@ static void xen_backend_table_add(XenBackendImpl *impl)
     g_hash_table_insert(xen_backend_table_get(), (void *)impl->type, impl);
 }
 
+static const char **xen_backend_table_keys(unsigned int *count)
+{
+    return (const char **)g_hash_table_get_keys_as_array(
+        xen_backend_table_get(), count);
+}
+
 static const XenBackendImpl *xen_backend_table_lookup(const char *type)
 {
     return g_hash_table_lookup(xen_backend_table_get(), type);
@@ -70,6 +76,11 @@ void xen_backend_register(const XenBackendInfo *info)
     xen_backend_table_add(impl);
 }
 
+const char **xen_backend_get_types(unsigned int *count)
+{
+    return xen_backend_table_keys(count);
+}
+
 static QLIST_HEAD(, XenBackendInstance) backend_list;
 
 static void xen_backend_list_add(XenBackendInstance *backend)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 9ce1c9540b9e..8c588920d9fc 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -430,7 +430,15 @@ static void xen_bus_unrealize(BusState *bus)
     trace_xen_bus_unrealize();
 
     if (xenbus->backend_watch) {
-        xen_bus_remove_watch(xenbus, xenbus->backend_watch, NULL);
+        unsigned int i;
+
+        for (i = 0; i < xenbus->backend_types; i++) {
+            if (xenbus->backend_watch[i]) {
+                xen_bus_remove_watch(xenbus, xenbus->backend_watch[i], NULL);
+            }
+        }
+
+        g_free(xenbus->backend_watch);
         xenbus->backend_watch = NULL;
     }
 
@@ -446,8 +454,11 @@ static void xen_bus_unrealize(BusState *bus)
 
 static void xen_bus_realize(BusState *bus, Error **errp)
 {
+    char *key = g_strdup_printf("%u", xen_domid);
     XenBus *xenbus = XEN_BUS(bus);
     unsigned int domid;
+    const char **type;
+    unsigned int i;
     Error *local_err = NULL;
 
     trace_xen_bus_realize();
@@ -469,19 +480,32 @@ static void xen_bus_realize(BusState *bus, Error **errp)
 
     module_call_init(MODULE_INIT_XEN_BACKEND);
 
-    xenbus->backend_watch =
-        xen_bus_add_watch(xenbus, "", /* domain root node */
-                          "backend", xen_bus_backend_changed, &local_err);
-    if (local_err) {
-        /* This need not be treated as a hard error so don't propagate */
-        error_reportf_err(local_err,
-                          "failed to set up enumeration watch: ");
+    type = xen_backend_get_types(&xenbus->backend_types);
+    xenbus->backend_watch = g_new(XenWatch *, xenbus->backend_types);
+
+    for (i = 0; i < xenbus->backend_types; i++) {
+        char *node = g_strdup_printf("backend/%s", type[i]);
+
+        xenbus->backend_watch[i] =
+            xen_bus_add_watch(xenbus, node, key, xen_bus_backend_changed,
+                              &local_err);
+        if (local_err) {
+            /* This need not be treated as a hard error so don't propagate */
+            error_reportf_err(local_err,
+                              "failed to set up '%s' enumeration watch: ",
+                              type[i]);
+        }
+
+        g_free(node);
     }
 
+    g_free(type);
+    g_free(key);
     return;
 
 fail:
     xen_bus_unrealize(bus);
+    g_free(key);
 }
 
 static void xen_bus_unplug_request(HotplugHandler *hotplug,
diff --git a/include/hw/xen/xen-backend.h b/include/hw/xen/xen-backend.h
index 010d71263876..aac2fd454d44 100644
--- a/include/hw/xen/xen-backend.h
+++ b/include/hw/xen/xen-backend.h
@@ -31,6 +31,7 @@ void xen_backend_set_device(XenBackendInstance *backend,
 XenDevice *xen_backend_get_device(XenBackendInstance *backend);
 
 void xen_backend_register(const XenBackendInfo *info);
+const char **xen_backend_get_types(unsigned int *nr);
 
 void xen_backend_device_create(XenBus *xenbus, const char *type,
                                const char *name, QDict *opts, Error **errp);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3df696136f7b..6bdbf3ff8220 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -66,7 +66,8 @@ struct XenBus {
     domid_t backend_id;
     struct xs_handle *xsh;
     XenWatchList *watch_list;
-    XenWatch *backend_watch;
+    unsigned int backend_types;
+    XenWatch **backend_watch;
     QLIST_HEAD(, XenDevice) inactive_devices;
 };
 
-- 
Anthony PERARD


