Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5AFC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED050206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DUqivhmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED050206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kanfh-0003cv-Sd
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbH-0006s3-La; Thu, 05 Nov 2020 17:19:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbF-000409-Ic; Thu, 05 Nov 2020 17:19:23 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M2mRg058559; Thu, 5 Nov 2020 17:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8oXxIUD/cSqLWGgnh3UvronhBOcl6oIFr9wjt0Pgxyw=;
 b=DUqivhmM+MbBlJ//xJpAW43qn20JbxwQCvuoCyGDxAogU1lQb3C2nTbzKpdnuM6tAn+m
 g6MUM2jwoXSqJFPlPKxLASJ5AUepbyljRiJfpLqeu7YhWfWw4dWZ2p2BYCzGGujjW6D9
 QOvPv6sE8sQdjgRJ1ldsUViE3Byr72B++xLW+DTLgw3GalL/tvFQgkE6fZKP/AryIGrD
 I67b2HZRfDimN7dfWZs3m7QO6K42/4X6XdvHZgYdf6lIBp+hn30JDm7a+BxcliT/Px6i
 BwNQhItK0ibD9wh2OhZs9lcUfzhXC9tnJsqN/7M/UawXn7aEr48cG9kS8P9LWvzcTHvs kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34mhxjtnva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:19 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5M3Wcv064827;
 Thu, 5 Nov 2020 17:19:19 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34mhxjtnuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:19 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MC2Af017625;
 Thu, 5 Nov 2020 22:19:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01dal.us.ibm.com with ESMTP id 34h0s801t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:18 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJHm314877298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:17 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 088576A054;
 Thu,  5 Nov 2020 22:19:17 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E7096A04D;
 Thu,  5 Nov 2020 22:19:16 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:16 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] s390x: fix clang 11 warnings in cpu_models.c
Date: Thu,  5 Nov 2020 17:18:58 -0500
Message-Id: <20201105221905.1350-3-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050141
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are void * pointers that get casted to enums, in cpu_models.c
Such casts can result in a small integer type and are caught as
warnings with clang, starting with version 11:

Clang 11 finds a bunch of spots in the code that trigger this new warnings:

../qemu-base/target/s390x/cpu_models.c:985:21: error: cast to smaller integer type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
    S390Feat feat = (S390Feat) opaque;
                    ^~~~~~~~~~~~~~~~~
../qemu-base/target/s390x/cpu_models.c:1002:21: error: cast to smaller integer type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
    S390Feat feat = (S390Feat) opaque;
                    ^~~~~~~~~~~~~~~~~
../qemu-base/target/s390x/cpu_models.c:1036:27: error: cast to smaller integer type 'S390FeatGroup' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
    S390FeatGroup group = (S390FeatGroup) opaque;
                          ^~~~~~~~~~~~~~~~~~~~~~
../qemu-base/target/s390x/cpu_models.c:1057:27: error: cast to smaller integer type 'S390FeatGroup' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
    S390FeatGroup group = (S390FeatGroup) opaque;
                          ^~~~~~~~~~~~~~~~~~~~~~
4 errors generated.

Avoid this warning by casting the pointer to uintptr_t first.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 target/s390x/cpu_models.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 461e0b8f4a..b5abff8bef 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -986,7 +986,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 static void get_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
-    S390Feat feat = (S390Feat) opaque;
+    S390Feat feat = (S390Feat) (uintptr_t) opaque;
     S390CPU *cpu = S390_CPU(obj);
     bool value;
 
@@ -1003,7 +1003,7 @@ static void get_feature(Object *obj, Visitor *v, const char *name,
 static void set_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
-    S390Feat feat = (S390Feat) opaque;
+    S390Feat feat = (S390Feat) (uintptr_t) opaque;
     DeviceState *dev = DEVICE(obj);
     S390CPU *cpu = S390_CPU(obj);
     bool value;
@@ -1037,7 +1037,7 @@ static void set_feature(Object *obj, Visitor *v, const char *name,
 static void get_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    S390FeatGroup group = (S390FeatGroup) opaque;
+    S390FeatGroup group = (S390FeatGroup) (uintptr_t) opaque;
     const S390FeatGroupDef *def = s390_feat_group_def(group);
     S390CPU *cpu = S390_CPU(obj);
     S390FeatBitmap tmp;
@@ -1058,7 +1058,7 @@ static void get_feature_group(Object *obj, Visitor *v, const char *name,
 static void set_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    S390FeatGroup group = (S390FeatGroup) opaque;
+    S390FeatGroup group = (S390FeatGroup) (uintptr_t) opaque;
     const S390FeatGroupDef *def = s390_feat_group_def(group);
     DeviceState *dev = DEVICE(obj);
     S390CPU *cpu = S390_CPU(obj);
-- 
2.17.1


