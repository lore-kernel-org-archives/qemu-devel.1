Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B916AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CCF20720
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gxu7cECB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CCF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5FJ-0000Eb-N2
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5BB-0002Oo-Sl
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5B5-0001S7-H3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593004258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=3arQYzUakvsEsZj46IHWx5U5R2JTza3tPTR92n9R/ag=;
 b=Gxu7cECBpMDp7ei5WpAK20IEnFpsj0iHft76pMSYgBnUm/0yu3VA9Kjho0hP039nEgQJpR
 6845u9pBkLsdVU7Zxt5IWSbjSzrlUHXwiIuadlUPc9hsULyXJ8HEBltn98XNY1WHTi0QRb
 E67WwwnjLMBCdmPv+JTNeBd64VpmaTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-juzJG9ksMGWUmeYhD7FfrA-1; Wed, 24 Jun 2020 09:10:56 -0400
X-MC-Unique: juzJG9ksMGWUmeYhD7FfrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B63805EE5
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:10:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 818A979317;
 Wed, 24 Jun 2020 13:10:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B530D59CC; Wed, 24 Jun 2020 15:10:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/10] qdev: device module support
Date: Wed, 24 Jun 2020 15:10:38 +0200
Message-Id: <20200624131045.14512-4-kraxel@redhat.com>
In-Reply-To: <20200624131045.14512-1-kraxel@redhat.com>
References: <20200624131045.14512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hook module loading into the places where we
need it when building devices as modules.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
index f669c06ede4a..1297815a5f5b 100644
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


