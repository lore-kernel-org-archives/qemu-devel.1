Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBBC47257
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644FD2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644FD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqVV-0005eg-J6
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 01:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jVqS8-00076I-PG; Tue, 05 May 2020 01:49:12 -0400
Received: from charlie.dont.surf ([128.199.63.193]:56226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jVqS1-0005CB-VQ; Tue, 05 May 2020 01:49:12 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B184EBF5DC;
 Tue,  5 May 2020 05:49:02 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v5 00/18] nvme: refactoring and cleanups
Date: Tue,  5 May 2020 07:48:22 +0200
Message-Id: <20200505054840.186586-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:31:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Changes since v5
~~~~~~~~~~~~~~~~
No functional changes, just updated Reviewed-by tags. Also, I screwed up
the CC list when sending v4.

Philippe and Keith, please add a Reviewed-by to

  * "nvme: factor out pmr setup" and
  * "do cmb/pmr init as part of pci init"

since the first one was added and the second one was changed in v4 when
rebasing on Kevins block-next tree which had the PMR work that was not
in master at the time.

With those in place, it should be ready for Kevin to merge.

Klaus Jensen (18):
  nvme: fix pci doorbell size calculation
  nvme: rename trace events to pci_nvme
  nvme: remove superfluous breaks
  nvme: move device parameters to separate struct
  nvme: use constants in identify
  nvme: refactor nvme_addr_read
  nvme: add max_ioqpairs device parameter
  nvme: remove redundant cmbloc/cmbsz members
  nvme: factor out property/constraint checks
  nvme: factor out device state setup
  nvme: factor out block backend setup
  nvme: add namespace helpers
  nvme: factor out namespace setup
  nvme: factor out pci setup
  nvme: factor out cmb setup
  nvme: factor out pmr setup
  nvme: do cmb/pmr init as part of pci init
  nvme: factor out controller identify setup

 hw/block/nvme.c       | 543 ++++++++++++++++++++++++------------------
 hw/block/nvme.h       |  31 ++-
 hw/block/trace-events | 180 +++++++-------
 include/block/nvme.h  |   8 +
 4 files changed, 429 insertions(+), 333 deletions(-)

-- 
2.26.2


