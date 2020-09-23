Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224E4214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cf1qJ0SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224E4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL184-0000yb-5T
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0p9-0002ag-Gr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0p7-0002VV-IP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kKr1tPg44mPe/WbX0xe37Ucwa7Fy/C1VRwVjYjwfY7c=;
 b=cf1qJ0SSVXiPzTZNwyB74EMuXV/S6Ht/N3R4AQvgani2p3cSAAqUTmIlTPQ7P+7SLsMHkZ
 NYFNM4unCLHQSJPfCYc9VR8w+U7mKahbuJiaSDIX7SS13edkGaDvvO9UFw25YfB2aMnrI/
 IS7QHapjn8relhmq28lcrNbUWwvi/oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-aSGXDD-gMG25ycD1meFODA-1; Wed, 23 Sep 2020 05:12:22 -0400
X-MC-Unique: aSGXDD-gMG25ycD1meFODA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C875281CBE5
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 09:12:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74A5A5C1DC;
 Wed, 23 Sep 2020 09:12:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 979A431E60; Wed, 23 Sep 2020 11:12:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] module: silence errors for module_load_qom_all().
Date: Wed, 23 Sep 2020 11:12:17 +0200
Message-Id: <20200923091217.22662-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add mayfail bool parameter to module loading functions.  Set it to true
for module_load_qom_all() because device modules might not load into all
system emulation variants.  qemu-system-s390x for example will not load
qxl because it lacks vga support.  Makes "make check" less chatty.

Drop module_loaded_qom_all check in module_load_qom_one to make sure we
see errors for explicit load requests, i.e. module_load_qom_one("qxl")
failing will log an error no matter whenever module_load_qom_all() was
called before or not.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/module.h |  8 ++++----
 softmmu/qtest.c       |  2 +-
 util/module.c         | 20 ++++++++++----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 9121a475c1b6..944d403cbd15 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -61,15 +61,15 @@ typedef enum {
 #define fuzz_target_init(function) module_init(function, \
                                                MODULE_INIT_FUZZ_TARGET)
 #define migration_init(function) module_init(function, MODULE_INIT_MIGRATION)
-#define block_module_load_one(lib) module_load_one("block-", lib)
-#define ui_module_load_one(lib) module_load_one("ui-", lib)
-#define audio_module_load_one(lib) module_load_one("audio-", lib)
+#define block_module_load_one(lib) module_load_one("block-", lib, false)
+#define ui_module_load_one(lib) module_load_one("ui-", lib, false)
+#define audio_module_load_one(lib) module_load_one("audio-", lib, false)
 
 void register_module_init(void (*fn)(void), module_init_type type);
 void register_dso_module_init(void (*fn)(void), module_init_type type);
 
 void module_call_init(module_init_type type);
-bool module_load_one(const char *prefix, const char *lib_name);
+bool module_load_one(const char *prefix, const char *lib_name, bool mayfail);
 void module_load_qom_one(const char *type);
 void module_load_qom_all(void);
 
diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 4e439caec7e9..6f697c8a6987 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -670,7 +670,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(words[1] && words[2]);
 
         qtest_send_prefix(chr);
-        if (module_load_one(words[1], words[2])) {
+        if (module_load_one(words[1], words[2], false)) {
             qtest_sendf(chr, "OK\n");
         } else {
             qtest_sendf(chr, "FAIL\n");
diff --git a/util/module.c b/util/module.c
index 34772e7d87eb..1535e7da4c06 100644
--- a/util/module.c
+++ b/util/module.c
@@ -109,7 +109,7 @@ void module_call_init(module_init_type type)
 }
 
 #ifdef CONFIG_MODULES
-static int module_load_file(const char *fname)
+static int module_load_file(const char *fname, bool mayfail)
 {
     GModule *g_module;
     void (*sym)(void);
@@ -133,8 +133,10 @@ static int module_load_file(const char *fname)
 
     g_module = g_module_open(fname, G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
     if (!g_module) {
-        fprintf(stderr, "Failed to open module: %s\n",
-                g_module_error());
+        if (!mayfail) {
+            fprintf(stderr, "Failed to open module: %s\n",
+                    g_module_error());
+        }
         ret = -EINVAL;
         goto out;
     }
@@ -166,7 +168,7 @@ out:
 }
 #endif
 
-bool module_load_one(const char *prefix, const char *lib_name)
+bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
 {
     bool success = false;
 
@@ -222,7 +224,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
     for (i = 0; i < n_dirs; i++) {
         fname = g_strdup_printf("%s/%s%s",
                 dirs[i], module_name, CONFIG_HOST_DSOSUF);
-        ret = module_load_file(fname);
+        ret = module_load_file(fname, mayfail);
         g_free(fname);
         fname = NULL;
         /* Try loading until loaded a module file */
@@ -279,13 +281,11 @@ void module_load_qom_one(const char *type)
     if (!type) {
         return;
     }
-    if (module_loaded_qom_all) {
-        return;
-    }
     for (i = 0; i < ARRAY_SIZE(qom_modules); i++) {
         if (strcmp(qom_modules[i].type, type) == 0) {
             module_load_one(qom_modules[i].prefix,
-                            qom_modules[i].module);
+                            qom_modules[i].module,
+                            false);
             return;
         }
     }
@@ -306,7 +306,7 @@ void module_load_qom_all(void)
             /* one module implementing multiple types -> load only once */
             continue;
         }
-        module_load_one(qom_modules[i].prefix, qom_modules[i].module);
+        module_load_one(qom_modules[i].prefix, qom_modules[i].module, true);
     }
     module_loaded_qom_all = true;
 }
-- 
2.27.0


