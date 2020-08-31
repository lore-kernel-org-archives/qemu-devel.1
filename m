Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06669C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8F12083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nAbXN3Sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8F12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClTq-0004VP-Ua
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClR0-00081E-K0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClQy-0005mA-LD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07VF3XhU079596
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zyTbis7odQ73yFoGFelxijktaeMXbkCz6c+59IjzkCE=;
 b=nAbXN3SwXog4DvEsIMfzYOPojhfY72EhtgIOK8kbvlBglHO4TrzEknxisuq6sz4jGt1L
 YYgY2znOpuXkt+WdTaj8IxGzBWTy3ns064beE7jboPvy4EHi17+ZJknWYxFI6IhO6KWZ
 qI2wUdOl3I+A29Xe4BfZj5pDXQ/kAfAJZ9OWUdO9li4351ismXS1D0U1Rt2xPl8V/5Zf
 pSQTFjnEsndoS0rDrPtO/f83tZifosF+HN08FqybKgmKooDRGhqOekn6xb9c3ycIh0Oh
 j+vcilmRgOTtJbN2/WtQX9fGGs308OZi28sRfcEn1aLHJMdcxdK3q7i1b/ELoLC7oPcM sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33937brq5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:23 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VF3kCX081612
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:22 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33937brq4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 11:09:22 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VF6jYP027548;
 Mon, 31 Aug 2020 15:09:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04fra.de.ibm.com with ESMTP id 338pkx0dqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 15:09:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07VF9Ieq22675744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 15:09:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0892AA404D;
 Mon, 31 Aug 2020 15:09:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69BCAA4051;
 Mon, 31 Aug 2020 15:09:17 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2020 15:09:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] pc-bios: s390x: Save io and external new PSWs before
 overwriting them
Date: Mon, 31 Aug 2020 11:09:09 -0400
Message-Id: <20200831150910.317171-5-frankja@linux.ibm.com>
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

Currently we always overwrite the mentioned exception new PSWs before
loading the enabled wait PSW. Let's save the PSW before overwriting
and restore it right before starting the loaded kernel.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/jump2ipl.c |  4 +++
 pc-bios/s390-ccw/netmain.c  |  3 ++
 pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++----------
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 5b8352d257..bb94ba7550 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -14,6 +14,7 @@
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 #define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
 
+extern uint64_t psw_save_io[], psw_save_ext[];
 static uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
 void write_reset_psw(uint64_t psw)
@@ -59,6 +60,9 @@ void jump_to_IPL_code(uint64_t address)
     /* Ensure the guest output starts fresh */
     sclp_print("\n");
 
+    memcpy(&lowcore->io_new_psw, psw_save_io, 16);
+    memcpy(&lowcore->external_new_psw, psw_save_ext, 16);
+
     /*
      * HACK ALERT.
      * We use the load normal reset to keep r15 unchanged. jump_to_IPL_2
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 056e93a818..74ef28fbc6 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -32,6 +32,7 @@
 #include <time.h>
 #include <pxelinux.h>
 
+#include "s390-arch.h"
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
@@ -43,6 +44,8 @@
 extern char _start[];
 void write_iplb_location(void) {}
 
+LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
+
 #define KERNEL_ADDR             ((void *)0L)
 #define KERNEL_MAX_SIZE         ((long)_start)
 #define ARCH_COMMAND_LINE_SIZE  896              /* Taken from Linux kernel */
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index ce519300a1..939aac3a7c 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -34,7 +34,17 @@ remainder:
 	larl	%r2,memsetxc
 	ex	%r3,0(%r2)
 done:
-	j      main		/* And call C */
+        /* prepare i/o call handler */
+        larl  %r1, io_new_code
+        larl  %r2, io_new_psw
+        stg   %r1, 8(%r2)
+        mvc   0x1f0(16),0(%r2)
+        /* prepare external call handler */
+        larl  %r1, external_new_code
+        larl  %r2, external_new_psw
+        stg   %r1, 8(%r2)
+        mvc   0x1b0(16),0(%r2)
+        j      main		/* And call C */
 
 memsetxc:
 	xc	0(1,%r1),0(%r1)
@@ -64,13 +74,16 @@ consume_sclp_int:
         oi      6(%r15),0x2
         lctlg   %c0,%c0,0(%r15)
         /* prepare external call handler */
-        larl %r1, external_new_code
-        stg %r1, 0x1b8
-        larl %r1, external_new_mask
-        mvc 0x1b0(8),0(%r1)
-        /* load enabled wait PSW */
-        larl %r1, enabled_wait_psw
-        lpswe 0(%r1)
+        larl  %r1, external_new_psw
+        lghi  %r2, 0x1b0
+        /* Is the BIOS' external new PSW already set? */
+        clc   0(16, %r1), 0(%r2)
+        je    load_ewait
+        /* No, save old PSW and write BIOS PSW */
+        larl  %r3, psw_save_ext
+        mvc   0(16, %r3), 0x1b0
+        mvc   0x1b0(16),0(%r1)
+        j     load_ewait
 
 /*
  * void consume_io_int(void)
@@ -84,11 +97,20 @@ consume_io_int:
         oi    4(%r15), 0xff
         lctlg %c6,%c6,0(%r15)
         /* prepare i/o call handler */
-        larl  %r1, io_new_code
-        stg   %r1, 0x1f8
-        larl  %r1, io_new_mask
-        mvc   0x1f0(8),0(%r1)
-        /* load enabled wait PSW */
+        larl  %r1, io_new_psw
+        lghi  %r2, 0x1f0
+        /* Is the BIOS' PSW already set? */
+        larl  %r3, load_ewait
+        clc   0(16, %r1), 0(%r2)
+        bcr   8, %r3
+        /* No, save old PSW and write BIOS PSW */
+        larl  %r3, psw_save_io
+        mvc   0(16, %r3), 0x1f0
+        mvc   0x1f0(16),0(%r1)
+        j     load_ewait
+
+load_ewait:
+        /* PSW is the correct one, time to load the enabled wait PSW */
         larl  %r1, enabled_wait_psw
         lpswe 0(%r1)
 
@@ -107,11 +129,17 @@ io_new_code:
         br    %r14
 
         .align  8
+        .globl psw_save_io
+        .globl psw_save_ext
 disabled_wait_psw:
         .quad   0x0002000180000000,0x0000000000000000
 enabled_wait_psw:
         .quad   0x0302000180000000,0x0000000000000000
-external_new_mask:
-        .quad   0x0000000180000000
-io_new_mask:
-        .quad   0x0000000180000000
+external_new_psw:
+        .quad   0x0000000180000000,0
+io_new_psw:
+        .quad   0x0000000180000000,0
+psw_save_io:
+        .quad   0,0
+psw_save_ext:
+        .quad   0,0
-- 
2.25.1


