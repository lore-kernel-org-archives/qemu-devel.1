Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B559C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9B920675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9B920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD6q-00013n-ED
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5R-0007fg-5q; Tue, 30 Jun 2020 06:01:58 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5O-0004J1-SX; Tue, 30 Jun 2020 06:01:56 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id ACF33BF676;
 Tue, 30 Jun 2020 10:01:51 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
Date: Tue, 30 Jun 2020 12:01:29 +0200
Message-Id: <20200630100139.1483002-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Hi all,

This series adds support for TP 4056 ("Namespace Types") and TP 4053
("Zoned Namespaces") and is an alternative implementation to the one
submitted by Dmitry[1].

While I don't want this to end up as a discussion about the merits of
each version, I want to point out a couple of differences from Dmitry's
version. At a glance, my version

  * builds on my patch series that adds fairly complete NVMe v1.4
    mandatory support, as well as nice-to-have feature such as SGLs,
    multiple namespaces and mostly just overall clean up. This finally
    brings the nvme device into a fairly compliant state on which we can
    add new features. I've tried hard to get these compliance and
    clean-up patches merged for a long time (in parallel with developing
    the emulation of NST and ZNS) and I would be really sad to see them
    by-passed since they have already been through many iterations and
    already carries Acked- and Reviewed-by's for the bulk of the
    patches. I think the nvme device is already in a "frankenstate" wrt.
    the implemented nvme version and the features it currently supports,
    so I think this kind of cleanup is long overdue.

  * uses an attached blockdev and standard blk_aio for persistent zone
    info. This is the same method used in our patches for Write
    Uncorrectable and (separate and extended lba) metadata support, but
    I've left those optional features out for now to ease the review
    process.

  * relies on the universal dulbe support added in ("hw/block/nvme: add
    support for dulbe") and sparse images for handling reads in gaps
    (above write pointer and below ZSZE); that is - the size of the
    underlying blockdev is in terms of ZSZE, not ZCAP

  * the controller uses timers to autonomously finish zones (wrt. FRL)

I've been on paternity leave for a month, so I havn't been around to
review Dmitry's patches, but I have started that process now. I would
also be happy to work with Dmitry & Friends on merging our versions to
get the best of both worlds if it makes sense.

This series and all preparatory patch sets (the ones I've been posting
yesterday and today) are available on my GitHub[2]. Unfortunately
Patchew got screwed up in the middle of me sending patches and it never
picked up v2 of "hw/block/nvme: support multiple namespaces" because it
was getting late and I made a mistake with the CC's. So my posted series
don't apply according to Patchew, but they actually do if you follow the
Based-on's (... or just grab [2]).


  [1]: Message-Id: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
  [2]: https://github.com/birkelund/qemu/tree/for-master/nvme


Based-on: <20200630043122.1307043-1-its@irrelevant.dk>
("[PATCH 0/3] hw/block/nvme: bump to v1.4")

Klaus Jensen (10):
  hw/block/nvme: support I/O Command Sets
  hw/block/nvme: add zns specific fields and types
  hw/block/nvme: add basic read/write for zoned namespaces
  hw/block/nvme: add the zone management receive command
  hw/block/nvme: add the zone management send command
  hw/block/nvme: add the zone append command
  hw/block/nvme: track and enforce zone resources
  hw/block/nvme: allow open to close transitions by controller
  hw/block/nvme: allow zone excursions
  hw/block/nvme: support reset/finish recommended limits

 block/nvme.c          |    6 +-
 hw/block/nvme-ns.c    |  397 +++++++++-
 hw/block/nvme-ns.h    |  148 +++-
 hw/block/nvme.c       | 1676 +++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |   76 +-
 hw/block/trace-events |   43 +-
 include/block/nvme.h  |  252 ++++++-
 7 files changed, 2469 insertions(+), 129 deletions(-)

-- 
2.27.0


