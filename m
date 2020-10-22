Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765EC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454D62244C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX8vUzzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454D62244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVT39-0007kT-6j
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu7-0003lX-52
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStw-0003x9-CH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCUAz/WcgThmhSFD6KwM9qtnbIanE8xzkmYEHtCD6ts=;
 b=VX8vUzzO0dQl9yyXr0j8sBFC1syE1LILmu/Ptb3WVx457A+zq25FkcpJrMMllqN6nnmnF7
 cyJSfwEE0jJn18hkqHo7t0dmD9R/WIq9Wzlgh7rhMDxNV4VW6QTGcikt5R0U3RPxZdYKHH
 XpPgIcGEBx2MKpYGiphX+YRxSv+lYR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-yZ4-3fiiP26ma53PKDrH4w-1; Thu, 22 Oct 2020 01:12:32 -0400
X-MC-Unique: yZ4-3fiiP26ma53PKDrH4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA6E91084D6C
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 603586EF62;
 Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EB0AF204A1; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] modules: dependencies infrastructure
Date: Thu, 22 Oct 2020 07:12:19 +0200
Message-Id: <20201022051223.6181-11-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow modules depending on other modules.

module_load_file() gets the option to export symbols (by not adding the
G_MODULE_BIND_LOCAL flag).

module_load_one() will check the module dependency list to figure (a)
whenever are other modules must be loaded first, or (b) the module
should export the symbols.

The dependencies are specificed as static list in the source code for
now as I expect the list will stay small.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-11-kraxel@redhat.com
---
 util/module.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/util/module.c b/util/module.c
index f0ed05fbd06b..0c0f258923dc 100644
--- a/util/module.c
+++ b/util/module.c
@@ -110,7 +110,7 @@ void module_call_init(module_init_type type)
 }
 
 #ifdef CONFIG_MODULES
-static int module_load_file(const char *fname, bool mayfail)
+static int module_load_file(const char *fname, bool mayfail, bool export_symbols)
 {
     GModule *g_module;
     void (*sym)(void);
@@ -118,7 +118,7 @@ static int module_load_file(const char *fname, bool mayfail)
     int len = strlen(fname);
     int suf_len = strlen(dsosuf);
     ModuleEntry *e, *next;
-    int ret;
+    int ret, flags;
 
     if (len <= suf_len || strcmp(&fname[len - suf_len], dsosuf)) {
         /* wrong suffix */
@@ -132,7 +132,11 @@ static int module_load_file(const char *fname, bool mayfail)
 
     assert(QTAILQ_EMPTY(&dso_init_list));
 
-    g_module = g_module_open(fname, G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
+    flags = G_MODULE_BIND_LAZY;
+    if (!export_symbols) {
+        flags |= G_MODULE_BIND_LOCAL;
+    }
+    g_module = g_module_open(fname, flags);
     if (!g_module) {
         if (!mayfail) {
             fprintf(stderr, "Failed to open module: %s\n",
@@ -167,6 +171,12 @@ static int module_load_file(const char *fname, bool mayfail)
 out:
     return ret;
 }
+
+static const struct {
+    const char *name;
+    const char *dep;
+} module_deps[] = {
+};
 #endif
 
 bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
@@ -182,7 +192,8 @@ bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
     char *dirs[5];
     char *module_name;
     int i = 0, n_dirs = 0;
-    int ret;
+    int ret, dep;
+    bool export_symbols = false;
     static GHashTable *loaded_modules;
 
     if (!g_module_supported()) {
@@ -196,6 +207,17 @@ bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
 
     module_name = g_strdup_printf("%s%s", prefix, lib_name);
 
+    for (dep = 0; dep < ARRAY_SIZE(module_deps); dep++) {
+        if (strcmp(module_name, module_deps[dep].name) == 0) {
+            /* we depend on another module */
+            module_load_one("", module_deps[dep].dep, false);
+        }
+        if (strcmp(module_name, module_deps[dep].dep) == 0) {
+            /* another module depends on us */
+            export_symbols = true;
+        }
+    }
+
     if (!g_hash_table_add(loaded_modules, module_name)) {
         g_free(module_name);
         return true;
@@ -220,7 +242,7 @@ bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
     for (i = 0; i < n_dirs; i++) {
         fname = g_strdup_printf("%s/%s%s",
                 dirs[i], module_name, CONFIG_HOST_DSOSUF);
-        ret = module_load_file(fname, mayfail);
+        ret = module_load_file(fname, mayfail, export_symbols);
         g_free(fname);
         fname = NULL;
         /* Try loading until loaded a module file */
-- 
2.27.0


