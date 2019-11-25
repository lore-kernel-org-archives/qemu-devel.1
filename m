Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4662C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA2820748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y58NO/+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA2820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZI4s-0003Ia-NP
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 12:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iZI2Y-0002Ky-Pv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iZI2X-000734-Bo
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iZI2X-00072j-89
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574702444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rV1uxixPaIXehb0b7lQJW/y8REitFePGOWHxuDHGVc=;
 b=Y58NO/+d26cWeOfJPZpOLRZ3yxFYehflrcTeqgbmVDaJF+vmpVcxFVnCDrxaDhT4/S14ou
 wBDBzScNBWBWTyqoOwTyeOKI6i+yBAXekICdPdLQzMRXduvsZP9g377vsPOJdibR+GHvJY
 UOr+UP3TnAoiZqR8Lp3CYFjG1GQoe0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-UK1omcc9M7Kjta5g6A15vA-1; Mon, 25 Nov 2019 12:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137E7869EDB;
 Mon, 25 Nov 2019 17:20:40 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3746619C69;
 Mon, 25 Nov 2019 17:20:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] s390x/cpumodel: Factor out CPU feature dependencies
Date: Mon, 25 Nov 2019 18:20:30 +0100
Message-Id: <20191125172031.16282-2-david@redhat.com>
In-Reply-To: <20191125172031.16282-1-david@redhat.com>
References: <20191125172031.16282-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UK1omcc9M7Kjta5g6A15vA-1
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we check "if bit X is set, bit Y is required". We want
to perform "if bit Y is not set, bit X must also not be set" when
creating CPU models that will pass all consistency checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 115 +++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7e92fb2e15..e6072fab43 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -88,6 +88,59 @@ static S390CPUDef s390_cpu_defs[] =3D {
     CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "gen15b", "IBM 8562 GA1"),
 };
=20
+static const int cpu_feature_dependencies[][2] =3D {
+    { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
+    { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
+    { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
+    { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
+    { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
+    { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
+    { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
+    { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
+    { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 =
},
+    { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
+    { S390_FEAT_CMM_NT, S390_FEAT_CMM },
+    { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
+    { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
+    { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
+    { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+    { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
+};
+
 #define QEMU_MAX_CPU_TYPE 0x2964
 #define QEMU_MAX_CPU_GEN 13
 #define QEMU_MAX_CPU_EC_GA 2
@@ -769,66 +822,14 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(Cp=
uModelInfo *infoa,
=20
 static void check_consistency(const S390CPUModel *model)
 {
-    static int dep[][2] =3D {
-        { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
-        { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
-        { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
-        { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
-        { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
-        { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
-        { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
-        { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
-        { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ES=
OP2 },
-        { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
-        { S390_FEAT_CMM_NT, S390_FEAT_CMM },
-        { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
-        { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
-        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
-        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
-        { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
-    };
     int i;
=20
-    for (i =3D 0; i < ARRAY_SIZE(dep); i++) {
-        if (test_bit(dep[i][0], model->features) &&
-            !test_bit(dep[i][1], model->features)) {
+    for (i =3D 0; i < ARRAY_SIZE(cpu_feature_dependencies); i++) {
+        if (test_bit(cpu_feature_dependencies[i][0], model->features) &&
+            !test_bit(cpu_feature_dependencies[i][1], model->features)) {
             warn_report("\'%s\' requires \'%s\'.",
-                        s390_feat_def(dep[i][0])->name,
-                        s390_feat_def(dep[i][1])->name);
+                        s390_feat_def(cpu_feature_dependencies[i][0])->nam=
e,
+                        s390_feat_def(cpu_feature_dependencies[i][1])->nam=
e);
         }
     }
 }
--=20
2.21.0


