Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDBC43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878CD22251
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRyeK0bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878CD22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2pQ-0002Il-EQ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT2lL-0005XS-I0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT2lJ-0002fF-KL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602766420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fg/4vi/oMFKQXb4y2H//iZd15YYvhthlbcxywBirMoQ=;
 b=dRyeK0bfDT3LrLe/PDq4GIYXXhYWDCx2PFhOR/I7fu6UnDDLVBbeUiXszroR4VzfuY1ELX
 GtrYWZeDn4nCOFAgrYodbPxrs1xqFo6scaIErBQMylxrbPqg/gGDTLC2WmYT582aem1g94
 Qfc60aqerfkAVQexiPcWzmDn83S1TN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-nJAaNeFfOfO2Z-NNwl3whA-1; Thu, 15 Oct 2020 08:53:39 -0400
X-MC-Unique: nJAaNeFfOfO2Z-NNwl3whA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C54118A8231
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:53:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8317919C66;
 Thu, 15 Oct 2020 12:53:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A2A9F1750A; Thu, 15 Oct 2020 14:53:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] module: silence errors for module_load_qom_all().
Date: Thu, 15 Oct 2020 14:53:15 +0200
Message-Id: <20201015125322.23648-2-kraxel@redhat.com>
In-Reply-To: <20201015125322.23648-1-kraxel@redhat.com>
References: <20201015125322.23648-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200923091217.22662-1-kraxel@redhat.com
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
index 2c6e8dc858c4..7965dc9a16ba 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -757,7 +757,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(words[1] && words[2]);
 
         qtest_send_prefix(chr);
-        if (module_load_one(words[1], words[2])) {
+        if (module_load_one(words[1], words[2], false)) {
             qtest_sendf(chr, "OK\n");
         } else {
             qtest_sendf(chr, "FAIL\n");
diff --git a/util/module.c b/util/module.c
index a44ec38d9362..836fd444e1fd 100644
--- a/util/module.c
+++ b/util/module.c
@@ -110,7 +110,7 @@ void module_call_init(module_init_type type)
 }
 
 #ifdef CONFIG_MODULES
-static int module_load_file(const char *fname)
+static int module_load_file(const char *fname, bool mayfail)
 {
     GModule *g_module;
     void (*sym)(void);
@@ -134,8 +134,10 @@ static int module_load_file(const char *fname)
 
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
@@ -167,7 +169,7 @@ out:
 }
 #endif
 
-bool module_load_one(const char *prefix, const char *lib_name)
+bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
 {
     bool success = false;
 
@@ -218,7 +220,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
     for (i = 0; i < n_dirs; i++) {
         fname = g_strdup_printf("%s/%s%s",
                 dirs[i], module_name, CONFIG_HOST_DSOSUF);
-        ret = module_load_file(fname);
+        ret = module_load_file(fname, mayfail);
         g_free(fname);
         fname = NULL;
         /* Try loading until loaded a module file */
@@ -275,13 +277,11 @@ void module_load_qom_one(const char *type)
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
@@ -302,7 +302,7 @@ void module_load_qom_all(void)
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


