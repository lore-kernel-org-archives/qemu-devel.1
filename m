Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6AD20881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ophcA/fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6AD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqkh-0007C1-6g
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:39:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTqfD-00033X-Co
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTqfC-0000fo-G5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:33:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hTqfA-0000bg-ES; Thu, 23 May 2019 12:33:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NGTIrL120086; Thu, 23 May 2019 16:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id; s=corp-2018-07-02;
	bh=G0EiAhQNZE4wm/S9pofS6RQroRxjzEPqF3ilQt+790g=;
	b=ophcA/fNwApQCj5ZRDfjv9hjL0QiaCv4+bUtQhAd1tDitcVrc1dAxDMVZLjD67ltpdqx
	b/jDwl3SmzFGFuKTIHnoqf3pH4HM1c/7S0GgE6NvG20G5p4nzm/1/UM6M7/l1R3gllBp
	QN5BC8eWieIdH3ghHEkpU0xGcxnaF405fjDJDeBatd9ZstOqFEYq++TWt7bGOc32zE/0
	GA16sK6ntxmUMaBYmKdnIgdafWy1yNWkG6rtopMiJCfLvYDtlascwSndKCADFg8DjUXM
	+8FMdIjssH2vcJgLMthyQ2HoPeBCli/PS68sJ/P2/EJJBpaFXoZ8qWvmrSd3mpo5wlL2
	fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2smsk5kmhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 16:33:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NGW8uR182621; Thu, 23 May 2019 16:33:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2smsh2bvnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 16:33:49 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4NGXmNf006040;
	Thu, 23 May 2019 16:33:48 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 16:33:47 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Thu, 23 May 2019 19:33:34 +0300
Message-Id: <20190523163337.4497-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=257
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=298
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230112
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v5 0/3] qemu-img: rebase: Improve/optimize
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

v4 & v5:

* Using backing_bs(bs) when a prefix was detected since bs was
  already checked for allocation.

Sam Eiderman (3):
  qemu-img: rebase: Reuse parent BlockDriverState
  qemu-img: rebase: Reduce reads on in-chain rebase
  qemu-img: rebase: Reuse in-chain BlockDriverState

 qemu-img.c | 85 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 30 deletions(-)

-- 
2.13.3


