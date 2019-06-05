Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E50C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954BB206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q4ZZiz3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954BB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUt4-0003SL-KJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:19:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hYUrT-0002Zm-6u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hYUrR-0002o3-0z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:17:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hYUrN-0002dr-97; Wed, 05 Jun 2019 08:17:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55C4wWV050876; Wed, 5 Jun 2019 12:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=h+mba0+eNWHBSHqCqhd4pFi93/ujCsDGO0cw1r+phXc=;
	b=q4ZZiz3wVgJmv4R78lJlmfnrgC4CL7wlHoV6ylCy1UbysIxbJvq7c3c5XLidvYq7+Lxo
	/fmkhZCrlnoV0VgNPFejlpLfGHmmYpJFg6RYoaHdrKbg0I29y/Z2ot1vvm32FHT8U5//
	0Qb1zA0GHIl0vMij0dl0q2S5AK8UoZ2xAYK7PaBkkMk56oXO0vapYq0Dw3E9CqHpXZsO
	F8Dr/PwBUuoq35HksnqwDv4ltK1vNkqdzNkX1Po9Qu60bDO6QNFUArZTCPhB5xeaXuZj
	oRSF4L+0vO6ZksUQiGRqafL6HCeP37NSXkRZE5+WUiVmmlbZbctyk/n56XOV4gaxeqX6
	PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2sugstj8et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 12:17:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55CHYuZ023752; Wed, 5 Jun 2019 12:17:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2swngkv104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 12:17:37 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55CHa09011640;
	Wed, 5 Jun 2019 12:17:36 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Jun 2019 05:17:35 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Wed,  5 Jun 2019 15:17:19 +0300
Message-Id: <20190605121721.29815-2-shmuel.eiderman@oracle.com>
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
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v2 1/3] vmdk: Fix comment regarding max l1_size
 coverage
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

Commit b0651b8c246d ("vmdk: Move l1_size check into vmdk_add_extent")
extended the l1_size check from VMDK4 to VMDK3 but did not update the
default coverage in the moved comment.

The previous vmdk4 calculation:

    (512 * 1024 * 1024) * 512(l2 entries) * 65536(grain) = 16PB

The added vmdk3 calculation:

    (512 * 1024 * 1024) * 4096(l2 entries) * 512(grain) = 1PB

Adding the calculation of vmdk3 to the comment.

In any case, VMware does not offer virtual disks more than 2TB for
vmdk4/vmdk3 or 64TB for the new undocumented seSparse format which is
not implemented yet in qemu.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 block/vmdk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 51067c774f..0f2e453bf5 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -426,10 +426,15 @@ static int vmdk_add_extent(BlockDriverState *bs,
         return -EFBIG;
     }
     if (l1_size > 512 * 1024 * 1024) {
-        /* Although with big capacity and small l1_entry_sectors, we can get a
+        /*
+         * Although with big capacity and small l1_entry_sectors, we can get a
          * big l1_size, we don't want unbounded value to allocate the table.
-         * Limit it to 512M, which is 16PB for default cluster and L2 table
-         * size */
+         * Limit it to 512M, which is:
+         *     16PB - for default "Hosted Sparse Extent" (VMDK4)
+         *            cluster size: 64KB, L2 table size: 512 entries
+         *     1PB  - for default "ESXi Host Sparse Extent" (VMDK3/vmfsSparse)
+         *            cluster size: 512B, L2 table size: 4096 entries
+         */
         error_setg(errp, "L1 size too big");
         return -EFBIG;
     }
-- 
2.13.3


