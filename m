Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E7C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB652137B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="enJ8C7mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB652137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3Na-0007vW-MG
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L6-0004de-21
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13384
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L4-0003id-CX
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NJXbfL151695; Fri, 23 Oct 2020 16:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=okw3TffWEdn/PVkFEUH/mlJtiTHXtPak0FlBw9YMJDw=;
 b=enJ8C7movXuFPIEyRI4B+ovqWZgBdvWrKXa4gkkw7E1SwmW6d/QYpW9j5uQeOo/H+Ep6
 EqlUVZF/j3yprMqckLfiF1+h6XSvArbyZZnoB3nSP2Y3WA052KzVLZsV7jI+uNV0zuM0
 7KOICi2+SbAwTd5UEUR48n6LfozptJDMw3VIkYGImXf5pNT8zAX4nD+KE2VUXTawzyjH
 Q8qPail+wNkg1Jb0iyb0XLRINkcl7JLdbtHmp5TEADTchMp8bVfOH7eAXCLLgKQLBhjw
 36VyOrj0hqyUrWOVLLZVLowOqNB/ifB84m29t21xfJS2wQymkfxKSTewURVHUPPYsNOJ 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34c4vh1sk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:00 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK0WTc028726;
 Fri, 23 Oct 2020 16:06:59 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34c4vh1sk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:06:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NK6x84027463;
 Fri, 23 Oct 2020 20:06:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01dal.us.ibm.com with ESMTP id 34bhyqhase-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:06:58 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK6nHg5636760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:06:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 281BD6A051;
 Fri, 23 Oct 2020 20:06:57 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E42D6A057;
 Fri, 23 Oct 2020 20:06:56 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:06:56 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
Date: Fri, 23 Oct 2020 16:06:40 -0400
Message-Id: <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-23_14:2020-10-23,
 2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=1 mlxscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230119
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 16:07:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang 11 finds a couple of spots in the code that trigger new warnings:

../qemu-base/hw/usb/dev-uas.c:157:31: error: field 'status' with variable sized type 'uas_iu' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
    uas_iu                    status;
                              ^
1 error generated.

The data structure is UASStatus, which must end with a QTAILQ_ENTRY, so
I believe we cannot have uas_iu at the end. Since this is a gnu
extension but CLANG supports it, just add
-Wno-gnu-variable-sized-type-not-at-end
to remove the warning.

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

These are void * that get casted to enums, which are (or can be)
smaller than a 64bit pointer.
A code reorg may be better on the long term, but for now will
fix this adding
-Wno-void-pointer-to-enum-cast

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index e6754c1e87..9dc05cfb8a 100755
--- a/configure
+++ b/configure
@@ -2000,6 +2000,8 @@ add_to nowarn_flags -Wno-shift-negative-value
 add_to nowarn_flags -Wno-string-plus-int
 add_to nowarn_flags -Wno-typedef-redefinition
 add_to nowarn_flags -Wno-tautological-type-limit-compare
+add_to nowarn_flags -Wno-gnu-variable-sized-type-not-at-end
+add_to nowarn_flags -Wno-void-pointer-to-enum-cast
 add_to nowarn_flags -Wno-psabi
 
 gcc_flags="$warn_flags $nowarn_flags"
-- 
2.17.1


