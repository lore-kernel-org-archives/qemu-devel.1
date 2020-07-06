Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8561620724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8561620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsKOY-0002Nv-Oc
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 02:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNT-0000eA-1C; Mon, 06 Jul 2020 02:13:19 -0400
Received: from charlie.dont.surf ([128.199.63.193]:57952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNP-0000uF-0c; Mon, 06 Jul 2020 02:13:18 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 4FA9DBF5FF;
 Mon,  6 Jul 2020 06:13:10 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/18] hw/block/nvme: bump to v1.3
Date: Mon,  6 Jul 2020 08:12:45 +0200
Message-Id: <20200706061303.246057-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 02:13:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds mandatory features of NVM Express v1.3 to the emulated NVMe
device.


v3:
  * hw/block/nvme: additional tracing
    - Reverse logic in nvme_cid(). (Philippe)
    - Move nvme_cid() and nvme_sqid() to source file. (Philippe)
  * hw/block/nvme: fix missing endian conversion
    - Move this patch to very early in the series and fix the bug properly as
      suggested by Philippe. Then let the change trickle down through
      the series. (Philippe)
  * hw/block/nvme: add remaining mandatory controller parameters
    - Move the nvme_feature_{support,default} arrays to the source file.
      (Philippe)
    - Add a NVME_FID_MAX constant. (Philippe)
  * hw/block/nvme: support the get/set features select and save fields
    - Move the nvme_feature_cap array to the source file. (Philippe)
  * hw/block/nvme: reject invalid nsid values in active namespace id list
    - Rework the condition and add a comment and reference to the spec.
      (Philippe)
  * hw/block/nvme: provide the mandatory subnqn field
    - Change to use strpadcpy(). (Philippe)

  Had to clear some R-b's due to functional changes.

  Missing review: 2, 3, 7, 12, 16, 17


v2:
  * hw/block/nvme: bump spec data structures to v1.3
    - Shorten some constants. (Dmitry)
  * hw/block/nvme: add temperature threshold feature
    - Remove unused temp_thresh member. (Dmitry)
  * hw/block/nvme: add support for the get log page command
    - Change the temperature field in the NvmeSmartLog struct to be an
      uint16_t and handle wierd alignment by adding QEMU_PACKED to the
      struct. (Dmitry)
  * hw/block/nvme: add remaining mandatory controller parameters
    - Fix spelling. (Dmitry)
  * hw/block/nvme: support the get/set features select and save fields
    - Fix bad logic causing temperature thresholds to always report
      defaults. (Dmitry)
  * hw/block/nvme: reject invalid nsid values in active namespace id list
    - Added patch; reject the 0xfffffffe and 0xffffffff nsid values.


$ git-backport-diff -u for-master/bump-to-v1.3-v2 -r upstream/master... -S
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/18:[----] [--] 'hw/block/nvme: bump spec data structures to v1.3'
002/18:[0008] [FC] 'hw/block/nvme: fix missing endian conversion'
003/18:[0028] [FC] 'hw/block/nvme: additional tracing'
004/18:[----] [--] 'hw/block/nvme: add support for the abort command'
005/18:[0004] [FC] 'hw/block/nvme: add temperature threshold feature'
006/18:[----] [--] 'hw/block/nvme: mark fw slot 1 as read-only'
007/18:[----] [--] 'hw/block/nvme: add support for the get log page command'
008/18:[0002] [FC] 'hw/block/nvme: add support for the asynchronous event request command'
009/18:[----] [--] 'hw/block/nvme: move NvmeFeatureVal into hw/block/nvme.h'
010/18:[----] [--] 'hw/block/nvme: flush write cache when disabled'
011/18:[0044] [FC] 'hw/block/nvme: add remaining mandatory controller parameters'
012/18:[0024] [FC] 'hw/block/nvme: support the get/set features select and save fields'
013/18:[----] [--] 'hw/block/nvme: make sure ncqr and nsqr is valid'
014/18:[----] [--] 'hw/block/nvme: support identify namespace descriptor list'
015/18:[0008] [FC] 'hw/block/nvme: reject invalid nsid values in active namespace id list'
016/18:[----] [--] 'hw/block/nvme: enforce valid queue creation sequence'
017/18:[0006] [FC] 'hw/block/nvme: provide the mandatory subnqn field'
018/18:[----] [--] 'hw/block/nvme: bump supported version to v1.3'


Klaus Jensen (18):
  hw/block/nvme: bump spec data structures to v1.3
  hw/block/nvme: fix missing endian conversion
  hw/block/nvme: additional tracing
  hw/block/nvme: add support for the abort command
  hw/block/nvme: add temperature threshold feature
  hw/block/nvme: mark fw slot 1 as read-only
  hw/block/nvme: add support for the get log page command
  hw/block/nvme: add support for the asynchronous event request command
  hw/block/nvme: move NvmeFeatureVal into hw/block/nvme.h
  hw/block/nvme: flush write cache when disabled
  hw/block/nvme: add remaining mandatory controller parameters
  hw/block/nvme: support the get/set features select and save fields
  hw/block/nvme: make sure ncqr and nsqr is valid
  hw/block/nvme: support identify namespace descriptor list
  hw/block/nvme: reject invalid nsid values in active namespace id list
  hw/block/nvme: enforce valid queue creation sequence
  hw/block/nvme: provide the mandatory subnqn field
  hw/block/nvme: bump supported version to v1.3

 block/nvme.c          |  18 +-
 hw/block/nvme.c       | 676 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |  22 +-
 hw/block/trace-events |  27 +-
 include/block/nvme.h  | 225 +++++++++++---
 5 files changed, 892 insertions(+), 76 deletions(-)

-- 
2.27.0


