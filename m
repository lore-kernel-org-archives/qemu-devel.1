Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF53C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A8520775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A8520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlEh-00048j-3S
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBW-0006x6-JO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBV-0003Dz-DV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jGlBV-0003D3-4h
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OF5qHr059810
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7dfbc3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:37 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 24 Mar 2020 15:09:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 24 Mar 2020 15:09:31 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02OF9W5Y47317216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2020 15:09:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63C8AA4054;
 Tue, 24 Mar 2020 15:09:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00660A405B;
 Tue, 24 Mar 2020 15:09:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.9.40])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2020 15:09:30 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] pc-bios: s390x: Get rid of magic offsets into the lowcore
Date: Tue, 24 Mar 2020 11:08:41 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324150847.10476-1-frankja@linux.ibm.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032415-0016-0000-0000-000002F6ED17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032415-0017-0000-0000-0000335A8B78
Message-Id: <20200324150847.10476-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_05:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=581
 mlxscore=0 suspectscore=1 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240079
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

If we have a lowcore struct that has members for offsets that we want
to touch, why not use it?

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.h  | 17 +++++++++++------
 pc-bios/s390-ccw/main.c |  8 +++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index aaa432deddb9242e..9ad794a789c47df2 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -122,12 +122,17 @@ typedef struct schib {
 } __attribute__ ((packed, aligned(4))) Schib;
 
 typedef struct subchannel_id {
-        __u32 cssid:8;
-        __u32:4;
-        __u32 m:1;
-        __u32 ssid:2;
-        __u32 one:1;
-        __u32 sch_no:16;
+    union {
+        struct {
+            __u16 cssid:8;
+	    __u16:4;
+            __u16 m:1;
+            __u16 ssid:2;
+            __u16 one:1;
+        };
+        __u16 sch_id;
+    };
+        __u16 sch_no;
 } __attribute__ ((packed, aligned(4))) SubChannelId;
 
 struct chsc_header {
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 4e65b411e1d890ba..8b912454c940a390 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -36,11 +36,9 @@ LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
  */
 void write_subsystem_identification(void)
 {
-    SubChannelId *schid = (SubChannelId *) 184;
-    uint32_t *zeroes = (uint32_t *) 188;
-
-    *schid = blk_schid;
-    *zeroes = 0;
+    lowcore->subchannel_id = blk_schid.sch_id;
+    lowcore->subchannel_nr = blk_schid.sch_no;
+    lowcore->io_int_parm = 0;
 }
 
 void write_iplb_location(void)
-- 
2.25.1


