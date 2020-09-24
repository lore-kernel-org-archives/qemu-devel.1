Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11160C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AA723741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="My+2JVKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AA723741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLN92-0003az-LZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLN6W-0001lY-SV; Thu, 24 Sep 2020 04:59:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLN6U-0002fN-T8; Thu, 24 Sep 2020 04:59:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08O8XRm7055783; Thu, 24 Sep 2020 04:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d/14tOMkclL/7K4bt99vOOKxWSHoeGHFY3cYi66loV0=;
 b=My+2JVKY61bzrA0vgy8QAzZhGEVBtmdlTBiKvEqTJKicGz2ATwBAmk6X3lKxbu1Tga0l
 CxVu9m+09WWuyHSMJjVfiZ5QyusNRvo7kTjy8T+UxFWQjNun0e1ucjggFIH8EMkz4LXn
 1oXZYR7eGPM/cyY6+yYoc/7BpHTTXBPUQ/tKoaP3U3A1Hwyy9NvQPsNWL4vlnMv4CYxo
 NoDVDkCdCX4J4dYqS4q9L5yEhr7/mmqRQ80+xtSs91saIsDeTrbTz6jFLZEhf7UnjQyf
 1HRxfD0xunZWZsMHSFsNnzz559aX4qZooqANuihhntUT2MXV3MI0y3iQCqxIA+63A8W3 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33rqc221pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 04:59:46 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08O8XjMw057237;
 Thu, 24 Sep 2020 04:59:45 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33rqc221np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 04:59:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08O8wDx1025345;
 Thu, 24 Sep 2020 08:59:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 33n98gw2xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 08:59:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08O8w5qc16712022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 08:58:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 221FD4C040;
 Thu, 24 Sep 2020 08:59:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B62084C04A;
 Thu, 24 Sep 2020 08:59:40 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.161.19])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2020 08:59:40 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/3] pc-bios/s390-ccw: fix off-by-one error
Date: Thu, 24 Sep 2020 10:59:24 +0200
Message-Id: <20200924085926.21709-2-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924085926.21709-1-mhartmay@linux.ibm.com>
References: <20200924085926.21709-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-24_05:2020-09-24,
 2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 mlxlogscore=992 suspectscore=1 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240067
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 04:59:46
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
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This error takes effect when the magic value "zIPL" is located at the
end of a block. For example if s2_cur_blk = 0x7fe18000 and the magic
value "zIPL" is located at 0x7fe18ffc - 0x7fe18fff.

Fixes: ba831b25262a ("s390-ccw: read stage2 boot loader data to find menu")
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 97205674e59a..0d29dceaa3cc 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -163,7 +163,7 @@ static bool find_zipl_boot_menu_banner(int *offset)
     int i;
 
     /* Menu banner starts with "zIPL" */
-    for (i = 0; i < virtio_get_block_size() - 4; i++) {
+    for (i = 0; i < virtio_get_block_size() - 3; i++) {
         if (magic_match(s2_cur_blk + i, ZIPL_MAGIC_EBCDIC)) {
             *offset = i;
             return true;
-- 
2.25.4


