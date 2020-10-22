Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A28C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BDE2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GraIzJ70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BDE2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVu5-0003RI-Qy
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVVsh-0002pK-3w; Thu, 22 Oct 2020 04:23:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVVse-0005VL-AF; Thu, 22 Oct 2020 04:23:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09M81Yim046016; Thu, 22 Oct 2020 04:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gKT1T1K5PqHTToYjp8jq9o38yj8nGIvd1wGICn9NoCU=;
 b=GraIzJ70UZt9VAowlX/pxG5B3hOGgsAUbcLaGu9rYK+VC2ohMFE/D9hyfCoVZ4mkBt3p
 woRzjZZr/mdpTaKlPfBztT1RoZDB55IP2IYavTGq41B772AGCfKgJetXdmsxff2GJRiC
 YmGqVBohOvzGuv8QI2XQwY3TcDsX/XqWRC3yws8Hio/ahi3zVpYt85xaKdt9hmDL5UFK
 WwcySPckguEkAnVIcbFwOqWga3MRJ30gpq684H0m4Uh8lWy15JTeAVBNd+beSWj64I1e
 mZ/I9fvHoQs43Mfk0HeANpBqQmc25ssDk32kj8a/pAm2KTYTgGk1/egtFYSaEjh2ReRJ wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0829gj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 04:23:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09M81exr049445;
 Thu, 22 Oct 2020 04:23:25 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0829gh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 04:23:25 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09M8LXiD012661;
 Thu, 22 Oct 2020 08:23:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03fra.de.ibm.com with ESMTP id 347r87tq4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 08:23:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09M8NKT034079188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 08:23:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE8A35204E;
 Thu, 22 Oct 2020 08:23:19 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E80052052;
 Thu, 22 Oct 2020 08:23:18 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] s390x: pv: Fix diag318 PV fencing
Date: Thu, 22 Oct 2020 04:23:12 -0400
Message-Id: <20201022082312.124708-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <74c4631b-735c-e5ad-77a3-0bbd9c63c4db@redhat.com>
References: <74c4631b-735c-e5ad-77a3-0bbd9c63c4db@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-22_02:2020-10-20,
 2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=1 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:23:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 walling@linux.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Diag318 fencing needs to be determined on the current VM PV state and
not on the state that the VM has when we create the CPU model.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
---

If you're sure that this is what you want, then I'll send a v2 of the
patch set.

---
 target/s390x/cpu_features.c | 5 +++++
 target/s390x/cpu_features.h | 4 ++++
 target/s390x/cpu_models.c   | 4 ++++
 target/s390x/kvm.c          | 3 +--
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 31ea8df246..42fe0bf4ca 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu_features.h"
+#include "hw/s390x/pv.h"
 
 #define DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC) \
     [S390_FEAT_##_FEAT] = {                        \
@@ -105,6 +106,10 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         }
         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
     }
+
+    if (type == S390_FEAT_TYPE_SCLP_FAC134 && s390_is_pv()) {
+        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
+    }
 }
 
 void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index ef52ffce83..87463f064d 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -81,6 +81,10 @@ const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
 
 #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
 
+static inline void clear_be_bit(unsigned int bit_nr, uint8_t *array)
+{
+    array[bit_nr / 8] &= ~(0x80 >> (bit_nr % 8));
+}
 static inline void set_be_bit(unsigned int bit_nr, uint8_t *array)
 {
     array[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ca484bfda7..461e0b8f4a 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #endif
 #include "qapi/qapi-commands-machine-target.h"
+#include "hw/s390x/pv.h"
 
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
     {                                                                    \
@@ -238,6 +239,9 @@ bool s390_has_feat(S390Feat feat)
         }
         return 0;
     }
+    if (feat == S390_FEAT_DIAG_318 && s390_is_pv()) {
+        return false;
+    }
     return test_bit(feat, cpu->model->features);
 }
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f13eff688c..baa070fdf7 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2498,8 +2498,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
      */
     set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
 
-    /* DIAGNOSE 0x318 is not supported under protected virtualization */
-    if (!s390_is_pv() && kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
+    if (kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
-- 
2.25.1


