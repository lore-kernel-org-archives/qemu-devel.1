Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B845C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5938120863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T79+rdH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5938120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9AXA-0005qT-7K
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVq-0004HW-Aa
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVo-0002zh-TQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVo-0002zZ-Pz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB+w0cC+DhrU6e0Xdne2cU+tRz8mcHFIaGFH9tmvCpc=;
 b=T79+rdH+JsR5J+ZHG4Qev/L+gQ73aZux5i1Vfic2QKaoVhTDuNNY5VQoutZ8SaXEGWXJbt
 bzZyTPEIp063S23ziLCVwEqMMU5BfSE/SnXlmkzEN4VQ4Bn0y/YtAAgf1g10ULROVoovtT
 nB90tvpcfl56vC5y4nwgUDAJkGPbosM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-lNFtbW_rO9uGPyYeZfemjg-1; Tue, 03 Mar 2020 11:35:14 -0500
X-MC-Unique: lNFtbW_rO9uGPyYeZfemjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DF71100DFC3;
 Tue,  3 Mar 2020 16:35:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47C7B1000322;
 Tue,  3 Mar 2020 16:35:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E454E1132A05; Tue,  3 Mar 2020 17:35:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/30] qapi/schema: Change _make_features() to a take
 feature list
Date: Tue,  3 Mar 2020 17:34:51 +0100
Message-Id: <20200303163505.32041-17-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QAPISchema._make_features() takes a definition expression, and
extracts its 'features' member.  The other ._make_FOO() leave
destructuring expressions to their callers.  Change ._make_features()
to match them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e3353989e9..2ab6dc67e4 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -905,8 +905,9 @@ class QAPISchema:
         self._def_entity(QAPISchemaEnumType('QType', None, None, None, Non=
e,
                                             qtype_values, 'QTYPE'))
=20
-    def _make_features(self, expr, info):
-        features =3D expr.get('features', [])
+    def _make_features(self, features, info):
+        if features is None:
+            return []
         return [QAPISchemaFeature(f['name'], info, f.get('if'))
                 for f in features]
=20
@@ -956,7 +957,7 @@ class QAPISchema:
         data =3D expr['data']
         prefix =3D expr.get('prefix')
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaEnumType(
             name, info, doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
@@ -980,7 +981,7 @@ class QAPISchema:
         base =3D expr.get('base')
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaObjectType(
             name, info, doc, ifcond, features, base,
             self._make_members(data, info),
@@ -1003,7 +1004,7 @@ class QAPISchema:
         data =3D expr['data']
         base =3D expr.get('base')
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         tag_name =3D expr.get('discriminator')
         tag_member =3D None
         if isinstance(base, dict):
@@ -1033,7 +1034,7 @@ class QAPISchema:
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         variants =3D [self._make_variant(key, value['type'], value.get('if=
'),
                                        info)
                     for (key, value) in data.items()]
@@ -1053,7 +1054,7 @@ class QAPISchema:
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, ifcond,
@@ -1071,7 +1072,7 @@ class QAPISchema:
         data =3D expr.get('data')
         boxed =3D expr.get('boxed', False)
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, ifcond,
--=20
2.21.1


