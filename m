Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068CEC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6745E20866
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OPbHXdsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6745E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjXr-00039s-E4
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kPjUx-0007ZX-6n
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kPjUu-0002Dr-28
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0969Vonc193822
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2020 05:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4DwvKU+klFJRrmZu4dlvRVnUY3gvooEZ199bNOhdDIA=;
 b=OPbHXdsKo1/0Mz6fYMDk52ISG6pMs8MK9+yJfZ/fAj1UaFnscHNLftQxMNI9SE7AwW1M
 jU6owXYKz3vtsAnbq8x/ZDsPqs18SNiofPRpdLF6cX7HUWgoJVSNP5mDZF1OaPLAUT34
 qUqzQyNNgeU6c9bmMhjp6T0UhjbNdKI9aWNFL1sdfaBxlVUHxW9f0mbyJdtXIkBZnSOp
 g++MmgAJasU/aVHBSVupHqVsLK9D1rk/dwx+3ODOH6hzy7xGrfCJEAUJ7r8ZUZiMDrO2
 EQfzMI1bzYrnv4pwZyOZgvuY26hwSHF6ndq4EorkBC9Wj4sb0wuUsHGhTDn3sFFV4Hts vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 340nej9k1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:43:01 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0969W3OF194814
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2020 05:43:00 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 340nej9k19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 05:43:00 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0969R5Ec006359;
 Tue, 6 Oct 2020 09:42:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma01fra.de.ibm.com with ESMTP id 33xgx7ske7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 09:42:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0969guC617498454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2020 09:42:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC67152051;
 Tue,  6 Oct 2020 09:42:56 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1A3725204F;
 Tue,  6 Oct 2020 09:42:56 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/4] pc-bios: s390x: Fix bootmap.c zipl component entry
 data handling
Date: Tue,  6 Oct 2020 05:42:46 -0400
Message-Id: <20201006094249.50640-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006094249.50640-1-frankja@linux.ibm.com>
References: <20201006094249.50640-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-06_03:2020-10-06,
 2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=1 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 05:43:01
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

The two main types of zipl component entries are execute and
load/data. The last member of the component entry struct therefore
denotes either a PSW or an address. Let's make this a bit more clear
by introducing a union and cleaning up the code that uses that struct
member.

The execute type component entries written by zipl contain short PSWs,
not addresses. Let's mask them and only pass the address part to
jump_to_IPL_code(uint64_t address) because it expects an address as
visible by the name of the argument.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 5 +++--
 pc-bios/s390-ccw/bootmap.h | 7 ++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 97205674e5..8747c4ea26 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "s390-arch.h"
 #include "bootmap.h"
 #include "virtio.h"
 #include "bswap.h"
@@ -436,7 +437,7 @@ static void zipl_load_segment(ComponentEntry *entry)
     char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
 
     blockno = entry->data.blockno;
-    address = entry->load_address;
+    address = entry->compdat.load_addr;
 
     debug_print_int("loading segment at block", blockno);
     debug_print_int("addr", address);
@@ -514,7 +515,7 @@ static void zipl_run(ScsiBlockPtr *pte)
     IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
 
     /* should not return */
-    jump_to_IPL_code(entry->load_address);
+    jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
 }
 
 static void ipl_scsi(void)
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 12a0166aae..3946aa3f8d 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -64,11 +64,16 @@ typedef struct BootMapTable {
     BootMapPointer entry[];
 } __attribute__ ((packed)) BootMapTable;
 
+typedef union ComponentEntryData {
+    uint64_t load_psw;
+    uint64_t load_addr;
+} ComponentEntryData;
+
 typedef struct ComponentEntry {
     ScsiBlockPtr data;
     uint8_t pad[7];
     uint8_t component_type;
-    uint64_t load_address;
+    ComponentEntryData compdat;
 } __attribute((packed)) ComponentEntry;
 
 typedef struct ComponentHeader {
-- 
2.25.1


