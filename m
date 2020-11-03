Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77583C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF07D22280
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URH8NavJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF07D22280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxEs-0003IC-1g
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxE4-0002LB-Rk
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxE1-0002WF-DE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604413428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tW2De5KzCvJ+b/QfuqPMqvOW0Qbdqr1oiAuBDBTMBHA=;
 b=URH8NavJZcmBLr8Sphj5stxXu9sWSg+PivJU6Yat+zd++VmScpJudRTDybvR8enF7lAjyq
 u5IvNj86MKbIpLDWv8MfuJsArZxf3WLTb53npjcPQbzMYYiXEUb+nQ68ho8B9FtSyTAXKu
 TpMw0HZijTPzuPk2yyEMcD7WOOPZkbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-iGNeNp66MGql6BDyawtmuQ-1; Tue, 03 Nov 2020 09:23:46 -0500
X-MC-Unique: iGNeNp66MGql6BDyawtmuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B9561868411
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 14:23:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFF9B5C230;
 Tue,  3 Nov 2020 14:23:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qapi: make all parsing visitors parse boolean options the same
Date: Tue,  3 Nov 2020 09:23:44 -0500
Message-Id: <20201103142344.402353-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OptsVisitor, StringInputVisitor and the keyval visitor have
three different ideas of how a human could write the value of
a boolean option.  Pay homage to the backwards-compatibility
gods and make the new common helper accept all four sets: on/off,
true/false, y/n and yes/no.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/util.h          |  2 ++
 qapi/opts-visitor.c          | 13 +------------
 qapi/qapi-util.c             | 23 +++++++++++++++++++++++
 qapi/qobject-input-visitor.c | 11 +----------
 qapi/string-input-visitor.c  | 17 +----------------
 5 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index bc312e90aa..6178e98e97 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -19,6 +19,8 @@ typedef struct QEnumLookup {
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
 int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
                     int def, Error **errp);
+bool qapi_bool_parse(const char *name, const char *value, bool *obj,
+                     Error **errp);
 
 int parse_qapi_name(const char *name, bool complete);
 
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 7781c23a42..9b3a735e6d 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -379,19 +379,8 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
     if (!opt) {
         return false;
     }
-
     if (opt->str) {
-        if (strcmp(opt->str, "on") == 0 ||
-            strcmp(opt->str, "yes") == 0 ||
-            strcmp(opt->str, "y") == 0) {
-            *obj = true;
-        } else if (strcmp(opt->str, "off") == 0 ||
-            strcmp(opt->str, "no") == 0 ||
-            strcmp(opt->str, "n") == 0) {
-            *obj = false;
-        } else {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
-                       "on|yes|y|off|no|n");
+        if (!qapi_bool_parse(name, opt->str, obj, errp)) {
             return false;
         }
     } else {
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 29a6c98b53..8a98813e42 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/ctype.h"
+#include "qapi/qmp/qerror.h"
 
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
@@ -40,6 +41,28 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
     return def;
 }
 
+bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
+{
+    if (!strcasecmp(value, "on") ||
+        !strcasecmp(value, "yes") ||
+        !strcasecmp(value, "true") ||
+        !strcasecmp(value, "y")) {
+        *obj = true;
+        return true;
+    }
+    if (!strcasecmp(value, "off") ||
+        !strcasecmp(value, "no") ||
+        !strcasecmp(value, "false") ||
+        !strcasecmp(value, "n")) {
+        *obj = false;
+        return true;
+    }
+
+    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+               "boolean (on/off, yes/no, true/false, y/n)");
+    return false;
+}
+
 /*
  * Parse a valid QAPI name from @str.
  * A valid name consists of letters, digits, hyphen and underscore.
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 7b184b50a7..183472e5e4 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -512,16 +512,7 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
         return false;
     }
 
-    if (!strcmp(str, "on")) {
-        *obj = true;
-    } else if (!strcmp(str, "off")) {
-        *obj = false;
-    } else {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   full_name(qiv, name), "'on' or 'off'");
-        return false;
-    }
-    return true;
+    return qapi_bool_parse(name, str, obj, errp);
 }
 
 static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 6e53396ea3..ba2697d70f 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -332,22 +332,7 @@ static bool parse_type_bool(Visitor *v, const char *name, bool *obj,
     StringInputVisitor *siv = to_siv(v);
 
     assert(siv->lm == LM_NONE);
-    if (!strcasecmp(siv->string, "on") ||
-        !strcasecmp(siv->string, "yes") ||
-        !strcasecmp(siv->string, "true")) {
-        *obj = true;
-        return true;
-    }
-    if (!strcasecmp(siv->string, "off") ||
-        !strcasecmp(siv->string, "no") ||
-        !strcasecmp(siv->string, "false")) {
-        *obj = false;
-        return true;
-    }
-
-    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-               "boolean");
-    return false;
+    return qapi_bool_parse(name, siv->string, obj, errp);
 }
 
 static bool parse_type_str(Visitor *v, const char *name, char **obj,
-- 
2.26.2


