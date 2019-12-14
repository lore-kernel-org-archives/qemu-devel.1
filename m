Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A1C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D6420700
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK1C6mBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D6420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig48W-0007KA-Jh
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig40B-00056W-SZ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig40A-0006A2-0L
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig409-00067Z-Me
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576316777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XW33OjbNZfIzOzwZ5W3uHfwF9YmS9RFQ9HoMdM6KrBs=;
 b=SK1C6mBUrcY79XrFj7vP+U7CKTDqjQpOe9R7uTHAFazCL5vk6s1JdtszMx7EakR8z3Ov3l
 GNY2fYzojYknTULDTJhPwX8bAgwyDOlKnsk0ULao3OUySGu8nY7pWqw6Kor+1MwUV1PX6+
 BCc4HjYsaFHYXc3fV2hDbE0odlEL1IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-Qw9is9HYNYalBd3cbC-RKg-1; Sat, 14 Dec 2019 04:46:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961A28017DF;
 Sat, 14 Dec 2019 09:46:12 +0000 (UTC)
Received: from localhost (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C745C28C;
 Sat, 14 Dec 2019 09:46:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 12/16] s390x/cpumodel: Fix realize() error API violations
Date: Sat, 14 Dec 2019 10:45:22 +0100
Message-Id: <20191214094526.8698-13-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
References: <20191214094526.8698-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Qw9is9HYNYalBd3cbC-RKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

get_max_cpu_model() dereferences @errp when
kvm_s390_get_host_cpu_model() fails, apply_cpu_model() dereferences it
when kvm_s390_apply_cpu_model() fails, and s390_realize_cpu_model()
dereferences it when get_max_cpu_model() or check_compatibility()
fail.  That's wrong; see the big comment in error.h.  All three
introduced in commit 80560137cf "s390x/cpumodel: check and apply the
CPU model".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191204093625.14836-14-armbru@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 6a29fd3ab113..c702e34a26b9 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -870,6 +870,7 @@ static void check_compatibility(const S390CPUModel *max=
_model,
=20
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
+    Error *err =3D NULL;
     static S390CPUModel max_model;
     static bool cached;
=20
@@ -878,22 +879,24 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     }
=20
     if (kvm_enabled()) {
-        kvm_s390_get_host_cpu_model(&max_model, errp);
+        kvm_s390_get_host_cpu_model(&max_model, &err);
     } else {
         max_model.def =3D s390_find_cpu_def(QEMU_MAX_CPU_TYPE, QEMU_MAX_CP=
U_GEN,
                                           QEMU_MAX_CPU_EC_GA, NULL);
         bitmap_copy(max_model.features, qemu_max_cpu_feat, S390_FEAT_MAX);
-   }
-    if (!*errp) {
-        cached =3D true;
-        return &max_model;
     }
-    return NULL;
+    if (err) {
+        error_propagate(errp, err);
+        return NULL;
+    }
+    cached =3D true;
+    return &max_model;
 }
=20
 static inline void apply_cpu_model(const S390CPUModel *model, Error **errp=
)
 {
 #ifndef CONFIG_USER_ONLY
+    Error *err =3D NULL;
     static S390CPUModel applied_model;
     static bool applied;
=20
@@ -909,20 +912,23 @@ static inline void apply_cpu_model(const S390CPUModel=
 *model, Error **errp)
     }
=20
     if (kvm_enabled()) {
-        kvm_s390_apply_cpu_model(model, errp);
+        kvm_s390_apply_cpu_model(model, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
=20
-    if (!*errp) {
-        applied =3D true;
-        if (model) {
-            applied_model =3D *model;
-        }
+    applied =3D true;
+    if (model) {
+        applied_model =3D *model;
     }
 #endif
 }
=20
 void s390_realize_cpu_model(CPUState *cs, Error **errp)
 {
+    Error *err =3D NULL;
     S390CPUClass *xcc =3D S390_CPU_GET_CLASS(cs);
     S390CPU *cpu =3D S390_CPU(cs);
     const S390CPUModel *max_model;
@@ -939,7 +945,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     }
=20
     max_model =3D get_max_cpu_model(errp);
-    if (*errp) {
+    if (!max_model) {
         error_prepend(errp, "CPU models are not available: ");
         return;
     }
@@ -951,8 +957,9 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     cpu->model->cpu_ver =3D max_model->cpu_ver;
=20
     check_consistency(cpu->model);
-    check_compatibility(max_model, cpu->model, errp);
-    if (*errp) {
+    check_compatibility(max_model, cpu->model, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
=20
--=20
2.21.0


