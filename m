Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0238C46470
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3484206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBJ1M7py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3484206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40511 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUt4-0003S2-LT
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:19:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hYUrT-0002Zl-6u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hYUrR-0002o2-0x
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:17:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hYUrN-0002cP-93; Wed, 05 Jun 2019 08:17:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55C4xCG071543; Wed, 5 Jun 2019 12:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id; s=corp-2018-07-02;
	bh=jKAYSVD57Abj8fOqnbC/jSNwgyrrLg96uks1IxQ18Bo=;
	b=kBJ1M7pyscS9DrZqko+PMoq6tcfuN7H96SVS2NravYOAhRVzO1InyeynOjHas7Q5kCm5
	3FqDTJ3cK734v2DBpqtYELmcuc0iG0XcNuLCki8Ia0B1KjH40iD3PdX2Reu0Q4JYiGIr
	QkfmKNW8HYec+Ow5RhjrqllO07ghVJZy6cle+HQdVUz8z1deL61LmLBb8OMZ0njk7vY4
	9HM1/QXpDNLPkjfQYeMtgbnM2+T2YLHUsJ6hMTt9C4uDFByAe/5p16Q47hELhVo7fnVI
	Vbseiz63oC9cWwqdkHt0UdyXGuCSrlP7Wsbr5tNBQGuTbB7mWvr4UjkkRw4Gy+rj8lgg
	EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2suevdjfkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 12:17:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55CHYxm092700; Wed, 5 Jun 2019 12:17:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2swnha3y32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 12:17:35 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55CHXj2030425;
	Wed, 5 Jun 2019 12:17:34 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Jun 2019 05:17:33 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Wed,  5 Jun 2019 15:17:18 +0300
Message-Id: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906050078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=825
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906050077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [PATCH v2 0/3] vmdk: Add read-only support for the new
 seSparse format
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

v1:

VMware introduced a new snapshot format in VMFS6 - seSparse (Space
Efficient Sparse) which is the default format available in ESXi 6.7.
Add read-only support for the new snapshot format.

v2:

Fixed after Max's review:

* Removed strict sesparse checks
* Reduced maximal L1 table size
* Added non-write mode check in vmdk_open() on sesparse

Sam Eiderman (3):
  vmdk: Fix comment regarding max l1_size coverage
  vmdk: Reduce the max bound for L1 table size
  vmdk: Add read-only support for seSparse snapshots

 block/vmdk.c               | 371 ++++++++++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/059.out |   2 +-
 2 files changed, 352 insertions(+), 21 deletions(-)

-- 
2.13.3


