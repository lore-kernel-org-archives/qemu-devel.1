Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB29C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAA6207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLCrxZM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAA6207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyGo-0004qO-QN
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqyDK-0000Cx-BP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:21:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqyDI-0000ea-KJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593692472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=fMprw3S8bj72InmJ3h279GUyyDfsULSh5AyJa+jLrDM=;
 b=BLCrxZM15zOm693IRJaISYq4kHAfr9cmZmsbsy2wOJZnKIwBfy5ZVWqcoYYde4+VzulP6y
 jB6tUEzf0/QBhsyCGSdcX5gDbeoqvzLuKA5u1JZnaC4Xa9jyGwFZc1eM7DQF9zVoUdo9e7
 sVSnfhGIVcCoh/EoPZhJmb4wpkH2QZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-JUa4_31HPAierjQ2f5vFEA-1; Thu, 02 Jul 2020 08:21:10 -0400
X-MC-Unique: JUa4_31HPAierjQ2f5vFEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A31618FF669
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 12:20:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDF792C2BB;
 Thu,  2 Jul 2020 12:20:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2979531E85; Thu,  2 Jul 2020 14:20:48 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] module: qom module support
Date: Thu,  2 Jul 2020 14:20:39 +0200
Message-Id: <20200702122048.27798-2-kraxel@redhat.com>
In-Reply-To: <20200702122048.27798-1-kraxel@redhat.com>
References: <20200702122048.27798-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
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
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for qom types provided by modules.  For starters use a
manually maintained list which maps qom type to module and prefix.

Two load functions are added:  One to load the module for a specific
type, and one to load all modules (needed for object/device lists as
printed by -- for example -- qemu -device help).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200624131045.14512-2-kraxel@redhat.com
---
 include/qemu/module.h |  2 ++
 util/module.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 011ae1ae7605..9121a475c1b6 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -70,5 +70,7 @@ void register_dso_module_init(void (*fn)(void), module_init_type type);
 
 void module_call_init(module_init_type type);
 bool module_load_one(const char *prefix, const char *lib_name);
+void module_load_qom_one(const char *type);
+void module_load_qom_all(void);
 
 #endif
diff --git a/util/module.c b/util/module.c
index e48d9aacc05a..ee560a4b4269 100644
--- a/util/module.c
+++ b/util/module.c
@@ -245,3 +245,58 @@ bool module_load_one(const char *prefix, const char *lib_name)
 #endif
     return success;
 }
+
+/*
+ * Building devices and other qom objects modular is mostly useful in
+ * case they have dependencies to external shared libraries, so we can
+ * cut down the core qemu library dependencies.  Which is the case for
+ * only a very few devices & objects.
+ *
+ * So with the expectation that this will be rather the exception than
+ * to rule and the list will not gain that many entries go with a
+ * simple manually maintained list for now.
+ */
+static struct {
+    const char *type;
+    const char *prefix;
+    const char *module;
+} const qom_modules[] = {
+};
+
+static bool module_loaded_qom_all;
+
+void module_load_qom_one(const char *type)
+{
+    int i;
+
+    if (module_loaded_qom_all) {
+        return;
+    }
+    for (i = 0; i < ARRAY_SIZE(qom_modules); i++) {
+        if (strcmp(qom_modules[i].type, type) == 0) {
+            module_load_one(qom_modules[i].prefix,
+                            qom_modules[i].module);
+            return;
+        }
+    }
+}
+
+void module_load_qom_all(void)
+{
+    int i;
+
+    if (module_loaded_qom_all) {
+        return;
+    }
+    for (i = 0; i < ARRAY_SIZE(qom_modules); i++) {
+        if (i > 0 && (strcmp(qom_modules[i - 1].module,
+                             qom_modules[i].module) == 0 &&
+                      strcmp(qom_modules[i - 1].prefix,
+                             qom_modules[i].prefix) == 0)) {
+            /* one module implementing multiple types -> load only once */
+            continue;
+        }
+        module_load_one(qom_modules[i].prefix, qom_modules[i].module);
+    }
+    module_loaded_qom_all = true;
+}
-- 
2.18.4


