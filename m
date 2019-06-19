Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E808C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4E420B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4Axl5n/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4E420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXH6-0001ES-8j
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWwL-00061C-GT
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWwJ-0001UY-DX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:31:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdWwC-0001Mj-2b; Wed, 19 Jun 2019 05:31:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9SVFk081460;
 Wed, 19 Jun 2019 09:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=EKEEChlrTWbSYze6N7Ygh+pkL6Ik3AJoN67+crLEBxc=;
 b=4Axl5n/dPeoxOZoSPkRRoOax9H57pF6SpltOOJtxg4HnZNzMBiEd87ZYVsMa0yOr7fna
 tl16f07jGg5/MG1in962D6NWlg/EL1I9xpn2HczMSdGH9HjsSSLuAv9K9uyen3UChiko
 DRuGDzmKMfEw3epNd5k5YidiBD1+1Ep28ZoA1gnuB3hqUsBvWWW5+lQpU+QpHQu9Q1Z+
 lp0D9ZLXLqLHmHgRt6YrOhnDg1gKuRjHeV7z5P4V43zUJOTjOtSrjvWBgaEChUVjAEVK
 RVMeVr9hH2tX90bl4MNepKj9i5t4tXhXSevuPjfRuGA8gAMYs4CHisvywUQyAVrOEzXt Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t7809a95u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:31:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9TDVl130124;
 Wed, 19 Jun 2019 09:29:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2t77yn7uh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:29:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J9TNpI026685;
 Wed, 19 Jun 2019 09:29:24 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 02:29:23 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 19 Jun 2019 12:28:57 +0300
Message-Id: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=791
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=833 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [QEMU] [PATCH v4 0/8] Add Qemu to SeaBIOS LCHS
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

Fix missing parenthesis check in
    "hd-geo-test: Add tests for lchs override"

v3:

* Rename fw_cfg key to "bios-geometry".
* Remove "extendible" interface.
* Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
* Fix last qtest commit - automatic docker tester for some reason does not have qemu-img set

v4:

* Change fw_cfg interface from mixed textual/binary to textual only

Sam Eiderman (8):
  block: Refactor macros - fix tabbing
  block: Support providing LCHS from user
  bootdevice: Add interface to gather LCHS
  scsi: Propagate unrealize() callback to scsi-hd
  bootdevice: Gather LCHS from all relevant devices
  bootdevice: Refactor get_boot_devices_list
  bootdevice: FW_CFG interface for LCHS values
  hd-geo-test: Add tests for lchs override

 bootdevice.c             | 148 +++++++++---
 hw/block/virtio-blk.c    |   6 +
 hw/ide/qdev.c            |   7 +-
 hw/nvram/fw_cfg.c        |  14 +-
 hw/scsi/scsi-bus.c       |  15 ++
 hw/scsi/scsi-disk.c      |  14 ++
 include/hw/block/block.h |  22 +-
 include/hw/scsi/scsi.h   |   1 +
 include/sysemu/sysemu.h  |   4 +
 tests/Makefile.include   |   2 +-
 tests/hd-geo-test.c      | 581 +++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 773 insertions(+), 41 deletions(-)

-- 
2.13.3


