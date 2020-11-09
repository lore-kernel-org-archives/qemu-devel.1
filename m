Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C658BC5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE7C206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6D7Nwvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE7C206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEhT-0005nT-4D
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg9-00043t-6a
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg4-0005cN-5d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV9fU25bD3yUHXQJa/vamTz1JOYnMnNvXJQyfXQfB2g=;
 b=G6D7Nwvt1SB0QxZYW8CELAOGTuzP/c+jR+L2eRAmuMBfbRyTD/wX1Y4P/3SanEry8lCo5H
 BI/5K63zmNYk5DUcizP5tJONJObxUAOYmQy0q2lccgKPmoBcmQLRQhSyDk35DJcLRqc4pM
 Yw+AuorSPRSDXCHnEGvsE30xWWFTN7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-jO1O_d05M-iw-dA2I7TB5w-1; Mon, 09 Nov 2020 16:26:05 -0500
X-MC-Unique: jO1O_d05M-iw-dA2I7TB5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350676D249
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:26:04 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4563175134;
 Mon,  9 Nov 2020 21:26:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] qnum: QNumValue type for QNum value literals
Date: Mon,  9 Nov 2020 16:25:51 -0500
Message-Id: <20201109212556.3934583-4-ehabkost@redhat.com>
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
References: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Provide a separate QNumValue type that can be used for QNum value
literals without the referencing counting and memory allocation
features provided by QObject.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/qmp/qnum.h | 40 +++++++++++++++++++--
 qobject/qnum.c          | 78 ++++++++++++++++++++---------------------
 2 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 55c27b1c24..62fbdfda68 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -46,20 +46,56 @@ typedef enum {
  * in range: qnum_get_try_int() / qnum_get_try_uint() check range and
  * convert under the hood.
  */
-struct QNum {
-    struct QObjectBase_ base;
+
+/**
+ * struct QNumValue: the value of a QNum
+ *
+ * QNumValue literals can be constructed using the `QNUM_VAL_INT`,
+ * `QNUM_VAL_UINT`, and `QNUM_VAL_DOUBLE` macros.
+ */
+typedef struct QNumValue {
+    /* private: */
     QNumKind kind;
     union {
         int64_t i64;
         uint64_t u64;
         double dbl;
     } u;
+} QNumValue;
+
+#define QNUM_VAL_INT(value) \
+    { .kind = QNUM_I64, .u.i64 = value }
+#define QNUM_VAL_UINT(value) \
+    { .kind = QNUM_U64, .u.u64 = value }
+#define QNUM_VAL_DOUBLE(value) \
+    { .kind = QNUM_DOUBLE, .u.dbl = value }
+
+struct QNum {
+    struct QObjectBase_ base;
+    QNumValue value;
 };
 
+/**
+ * qnum_from_int(): Create a new QNum from a QNumValue
+ * @value: QNumValue
+ *
+ * Return strong reference.
+ */
+QNum *qnum_from_value(QNumValue value);
+
 QNum *qnum_from_int(int64_t value);
 QNum *qnum_from_uint(uint64_t value);
 QNum *qnum_from_double(double value);
 
+/**
+ * qnum_get_value(): Get QNumValue from QNum
+ * @qn: QNum object
+ */
+static inline const QNumValue *qnum_get_value(const QNum *qn)
+{
+    return &qn->value;
+}
+
 bool qnum_get_try_int(const QNum *qn, int64_t *val);
 int64_t qnum_get_int(const QNum *qn);
 
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 69fd9a82d9..f80d4efd76 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -15,6 +15,15 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/qnum.h"
 
+QNum *qnum_from_value(QNumValue value)
+{
+    QNum *qn = g_new(QNum, 1);
+
+    qobject_init(QOBJECT(qn), QTYPE_QNUM);
+    qn->value = value;
+    return qn;
+}
+
 /**
  * qnum_from_int(): Create a new QNum from an int64_t
  * @value: int64_t value
@@ -23,13 +32,7 @@
  */
 QNum *qnum_from_int(int64_t value)
 {
-    QNum *qn = g_new(QNum, 1);
-
-    qobject_init(QOBJECT(qn), QTYPE_QNUM);
-    qn->kind = QNUM_I64;
-    qn->u.i64 = value;
-
-    return qn;
+    return qnum_from_value((QNumValue) QNUM_VAL_INT(value));
 }
 
 /**
@@ -40,13 +43,7 @@ QNum *qnum_from_int(int64_t value)
  */
 QNum *qnum_from_uint(uint64_t value)
 {
-    QNum *qn = g_new(QNum, 1);
-
-    qobject_init(QOBJECT(qn), QTYPE_QNUM);
-    qn->kind = QNUM_U64;
-    qn->u.u64 = value;
-
-    return qn;
+    return qnum_from_value((QNumValue) QNUM_VAL_UINT(value));
 }
 
 /**
@@ -57,13 +54,7 @@ QNum *qnum_from_uint(uint64_t value)
  */
 QNum *qnum_from_double(double value)
 {
-    QNum *qn = g_new(QNum, 1);
-
-    qobject_init(QOBJECT(qn), QTYPE_QNUM);
-    qn->kind = QNUM_DOUBLE;
-    qn->u.dbl = value;
-
-    return qn;
+    return qnum_from_value((QNumValue) QNUM_VAL_DOUBLE(value));
 }
 
 /**
@@ -75,15 +66,17 @@ QNum *qnum_from_double(double value)
  */
 bool qnum_get_try_int(const QNum *qn, int64_t *val)
 {
-    switch (qn->kind) {
+    const QNumValue *qv = &qn->value;
+
+    switch (qv->kind) {
     case QNUM_I64:
-        *val = qn->u.i64;
+        *val = qv->u.i64;
         return true;
     case QNUM_U64:
-        if (qn->u.u64 > INT64_MAX) {
+        if (qv->u.u64 > INT64_MAX) {
             return false;
         }
-        *val = qn->u.u64;
+        *val = qv->u.u64;
         return true;
     case QNUM_DOUBLE:
         return false;
@@ -116,15 +109,17 @@ int64_t qnum_get_int(const QNum *qn)
  */
 bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
 {
-    switch (qn->kind) {
+    const QNumValue *qv = &qn->value;
+
+    switch (qv->kind) {
     case QNUM_I64:
-        if (qn->u.i64 < 0) {
+        if (qv->u.i64 < 0) {
             return false;
         }
-        *val = qn->u.i64;
+        *val = qv->u.i64;
         return true;
     case QNUM_U64:
-        *val = qn->u.u64;
+        *val = qv->u.u64;
         return true;
     case QNUM_DOUBLE:
         return false;
@@ -156,13 +151,15 @@ uint64_t qnum_get_uint(const QNum *qn)
  */
 double qnum_get_double(const QNum *qn)
 {
-    switch (qn->kind) {
+    const QNumValue *qv = &qn->value;
+
+    switch (qv->kind) {
     case QNUM_I64:
-        return qn->u.i64;
+        return qv->u.i64;
     case QNUM_U64:
-        return qn->u.u64;
+        return qv->u.u64;
     case QNUM_DOUBLE:
-        return qn->u.dbl;
+        return qv->u.dbl;
     }
 
     assert(0);
@@ -171,14 +168,15 @@ double qnum_get_double(const QNum *qn)
 
 char *qnum_to_string(QNum *qn)
 {
+    const QNumValue *qv = &qn->value;
     char *buffer;
     int len;
 
-    switch (qn->kind) {
+    switch (qv->kind) {
     case QNUM_I64:
-        return g_strdup_printf("%" PRId64, qn->u.i64);
+        return g_strdup_printf("%" PRId64, qv->u.i64);
     case QNUM_U64:
-        return g_strdup_printf("%" PRIu64, qn->u.u64);
+        return g_strdup_printf("%" PRIu64, qv->u.u64);
     case QNUM_DOUBLE:
         /* FIXME: snprintf() is locale dependent; but JSON requires
          * numbers to be formatted as if in the C locale. Dependence
@@ -189,7 +187,7 @@ char *qnum_to_string(QNum *qn)
          * rounding errors; we should be using DBL_DECIMAL_DIG (17),
          * and only rounding to a shorter number if the result would
          * still produce the same floating point value.  */
-        buffer = g_strdup_printf("%f" , qn->u.dbl);
+        buffer = g_strdup_printf("%f" , qv->u.dbl);
         len = strlen(buffer);
         while (len > 0 && buffer[len - 1] == '0') {
             len--;
@@ -221,8 +219,10 @@ char *qnum_to_string(QNum *qn)
  */
 bool qnum_is_equal(const QObject *x, const QObject *y)
 {
-    QNum *num_x = qobject_to(QNum, x);
-    QNum *num_y = qobject_to(QNum, y);
+    const QNum *qnum_x = qobject_to(QNum, x);
+    const QNum *qnum_y = qobject_to(QNum, y);
+    const QNumValue *num_x = &qnum_x->value;
+    const QNumValue *num_y = &qnum_y->value;
 
     switch (num_x->kind) {
     case QNUM_I64:
-- 
2.28.0


