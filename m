Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0678BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFCF205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFCF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99p9-0006kY-VA
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j99oU-0006Ck-PW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j99oT-0006QE-K9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:50:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j99oT-0006OT-DE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:50:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 023Fnl2B134590
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2020 10:50:26 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yfk5naw0f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 10:50:25 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 3 Mar 2020 15:50:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 3 Mar 2020 15:50:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 023FoK3M51904720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2020 15:50:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FAE6A405C;
 Tue,  3 Mar 2020 15:50:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBFAAA4054;
 Tue,  3 Mar 2020 15:50:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.150.5])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2020 15:50:18 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pc-bios: s390x: Save iplb location in lowcore
Date: Tue,  3 Mar 2020 10:50:10 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226122038.61481-1-frankja@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030315-0008-0000-0000-00000358FBA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030315-0009-0000-0000-00004A7A2B08
Message-Id: <20200303155010.2519-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-03_05:2020-03-03,
 2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=579 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030113
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The POP states that for a list directed IPL the IPLB is stored into
memory by the machine loader and its address is stored at offset 0x14
of the lowcore.

ZIPL currently uses the address in offset 0x14 to access the IPLB and
acquire flags about secure boot. If the IPLB address points into
memory which has an unsupported mix of flags set, ZIPL will panic
instead of booting the OS.

As the lowcore can have quite a high entropy for a guest that did drop
out of protected mode (i.e. rebooted) we encountered the ZIPL panic
quite often.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 pc-bios/s390-ccw/jump2ipl.c  |  1 +
 pc-bios/s390-ccw/main.c      |  8 +++++++-
 pc-bios/s390-ccw/netmain.c   |  1 +
 pc-bios/s390-ccw/s390-arch.h | 10 ++++++++--
 pc-bios/s390-ccw/s390-ccw.h  |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index da13c43cc0..4eba2510b0 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -35,6 +35,7 @@ void jump_to_IPL_code(uint64_t address)
 {
     /* store the subsystem information _after_ the bootmap was loaded */
     write_subsystem_identification();
+    write_iplb_location();
 
     /* prevent unknown IPL types in the guest */
     if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a21b386280..4e65b411e1 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -9,6 +9,7 @@
  */
 
 #include "libc.h"
+#include "helper.h"
 #include "s390-arch.h"
 #include "s390-ccw.h"
 #include "cio.h"
@@ -22,7 +23,7 @@ QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
 static uint16_t cutype;
-LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
+LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
@@ -42,6 +43,11 @@ void write_subsystem_identification(void)
     *zeroes = 0;
 }
 
+void write_iplb_location(void)
+{
+    lowcore->ptr_iplb = ptr2u32(&iplb);
+}
+
 void panic(const char *string)
 {
     sclp_print(string);
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index f2dcc01e27..309ffa30d9 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -40,6 +40,7 @@
 #define DEFAULT_TFTP_RETRIES 20
 
 extern char _start[];
+void write_iplb_location(void) {}
 
 #define KERNEL_ADDR             ((void *)0L)
 #define KERNEL_MAX_SIZE         ((long)_start)
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
index 504fc7c2f0..5f36361c02 100644
--- a/pc-bios/s390-ccw/s390-arch.h
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -36,7 +36,13 @@ typedef struct LowCore {
     /* prefix area: defined by architecture */
     PSWLegacy       ipl_psw;                  /* 0x000 */
     uint32_t        ccw1[2];                  /* 0x008 */
-    uint32_t        ccw2[2];                  /* 0x010 */
+    union {
+        uint32_t        ccw2[2];                  /* 0x010 */
+        struct {
+            uint32_t reserved10;
+            uint32_t ptr_iplb;
+        };
+    };
     uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
     uint32_t        ext_params;               /* 0x080 */
     uint16_t        cpu_addr;                 /* 0x084 */
@@ -85,7 +91,7 @@ typedef struct LowCore {
     PSW             io_new_psw;               /* 0x1f0 */
 } __attribute__((packed, aligned(8192))) LowCore;
 
-extern LowCore const *lowcore;
+extern LowCore *lowcore;
 
 static inline void set_prefix(uint32_t address)
 {
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 11bce7d73c..21f27e7990 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -57,6 +57,7 @@ void consume_io_int(void);
 /* main.c */
 void panic(const char *string);
 void write_subsystem_identification(void);
+void write_iplb_location(void);
 extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 unsigned int get_loadparm_index(void);
 
-- 
2.20.1


