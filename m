Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D827724125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjDavv3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D827724125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnxY-0006cW-Ij
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifnfS-0000sf-FG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnfR-0002CC-7p
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34281
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifnfR-0002B1-2g
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0n4kzHV7ijQhtr1OsgzkClrsjQtDJq/jf3/dxh+9j8I=;
 b=VjDavv3efQcbSS+ObFSu2rbQqz3Oimd/ZZhFd/3qDU7W1Fglr9eRkzv3DPNccZG8HaBGGK
 2X7XtLj+GEMgOWk2oZ0l1MJ6HF//CBDG98bu9lwaHW80SHBMRO/QnL5xOdbdEyedYKK3t1
 fcinP0I1PQu3aAGWChYaASuEYnTAU2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Wdf2M40RPCOisdBVTM-BAQ-1; Fri, 13 Dec 2019 11:19:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDC38593DB;
 Fri, 13 Dec 2019 16:19:45 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 198481CB;
 Fri, 13 Dec 2019 16:19:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/16] s390x/cpumodel: Fix query-cpu-model-FOO error API
 violations
Date: Fri, 13 Dec 2019 17:18:48 +0100
Message-Id: <20191213161851.24687-14-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Wdf2M40RPCOisdBVTM-BAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

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
Message-Id: <20191204093625.14836-15-armbru@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c702e34a26b9..3ed301b5e509 100644
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


