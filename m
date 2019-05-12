Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438BC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BBF2146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BBF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk7W-0002ky-D6
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:46:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzW-0004I5-6E
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzU-0003kD-Ff
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjz1-0003UD-Lz; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A24F03084248;
	Sun, 12 May 2019 08:37:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3754E5D706;
	Sun, 12 May 2019 08:37:16 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:21 +0200
Message-Id: <20190512083624.8916-11-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Sun, 12 May 2019 08:37:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 10/13] target/arm/monitor: kvm: only return
 valid sve vector sets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the TCG SVE implementation can implement all vector lengths
which are a quadword multiple, up to some maximum length, KVM can
only provide what the host supports, and not all multiples are
required to be supported by the architecture. With this patch
we extend the QMP query to ask KVM for the valid vectors when KVM
is enabled.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/monitor.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 8b2afa255c92..3e13dd7c7b7a 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -84,6 +84,41 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **=
errp)
     return head;
 }
=20
+#ifdef CONFIG_KVM
+static SVEVectorLengths *qmp_kvm_sve_vls_get(void)
+{
+    CPUArchState *env =3D mon_get_cpu_env();
+    ARMCPU *cpu =3D arm_env_get_cpu(env);
+    uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS];
+    SVEVectorLengths *vls =3D g_new(SVEVectorLengths, 1);
+    intList **v =3D &vls->vls;
+    int ret, i;
+
+    ret =3D kvm_arm_get_sve_vls(CPU(cpu), sve_vls);
+    if (ret <=3D 0) {
+        *v =3D g_new0(intList, 1); /* one vl of 0 means none supported *=
/
+        return vls;
+    }
+
+    for (i =3D KVM_ARM64_SVE_VQ_MIN; i <=3D ret; ++i) {
+        int bitval =3D (sve_vls[(i - KVM_ARM64_SVE_VQ_MIN) / 64] >>
+                      ((i - KVM_ARM64_SVE_VQ_MIN) % 64)) & 1;
+        if (bitval) {
+            *v =3D g_new0(intList, 1);
+            (*v)->value =3D i;
+            v =3D &(*v)->next;
+        }
+    }
+
+    return vls;
+}
+#else
+static SVEVectorLengths *qmp_kvm_sve_vls_get(void)
+{
+    return NULL;
+}
+#endif
+
 static SVEVectorLengths *qmp_sve_vls_get(void)
 {
     CPUArchState *env =3D mon_get_cpu_env();
@@ -130,7 +165,13 @@ static SVEVectorLengths *qmp_sve_vls_dup_and_truncat=
e(SVEVectorLengths *vls)
 SVEVectorLengthsList *qmp_query_sve_vector_lengths(Error **errp)
 {
     SVEVectorLengthsList *vls_list =3D g_new0(SVEVectorLengthsList, 1);
-    SVEVectorLengths *vls =3D qmp_sve_vls_get();
+    SVEVectorLengths *vls;
+
+    if (kvm_enabled()) {
+        vls =3D qmp_kvm_sve_vls_get();
+    } else {
+        vls =3D qmp_sve_vls_get();
+    }
=20
     while (vls) {
         vls_list->value =3D vls;
--=20
2.20.1


