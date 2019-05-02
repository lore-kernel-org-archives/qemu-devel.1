Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39FEC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80D0206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aok5cT4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80D0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCGt-0003JJ-R5
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:01:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF7-0002Ga-9W
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF6-0008M6-9N
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hMCF0-0008EU-Tp; Thu, 02 May 2019 09:59:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42DrkVS035771; Thu, 2 May 2019 13:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=W+DgkX3WpUWxz9RRS5xSoAyHrSdF9ITlRqjQjs6QkCE=;
	b=aok5cT4b36VJMWiKhXNgVKBhrw8Ug0AVD/rO6EpLBUBmZQvQfIXCpJrB6k0s1y/GsWHp
	jpMrF1/hd0PiObut155sQPDVy3XJC3J3S8aCF25hS+jVM0EcG3ShlzkUXikJUaeQvWVX
	/j3s3RniZJf9QxiD7EUDpMo+hZRC6uErbrEejR7TPnZB2SPzZjLpVHnFBrEdZ0RadGBy
	Hpoi5BCS64Ub8ZhrmScirK/SS73Dtteml4GgC7KfxAmAq26zM7gUiuxR4o5Wh5gQV7UB
	jSQuvLN2K/Aw7fGSeyLlVjt+AtTapfX0Wxvjvt72nd1AIeJclagldawQOxgSHB8Rh/ad
	xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2s6xhygtme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:59:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42Dx5JM147652; Thu, 2 May 2019 13:59:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2s6xhgtnf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:59:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x42Dx2cU030308;
	Thu, 2 May 2019 13:59:04 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 02 May 2019 06:59:02 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:58:25 +0300
Message-Id: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=260
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905020095
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=293
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905020095
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v2 0/3] qemu-img: rebase: Improve/optimize
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502135825.ssx2TFsK69FGbMlSGvTKFmZREKtRV9B6psR0yRLzwK4@z>

This patch series aims to improve the speed of qemu-img rebase.

1. Mainly by removing unnecessary reads when rebasing on the same
   chain.
2. But also by minimizing the number of bdrv_open calls rebase
   requires.

v2:

 - Added missing g_free in
   "qemu-img: rebase: Reuse in-chain BlockDriverState"*

Sam Eiderman (3):
  qemu-img: rebase: Reuse parent BlockDriverState
  qemu-img: rebase: Reduce reads on in-chain rebase
  qemu-img: rebase: Reuse in-chain BlockDriverState

 qemu-img.c | 85 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 27 deletions(-)

-- 
2.13.3


