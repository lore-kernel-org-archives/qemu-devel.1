Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB0C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C762214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2Qo3DaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C762214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7Ee-00024w-H2
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CF-0000HY-0J
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CD-0006U7-II
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg7C7-0006Gl-4c; Wed, 26 Jun 2019 08:38:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCYECL105242;
 Wed, 26 Jun 2019 12:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ctg1U7ZXa/ucf+cAYr43gPZyEKHKzEUUwGQ3sHqLG+U=;
 b=j2Qo3DaVsn5jAds87502ypJ58rz9kx8zvirCB0+zRP+ZK57DzZO20DCxo49gPHlDQX4T
 6/TzOAHNGF34TnNiRIvBrRY36g3p3SvEt+HUprDhIa+R5jyfpqIjZEDhTmrmo6y/s613
 W+87wQDtcGhGIfsL1JrAloBmaXH+Kfe99vr5Q1IdoxumSFtPNUQibEiVTp5m6odVsipA
 f9XTOQMxoHNPWb9pFCO9wAYBU1PlzR63kaIKVSjNNh2Ir8u2w5bEFUB9cI8MoleZ39nF
 CdQFIkurcQ8aYW7ctufJfZlAh8uB5fCzDB/US84wiegAmId2wrHFa3rlvuicoG+brKZ7 VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t9c9pt2bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCbUrg021783;
 Wed, 26 Jun 2019 12:38:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2tat7ct4ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:31 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QCcTVg019535;
 Wed, 26 Jun 2019 12:38:29 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 05:38:29 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 26 Jun 2019 15:38:11 +0300
Message-Id: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=844
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=888 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [SeaBIOS] [PATCH v4 0/5] Add Qemu to SeaBIOS LCHS
 interface
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

Non-standard logical geometries break under QEMU.

A virtual disk which contains an operating system which depends on
logical geometries (consistent values being reported from BIOS INT13
AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
logical geometries - for example 56 SPT (sectors per track).
No matter what QEMU will guess - SeaBIOS, for large enough disks - will
use LBA translation, which will report 63 SPT instead.

In addition we can not enforce SeaBIOS to rely on phyiscal geometries at
all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
report more than 16 physical heads when moved to an IDE controller, the
ATA spec allows a maximum of 16 heads - this is an artifact of
virtualization.

By supplying the logical geometies directly we are able to support such
"exotic" disks.

We will use fw_cfg to do just that.

v2:

Rename bootdevices fw_cfg key to bios-geoemtry

v3:

Change fw_cfg interface from mixed binary/textual to textual only
Squash commit "config: Add toggle for bootdevice information"

v4:

* Rename TRANSLATION_MACHINE to TRANSLATION_HOST
* Rename "overriden" translation name to "host-supplied"
* Rename overriden_lchs_supplied() to host_lchs_supplied()
* Move sectors and heads check to host_lchs_supplied()
* Reuse duplicate code in boot.c

Sam Eiderman (5):
  geometry: Read LCHS from fw_cfg
  boot: Reorder functions in boot.c
  boot: Build ata and scsi paths in function
  geometry: Add boot_lchs_find_*() utility functions
  geometry: Apply LCHS values for boot devices

 src/Kconfig          |   7 ++
 src/block.c          |  18 +++-
 src/block.h          |   1 +
 src/boot.c           | 273 +++++++++++++++++++++++++++++++++++++++++----------
 src/hw/ahci.c        |   1 +
 src/hw/ata.c         |   8 ++
 src/hw/esp-scsi.c    |   2 +
 src/hw/lsi-scsi.c    |   2 +
 src/hw/megasas.c     |   1 +
 src/hw/mpt-scsi.c    |   2 +
 src/hw/pvscsi.c      |   1 +
 src/hw/virtio-blk.c  |   2 +
 src/hw/virtio-scsi.c |   2 +
 src/util.h           |   6 ++
 14 files changed, 272 insertions(+), 54 deletions(-)

-- 
2.13.3


