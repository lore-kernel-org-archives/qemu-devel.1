Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B53CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4519820658
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8vF+U4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4519820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnsm-0008Kn-DO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsnrv-0006dU-0c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:42:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsnrs-0004Yw-TF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594129360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=aWEGvrK7YSjXUBMVlkvwbjgfnMCter2xKCRiNrgagJg=;
 b=d8vF+U4Q6K4/lAGF/Td47Am782OKAB0CFUui8S34dTvkhISM2ntnUyTC6S0J++7hcVxtbO
 +3Ikq+MMa0wPSResOxyr+kCHswUAjR9U5uRHx7jwqVmdyGYZqXy2yUXD4wXDTFDIAVm96j
 WL8nt366U41a6S07iRwrG+wDVJhquJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-C0MNZ5h3MkG7ScI8bTOtow-1; Tue, 07 Jul 2020 09:42:38 -0400
X-MC-Unique: C0MNZ5h3MkG7ScI8bTOtow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9C7DC28
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 13:42:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB6D7788F;
 Tue,  7 Jul 2020 13:42:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CA73F31F24; Tue,  7 Jul 2020 15:42:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] qdev: device module support
Date: Tue,  7 Jul 2020 15:42:22 +0200
Message-Id: <20200707134229.9773-4-kraxel@redhat.com>
In-Reply-To: <20200707134229.9773-1-kraxel@redhat.com>
References: <20200707134229.9773-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hook module loading into the places where we
need it when building devices as modules.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200624131045.14512-4-kraxel@redhat.com
---
 hw/core/qdev.c     | 6 ++++--
 qdev-monitor.c     | 5 +++--
 qom/qom-qmp-cmds.c | 3 ++-
 softmmu/vl.c       | 4 ++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951dd..9de16eae05b7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -137,6 +137,9 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
  */
 DeviceState *qdev_new(const char *name)
 {
+    if (!object_class_by_name(name)) {
+        module_load_qom_one(name);
+    }
     return DEVICE(object_new(name));
 }
 
@@ -147,10 +150,9 @@ DeviceState *qdev_new(const char *name)
  */
 DeviceState *qdev_try_new(const char *name)
 {
-    if (!object_class_by_name(name)) {
+    if (!module_object_class_by_name(name)) {
         return NULL;
     }
-
     return DEVICE(object_new(name));
 }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 22da107484c5..8e7a7f7bbdbc 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -147,6 +147,7 @@ static void qdev_print_devinfos(bool show_no_user)
     int i;
     bool cat_printed;
 
+    module_load_qom_all();
     list = object_class_get_list_sorted(TYPE_DEVICE, false);
 
     for (i = 0; i <= DEVICE_CATEGORY_MAX; i++) {
@@ -215,13 +216,13 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
     DeviceClass *dc;
     const char *original_name = *driver;
 
-    oc = object_class_by_name(*driver);
+    oc = module_object_class_by_name(*driver);
     if (!oc) {
         const char *typename = find_typename_by_alias(*driver);
 
         if (typename) {
             *driver = typename;
-            oc = object_class_by_name(*driver);
+            oc = module_object_class_by_name(*driver);
         }
     }
 
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index c5249e44d020..5e2c8cbf333f 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -116,6 +116,7 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
 {
     ObjectTypeInfoList *ret = NULL;
 
+    module_load_qom_all();
     object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
 
     return ret;
@@ -130,7 +131,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
     ObjectPropertyIterator iter;
     ObjectPropertyInfoList *prop_list = NULL;
 
-    klass = object_class_by_name(typename);
+    klass = module_object_class_by_name(typename);
     if (klass == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                   "Device '%s' not found", typename);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3e15ee243572..5acb65d7f48c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1772,8 +1772,8 @@ static bool vga_interface_available(VGAInterfaceType t)
 
     assert(t < VGA_TYPE_MAX);
     return !ti->class_names[0] ||
-           object_class_by_name(ti->class_names[0]) ||
-           object_class_by_name(ti->class_names[1]);
+           module_object_class_by_name(ti->class_names[0]) ||
+           module_object_class_by_name(ti->class_names[1]);
 }
 
 static const char *
-- 
2.18.4


