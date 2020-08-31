Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F8DC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB832083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWOEs6yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB832083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClS6-0001DC-Kj
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClR0-00080F-5f
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClQx-0005m2-6J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07VF3SIZ079073
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d39EoDnLoQiZEpv6UafLFDNJocy9Tjk1Fk0UzspxBEo=;
 b=AWOEs6yKHAHC4zIms2+XmM+OEPV1i9iYHa/8lViQPCO7ppwpqoUahKV8oSCsk4zTNTl4
 1MQaVZkKPiNTu4Zd4GQ1ORNE0RDU3iG3LZs/Tq+BBkwJI/cpJ88KPv1UkRjdG7elEXjE
 gQvdEXK9v8p/LfFkBl/Tc4PLjMkyYqzriuwZg84/mUIu0bT7P5oB65FVE8mHTeRaFUDq
 tZy0tQp7BxWXaHjS8ejvqafkADROb+w+4BwY3r3q+/xmXzLogbPE+Gu4gKkDDrnOzMLI
 87vS5+LTns2Xnv3rk8+V0+yjdhP1vJPPKy0LySGl3UXlqOF8xgFhxGdG7YsgAo9zLlTR Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33937brq4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:21 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VF3cMo080418
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:21 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33937brq3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 11:09:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VF72sl014199;
 Mon, 31 Aug 2020 15:09:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 337e9gta6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 15:09:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07VF9GIv22544684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 15:09:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C74FA405E;
 Mon, 31 Aug 2020 15:09:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCFC1A4055;
 Mon, 31 Aug 2020 15:09:15 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2020 15:09:15 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] pc-bios: s390x: Save PSW rework
Date: Mon, 31 Aug 2020 11:09:07 -0400
Message-Id: <20200831150910.317171-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831150910.317171-1-frankja@linux.ibm.com>
References: <20200831150910.317171-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-31_07:2020-08-31,
 2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=1 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:09:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to save the ipl_continue variable in lowcore and have it
limited to 32 bits because of the lowcore layout. Let's move it to a
new 64 bit variable and get rid of the reset info struct.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/jump2ipl.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 767012bf0c..b6aad32def 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -13,20 +13,17 @@
 #define KERN_IMAGE_START 0x010000UL
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 
-typedef struct ResetInfo {
-    uint64_t ipl_psw;
-    uint32_t ipl_continue;
-} ResetInfo;
+static uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
-static ResetInfo save;
-
-static void jump_to_IPL_2(void)
+static void jump_to_IPL_addr(void)
 {
-    ResetInfo *current = 0;
+    __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
 
-    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
-    *current = save;
-    ipl(); /* should not return */
+    /* Restore reset PSW */
+    *reset_psw = save_psw;
+
+    ipl();
+    /* should not return */
 }
 
 void jump_to_IPL_code(uint64_t address)
@@ -46,15 +43,11 @@ void jump_to_IPL_code(uint64_t address)
      * content of non-BIOS memory after we loaded the guest, so we
      * save the original content and restore it in jump_to_IPL_2.
      */
-    ResetInfo *current = 0;
-
-    save = *current;
-
-    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
-    current->ipl_psw |= RESET_PSW_MASK;
-    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
-
-    debug_print_int("set IPL addr to", current->ipl_continue);
+    save_psw = *reset_psw;
+    *reset_psw = (uint64_t) &jump_to_IPL_addr;
+    *reset_psw |= RESET_PSW_MASK;
+    ipl_continue = address;
+    debug_print_int("set IPL addr to", ipl_continue);
 
     /* Ensure the guest output starts fresh */
     sclp_print("\n");
-- 
2.25.1


