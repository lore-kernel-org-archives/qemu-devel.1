Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE1B20738
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qiVSqi0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE1B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEIY-0006KG-Fq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBEGR-0002Hg-ED
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:32:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40050
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBEGO-0004UQ-F5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:32:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07R9ViNP032659
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KXUh3AnRFkecV2Ytu1ZxecpP1UPZJ4wLAYyw9rsuhzQ=;
 b=qiVSqi0Wk+2ReG6lkOaDYcixYAixhs2vxdxEGvFvwdEfFfvVovrL/N2vZmMmAcQZ5DYv
 LjYgBJFpcoDHBr5K2RYHgEqmi5EEVNi4qGH33ty+XNgKUJTzZH5/+EdMKVrXV1a5PYMC
 U3+9guWGWp6gUekdssFxppX6WbkHffL3qimwbZDoSB06NcXFSFnTduUGEAZaGFSLNciU
 2r9LH44QXjgKlFBlCbfsDSeFZHpGY9vpaCJuixNxDIec95z0tvRtHyJRL+ftAiXGqOkE
 cuMnEVnGPnT827xDj4u/E8z1WCPB9CgwVWry4mYwQezvDZlvlFnurshnNLsdxOChWAkI 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 336a2k8asb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:06 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07R9W6kI033758
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:06 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 336a2k8aru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2020 05:32:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R9J68s007334;
 Thu, 27 Aug 2020 09:32:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 332uk6dgpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2020 09:32:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 07R9W2c365339696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 09:32:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B2EB42042;
 Thu, 27 Aug 2020 09:32:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7469042041;
 Thu, 27 Aug 2020 09:32:01 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2020 09:32:01 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 3/4] pc-bios: s390x: Save io and external new PSWs
 before overwriting them
Date: Thu, 27 Aug 2020 05:31:51 -0400
Message-Id: <20200827093152.3026-4-frankja@linux.ibm.com>
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
 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=969 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:32:06
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

Currently we always overwrite the mentioned exception new PSWs before
loading the enabled wait PSW. Let's save the PSW before overwriting
and restore it right before starting the loaded kernel.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

Maybe we should rather statically allocate a lowcore so we don't dirty
0x0 at all.

---
 pc-bios/s390-ccw/jump2ipl.c |  3 ++
 pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 143d027bf7..a44f3ab5b3 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -13,12 +13,15 @@
 #define KERN_IMAGE_START 0x010000UL
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 
+extern uint64_t *psw_save_io, *psw_save_ext;
 uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
 static void jump_to_IPL_2(void)
 {
     /* Restore reset PSW and io and external new PSWs */
     *reset_psw = save_psw;
+    memcpy((void *)0x1f0, psw_save_io, 16);
+    memcpy((void *)0x1b0, psw_save_ext, 16);
 
     /* No reset PSW, let's jump instead. */
     if (ipl_continue) {
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


