Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E280C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4217E2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UwHvAt1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4217E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3Lp-0005Ws-VX
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L4-0004dE-L7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L1-0003iS-OU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:02 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NK2K26089486; Fri, 23 Oct 2020 16:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=z5M+CfLfcIamQglRSlI21ks6h3CpiPOTkWkfiogbSq4=;
 b=UwHvAt1CzTYN6BHBuo7uTYjgozLC9vtqdFHK3BQEA6zOXpgX/wiknQpUCb3ZWmIVnDg0
 6x42+FXrjU50hggSZp26gzHY/XOWSEu7M5BSkgNKqF1Qxfbs2Mq39x/btYeKxfQSYSQw
 Y7SKxe47jFbd+2HbOJQIZf5ormZM/vXL/PD3n/16nst4gkyva6dCqgJ+WWwjxiIaFgVX
 Q5Xxo55BWh3U7hmp+s8LstrUh3DcvBBvNqZDQt3IKSBq4yq9kiwSpcp66NRutL1rSF6D
 m5JUnsuz/p6lFzcx73yRt3/CI4zBfkO42zih3jhXePr+HMBdoioNioI6vmpebg91GfaT vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34bm6wbsnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:06:57 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK2llu090635;
 Fri, 23 Oct 2020 16:06:57 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34bm6wbsn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:06:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NJw6oj017944;
 Fri, 23 Oct 2020 20:06:56 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 347r8a7xhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:06:56 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK6okm60031266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:06:50 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CC606A04F;
 Fri, 23 Oct 2020 20:06:55 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 587F16A054;
 Fri, 23 Oct 2020 20:06:54 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:06:54 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] fuzz: Make fork_fuzz.ld compatible with LLVM's LLD
Date: Fri, 23 Oct 2020 16:06:39 -0400
Message-Id: <20201023200645.1055-2-dbuono@linux.vnet.ibm.com>
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
 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=969 mlxscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=1 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230119
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 16:06:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LLVM's linker, LLD, supports the keyword "INSERT AFTER", starting with
version 11.
However, when multiple sections are defined in the same "INSERT AFTER",
they are added in a reversed order, compared to BFD's LD.

This patch makes fork_fuzz.ld generic enough to work with both linkers.
Each section now has its own "INSERT AFTER" keyword, so proper ordering is
defined between the sections added.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 tests/qtest/fuzz/fork_fuzz.ld | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
index bfb667ed06..cfb88b7fdb 100644
--- a/tests/qtest/fuzz/fork_fuzz.ld
+++ b/tests/qtest/fuzz/fork_fuzz.ld
@@ -16,6 +16,11 @@ SECTIONS
       /* Lowest stack counter */
       *(__sancov_lowest_stack);
   }
+}
+INSERT AFTER .data;
+
+SECTIONS
+{
   .data.fuzz_ordered :
   {
       /*
@@ -34,6 +39,11 @@ SECTIONS
        */
        *(.bss._ZN6fuzzer3TPCE);
   }
+}
+INSERT AFTER .data.fuzz_start;
+
+SECTIONS
+{
   .data.fuzz_end : ALIGN(4K)
   {
       __FUZZ_COUNTERS_END = .;
@@ -43,4 +53,4 @@ SECTIONS
  * Don't overwrite the SECTIONS in the default linker script. Instead insert the
  * above into the default script
  */
-INSERT AFTER .data;
+INSERT AFTER .data.fuzz_ordered;
-- 
2.17.1


