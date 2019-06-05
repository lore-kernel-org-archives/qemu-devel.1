Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA3C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9FC206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WWX5GwQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9FC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUut-0004le-JO
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:21:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hYUrV-0002bd-Is
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hYUrT-0002qf-23
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:17:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hYUrP-0002it-48; Wed, 05 Jun 2019 08:17:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55C55rO071574; Wed, 5 Jun 2019 12:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=r8ORzcEb/eyuf4HLxGpD0OePgE1pHG8c+mq42TaI/tU=;
	b=WWX5GwQ6HEEy77TfTuELPZLBYIzuq2v296C0rxnZlM6NKkNM7aeA2b8pFo9nvYiZn7xo
	0+VyZIxl03VL/V0XaEZAJP7ov64N+XETqT4nWDdDJTk31fmeztT757Rn/Ro17paZgP+h
	ALdi3MGscFY6OIMWzA6dSjcIeIvHFln1figBJXwTVrc88N64RB56KTLLxMkz2XdBU0FY
	yjqx9pzp8bvY4h1xd922z2VITplpRIh6PDF5ifO24U5yZME7o9f37eB51Z8CLqVfYUnr
	zO6TNZDM6xUiJSSVNkJUri6TkCX/zVNT1cjF8ivGGJN3dhOBb5DPOQ1qY6gGdJ42K2/M
	qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2suevdjfm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 12:17:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55CHZG1092739; Wed, 5 Jun 2019 12:17:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2swnha3y3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 12:17:39 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55CHdlH003447;
	Wed, 5 Jun 2019 12:17:39 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Jun 2019 05:17:38 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Wed,  5 Jun 2019 15:17:20 +0300
Message-Id: <20190605121721.29815-3-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906050078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906050077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [PATCH v2 2/3] vmdk: Reduce the max bound for L1 table
 size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: liran.alon@oracle.com, arbel.moshe@oracle.com, shmuel.eiderman@oracle.com,
	eyal.moscovici@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

512M of L1 entries is a very loose bound, only 32M are required to store
the maximal supported VMDK file size of 2TB.

Fixed qemu-iotest 59# - now failure occures before on impossible L1
table size.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 block/vmdk.c               | 13 +++++++------
 tests/qemu-iotests/059.out |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 0f2e453bf5..931eb2759c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -425,15 +425,16 @@ static int vmdk_add_extent(BlockDriverState *bs,
         error_setg(errp, "Invalid granularity, image may be corrupt");
         return -EFBIG;
     }
-    if (l1_size > 512 * 1024 * 1024) {
+    if (l1_size > 32 * 1024 * 1024) {
         /*
          * Although with big capacity and small l1_entry_sectors, we can get a
          * big l1_size, we don't want unbounded value to allocate the table.
-         * Limit it to 512M, which is:
-         *     16PB - for default "Hosted Sparse Extent" (VMDK4)
-         *            cluster size: 64KB, L2 table size: 512 entries
-         *     1PB  - for default "ESXi Host Sparse Extent" (VMDK3/vmfsSparse)
-         *            cluster size: 512B, L2 table size: 4096 entries
+         * Limit it to 32M, which is enough to store:
+         *     8TB  - for both VMDK3 & VMDK4 with
+         *            minimal cluster size: 512B
+         *            minimal L2 table size: 512 entries
+         *            8 TB is still more than the maximal value supported for
+         *            VMDK3 & VMDK4 which is 2TB.
          */
         error_setg(errp, "L1 size too big");
         return -EFBIG;
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f51394ae8e..4fab42a28c 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2358,5 +2358,5 @@ Offset          Length          Mapped to       File
 0x140000000     0x10000         0x50000         TEST_DIR/t-s003.vmdk
 
 === Testing afl image with a very large capacity ===
-qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
+qemu-img: Could not open 'TEST_DIR/afl9.IMGFMT': L1 size too big
 *** done
-- 
2.13.3


