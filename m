Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24E0C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C6520708
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="hilq0iuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C6520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtki-0003HN-4J
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1kNtk2-0002np-UA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:15:06 -0400
Received: from mail.xenproject.org ([104.130.215.37]:50426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1kNtk1-0000ie-20
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From; bh=FbjlksMu36p7p6zRsPPG2Wo7gSzgDilHr5PW/goywzg=; b=hilq0i
 uzkQAjHMtDMOkBwWo43MPEvjvYipGJgep2B5L2FmfnfwnZK9wyo3jCx9MuD6NGa9UJZuERGXmP8g0
 piILENWxKcwz26eM2X+AzCU2pc07uAvKWdcBEIdS+hvVRF0qI/NiSS8s8crDlSaXGmG/lmc2naT89
 7Q8NQ2jNLK8=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1kNtjy-0008NO-IX; Thu, 01 Oct 2020 08:15:02 +0000
Received: from host109-146-187-185.range109-146.btcentralplus.com
 ([109.146.187.185] helo=u2f063a87eabd5f.home)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1kNtjy-000244-8G; Thu, 01 Oct 2020 08:15:02 +0000
From: Paul Durrant <paul@xen.org>
To: xen-devel@lists.xenproject.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] xen-bus: reduce scope of backend watch
Date: Thu,  1 Oct 2020 09:15:00 +0100
Message-Id: <20201001081500.1026-1-paul@xen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=paul@xen.org;
 helo=mail.xenproject.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <pdurrant@amazon.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Edwin Torok <edvin.torok@citrix.com>,
 Jerome Leseinne <jerome.leseinne@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
Cc: Edwin Torok <edvin.torok@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v2:
 - Re-work casting
 - Check for a NULL watch before trying to remove it
---
 hw/xen/xen-backend.c         | 11 ++++++++++
 hw/xen/xen-bus.c             | 40 ++++++++++++++++++++++++++++--------
 include/hw/xen/xen-backend.h |  1 +
 include/hw/xen/xen-bus.h     |  3 ++-
 4 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
index 10199fb58d..5b0fb76eae 100644
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
index 9ce1c9540b..8c588920d9 100644
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
index 010d712638..aac2fd454d 100644
--- a/include/hw/xen/xen-backend.h
+++ b/include/hw/xen/xen-backend.h
@@ -31,6 +31,7 @@ void xen_backend_set_device(XenBackendInstance *backend,
 XenDevice *xen_backend_get_device(XenBackendInstance *backend);
 
 void xen_backend_register(const XenBackendInfo *info);
+const char **xen_backend_get_types(unsigned int *nr);
 
 void xen_backend_device_create(XenBus *xenbus, const char *type,
                                const char *name, QDict *opts, Error **errp);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3df696136f..6bdbf3ff82 100644
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
2.20.1


