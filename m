Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FCDC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57512083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MLhhy7Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57512083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClTx-0004lw-VN
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClQy-0007yj-Mr
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39276
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClQw-0005m0-Jc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07VF2BJh168209
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=awjFdXsWMaMNn8wNz7SVZG/HyxuBpMRmmzkgAlDYE68=;
 b=MLhhy7Y94H8mJh0mGB+ZiTQLXV3iO9vrt0yPW9/ShhRvFpvE1sLUBskkCsWhwzl4Wq0C
 QI7Sal3k5/EgwxJG5QzHBNUyGsRgM9BaVGU3n5fZOpvnK3q+ENJFA20fxXvZ7PhgyHD1
 KIoUeW2lp0jvT9iRd+uxvkp8FvNuFqlFWr3/d79NId3mlqNY7V/f3rQITbhgI7lTO0CU
 JSQsRhXb91QrbLh+BKyuSe6qxm0fNP63mQIcIM/gP/LvjT5LH2t8dNm9nc4gwfwygQYB
 AvfVgBG9UWKZKwpuaMCxFNtZTC3RdCylyGhabfIzk+yZ7cmIMViL2bl2mQ+Ws91tdKXM xA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 338xes900g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:21 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VF2C2q168383
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:21 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com with ESMTP id 338xes8yy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 11:09:21 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VF86S7001863;
 Mon, 31 Aug 2020 15:09:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma02fra.de.ibm.com with ESMTP id 337en7hd0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 15:09:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07VF9H3921496162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 15:09:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42E9BA4040;
 Mon, 31 Aug 2020 15:09:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3755A4053;
 Mon, 31 Aug 2020 15:09:16 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2020 15:09:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] pc-bios: s390x: Use reset PSW if avaliable
Date: Mon, 31 Aug 2020 11:09:08 -0400
Message-Id: <20200831150910.317171-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831150910.317171-1-frankja@linux.ibm.com>
References: <20200831150910.317171-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-31_06:2020-08-31,
 2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=1 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:09:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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

If a blob provides a reset PSW then we should use it instead of
branching to the PSW address and using our own mask.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  |  3 ++-
 pc-bios/s390-ccw/jump2ipl.c | 22 +++++++++++++++++-----
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 8747c4ea26..5a03b1eb8b 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -515,7 +515,8 @@ static void zipl_run(ScsiBlockPtr *pte)
     IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
 
     /* should not return */
-    jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
+    write_reset_psw(entry->compdat.load_psw);
+    jump_to_IPL_code(0);
 }
 
 static void ipl_scsi(void)
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index b6aad32def..5b8352d257 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -12,15 +12,21 @@
 
 #define KERN_IMAGE_START 0x010000UL
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
+#define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
 
 static uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
+void write_reset_psw(uint64_t psw)
+{
+    *reset_psw = psw;
+}
+
 static void jump_to_IPL_addr(void)
 {
     __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
 
     /* Restore reset PSW */
-    *reset_psw = save_psw;
+    write_reset_psw(save_psw);
 
     ipl();
     /* should not return */
@@ -43,9 +49,10 @@ void jump_to_IPL_code(uint64_t address)
      * content of non-BIOS memory after we loaded the guest, so we
      * save the original content and restore it in jump_to_IPL_2.
      */
-    save_psw = *reset_psw;
-    *reset_psw = (uint64_t) &jump_to_IPL_addr;
-    *reset_psw |= RESET_PSW_MASK;
+    if (address) {
+        save_psw = *reset_psw;
+        write_reset_psw(RESET_PSW);
+    }
     ipl_continue = address;
     debug_print_int("set IPL addr to", ipl_continue);
 
@@ -77,7 +84,12 @@ void jump_to_low_kernel(void)
 
     /* Trying to get PSW at zero address */
     if (*((uint64_t *)0) & RESET_PSW_MASK) {
-        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
+        /*
+         * Surely nobody will try running directly from lowcore, so
+         * let's use 0 as an indication that we want to load the reset
+         * psw at 0x0 and not jump to the entry.
+         */
+        jump_to_IPL_code(0);
     }
 
     /* No other option left, so use the Linux kernel start address */
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 36b884cced..7090720422 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -78,6 +78,7 @@ int virtio_read(ulong sector, void *load_addr);
 void zipl_load(void);
 
 /* jump2ipl.c */
+void write_reset_psw(uint64_t psw);
 void jump_to_IPL_code(uint64_t address);
 void jump_to_low_kernel(void);
 
-- 
2.25.1


