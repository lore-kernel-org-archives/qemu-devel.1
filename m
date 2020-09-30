Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5D7C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292CC20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3Jzigm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292CC20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfVd-0003O4-Vt
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJM-0006Vg-5g
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJB-00076e-V3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JnF87mYv9nAoTiMqtlszBIcwjhpYBnj/f8wWUylyEBo=;
 b=d3Jzigm3vWvAVN3XVWATzF/7tI/mjnK96SpRkl6K2ZIG5yN9Ed7yifzTUumLHjlkMK/YdK
 a12A2IooXdx8wgZGEx9+Oy6v28K9g+o3MnKtlov8eT4VhjCYixnHqC3Lc+cbdcjpe919sv
 fMYgNcM1hm1CYRt1NgjT4dlXy+p5QmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-dkJimKjNNlKFEU4jHMp0UQ-1; Wed, 30 Sep 2020 12:50:20 -0400
X-MC-Unique: dkJimKjNNlKFEU4jHMp0UQ-1
Received: by mail-wm1-f69.google.com with SMTP id r10so221562wmh.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JnF87mYv9nAoTiMqtlszBIcwjhpYBnj/f8wWUylyEBo=;
 b=E44S2S3QqoM82f/P9Jr7Gp6UlRwhSIegQehteu13kHBjvcBPejPkw4GN22YBSN/zMj
 sbyLwgglKO2mPRQ3NlKvkg/VjQVz4hoJ7ZIXM9SQv2klaG4I4T4fDTON6X99nTdA70tg
 LCEvGUup7lhiBKNyN2jaO5xMwYDpSQ7J/cODEyL/+AJGAqAVNCLtrqKDpw7dQGYrZX0N
 6c96V/teSGq7baGrvJcl3XFY5t5xpsfFsyuPXCWxw232Gu/03wi8D2vMToeYYjY/1qc/
 EatpeSL+zfg5MZMbms1xxbg+BDBiwFDqKCEeSc5qeQ8vU9CSToNabmFDFpLjm00e903b
 Z3Cw==
X-Gm-Message-State: AOAM533KucGCtNtBl62sqsm/JYlSX1feoDEF9Af3TihrZZAk4EPcOOKg
 Fpxf8UYJJvU4WuACkQ9O2MOF+/nvW1bUS4vDgxX7zcaVYcYNpzJ1UP0w5qWqjBnLFD2DEtECyR/
 XDek3hp9XhRX394o=
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr4164929wrt.122.1601484618804; 
 Wed, 30 Sep 2020 09:50:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7NiQM0mxDOzxHSfAyhi8ASwWDi0eN5yG6RQuak95CeGWRLYJFGw3mi2qS/uUXhISKB0mjdA==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr4164898wrt.122.1601484618525; 
 Wed, 30 Sep 2020 09:50:18 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y1sm3951468wmi.36.2020.09.30.09.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 05/11] hw/core/qdev-properties: Export enum-related
 functions
Date: Wed, 30 Sep 2020 18:49:43 +0200
Message-Id: <20200930164949.1425294-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split this file and reuse these static functions.
Add the local "qdev-prop-internal.h" header declaring them.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/qdev-prop-internal.h | 19 ++++++++++++
 hw/core/qdev-properties.c    | 58 +++++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 28 deletions(-)
 create mode 100644 hw/core/qdev-prop-internal.h

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
new file mode 100644
index 0000000000..2a8c9a306a
--- /dev/null
+++ b/hw/core/qdev-prop-internal.h
@@ -0,0 +1,19 @@
+/*
+ * qdev property parsing
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CORE_QDEV_PROP_INTERNAL_H
+#define HW_CORE_QDEV_PROP_INTERNAL_H
+
+void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp);
+void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp);
+
+void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
+                                          const Property *prop);
+
+#endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 071fd5864a..76417d0936 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -18,6 +18,7 @@
 #include "qemu/uuid.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qdev-prop-internal.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -53,8 +54,8 @@ void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
     return ptr;
 }
 
-static void get_enum(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
+void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
@@ -63,8 +64,8 @@ static void get_enum(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
 
-static void set_enum(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
+void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
@@ -78,7 +79,8 @@ static void set_enum(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
 
-static void set_default_value_enum(ObjectProperty *op, const Property *prop)
+void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
+                                          const Property *prop)
 {
     object_property_set_default_str(op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
@@ -669,9 +671,9 @@ const PropertyInfo qdev_prop_on_off_auto = {
     .name = "OnOffAuto",
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
-    .get = get_enum,
-    .set = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- lost tick policy --- */
@@ -681,9 +683,9 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 const PropertyInfo qdev_prop_losttickpolicy = {
     .name  = "LostTickPolicy",
     .enum_table  = &LostTickPolicy_lookup,
-    .get   = get_enum,
-    .set   = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- Block device error handling policy --- */
@@ -695,9 +697,9 @@ const PropertyInfo qdev_prop_blockdev_on_error = {
     .description = "Error handling policy, "
                    "report/ignore/enospc/stop/auto",
     .enum_table = &BlockdevOnError_lookup,
-    .get = get_enum,
-    .set = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- BIOS CHS translation */
@@ -709,9 +711,9 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
     .description = "Logical CHS translation algorithm, "
                    "auto/none/lba/large/rechs",
     .enum_table = &BiosAtaTranslation_lookup,
-    .get = get_enum,
-    .set = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- FDC default drive types */
@@ -721,9 +723,9 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
     .description = "FDC drive type, "
                    "144/288/120/none/auto",
     .enum_table = &FloppyDriveType_lookup,
-    .get = get_enum,
-    .set = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- MultiFDCompression --- */
@@ -733,9 +735,9 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .description = "multifd_compression values, "
                    "none/zlib/zstd",
     .enum_table = &MultiFDCompression_lookup,
-    .get = get_enum,
-    .set = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- pci address --- */
@@ -1416,9 +1418,9 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
     .name = "OffAutoPCIBAR",
     .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
     .enum_table = &OffAutoPCIBAR_lookup,
-    .get = get_enum,
-    .set = set_enum,
-    .set_default_value = set_default_value_enum,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- PCIELinkSpeed 2_5/5/8/16 -- */
@@ -1495,7 +1497,7 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
     .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
-    .set_default_value = set_default_value_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 /* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
@@ -1590,5 +1592,5 @@ const PropertyInfo qdev_prop_pcie_link_width = {
     .enum_table = &PCIELinkWidth_lookup,
     .get = get_prop_pcielinkwidth,
     .set = set_prop_pcielinkwidth,
-    .set_default_value = set_default_value_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
 };
-- 
2.26.2


