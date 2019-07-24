Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92720C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68735227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68735227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCrp-0001Gz-Ox
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCrg-0000sd-De
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCrf-0001NY-C1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:43:12 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58746)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCrf-0001Ml-41
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:43:11 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 4173654006A;
 Wed, 24 Jul 2019 11:43:09 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 11:43:08 +0300
Message-ID: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.2 00/14] Some record/replay fixes
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

The set of patches include the latest fixes for record/replay icount function:
 - fix for icount for the case when translation blocks are chained
 - block operation fixes for rr mode
 - development documentation update
 - some refactoring

These patches make record/replay functional on the latest 4.2 QEMU core.

---

Pavel Dovgalyuk (13):
      block: implement bdrv_snapshot_goto for blkreplay
      replay: disable default snapshot for record/replay
      replay: update docs for record/replay with block devices
      replay: don't drain/flush bdrv queue while RR is working
      replay: finish record/replay before closing the disks
      replay: provide an accessor for rr filename
      replay: add BH oneshot event for block layer
      replay: document development rules
      util/qemu-timer: refactor deadline calculation for external timers
      replay: fix replay shutdown
      replay: refine replay-time module
      replay: rename step-related variables and functions
      icount: clean up cpu_can_io before jumping to the next block

pbonzini@redhat.com (1):
      replay: add missing fix for internal function


 accel/tcg/tcg-runtime.c   |    2 ++
 block/blkreplay.c         |    8 ++++++++
 block/block-backend.c     |    8 +++++---
 block/io.c                |   32 +++++++++++++++++++++++++++++--
 block/iscsi.c             |    5 +++--
 block/nfs.c               |    5 +++--
 block/null.c              |    4 +++-
 block/nvme.c              |    6 ++++--
 block/rbd.c               |    5 +++--
 block/vxhs.c              |    5 +++--
 cpus.c                    |   11 ++++-------
 docs/devel/replay.txt     |   46 +++++++++++++++++++++++++++++++++++++++++++++
 docs/replay.txt           |   12 +++++++++---
 include/qemu/timer.h      |    7 +++----
 include/sysemu/replay.h   |    7 ++++++-
 qtest.c                   |    2 +-
 replay/replay-events.c    |   18 +++++++++++++++++-
 replay/replay-internal.c  |   10 +++++-----
 replay/replay-internal.h  |   11 ++++++-----
 replay/replay-snapshot.c  |    6 +++---
 replay/replay-time.c      |   36 ++++++++++++++++-------------------
 replay/replay.c           |   39 +++++++++++++++++++++++---------------
 stubs/Makefile.objs       |    1 +
 stubs/replay-user.c       |    9 +++++++++
 tests/ptimer-test-stubs.c |    4 ++--
 tests/ptimer-test.c       |    4 ++--
 util/qemu-timer.c         |   41 ++++++++++++++++++++++++++++++++--------
 vl.c                      |   11 +++++++++--
 28 files changed, 259 insertions(+), 96 deletions(-)
 create mode 100644 docs/devel/replay.txt
 create mode 100644 stubs/replay-user.c

-- 
Pavel Dovgalyuk

