Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88723C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5750B214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5750B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACAM-0005j0-Nz
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAC7B-0003s4-5F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAC7A-0001Ne-0N
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:57:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42136)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAC79-0001N3-Ot
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:57:47 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id D5F475400BA;
 Tue, 17 Sep 2019 14:57:45 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 14:57:45 +0300
Message-ID: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The set of patches include the block-related updates
of the record/replay icount feature:
 - application of 'snapshot' option on the file layer instead of
   the top one: command line and documentation fix
 - implementation of bdrv_snapshot_goto for blkreplay driver
 - start/stop fix in replay mode with attached block devices
 - record/replay of bh oneshot events, used in the block layer

---

Pavel Dovgaluk (6):
      block: implement bdrv_snapshot_goto for blkreplay
      replay: disable default snapshot for record/replay
      replay: update docs for record/replay with block devices
      replay: don't drain/flush bdrv queue while RR is working
      replay: finish record/replay before closing the disks
      replay: add BH oneshot event for block layer


 block/blkreplay.c        |    8 ++++++++
 block/block-backend.c    |    9 ++++++---
 block/io.c               |   32 ++++++++++++++++++++++++++++++--
 block/iscsi.c            |    5 +++--
 block/nfs.c              |    6 ++++--
 block/null.c             |    4 +++-
 block/nvme.c             |    6 ++++--
 block/rbd.c              |    5 +++--
 block/vxhs.c             |    5 +++--
 cpus.c                   |    2 --
 docs/replay.txt          |   12 +++++++++---
 include/sysemu/replay.h  |    4 ++++
 replay/replay-events.c   |   16 ++++++++++++++++
 replay/replay-internal.h |    1 +
 replay/replay.c          |    2 ++
 stubs/Makefile.objs      |    1 +
 stubs/replay-user.c      |    9 +++++++++
 vl.c                     |   11 +++++++++--
 18 files changed, 115 insertions(+), 23 deletions(-)
 create mode 100644 stubs/replay-user.c

-- 
Pavel Dovgalyuk

