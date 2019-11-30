Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E8C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 20:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2072020732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 20:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TACeyDGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2072020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8wr-0003yp-AH
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 15:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dx-0006Zv-Jx
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8dv-0005DX-2X
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8du-00058t-M8
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwveq/Hd1QbJmTtcX2t0aVbraIXH0lWuf5V+vTtMWvM=;
 b=TACeyDGHsd9S/0cmzE+f7QHTx4spedE5eOcV4bOzfofw+4q4gyQqzxOKvLOtyl0NltBbLY
 2cE0ti+lrmMurjuTAhpkPMDQS3guFqRZdk9KojiiXDapwf1g2XWW2A6pcs8vb8V6Be2mFe
 BNfiWBxYqkYo7bXWimun6k4Z97qKKeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-2qicZGfxP_KjNJUjYTuOFQ-1; Sat, 30 Nov 2019 14:42:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A4721005502;
 Sat, 30 Nov 2019 19:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22A74611DB;
 Sat, 30 Nov 2019 19:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D2E81135A5A; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error handling
 bugs
Date: Sat, 30 Nov 2019 20:42:36 +0100
Message-Id: <20191130194240.10517-18-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2qicZGfxP_KjNJUjYTuOFQ-1
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
Cc: Cornelia Huck <cohuck@redhat.com>, vsementsov@virtuozzo.com,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
crashes when the visitor or the QOM setter fails, and its @errp
argument is null.  Messed up in commit 137974cea3 's390x/cpumodel:
implement QMP interface "query-cpu-model-expansion"'.

Its three callers have the same bug.  Messed up in commit 4e82ef0502
's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"'
and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
"query-cpu-model-baseline"'.

The bugs can't bite as no caller actually passes null.  Fix them
anyway.

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


