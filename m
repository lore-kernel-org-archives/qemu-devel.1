Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0440C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE7720724
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKdvKUeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE7720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig43N-0007no-94
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig407-00050M-9o
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig406-0005xR-1F
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig405-0005vP-SJ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576316773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uw8RzRlPrWToSzICCddlif8igLPYf+K8CwNrzt2Ukug=;
 b=UKdvKUeoOSfqAgEtfDDba8Z1hLbrjrtxIEYLO9MS51S9HZSeYNm0Tr58LA+xoSJtOlxjAm
 3O4SzG7fptM5t+08JxhC/+fMCA1oZCZHwUlxaNJf9Op0dA7rUB0MD3d8+Ko1zBi7b/WhQ8
 8CFvPPOL+K7hkILjEyTniCxxjq3dEfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-l85MMfPhPT-I5939l_beLg-1; Sat, 14 Dec 2019 04:46:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C60C477;
 Sat, 14 Dec 2019 09:46:10 +0000 (UTC)
Received: from localhost (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9EA5C28C;
 Sat, 14 Dec 2019 09:46:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 11/16] s390x/cpumodel: Fix feature property error API
 violations
Date: Sat, 14 Dec 2019 10:45:21 +0100
Message-Id: <20191214094526.8698-12-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
References: <20191214094526.8698-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: l85MMfPhPT-I5939l_beLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

s390x-cpu property setters set_feature() and set_feature_group()
dereference @errp when the visitor fails.  That's wrong; see the big
comment in error.h.  Introduced in commit 0754f60429 "s390x/cpumodel:
expose features and feature groups as properties".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191204093625.14836-13-armbru@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7e92fb2e156d..6a29fd3ab113 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -987,6 +987,7 @@ static void get_feature(Object *obj, Visitor *v, const =
char *name,
 static void set_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
+    Error *err =3D NULL;
     S390Feat feat =3D (S390Feat) opaque;
     DeviceState *dev =3D DEVICE(obj);
     S390CPU *cpu =3D S390_CPU(obj);
@@ -1002,8 +1003,9 @@ static void set_feature(Object *obj, Visitor *v, cons=
t char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, errp);
-    if (*errp) {
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
     if (value) {
@@ -1043,6 +1045,7 @@ static void get_feature_group(Object *obj, Visitor *v=
, const char *name,
 static void set_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
+    Error *err =3D NULL;
     S390FeatGroup group =3D (S390FeatGroup) opaque;
     const S390FeatGroupDef *def =3D s390_feat_group_def(group);
     DeviceState *dev =3D DEVICE(obj);
@@ -1059,8 +1062,9 @@ static void set_feature_group(Object *obj, Visitor *v=
, const char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, errp);
-    if (*errp) {
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
     if (value) {
--=20
2.21.0


