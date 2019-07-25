Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D8C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096182238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096182238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZNK-0002Lh-Mi
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMD-0006Nr-S1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMC-0008PW-JY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:13 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56902)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMC-0008NY-BL
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:12 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 32C2454006A;
 Thu, 25 Jul 2019 11:44:10 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:44:09 +0300
Message-ID: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH v2 0/8] Some record/replay fixes
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
 - development documentation update
 - some refactoring

v2 changes (suggested by Paolo Bonzini):
 - allow fixed qemu_clock_deadline_ns_all to be used with any timers
 - clean up can_do_io at the start of every TB
 - remove unnecessary gen_io_end calls due to the previous change

---

Pavel Dovgalyuk (7):
      replay: document development rules
      util/qemu-timer: refactor deadline calculation for external timers
      replay: fix replay shutdown
      replay: refine replay-time module
      replay: rename step-related variables and functions
      icount: clean up cpu_can_io at the entry to the block
      icount: remove unnecessary gen_io_end calls

pbonzini@redhat.com (1):
      replay: add missing fix for internal function


 accel/tcg/cpu-exec.c                    |    1 -
 accel/tcg/translator.c                  |    2 +
 cpus.c                                  |   17 ++++++++---
 docs/devel/replay.txt                   |   46 +++++++++++++++++++++++++++++++
 include/exec/gen-icount.h               |   38 +++++++++++++-------------
 include/qemu/timer.h                    |    8 ++++-
 include/sysemu/replay.h                 |    2 +
 qtest.c                                 |    3 +-
 replay/replay-events.c                  |    2 +
 replay/replay-internal.c                |   10 +++----
 replay/replay-internal.h                |   10 +++----
 replay/replay-snapshot.c                |    6 ++--
 replay/replay-time.c                    |   36 +++++++++++-------------
 replay/replay.c                         |   30 ++++++++++----------
 target/alpha/translate.c                |    4 +--
 target/arm/translate-a64.c              |    6 +---
 target/arm/translate.c                  |   10 ++-----
 target/cris/translate.c                 |    4 +--
 target/hppa/translate.c                 |    2 +
 target/i386/translate.c                 |   18 +++++-------
 target/lm32/translate.c                 |   12 ++------
 target/microblaze/translate.c           |    4 +--
 target/mips/translate.c                 |   16 +++--------
 target/nios2/translate.c                |    4 +--
 target/ppc/translate.c                  |   18 +++---------
 target/ppc/translate_init.inc.c         |    4 +--
 target/riscv/insn_trans/trans_rvi.inc.c |    2 +
 target/sparc/translate.c                |   32 +++++++++++-----------
 target/unicore32/translate.c            |    2 +
 target/xtensa/translate.c               |   20 +++----------
 tests/ptimer-test-stubs.c               |    4 +--
 tests/ptimer-test.c                     |    6 +++-
 util/qemu-timer.c                       |   30 ++++++++++++++++++--
 33 files changed, 225 insertions(+), 184 deletions(-)
 create mode 100644 docs/devel/replay.txt

-- 
Pavel Dovgalyuk

