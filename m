Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01BC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE918208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rea+ie0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE918208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazyH-0007L6-0E
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45468)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazrf-0001co-BH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazrd-0002r4-2p
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:48:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hazmh-0000iE-SP; Wed, 12 Jun 2019 05:43:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9XjHZ007455;
 Wed, 12 Jun 2019 09:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=B95NFMN89TpkRhbo2thttGiMmUdmAK0h/7Qmqt0zUJw=;
 b=Rea+ie0q9xL57Lk0qrrVqe/+5wWWi/+9EIZS2RzYh41BczNWMeG2gLm7fCKbeg1pcfVK
 qcCi/6RNGPfIMjCrLZMUpGqflqlIzDUiYBbocvCZIF4t9QvFTptpzvdtW2rePrN7G4c2
 K3vagyznqImgrfRAT+SlxIcEAajoRwtXst8S7ozs+hHbKBXOshBmj+W0YMyenTTP7SWQ
 zFC3Ds53Q/yvow5+bUuKk2jHrdNF0VQ70VWCxaVL5c3ic0t51kkuObJbf7TjZ5oBy2CD
 6jCE+1nXIXYUR9mWzBVonPkIlq1hJ9ahFnqOU1j2JP0I7y/pxUNsJLfBQUxuEA9maTT+ cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 2t02hetf4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9gufT064402;
 Wed, 12 Jun 2019 09:43:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2t04hyuas8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C9h5GP028670;
 Wed, 12 Jun 2019 09:43:06 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 02:43:04 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 12:42:29 +0300
Message-Id: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=702
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=742 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [QEMU] [PATCH 0/8] Add Qemu to SeaBIOS LCHS interface
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

Sam Eiderman (8):
  block: Refactor macros - fix tabbing
  block: Support providing LCHS from user
  bootdevice: Add interface to gather LCHS
  scsi: Propagate unrealize() callback to scsi-hd
  bootdevice: Gather LCHS from all relevant devices
  bootdevice: Refactor get_boot_devices_list
  bootdevice: FW_CFG interface for LCHS values
  hd-geo-test: Add tests for lchs override

 bootdevice.c             | 158 ++++++++++---
 hw/block/virtio-blk.c    |   6 +
 hw/ide/qdev.c            |   7 +-
 hw/nvram/fw_cfg.c        |  14 +-
 hw/scsi/scsi-bus.c       |  15 ++
 hw/scsi/scsi-disk.c      |  14 ++
 include/hw/block/block.h |  22 +-
 include/hw/scsi/scsi.h   |   1 +
 include/sysemu/sysemu.h  |   4 +
 tests/Makefile.include   |   2 +-
 tests/hd-geo-test.c      | 565 +++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 767 insertions(+), 41 deletions(-)

-- 
2.13.3


