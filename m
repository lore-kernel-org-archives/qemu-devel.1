Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0B720897
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="loko2sDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0B720897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7AX-0008RI-Ou
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1kL79G-0007Kp-P7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:57:38 -0400
Received: from mail.xenproject.org ([104.130.215.37]:54706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1kL79E-0003Fw-Ld
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From; bh=IoG8+u5DO3QTJ8mTEeCRhU9y1whcnebb+jEmucWmQMM=; b=loko2s
 DO/2tVDvNW6Zm+rjDG09IjiEI2ZvTLljwR8NnUILuFC3rJhcsmKdqbQ6q/GBoZPZ/FWJ7VmeBlpKi
 PMzsStxiE1y6YQAiq+1n2SYXexHE4/LD24AtmcQfChLTajUl21ZRqSbTYIHOh1hs5ZMl0O+QtuA8a
 oFR6CmAvYzs=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1kL79B-0005sh-T6; Wed, 23 Sep 2020 15:57:33 +0000
Received: from host86-176-94-160.range86-176.btcentralplus.com
 ([86.176.94.160] helo=u2f063a87eabd5f.home)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1kL79B-0003sW-G2; Wed, 23 Sep 2020 15:57:33 +0000
From: Paul Durrant <paul@xen.org>
To: xen-devel@lists.xenproject.org,
	qemu-devel@nongnu.org
Subject: [PATCH] xen-bus: reduce scope of backend watch
Date: Wed, 23 Sep 2020 16:57:31 +0100
Message-Id: <20200923155731.29528-1-paul@xen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=paul@xen.org;
 helo=mail.xenproject.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 11:57:34
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
---
 hw/xen/xen-backend.c         | 10 ++++++++++
 hw/xen/xen-bus.c             | 38 ++++++++++++++++++++++++++++--------
 include/hw/xen/xen-backend.h |  1 +
 include/hw/xen/xen-bus.h     |  3 ++-
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
index 10199fb58d..f2711fe4a7 100644
--- a/hw/xen/xen-backend.c
+++ b/hw/xen/xen-backend.c
@@ -41,6 +41,11 @@ static void xen_backend_table_add(XenBackendImpl *impl)
     g_hash_table_insert(xen_backend_table_get(), (void *)impl->type, impl);
 }
 
+static void **xen_backend_table_keys(unsigned int *count)
+{
+    return g_hash_table_get_keys_as_array(xen_backend_table_get(), count);
+}
+
 static const XenBackendImpl *xen_backend_table_lookup(const char *type)
 {
     return g_hash_table_lookup(xen_backend_table_get(), type);
@@ -70,6 +75,11 @@ void xen_backend_register(const XenBackendInfo *info)
     xen_backend_table_add(impl);
 }
 
+const char **xen_backend_get_types(unsigned int *count)
+{
+    return (const char **)xen_backend_table_keys(count);
+}
+
 static QLIST_HEAD(, XenBackendInstance) backend_list;
 
 static void xen_backend_list_add(XenBackendInstance *backend)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 9ce1c9540b..c83da93bf3 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -430,7 +430,13 @@ static void xen_bus_unrealize(BusState *bus)
     trace_xen_bus_unrealize();
 
     if (xenbus->backend_watch) {
-        xen_bus_remove_watch(xenbus, xenbus->backend_watch, NULL);
+        unsigned int i;
+
+        for (i = 0; i < xenbus->backend_types; i++) {
+            xen_bus_remove_watch(xenbus, xenbus->backend_watch[i], NULL);
+        }
+
+        g_free(xenbus->backend_watch);
         xenbus->backend_watch = NULL;
     }
 
@@ -446,8 +452,11 @@ static void xen_bus_unrealize(BusState *bus)
 
 static void xen_bus_realize(BusState *bus, Error **errp)
 {
+    char *key = g_strdup_printf("%u", xen_domid);
     XenBus *xenbus = XEN_BUS(bus);
     unsigned int domid;
+    const char **type;
+    unsigned int i;
     Error *local_err = NULL;
 
     trace_xen_bus_realize();
@@ -469,19 +478,32 @@ static void xen_bus_realize(BusState *bus, Error **errp)
 
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


