Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC92C11D24
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB99220675
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB99220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67ep-000521-Vb
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 01:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j67dk-0003Fy-Hz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j67dj-0006CV-GE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52406 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j67dj-00064u-3n
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:51 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 099D253108E2A250BA89;
 Mon, 24 Feb 2020 14:54:46 +0800 (CST)
Received: from huawei.com (10.133.214.142) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 14:54:37 +0800
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH V2 0/8] Optimize VM's downtime while do checkpoint in COLO
Date: Mon, 24 Feb 2020 14:54:06 +0800
Message-ID: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.214.142]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: danielcho@qnap.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series try to  tries to reduce VM's pause time while do checkpoint i=
n COLO state.

Here, we use two methods to reduce the downtime during COLO stage:
The first one is to reduce the time of backup PVM's memory into cache,
Instread of doing this once time backup all PVM's memory when VM is stopp=
ed, we backup
them during the live migration time.

Secondly, we reduced the total number of dirty pages while do checkpoint =
with VM been paused,
instead of sending all dirty pages while VM been pause, it sends part of =
dirty pages
during the gap time of two checkpoints when SVM and PVM are running.

V1 -> V2:
- Fix tested problem found by Daniel Cho
- Fix a degradation after rebase to master (first patch)

Please review, thanks.

Hailiang Zhang (8):
  migration: fix COLO broken caused by a previous commit
  migration/colo: wrap incoming checkpoint process into new helper
  savevm: Don't call colo_init_ram_cache twice
  COLO: Optimize memory back-up process
  ram/colo: only record bitmap of dirty pages in COLO stage
  migration: recognize COLO as part of activating process
  COLO: Migrate dirty pages during the gap of checkpointing
  migration/colo: Only flush ram cache while do checkpoint

 migration/colo.c       | 337 +++++++++++++++++++++++++----------------
 migration/migration.c  |   7 +-
 migration/migration.h  |   1 +
 migration/ram.c        |  78 +++++++---
 migration/ram.h        |   2 +
 migration/trace-events |   1 +
 qapi/migration.json    |   4 +-
 7 files changed, 269 insertions(+), 161 deletions(-)

--
2.21.0



