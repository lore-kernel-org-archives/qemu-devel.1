Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6510BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1922087C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1922087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNxB-0002gu-76
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kDNvv-00011X-ML
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:15:55 -0400
Received: from mail.ispras.ru ([83.149.199.84]:38484)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kDNvt-0002tZ-27
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:15:55 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 8CC7740A2055;
 Wed,  2 Sep 2020 08:15:47 +0000 (UTC)
Subject: [PATCH v3 00/15] Reverse debugging
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Wed, 02 Sep 2020 11:15:47 +0300
Message-ID: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 04:15:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GDB remote protocol supports reverse debugging of the targets.
It includes 'reverse step' and 'reverse continue' operations.
The first one finds the previous step of the execution,
and the second one is intended to stop at the last breakpoint that
would happen when the program is executed normally.

Reverse debugging is possible in the replay mode, when at least
one snapshot was created at the record or replay phase.
QEMU can use these snapshots for travelling back in time with GDB.

Running the execution in replay mode allows using GDB reverse debugging
commands:
 - reverse-stepi (or rsi): Steps one instruction to the past.
   QEMU loads on of the prior snapshots and proceeds to the desired
   instruction forward. When that step is reaches, execution stops.
 - reverse-continue (or rc): Runs execution "backwards".
   QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
   and replaying the execution. Then QEMU loads snapshots again and
   replays to the latest breakpoint. When there are no breakpoints in
   the examined section of the execution, QEMU finds one more snapshot
   and tries again. After the first snapshot is processed, execution
   stops at this snapshot.

The set of patches include the following modifications:
 - gdbstub update for reverse debugging support
 - functions that automatically perform reverse step and reverse
   continue operations
 - hmp/qmp commands for manipulating the replay process
 - improvement of the snapshotting for saving the execution step
   in the snapshot parameters
 - avocado-based acceptance tests for reverse debugging

The patches are available in the repository:
https://github.com/ispras/qemu/tree/rr-200901

v3 changes:
 - rebased to support the new build system
 - bumped avocado framework version for using fixed remote gdb client
v2 changes:
 - rebased to the latest upstream version
 - fixed replaying of the POLL interrupts after the latest debug changes

---

Pavel Dovgaluk (14):
      replay: provide an accessor for rr filename
      qcow2: introduce icount field for snapshots
      migration: introduce icount field for snapshots
      iotests: update snapshot test for new output format
      qapi: introduce replay.json for record/replay-related stuff
      replay: introduce info hmp/qmp command
      replay: introduce breakpoint at the specified step
      replay: implement replay-seek command
      replay: flush rr queue before loading the vmstate
      gdbstub: add reverse step support in replay mode
      gdbstub: add reverse continue support in replay mode
      replay: describe reverse debugging in docs/replay.txt
      tests: bump avocado version
      tests/acceptance: add reverse debugging test

Pavel Dovgalyuk (1):
      replay: don't record interrupt poll


 MAINTAINERS                           |    2 
 accel/tcg/cpu-exec.c                  |   11 +
 accel/tcg/translator.c                |    1 
 block/qapi.c                          |   18 +-
 block/qcow2-snapshot.c                |    9 +
 block/qcow2.h                         |    3 
 blockdev.c                            |   10 +
 docs/interop/qcow2.txt                |    5 +
 docs/replay.txt                       |   33 +++
 exec.c                                |    8 +
 gdbstub.c                             |   63 ++++++
 hmp-commands-info.hx                  |   11 +
 hmp-commands.hx                       |   50 +++++
 include/block/snapshot.h              |    1 
 include/monitor/hmp.h                 |    4 
 include/sysemu/replay.h               |   24 ++
 migration/savevm.c                    |   17 +-
 qapi/block-core.json                  |   11 +
 qapi/meson.build                      |    1 
 qapi/misc.json                        |   18 --
 qapi/qapi-schema.json                 |    1 
 qapi/replay.json                      |  121 ++++++++++++
 replay/meson.build                    |    1 
 replay/replay-debugging.c             |  325 +++++++++++++++++++++++++++++++++
 replay/replay-events.c                |    4 
 replay/replay-internal.h              |    6 -
 replay/replay.c                       |   22 ++
 softmmu/cpus.c                        |   19 ++
 stubs/replay.c                        |   15 ++
 tests/Makefile.include                |    2 
 tests/acceptance/reverse_debugging.py |  203 +++++++++++++++++++++
 tests/qemu-iotests/267.out            |   48 ++---
 tests/requirements.txt                |    2 
 33 files changed, 1003 insertions(+), 66 deletions(-)
 create mode 100644 qapi/replay.json
 create mode 100644 replay/replay-debugging.c
 create mode 100644 tests/acceptance/reverse_debugging.py

--
Pavel Dovgalyuk

