Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA28C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B162075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="rW6aArx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B162075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uHL-0003rX-I8
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDo-0006oe-Pw; Wed, 29 Jul 2020 18:06:48 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDl-0008U5-7v; Wed, 29 Jul 2020 18:06:48 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DAF95BF616;
 Wed, 29 Jul 2020 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060402;
 bh=PWC1uSf9gvUeJXpIbaAR4n8Y57AHWSEEhnnBDFKHR2I=;
 h=From:To:Cc:Subject:Date:From;
 b=rW6aArx/DPe9dEdibtJKQoZ2sX+PYftOqDDqAYiXeZwupItYCfCzjq7FYO4w7nlq7
 u6/jocpNiAUNnlOXTBN7/ZU8fEqHYiBHZaYBtywrZ5qvRMsnIB8aGyYfosJJ7sdNqU
 rfDyI6PF/ex9XK/+UlNVd95GLjifGrGuzuBLIy+8/yHfKsfwsd0VWkrASNnKpg4Oof
 VL5fcm8URiqOi0tXYw0kfT3ki6cJ/oN0EHj1taOQHSR5UehtiL4QMR1/Wr8+bxMYTJ
 2DKxNocmj3myHNltwRiQQQe8NKivAc9ayGIJHE/hT+dUHTPbBeJljLMnbN6DeT3iMj
 dlP55SRSHI0rA==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] hw/block/nvme: dma handling and address mapping
 cleanup
Date: Thu, 30 Jul 2020 00:06:22 +0200
Message-Id: <20200729220638.344477-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

This series consists of patches that refactors dma read/write and adds a=0D
number of address mapping helper functions.=0D
=0D
v2:=0D
  * hw/block/nvme: add mapping helpers=0D
    - Add an assert in case of out of bounds array access. (Maxim)=0D
=0D
  * hw/block/nvme: remove redundant has_sg member=0D
    - Split the fix for the missing qemu_iov_destroy into a fresh patch=0D
      ("hw/block/nvme: destroy request iov before reuse"). (Minwoo)=0D
=0D
  * hw/block/nvme: pass request along for tracing [DROPPED]=0D
    - Dropped the patch and replaced it with a simple patch that just adds=
=0D
      tracing to the nvme_map_prp function ("hw/block/nvme: add tracing to=
=0D
      nvme_map_prp"). (Minwoo)=0D
=0D
  * hw/block/nvme: add request mapping helper=0D
    - Changed the name from nvme_map to nvme_map_dptr. (Minwoo, Maxim)=0D
=0D
  * hw/block/nvme: add check for mdts=0D
    - Don't touch the documentaiton for the cmb_size_mb and max_ioqpairs=0D
      parameters in this patch. (Minwoo)=0D
=0D
  * hw/block/nvme: refactor NvmeRequest clearing [DROPPED]=0D
    - Keep NvmeRequest structure clearing as "before use". (Maxim)=0D
=0D
  * hw/block/nvme: add a namespace reference in NvmeRequest=0D
  * hw/block/nvme: remove NvmeCmd parameter=0D
    - Squash these two patches together into "hw/block/nvme: add ns/cmd=0D
      references in NvmeRequest".=0D
=0D
  * hw/block/nvme: consolidate qsg/iov clearing=0D
    - Move the qsg/iov destroys to a new nvme_req_exit function that is cal=
led=0D
      after the cqe has been posted.=0D
=0D
  * hw/block/nvme: remove explicit qsg/iov parameters=0D
    - New patch. THe nvme_map_prp() function doesn't require the qsg and io=
v=0D
      parameters since it can just get them from the passed NvmeRequest.=0D
=0D
Based-on: <20200706061303.246057-1-its@irrelevant.dk>=0D
=0D
Klaus Jensen (16):=0D
  hw/block/nvme: memset preallocated requests structures=0D
  hw/block/nvme: add mapping helpers=0D
  hw/block/nvme: replace dma_acct with blk_acct equivalent=0D
  hw/block/nvme: remove redundant has_sg member=0D
  hw/block/nvme: destroy request iov before reuse=0D
  hw/block/nvme: refactor dma read/write=0D
  hw/block/nvme: add tracing to nvme_map_prp=0D
  hw/block/nvme: add request mapping helper=0D
  hw/block/nvme: verify validity of prp lists in the cmb=0D
  hw/block/nvme: refactor request bounds checking=0D
  hw/block/nvme: add check for mdts=0D
  hw/block/nvme: be consistent about zeros vs zeroes=0D
  hw/block/nvme: add ns/cmd references in NvmeRequest=0D
  hw/block/nvme: consolidate qsg/iov clearing=0D
  hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp=0D
  hw/block/nvme: remove explicit qsg/iov parameters=0D
=0D
 block/nvme.c          |   4 +-=0D
 hw/block/nvme.c       | 506 +++++++++++++++++++++++++++---------------=0D
 hw/block/nvme.h       |   4 +-=0D
 hw/block/trace-events |   4 +=0D
 include/block/nvme.h  |   4 +-=0D
 5 files changed, 340 insertions(+), 182 deletions(-)=0D
=0D
-- =0D
2.27.0=0D
=0D

