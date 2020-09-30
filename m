Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B74C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0EB2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WytEUMGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0EB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdzv-0007Ph-2N
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWt-00052D-Pa
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWr-0004el-1o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GflSwi2LMqoHBXKk32E+PkY+RKOVuf3EcxGk3RIoRE8=;
 b=WytEUMGHiLngu8SkBCgDauHpEoWs6uqh5ng22T9t7hs7TXWBcjray3AgcP+2vS166O+duT
 rX6s3st5Dtowq+lxUo8N1pJ0VrWENVpr8qWErcfPNzhQL4MTufPdOIoqZZKE9DwZhtQzie
 nM3ZA2CsVp6yLwfRYbCzzqtTiAqW74E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-o4dhMOHrMu6PIZEo_m2ZEA-1; Wed, 30 Sep 2020 10:56:19 -0400
X-MC-Unique: o4dhMOHrMu6PIZEo_m2ZEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B6DD8030B7;
 Wed, 30 Sep 2020 14:56:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CA1A5C1C4;
 Wed, 30 Sep 2020 14:56:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 20/20] s390x/cpumodel: Bump up QEMU model to a
 stripped-down IBM z14 GA2
Date: Wed, 30 Sep 2020 16:55:23 +0200
Message-Id: <20200930145523.71087-21-david@redhat.com>
In-Reply-To: <20200930145523.71087-1-david@redhat.com>
References: <20200930145523.71087-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG implements everything we need to run basic z14 OS+software.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  |  2 ++
 target/s390x/cpu_models.c   |  4 ++--
 target/s390x/gen-features.c | 15 +++++++++------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3106bbea33..5f9931d509 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -812,7 +812,9 @@ DEFINE_CCW_MACHINE(5_2, "5.2", true);
 
 static void ccw_machine_5_1_instance_options(MachineState *machine)
 {
+    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V5_1 };
     ccw_machine_5_2_instance_options(machine);
+    s390_set_qemu_cpu_model(0x2964, 13, 2, qemu_cpu_feat);
 }
 
 static void ccw_machine_5_1_class_options(MachineClass *mc)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b97e9596ab..c613ea87e8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -88,8 +88,8 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "gen15b", "IBM 8562 GA1"),
 };
 
-#define QEMU_MAX_CPU_TYPE 0x2964
-#define QEMU_MAX_CPU_GEN 13
+#define QEMU_MAX_CPU_TYPE 0x3906
+#define QEMU_MAX_CPU_GEN 14
 #define QEMU_MAX_CPU_EC_GA 2
 static const S390FeatInit qemu_max_cpu_feat_init = { S390_FEAT_LIST_QEMU_MAX };
 static S390FeatBitmap qemu_max_cpu_feat;
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a7bad36f35..017b8ac95e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -704,23 +704,25 @@ static uint16_t qemu_V4_1[] = {
     S390_FEAT_VECTOR,
 };
 
-static uint16_t qemu_LATEST[] = {
+static uint16_t qemu_V5_1[] = {
     S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
     S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
     S390_FEAT_ESOP,
 };
 
-/* add all new definitions before this point */
-static uint16_t qemu_MAX[] = {
-    /* generates a dependency warning, leave it out for now */
-    S390_FEAT_MSA_EXT_5,
-    /* features introduced after the z13 */
+static uint16_t qemu_LATEST[] = {
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_MISC_INSTRUCTION_EXT2,
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_VECTOR_ENH,
 };
 
+/* add all new definitions before this point */
+static uint16_t qemu_MAX[] = {
+    /* generates a dependency warning, leave it out for now */
+    S390_FEAT_MSA_EXT_5,
+};
+
 /****** END FEATURE DEFS ******/
 
 #define _YEARS  "2016"
@@ -837,6 +839,7 @@ static FeatGroupDefSpec QemuFeatDef[] = {
     QEMU_FEAT_INITIALIZER(V3_1),
     QEMU_FEAT_INITIALIZER(V4_0),
     QEMU_FEAT_INITIALIZER(V4_1),
+    QEMU_FEAT_INITIALIZER(V5_1),
     QEMU_FEAT_INITIALIZER(LATEST),
     QEMU_FEAT_INITIALIZER(MAX),
 };
-- 
2.26.2


