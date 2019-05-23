Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A069C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AF42133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TiVWDsPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AF42133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToAn-00011t-Ji
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:54:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTo92-0008QZ-GY
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTo91-0007Tx-KR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:52:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hTo8z-0007MQ-Gj; Thu, 23 May 2019 09:52:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NDhRIe167125; Thu, 23 May 2019 13:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id; s=corp-2018-07-02;
	bh=Xq+Xfa1sCQXSU5N6IxydmnqinVkBe7F1dpG+D0+IfEE=;
	b=TiVWDsPpVPSyiOAZHycxHOJARbulFbcRmkEPcLnjVwPCsGEP/xzgcVYdtsQtG4d9O07q
	ctBR4+Hs6Ft8Mc7s3chgBCK00NHK7Xy4SlQNodUyOrBJ6XnxwSxSmA5J8BDRiuyHWwqu
	4OxaWl6VHWJAciDJUhACFZhAbKZ3pYB99RO5ZvY1YNb+1xKNPotPg5cXIvWbCkcKX1f3
	AssECPIqjbVIv2IkoazeFSw80zM4R9qZPBSJSghtoSkk9WRcCNfIMOQPGspgUXTFzoA3
	E+no4mz4hUTq7ftV5htGi0RQ8pM1cQwmEyh1ZPoAL1aoPpGCw4eAEuqSI6VSDEsS8HSM
	HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 2smsk5jeuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 13:52:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NDp7J5014874; Thu, 23 May 2019 13:52:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2smshf8evq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 13:52:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4NDqNAg029383;
	Thu, 23 May 2019 13:52:23 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 13:52:22 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Thu, 23 May 2019 16:51:36 +0300
Message-Id: <20190523135139.2147-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=1 mlxscore=1 mlxlogscore=219
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=260
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230096
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [PATCH v3 0/3] qemu-img: rebase: Improve/optimize
 rebase operation
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
Cc: eyal.moscovici@oracle.com, arbel.moshe@oracle.com, liran.alon@oracle.com,
	shmuel.eiderman@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series aims to improve the speed of qemu-img rebase.

  1. Mainly by removing unnecessary reads when rebasing on the same
     chain.
  2. But also by minimizing the number of bdrv_open calls rebase
     requires.

v2:

* Added missing g_free in
  "qemu-img: rebase: Reuse in-chain BlockDriverState"

v3:

* Rebased on top of "Allow rebase with no input base" series

Sam Eiderman (3):
  qemu-img: rebase: Reuse parent BlockDriverState
  qemu-img: rebase: Reduce reads on in-chain rebase
  qemu-img: rebase: Reuse in-chain BlockDriverState

 qemu-img.c | 85 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 30 deletions(-)

-- 
2.13.3


