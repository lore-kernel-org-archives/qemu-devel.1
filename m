Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB832C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FEE207DD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXpb1r+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FEE207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icS6n-0000NF-Pw
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5n-0007J8-Sl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5L-0000Xu-3C
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5K-0000MH-UE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NE3kP/DOAuh+KztePlu2TgOR4p2JwUK9MqY4o9RapzI=;
 b=EXpb1r+UCi/0veQSmNOH/NBC6wWOcY6iDplauI8P2EjsQC82Zs/tGviwQKqFcHrl26QO6p
 EEl+O+BeJ/5xbrGJle33k9y2Oo7QABFH2/car++e5PKIYSwy3TBN1eMqhX+565XW4t24Ha
 bA52y/Kjjp0ydXBoRu2hpTjy0FUkfFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-ARweqmouMWCT93hHyKeCjA-1; Wed, 04 Dec 2019 04:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FFEF801E70
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD4475D6B7;
 Wed,  4 Dec 2019 09:36:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF4DD113639C; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/18] s390x/cpumodel: Fix query-cpu-model-FOO error API
 violations
Date: Wed,  4 Dec 2019 10:36:21 +0100
Message-Id: <20191204093625.14836-15-armbru@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ARweqmouMWCT93hHyKeCjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
dereferences @errp when the visitor or the QOM setter fails.  That's
wrong; see the big comment in error.h.  Introduced in commit
137974cea3 's390x/cpumodel: implement QMP interface
"query-cpu-model-expansion"'.

Its three callers have the same issue.  Introduced in commit
4e82ef0502 's390x/cpumodel: implement QMP interface
"query-cpu-model-comparison"' and commit f1a47d08ef 's390x/cpumodel:
implement QMP interface "query-cpu-model-baseline"'.

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c702e34a26..3ed301b5e5 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -477,6 +477,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error =
**errp)
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *i=
nfo,
                                 Error **errp)
 {
+    Error *err =3D NULL;
     const QDict *qdict =3D NULL;
     const QDictEntry *e;
     Visitor *visitor;
@@ -513,24 +514,26 @@ static void cpu_model_from_info(S390CPUModel *model, =
const CpuModelInfo *info,
=20
     if (qdict) {
         visitor =3D qobject_input_visitor_new(info->props);
-        visit_start_struct(visitor, NULL, NULL, 0, errp);
-        if (*errp) {
+        visit_start_struct(visitor, NULL, NULL, 0, &err);
+        if (err) {
+            error_propagate(errp, err);
             visit_free(visitor);
             object_unref(obj);
             return;
         }
         for (e =3D qdict_first(qdict); e; e =3D qdict_next(qdict, e)) {
-            object_property_set(obj, visitor, e->key, errp);
-            if (*errp) {
+            object_property_set(obj, visitor, e->key, &err);
+            if (err) {
                 break;
             }
         }
-        if (!*errp) {
+        if (!err) {
             visit_check_struct(visitor, errp);
         }
         visit_end_struct(visitor, NULL);
         visit_free(visitor);
-        if (*errp) {
+        if (err) {
+            error_propagate(errp, err);
             object_unref(obj);
             return;
         }
@@ -595,13 +598,15 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
                                                       CpuModelInfo *model,
                                                       Error **errp)
 {
+    Error *err =3D NULL;
     CpuModelExpansionInfo *expansion_info =3D NULL;
     S390CPUModel s390_model;
     bool delta_changes =3D false;
=20
     /* convert it to our internal representation */
-    cpu_model_from_info(&s390_model, model, errp);
-    if (*errp) {
+    cpu_model_from_info(&s390_model, model, &err);
+    if (err) {
+        error_propagate(errp, err);
         return NULL;
     }
=20
@@ -634,18 +639,21 @@ CpuModelCompareInfo *qmp_query_cpu_model_comparison(C=
puModelInfo *infoa,
                                                      CpuModelInfo *infob,
                                                      Error **errp)
 {
+    Error *err =3D NULL;
     CpuModelCompareResult feat_result, gen_result;
     CpuModelCompareInfo *compare_info;
     S390FeatBitmap missing, added;
     S390CPUModel modela, modelb;
=20
     /* convert both models to our internal representation */
-    cpu_model_from_info(&modela, infoa, errp);
-    if (*errp) {
+    cpu_model_from_info(&modela, infoa, &err);
+    if (err) {
+        error_propagate(errp, err);
         return NULL;
     }
-    cpu_model_from_info(&modelb, infob, errp);
-    if (*errp) {
+    cpu_model_from_info(&modelb, infob, &err);
+    if (err) {
+        error_propagate(errp, err);
         return NULL;
     }
     compare_info =3D g_new0(CpuModelCompareInfo, 1);
@@ -707,6 +715,7 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuM=
odelInfo *infoa,
                                                     CpuModelInfo *infob,
                                                     Error **errp)
 {
+    Error *err =3D NULL;
     CpuModelBaselineInfo *baseline_info;
     S390CPUModel modela, modelb, model;
     uint16_t cpu_type;
@@ -714,13 +723,15 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(Cp=
uModelInfo *infoa,
     uint8_t max_gen;
=20
     /* convert both models to our internal representation */
-    cpu_model_from_info(&modela, infoa, errp);
-    if (*errp) {
+    cpu_model_from_info(&modela, infoa, &err);
+    if (err) {
+        error_propagate(errp, err);
         return NULL;
     }
=20
-    cpu_model_from_info(&modelb, infob, errp);
-    if (*errp) {
+    cpu_model_from_info(&modelb, infob, &err);
+    if (err) {
+        error_propagate(errp, err);
         return NULL;
     }
=20
--=20
2.21.0


