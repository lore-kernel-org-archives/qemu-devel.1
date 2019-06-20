Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F57C48BE1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236D12083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MDj9B4qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236D12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtTw-00011T-9g
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:35:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdtDR-00033W-5E
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdtBk-0004xj-1W
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:17:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdtBi-0004uG-ME; Thu, 20 Jun 2019 05:16:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K93xDl079241;
 Thu, 20 Jun 2019 09:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=2tnL0/JjqC/MgRnQPOj7/mLJovyVBdZIaiuuQnaOSf8=;
 b=MDj9B4qoTFt1twl7etp8PGCo9pWmzA80pAfWmr9sDAoQtg5xvtKz1QgAyFzIRp6GXNK1
 8cn5UDaFprjOh8cKxR+woo/MjBC8cpvQaugMihbD7x6DS8mKdne9PkFH6vg3tpcYn9xO
 dqsXb5Sy4wtUITkoMKLECI57tUyl3YtyJJoIqPccX4NSSfYNAM86mhC2rqj5056cqkCa
 x4xhLvy0LUorToV9dXuQAiOq5xkwkMtw6YuxnLqX6mfYCUP2Qm7p7i7Y8VARZor3nqU5
 rws+6y+LbCsnA6epbPM+pJHF+W8Enqsoi2ohlmxUpNfLiJD25frpG9woEulmDqAXXll6 wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t7809g0w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 09:16:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K9FC6d022033;
 Thu, 20 Jun 2019 09:16:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t77ynhcf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 09:16:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5K9Gtn6025740;
 Thu, 20 Jun 2019 09:16:55 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Jun 2019 02:11:14 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com
Date: Thu, 20 Jun 2019 12:10:54 +0300
Message-Id: <20190620091057.47441-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=816
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=868 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200068
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH v3 0/3] vmdk: Add read-only support for the new
 seSparse format
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
Cc: liran.alon@oracle.com, shmuel.eiderman@oracle.com, karl.heubaum@oracle.com,
 arbel.moshe@oracle.com
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

v3:

Change non-write mode check in vmdk_open() to bdrv_apply_auto_read_only().

Sam Eiderman (3):
  vmdk: Fix comment regarding max l1_size coverage
  vmdk: Reduce the max bound for L1 table size
  vmdk: Add read-only support for seSparse snapshots

 block/vmdk.c               | 372 ++++++++++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/059.out |   2 +-
 2 files changed, 353 insertions(+), 21 deletions(-)

-- 
2.13.3


