Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BBA207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqqRQ0kZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BBA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRVyC-0005gj-IU
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 03:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRVt2-0006GC-J7
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRVsx-0003H4-M5
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602401711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHPYCqiyKGAD+Zc8/zz2fhKOml70BFrb+sHIjUM/cYM=;
 b=fqqRQ0kZdWjF5iMPR8+QEa7j05tOMJy8w1EYH8zfcUu6GVnljBvBOo24FUck7EobjCvtHK
 ZE9MzpYSK+/KyvRXi1mexzHgO2gRrlXoHX6ztJLpvNiMOQTvaQNzYOLLuu+diksdUTqtVt
 2o29IOojGx6rGIL+2oMrPOWAnECRKCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-RqBuCnqFO4msgEnCJJzFiA-1; Sun, 11 Oct 2020 03:35:07 -0400
X-MC-Unique: RqBuCnqFO4msgEnCJJzFiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC192107AD96;
 Sun, 11 Oct 2020 07:35:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B5C160C07;
 Sun, 11 Oct 2020 07:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B7D4112CE10; Sun, 11 Oct 2020 09:35:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/7] keyval: Fix parsing of ',' in value of implied key
Date: Sun, 11 Oct 2020 09:35:01 +0200
Message-Id: <20201011073505.1185335-4-armbru@redhat.com>
In-Reply-To: <20201011073505.1185335-1-armbru@redhat.com>
References: <20201011073505.1185335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 02:10:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit demonstrated documentation and code disagree on
parsing of ',' in the value of an implied key.  Fix the code to match
the documentation.

This breaks uses of keyval_parse() that pass an implied key and accept
a value containing ','.  None of the existing uses does:

* audiodev: implied key "driver" is enum AudiodevDriver, none of the
  values contains ','

* display: implied key "type" is enum DisplayType, none of the values
  contains ','

* blockdev: implied key "driver is enum BlockdevDriver, none of the
  values contains ','

* export: implied key "type" is enum BlockExportType, none of the
  values contains ','

* monitor: implied key "mode" is enum MonitorMode, none of the values
  contains ','

* nbd-server: no implied key.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-keyval.c |  8 +++-----
 util/keyval.c       | 28 +++++++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index f02bdf7029..04c62cf045 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -183,11 +183,9 @@ static void test_keyval_parse(void)
     g_assert(!qdict);
 
     /* Implied key's value can't have comma (qemu_opts_parse(): it can) */
-    /* BUG: it can */
-    qdict = keyval_parse("val,,ue", "implied", &error_abort);
-    g_assert_cmpuint(qdict_size(qdict), ==, 1);
-    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val,ue");
-    qobject_unref(qdict);
+    qdict = keyval_parse("val,,ue", "implied", &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
 
     /* Empty key is not an implied key */
     qdict = keyval_parse("=val", "implied", &err);
diff --git a/util/keyval.c b/util/keyval.c
index 82d8497c71..8f33a36a7c 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -173,7 +173,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
                                     const char *implied_key,
                                     Error **errp)
 {
-    const char *key, *key_end, *s, *end;
+    const char *key, *key_end, *val_end, *s, *end;
     size_t len;
     char key_in_cur[128];
     QDict *cur;
@@ -182,10 +182,12 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     QString *val;
 
     key = params;
+    val_end = NULL;
     len = strcspn(params, "=,");
     if (implied_key && len && key[len] != '=') {
         /* Desugar implied key */
         key = implied_key;
+        val_end = params + len;
         len = strlen(implied_key);
     }
     key_end = key + len;
@@ -241,7 +243,11 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
 
     if (key == implied_key) {
         assert(!*s);
-        s = params;
+        val = qstring_from_substr(params, 0, val_end - params);
+        s = val_end;
+        if (*s == ',') {
+            s++;
+        }
     } else {
         if (*s != '=') {
             error_setg(errp, "Expected '=' after parameter '%.*s'",
@@ -249,19 +255,19 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
             return NULL;
         }
         s++;
-    }
 
-    val = qstring_new();
-    for (;;) {
-        if (!*s) {
-            break;
-        } else if (*s == ',') {
-            s++;
-            if (*s != ',') {
+        val = qstring_new();
+        for (;;) {
+            if (!*s) {
                 break;
+            } else if (*s == ',') {
+                s++;
+                if (*s != ',') {
+                    break;
+                }
             }
+            qstring_append_chr(val, *s++);
         }
-        qstring_append_chr(val, *s++);
     }
 
     if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
-- 
2.26.2


