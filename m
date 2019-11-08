Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CBCC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6605C214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0kp-0007US-4T
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iT0h9-0003Bp-IU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iT0h7-0002Sy-QG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:36:43 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2544)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>)
 id 1iT0h0-0002FL-Df; Fri, 08 Nov 2019 04:36:35 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35dc536d4101-8563d;
 Fri, 08 Nov 2019 17:35:17 +0800 (CST)
X-RM-TRANSID: 2ee35dc536d4101-8563d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.novalocal (unknown[112.25.65.41])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25dc536d2c26-16e35;
 Fri, 08 Nov 2019 17:35:17 +0800 (CST)
X-RM-TRANSID: 2ee25dc536d2c26-16e35
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: pbonzini@redhat.com, fam@euphon.net, dillaman@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Subject: [PATCH 0/4 V2] SCSI COMPARE_AND_WRITE command support
Date: Fri,  8 Nov 2019 17:35:37 +0800
Message-Id: <1573205741-2094-1-git-send-email-baiyaowei@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: baiyaowei@cmss.chinamobile.com, yangjun@cmss.chinamobile.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently ceph/librbd added several interfaces to handle SCSI commands like
COMPARE_AND_WRITE directly. However they were only be used in special
scenarios, i.e. ISCSI. That involves more software components which makes
the IO path longer and could bring more potential issues. Actually we're
maintaining several ceph clusters with ISCSI protocal being used which,
i have to say, is not an easy job.

So supporting COMPARE_AND_WRITE in scsi-disk would be a reasonable solution
and easy to implement with the help of the SCSI handlers in librbd, which
could leave alone the ISCSI stuff and make the IO path shorter.

This patchset implements it by reusing the blk_aio_pwritev interface and
introducing a new BDRV_REQ_COMPARE_AND_WRITE element into BdrvRequestFlags
to indicate a COMPARE_AND_WRITE request, rather than adding a new interface
into block-backend.c.

The FUA support is implemented in the blk_aio_pwritev's callback function
similar to its emulation in scsi_write_do_fua function, maybe through
BDRV_REQ_FUA is another doable way.

This patchset is tested with the method of sg_compare_and_write.txt from
sg3_utils. Link below:

https://github.com/hreinecke/sg3_utils/blob/master/examples/sg_compare_and_write.txt

v1->v2: fix checkpatch script complaints and cleanup

Yaowei Bai (4):
  block: add SCSI COMPARE_AND_WRITE support
  block/rbd: implement bdrv_aio_compare_and_write interface
  hw/scsi: add SCSI COMPARE_AND_WRITE support
  scsi-disk: add FUA support for COMPARE_AND_WRITE

 block/io.c                  | 20 +++++++++
 block/raw-format.c          |  3 +-
 block/rbd.c                 | 45 ++++++++++++++++++++-
 hw/scsi/emulation.c         |  1 +
 hw/scsi/scsi-bus.c          |  4 ++
 hw/scsi/scsi-disk.c         | 98 +++++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/trace-events        |  1 +
 include/block/block.h       |  5 ++-
 include/block/block_int.h   |  3 ++
 include/hw/scsi/emulation.h |  3 ++
 include/scsi/utils.h        |  2 +
 scsi/utils.c                |  5 +++
 12 files changed, 185 insertions(+), 5 deletions(-)

-- 
1.8.3.1




