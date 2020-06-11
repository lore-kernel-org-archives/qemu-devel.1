Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1301DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FC62072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWzwYf8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FC62072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIUT-0006PL-0o
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jjITW-0004qP-NL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:22:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jjITU-0006qd-BO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591863730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=m2yv07S+Jzz+ZmV3AmBtr+0sKpxMyFYao4v1mJ/9W1E=;
 b=LWzwYf8PxJx6rToTGKRBLwyyp5ZnVLCbZKNGUBdvsFsfRqEhVPcwuRwFxm/PPOS4CWjVJx
 7PdfWuzhzp6q7Zzsfmop8VtRRIxXUexfJW9zJxm2F4ZuSlTgrIRjZum8dCtqsCQhOvHc87
 EVyKIrB0qNPrHZ2aDyXxXtHQWWSudus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-pP7llZ_kOVSRnQG3fObFiA-1; Thu, 11 Jun 2020 04:22:08 -0400
X-MC-Unique: pP7llZ_kOVSRnQG3fObFiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F4B835B44
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:22:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A249C5C1B0;
 Thu, 11 Jun 2020 08:22:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 189031750A; Thu, 11 Jun 2020 10:22:00 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] qdev: add support for device module loading
Date: Thu, 11 Jun 2020 10:21:53 +0200
Message-Id: <20200611082200.26331-2-kraxel@redhat.com>
In-Reply-To: <20200611082200.26331-1-kraxel@redhat.com>
References: <20200611082200.26331-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:35
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When compiling devices as modules we'll need some infrastrtucture to
actually load those modules if needed.  This patch adds it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/qdev-core.h |  3 +++
 include/qemu/module.h  |  1 +
 hw/core/qdev.c         | 50 ++++++++++++++++++++++++++++++++++++++++++
 qdev-monitor.c         |  5 +++++
 qom/qom-qmp-cmds.c     |  5 +++++
 softmmu/vl.c           |  4 ++++
 stubs/hw-module.c      | 10 +++++++++
 stubs/Makefile.objs    |  1 +
 8 files changed, 79 insertions(+)
 create mode 100644 stubs/hw-module.c

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b870b279661a..a96c890bb95b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -552,4 +552,7 @@ void device_listener_unregister(DeviceListener *listener);
  */
 bool qdev_should_hide_device(QemuOpts *opts);
 
+void qdev_module_load_type(const char *type);
+void qdev_module_load_all(void);
+
 #endif
diff --git a/include/qemu/module.h b/include/qemu/module.h
index 011ae1ae7605..077a6b09bca7 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -64,6 +64,7 @@ typedef enum {
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
 #define audio_module_load_one(lib) module_load_one("audio-", lib)
+#define hw_module_load_one(lib) module_load_one("hw-", lib)
 
 void register_module_init(void (*fn)(void), module_init_type type);
 void register_dso_module_init(void (*fn)(void), module_init_type type);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9e5538aeaebd..342b5b64871e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -146,10 +146,60 @@ DeviceState *qdev_create(BusState *bus, const char *name)
     return dev;
 }
 
+/*
+ * Building devices modular is mostly useful in case they have
+ * dependencies to external libraries.  Which is the case for very few
+ * devices.  So with the expectation that this will be rather the
+ * exception than to rule go with a simple hardcoded list for now ...
+ */
+static struct {
+    const char *type;
+    const char *mod;
+} const hwmodules[] = {
+};
+
+static bool qdev_module_loaded_all;
+
+void qdev_module_load_type(const char *type)
+{
+    int i;
+
+    if (qdev_module_loaded_all) {
+        return;
+    }
+    for (i = 0; i < ARRAY_SIZE(hwmodules); i++) {
+        if (strcmp(hwmodules[i].type, type) == 0) {
+            hw_module_load_one(hwmodules[i].mod);
+            return;
+        }
+    }
+}
+
+void qdev_module_load_all(void)
+{
+    int i;
+
+    if (qdev_module_loaded_all) {
+        return;
+    }
+    for (i = 0; i < ARRAY_SIZE(hwmodules); i++) {
+        if (i > 0 && strcmp(hwmodules[i - 1].mod,
+                            hwmodules[i].mod) == 0) {
+            /* one module implementing multiple devices -> load only once */
+            continue;
+        }
+        hw_module_load_one(hwmodules[i].mod);
+    }
+    qdev_module_loaded_all = true;
+}
+
 DeviceState *qdev_try_create(BusState *bus, const char *type)
 {
     DeviceState *dev;
 
+    if (object_class_by_name(type) == NULL) {
+        qdev_module_load_type(type);
+    }
     if (object_class_by_name(type) == NULL) {
         return NULL;
     }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index a4735d3bb190..55dddeb2f978 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -147,6 +147,7 @@ static void qdev_print_devinfos(bool show_no_user)
     int i;
     bool cat_printed;
 
+    qdev_module_load_all();
     list = object_class_get_list_sorted(TYPE_DEVICE, false);
 
     for (i = 0; i <= DEVICE_CATEGORY_MAX; i++) {
@@ -224,6 +225,10 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
             oc = object_class_by_name(*driver);
         }
     }
+    if (!oc) {
+        qdev_module_load_type(*driver);
+        oc = object_class_by_name(*driver);
+    }
 
     if (!object_class_dynamic_cast(oc, TYPE_DEVICE)) {
         if (*driver != original_name) {
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index c5249e44d020..4e0d7e53cd16 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -116,6 +116,7 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
 {
     ObjectTypeInfoList *ret = NULL;
 
+    qdev_module_load_all();
     object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
 
     return ret;
@@ -131,6 +132,10 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
     ObjectPropertyInfoList *prop_list = NULL;
 
     klass = object_class_by_name(typename);
+    if (klass == NULL) {
+        qdev_module_load_type(typename);
+        klass = object_class_by_name(typename);
+    }
     if (klass == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                   "Device '%s' not found", typename);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 05d1a4cb6bf8..f93724c8cc56 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1770,6 +1770,10 @@ static bool vga_interface_available(VGAInterfaceType t)
 {
     const VGAInterfaceInfo *ti = &vga_interfaces[t];
 
+    if (ti->class_names[0] && !object_class_by_name(ti->class_names[0])) {
+        qdev_module_load_type(ti->class_names[0]);
+    }
+
     assert(t < VGA_TYPE_MAX);
     return !ti->class_names[0] ||
            object_class_by_name(ti->class_names[0]) ||
diff --git a/stubs/hw-module.c b/stubs/hw-module.c
new file mode 100644
index 000000000000..58b2160b97fe
--- /dev/null
+++ b/stubs/hw-module.c
@@ -0,0 +1,10 @@
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+
+void qdev_module_load_all(void)
+{
+}
+
+void qdev_module_load_type(const char *type)
+{
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c1e43ac68f87..40d630202648 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -5,6 +5,7 @@ stub-obj-y += dump.o
 stub-obj-y += error-printf.o
 stub-obj-y += fdset.o
 stub-obj-y += gdbstub.o
+stub-obj-y += hw-module.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
-- 
2.18.4


