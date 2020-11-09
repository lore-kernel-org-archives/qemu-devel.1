Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A67C5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A73A206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKb/Ktje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A73A206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEhO-0005Zu-HN
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg2-0003uG-1e
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEfz-0005bE-43
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtYmU02TyTHMCT8p52Unsn1UtpXki2UBOqhDJEoT+Bg=;
 b=SKb/KtjeX+6B2KkRM6dwD10a0lbHPLY728P0FTmxT/nntk+NmyGwv2g2JGjs1GgszSkrZp
 QTvvGkERGxcNJEaLMib8CxB8jR2+GO0Ecx9pjwlU0eyHxQcLaMwsqJ95dk4Ctz8dtw6HdG
 k+AZOqw9Ivsny+0qJlEy6Y/+0+HXd2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-HdLc6BkIOBORut_Vj2NlTQ-1; Mon, 09 Nov 2020 16:26:08 -0500
X-MC-Unique: HdLc6BkIOBORut_Vj2NlTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3AAC6D244
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:26:06 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98B351A3D6;
 Mon,  9 Nov 2020 21:26:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] qnum: qnum_value_is_equal() function
Date: Mon,  9 Nov 2020 16:25:52 -0500
Message-Id: <20201109212556.3934583-5-ehabkost@redhat.com>
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
References: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Extract the QNum value comparison logic to a function that takes
QNumValue* as argument.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/qmp/qnum.h |  1 +
 qobject/qnum.c          | 29 +++++++++++++++++++----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 62fbdfda68..0327ecd0f0 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -106,6 +106,7 @@ double qnum_get_double(const QNum *qn);
 
 char *qnum_to_string(QNum *qn);
 
+bool qnum_value_is_equal(const QNumValue *num_x, const QNumValue *num_y);
 bool qnum_is_equal(const QObject *x, const QObject *y);
 void qnum_destroy_obj(QObject *obj);
 
diff --git a/qobject/qnum.c b/qobject/qnum.c
index f80d4efd76..6a0f948b16 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -207,9 +207,9 @@ char *qnum_to_string(QNum *qn)
 }
 
 /**
- * qnum_is_equal(): Test whether the two QNums are equal
- * @x: QNum object
- * @y: QNum object
+ * qnum_value_is_equal(): Test whether two QNumValues are equal
+ * @num_x: QNum value
+ * @num_y: QNum value
  *
  * Negative integers are never considered equal to unsigned integers,
  * but positive integers in the range [0, INT64_MAX] are considered
@@ -217,13 +217,8 @@ char *qnum_to_string(QNum *qn)
  *
  * Doubles are never considered equal to integers.
  */
-bool qnum_is_equal(const QObject *x, const QObject *y)
+bool qnum_value_is_equal(const QNumValue *num_x, const QNumValue *num_y)
 {
-    const QNum *qnum_x = qobject_to(QNum, x);
-    const QNum *qnum_y = qobject_to(QNum, y);
-    const QNumValue *num_x = &qnum_x->value;
-    const QNumValue *num_y = &qnum_y->value;
-
     switch (num_x->kind) {
     case QNUM_I64:
         switch (num_y->kind) {
@@ -241,7 +236,7 @@ bool qnum_is_equal(const QObject *x, const QObject *y)
     case QNUM_U64:
         switch (num_y->kind) {
         case QNUM_I64:
-            return qnum_is_equal(y, x);
+            return qnum_value_is_equal(num_y, num_x);
         case QNUM_U64:
             /* Comparison in native uint64_t type */
             return num_x->u.u64 == num_y->u.u64;
@@ -264,6 +259,20 @@ bool qnum_is_equal(const QObject *x, const QObject *y)
     abort();
 }
 
+/**
+ * qnum_is_equal(): Test whether the two QNums are equal
+ * @x: QNum object
+ * @y: QNum object
+ *
+ * See qnum_value_is_equal() for details on the comparison rules.
+ */
+bool qnum_is_equal(const QObject *x, const QObject *y)
+{
+    const QNum *qnum_x = qobject_to(QNum, x);
+    const QNum *qnum_y = qobject_to(QNum, y);
+    return qnum_value_is_equal(&qnum_x->value, &qnum_y->value);
+}
+
 /**
  * qnum_destroy_obj(): Free all memory allocated by a QNum object
  *
-- 
2.28.0


