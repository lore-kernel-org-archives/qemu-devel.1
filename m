Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C741CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D68E207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dUxfM6st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D68E207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEJA-0007mO-N0
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBEGm-0002ht-JK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:32:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBEGi-0004UM-9B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:32:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07R92VWd101577
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A+izSw8xoqB4rugyDo/MLV/Rhigge4h+CJkqGZjDRaE=;
 b=dUxfM6stMhpE/4QG6jhK01Og38CYat6LIWGV+d3pXir+CdlqMM5JqIhLozw1eKbip2Q4
 Ty7tKmH8SRdqmRluFV+rg+bANo0Mcb39hkkG2fX9649BT0zpvnWJkI/voYDrwKFKsbPp
 +YGRY9aLwvzSFVpCK0FFvBPTzBrKML+5hH5DSiTz3Vv3OFBakUbW2QWNFeY0oP4m++Lc
 7WTOucW4YtKSiDgRS137LyblEB7j7xdOiZC0+t1oifBiuRZQV2fnNwnN8C/Kgr5xIluf
 CZmcoBsNdGEt44t6sVsiJDocjmme1fMJUPheTg6OOm2kYi62PCz8JwzkXALzjA5TjOhk xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 336620qrbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:06 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07R9W5xu053685
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 336620qrax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2020 05:32:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R9SdOj028676;
 Thu, 27 Aug 2020 09:32:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 332ujkwgrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2020 09:32:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07R9W1xa29557070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 09:32:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43B9942042;
 Thu, 27 Aug 2020 09:32:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD62C42041;
 Thu, 27 Aug 2020 09:32:00 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2020 09:32:00 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] pc-bios: s390x: Use reset PSW if avaliable
Date: Thu, 27 Aug 2020 05:31:50 -0400
Message-Id: <20200827093152.3026-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200827093152.3026-1-frankja@linux.ibm.com>
References: <20200827093152.3026-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-27_02:2020-08-27,
 2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=1
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:32:05
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

If a blob provides a reset PSW then we should use it instead of
branching to the PSW address and using our own mask.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  |  1 +
 pc-bios/s390-ccw/jump2ipl.c | 48 ++++++++++++++++++++++---------------
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 8747c4ea26..0df9b3781d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -515,6 +515,7 @@ static void zipl_run(ScsiBlockPtr *pte)
     IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
 
     /* should not return */
+    write_reset_psw(entry->compdat.load_psw);
     jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
 }
 
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 767012bf0c..143d027bf7 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -13,20 +13,28 @@
 #define KERN_IMAGE_START 0x010000UL
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 
-typedef struct ResetInfo {
-    uint64_t ipl_psw;
-    uint32_t ipl_continue;
-} ResetInfo;
-
-static ResetInfo save;
+uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
 static void jump_to_IPL_2(void)
 {
-    ResetInfo *current = 0;
+    /* Restore reset PSW and io and external new PSWs */
+    *reset_psw = save_psw;
 
-    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
-    *current = save;
-    ipl(); /* should not return */
+    /* No reset PSW, let's jump instead. */
+    if (ipl_continue) {
+        void (*ipl)(void) = (void *) (uint64_t) ipl_continue;
+        ipl();
+    }
+
+    /* Reset PSW available, let's load it */
+    asm volatile ("lpsw 0(%0)\n"
+        :  : "a" (0):);
+    /* should not return */
+}
+
+void write_reset_psw(uint64_t psw)
+{
+    *reset_psw = psw;
 }
 
 void jump_to_IPL_code(uint64_t address)
@@ -46,15 +54,12 @@ void jump_to_IPL_code(uint64_t address)
      * content of non-BIOS memory after we loaded the guest, so we
      * save the original content and restore it in jump_to_IPL_2.
      */
-    ResetInfo *current = 0;
+    save_psw = *reset_psw;
+    *reset_psw = (uint64_t) &jump_to_IPL_2;
+    *reset_psw |= RESET_PSW_MASK;
+    ipl_continue = address;
 
-    save = *current;
-
-    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
-    current->ipl_psw |= RESET_PSW_MASK;
-    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
-
-    debug_print_int("set IPL addr to", current->ipl_continue);
+    debug_print_int("set IPL addr to", ipl_continue);
 
     /* Ensure the guest output starts fresh */
     sclp_print("\n");
@@ -84,7 +89,12 @@ void jump_to_low_kernel(void)
 
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


