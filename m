Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11988C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B47F206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxJvguv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B47F206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEmd-0002c1-Bi
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg4-0003yA-Q7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg2-0005c3-Qb
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrttNqAhwpG0xM9KyBcAIFaMWj5fSOHCWB5lN6j6duY=;
 b=UxJvguv/JqbE+XupvCqQmok0rBlMG5Nw4vSh5kb45CRj2+P+ZjKPsVcplUVEPnqyXu8/qc
 2UJVhJpX1VBK/lKh1LAWmyOhDOYC+xGjcM7gdIWq8KjrIe+TGIy238h8zHhd4A+iMJyimn
 tiEMZRvE/ASpVMsRn7uSx69ICWsCqrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-4GgTmPKWNZK-4qRrYmS3gQ-1; Mon, 09 Nov 2020 16:26:09 -0500
X-MC-Unique: 4GgTmPKWNZK-4qRrYmS3gQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD47879513
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:26:08 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE1F77E72A;
 Mon,  9 Nov 2020 21:26:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] qlit: Support all types of QNums
Date: Mon,  9 Nov 2020 16:25:53 -0500
Message-Id: <20201109212556.3934583-6-ehabkost@redhat.com>
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
References: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use QNumValue to represent QNums, so we can also support uint64_t
and double QNum values.  Add new QLIT_QNUM_(INT|UINT|DOUBLE)
macros for each case.

The QLIT_QNUM() macro is being kept for compatibility with
existing code, but becomes just a wrapper for QLIT_QNUM_INT().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/qmp/qlit.h | 11 +++++--
 qobject/qlit.c          |  4 +--
 tests/check-qjson.c     | 72 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index c0676d5daf..f9e356d31e 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -15,6 +15,7 @@
 #define QLIT_H
 
 #include "qobject.h"
+#include "qnum.h"
 
 typedef struct QLitDictEntry QLitDictEntry;
 typedef struct QLitObject QLitObject;
@@ -23,7 +24,7 @@ struct QLitObject {
     QType type;
     union {
         bool qbool;
-        int64_t qnum;
+        QNumValue qnum;
         const char *qstr;
         QLitDictEntry *qdict;
         QLitObject *qlist;
@@ -39,8 +40,14 @@ struct QLitDictEntry {
     { .type = QTYPE_QNULL }
 #define QLIT_QBOOL(val) \
     { .type = QTYPE_QBOOL, .value.qbool = (val) }
+#define QLIT_QNUM_INT(val) \
+    { .type = QTYPE_QNUM, .value.qnum = QNUM_VAL_INT(val) }
+#define QLIT_QNUM_UINT(val) \
+    { .type = QTYPE_QNUM, .value.qnum = QNUM_VAL_UINT(val) }
+#define QLIT_QNUM_DOUBLE(val) \
+    { .type = QTYPE_QNUM, .value.qnum = QNUM_VAL_DOUBLE(val) }
 #define QLIT_QNUM(val) \
-    { .type = QTYPE_QNUM, .value.qnum = (val) }
+    QLIT_QNUM_INT(val)
 #define QLIT_QSTR(val) \
     { .type = QTYPE_QSTRING, .value.qstr = (val) }
 #define QLIT_QDICT(val) \
diff --git a/qobject/qlit.c b/qobject/qlit.c
index be8332136c..ec11a39518 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -71,7 +71,7 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
     case QTYPE_QBOOL:
         return lhs->value.qbool == qbool_get_bool(qobject_to(QBool, rhs));
     case QTYPE_QNUM:
-        return lhs->value.qnum ==  qnum_get_int(qobject_to(QNum, rhs));
+        return qnum_value_is_equal(&lhs->value.qnum, qnum_get_value(qobject_to(QNum, rhs)));
     case QTYPE_QSTRING:
         return (strcmp(lhs->value.qstr,
                        qstring_get_str(qobject_to(QString, rhs))) == 0);
@@ -94,7 +94,7 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
     case QTYPE_QNULL:
         return QOBJECT(qnull());
     case QTYPE_QNUM:
-        return QOBJECT(qnum_from_int(qlit->value.qnum));
+        return QOBJECT(qnum_from_value(qlit->value.qnum));
     case QTYPE_QSTRING:
         return QOBJECT(qstring_from_str(qlit->value.qstr));
     case QTYPE_QDICT: {
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 07a773e653..711030cffd 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -796,20 +796,23 @@ static void simple_number(void)
     int i;
     struct {
         const char *encoded;
+        QLitObject qlit;
         int64_t decoded;
         int skip;
     } test_cases[] = {
-        { "0", 0 },
-        { "1234", 1234 },
-        { "1", 1 },
-        { "-32", -32 },
-        { "-0", 0, .skip = 1 },
+        { "0",    QLIT_QNUM(0),    0, },
+        { "1234", QLIT_QNUM(1234), 1234, },
+        { "1",    QLIT_QNUM(1),    1, },
+        { "-32",  QLIT_QNUM(-32),  -32, },
+        { "-0",   QLIT_QNUM(0),    0, .skip = 1 },
         { },
     };
 
     for (i = 0; test_cases[i].encoded; i++) {
         QNum *qnum;
         int64_t val;
+        QNum *qlit_num;
+        int64_t qlit_val;
 
         qnum = qobject_to(QNum,
                           qobject_from_json(test_cases[i].encoded,
@@ -817,6 +820,7 @@ static void simple_number(void)
         g_assert(qnum);
         g_assert(qnum_get_try_int(qnum, &val));
         g_assert_cmpint(val, ==, test_cases[i].decoded);
+
         if (test_cases[i].skip == 0) {
             QString *str;
 
@@ -826,9 +830,66 @@ static void simple_number(void)
         }
 
         qobject_unref(qnum);
+
+        qlit_num = qobject_to(QNum,
+                              qobject_from_qlit(&test_cases[i].qlit));
+        g_assert(qlit_num);
+        g_assert(qnum_get_try_int(qlit_num, &qlit_val));
+        g_assert_cmpint(qlit_val, ==, test_cases[i].decoded);
+
+        qobject_unref(qlit_num);
     }
 }
 
+static void qlit_large_number(void)
+{
+    QLitObject maxu64 = QLIT_QNUM_UINT(UINT64_MAX);
+    QLitObject maxi64 = QLIT_QNUM(INT64_MAX);
+    QLitObject mini64 = QLIT_QNUM(INT64_MIN);
+    QLitObject gtu64  = QLIT_QNUM_DOUBLE(18446744073709552e3);
+    QLitObject lti64  = QLIT_QNUM_DOUBLE(-92233720368547758e2);
+    QNum *qnum;
+    uint64_t val;
+    int64_t ival;
+
+    qnum = qobject_to(QNum, qobject_from_qlit(&maxu64));
+    g_assert(qnum);
+    g_assert_cmpuint(qnum_get_uint(qnum), ==, UINT64_MAX);
+    g_assert(!qnum_get_try_int(qnum, &ival));
+
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_qlit(&maxi64));
+    g_assert(qnum);
+    g_assert_cmpuint(qnum_get_uint(qnum), ==, INT64_MAX);
+    g_assert_cmpint(qnum_get_int(qnum), ==, INT64_MAX);
+
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_qlit(&mini64));
+    g_assert(qnum);
+    g_assert(!qnum_get_try_uint(qnum, &val));
+    g_assert_cmpuint(qnum_get_int(qnum), ==, INT64_MIN);
+
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_qlit(&gtu64));
+    g_assert(qnum);
+    g_assert_cmpfloat(qnum_get_double(qnum), ==, 18446744073709552e3);
+    g_assert(!qnum_get_try_uint(qnum, &val));
+    g_assert(!qnum_get_try_int(qnum, &ival));
+
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_qlit(&lti64));
+    g_assert(qnum);
+    g_assert_cmpfloat(qnum_get_double(qnum), ==, -92233720368547758e2);
+    g_assert(!qnum_get_try_uint(qnum, &val));
+    g_assert(!qnum_get_try_int(qnum, &ival));
+
+    qobject_unref(qnum);
+}
+
 static void large_number(void)
 {
     const char *maxu64 = "18446744073709551615"; /* 2^64-1 */
@@ -1472,6 +1533,7 @@ int main(int argc, char **argv)
     g_test_add_func("/literals/string/utf8", utf8_string);
 
     g_test_add_func("/literals/number/simple", simple_number);
+    g_test_add_func("/literals/number/qlit_large", qlit_large_number);
     g_test_add_func("/literals/number/large", large_number);
     g_test_add_func("/literals/number/float", float_number);
 
-- 
2.28.0


