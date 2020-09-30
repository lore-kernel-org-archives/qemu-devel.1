Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE403C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B3C206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q/Puv350"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B3C206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeZU-0001Rp-9q
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kNeVy-0007PS-Bd; Wed, 30 Sep 2020 11:59:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kNeVo-00021s-Ed; Wed, 30 Sep 2020 11:59:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08UFZ0Hp182393; Wed, 30 Sep 2020 11:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=4jbzuzklvkZtovivYeLq/4Z+2yoD2zkSehVxqFzXxB0=;
 b=Q/Puv350K3lj0bPyJSwcAq9xE8DjqU6eta9WkqouUgmocZOMCQRrK272yerSrWF7Nb1y
 BYN0xI3RfKCCtAlJpC0jMNAkSGuSKMqifdREIp6KDXgeaabWoCLZ9ApQsNBx7aUnT4Z5
 hFyMezt1ejan6v8KhNUaYaGuXboI2h3+iNbvO/wonlmfAU5LmTHKCQ/L/8wmzsdUjNTl
 FFFwPn7bz068RHIElqp+rm+94X2Ss7gxu9uCAjAjBfAAYiepPKC/lik6B8l4RBLdm4lZ
 6rL3X1O3fz/MLR1eSL7aTYlMS/yG58OHpOb41Y9GFyB/OYkjvIuhSDzX5p6KjYJ/skwl Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33vv1qad0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 11:59:06 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UFdPCO000999;
 Wed, 30 Sep 2020 11:59:06 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33vv1qacyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 11:59:05 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UFw4kI025934;
 Wed, 30 Sep 2020 15:59:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 33v6mgs59b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 15:59:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08UFx1nS23921086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 15:59:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00E144C044;
 Wed, 30 Sep 2020 15:59:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE1C14C040;
 Wed, 30 Sep 2020 15:59:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 30 Sep 2020 15:59:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 9B787E1FB0; Wed, 30 Sep 2020 17:59:00 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] vmdk: fix maybe uninitialized warnings
Date: Wed, 30 Sep 2020 17:58:56 +0200
Message-Id: <20200930155859.303148-2-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930155859.303148-1-borntraeger@de.ibm.com>
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-30_08:2020-09-30,
 2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=4 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300124
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 11:59:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fedora 32 gcc 10 seems to give false positives:

Compiling C object libblock.fa.p/block_vmdk.c.o
../block/vmdk.c: In function ‘vmdk_parse_extents’:
../block/vmdk.c:587:5: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  587 |     g_free(extent->l1_table);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:754:17: note: ‘extent’ was declared here
  754 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  620 |     ret = vmdk_init_tables(bs, extent, errp);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:598:17: note: ‘extent’ was declared here
  598 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c:1178:39: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 1178 |             extent->flat_start_offset = flat_offset << 9;
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../block/vmdk.c: In function ‘vmdk_open_vmdk4’:
../block/vmdk.c:581:22: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  581 |     extent->l2_cache =
      |     ~~~~~~~~~~~~~~~~~^
  582 |         g_malloc(extent->entry_size * extent->l2_size * L2_CACHE_SIZE);
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:872:17: note: ‘extent’ was declared here
  872 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c: In function ‘vmdk_open’:
../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  620 |     ret = vmdk_init_tables(bs, extent, errp);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:598:17: note: ‘extent’ was declared here
  598 |     VmdkExtent *extent;
      |                 ^~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile.ninja:884: libblock.fa.p/block_vmdk.c.o] Error 1

fix them by assigning a default value.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 block/vmdk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8ec62c7ab798..a00dc00eb47a 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -595,7 +595,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *bs,
     int ret;
     uint32_t magic;
     VMDK3Header header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
@@ -751,7 +751,7 @@ static int vmdk_open_se_sparse(BlockDriverState *bs,
     int ret;
     VMDKSESparseConstHeader const_header;
     VMDKSESparseVolatileHeader volatile_header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
 
     ret = bdrv_apply_auto_read_only(bs,
             "No write support for seSparse images available", errp);
@@ -869,7 +869,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
     uint32_t magic;
     uint32_t l1_size, l1_entry_sectors;
     VMDK4Header header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
     BDRVVmdkState *s = bs->opaque;
     int64_t l1_backup_offset = 0;
     bool compressed;
@@ -1088,7 +1088,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
     BdrvChild *extent_file;
     BdrvChildRole extent_role;
     BDRVVmdkState *s = bs->opaque;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
     char extent_opt_prefix[32];
     Error *local_err = NULL;
 
-- 
2.26.2


