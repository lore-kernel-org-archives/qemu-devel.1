Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC089C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643FD20872
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643FD20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqIb-00035y-Ky
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:32:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4Y-0008V1-R3
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4U-00005G-LI
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGq4R-0008Oj-Gn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4840E309E9A7
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:18:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC14A60C67;
	Wed, 17 Apr 2019 19:18:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6D9B91138648; Wed, 17 Apr 2019 21:18:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:17:48 +0200
Message-Id: <20190417191805.28198-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 17 Apr 2019 19:18:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/17] Clean up and simplify around
 fprintf_function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417191748.2JwA9NttqiWdNoDD4T35mju1bqEAbn5KcAdlyj35-dY@z>

We pass around fprintf_function callbacks together a FILE * argument.
Three cases:

* We pass fprintf() and stdout, stderr or qemu_log_file.  Okay.

* We pass monitor_fprintf() together with the current monitor cast to
  FILE *.  The type-punning is ugly.

* We pass monitor_printf() cast to fprintf_function together with the
  current monitor cast to FILE *.  Even uglier.

All but two instances can be replaced by using qemu_printf() directly
instead of printing through a callback.

One more can be replace by using new qemu_fprintf() directly.

The last one can use qemu_fprintf() to at least avoid the
type-punning.

Based-on: <20190417190641.26814-1-armbru@redhat.com>

v2:
* PATCH 08: Commit message pasto [Dave]
* PATCH 09: Commit message typo [Dave]
* PATCH 14: Drop spurious change to x86_cpu_dump_local_apic_state()
  [Dave]

Markus Armbruster (17):
  include: Include fprintf-fn.h only where needed
  trace: Simplify how st_print_trace_file_status() prints
  tcg: Simplify how dump_opcount_info() prints
  tcg: Simplify how dump_exec_info() prints
  tcg: Simplify how dump_drift_info() prints
  qsp: Simplify how qsp_report() prints
  block/qapi: Clean up how we print to monitor or stdout
  memory: Clean up how mtree_info() prints
  target: Simplify how the TARGET_cpu_list() print
  target: Clean up how the dump_mmu() print
  target/i386: Simplify how x86_cpu_dump_local_apic_state() prints
  qom/cpu: Simplify how CPUClass::dump_statistics() prints
  qemu-print: New qemu_fprintf(), qemu_vfprintf()
  qom/cpu: Simplify how CPUClass:cpu_dump_state() prints
  monitor: Clean up how monitor_disas() funnels output to monitor
  disas: Rename include/disas/bfd.h back to include/disas/dis-asm.h
  include: Move fprintf_function to disas/

 accel/kvm/kvm-all.c                |   4 +-
 accel/tcg/translate-all.c          |  49 ++--
 block/qapi.c                       | 120 +++++-----
 bsd-user/main.c                    |   4 +-
 cpus.c                             |  21 +-
 disas.c                            |   5 +-
 disas/alpha.c                      |   2 +-
 disas/arm-a64.cc                   |   2 +-
 disas/arm.c                        |   2 +-
 disas/cris.c                       |   2 +-
 disas/hppa.c                       |   2 +-
 disas/i386.c                       |   2 +-
 disas/lm32.c                       |   2 +-
 disas/m68k.c                       |   2 +-
 disas/microblaze.c                 |   2 +-
 disas/mips.c                       |   2 +-
 disas/moxie.c                      |   2 +-
 disas/nanomips.cpp                 |   2 +-
 disas/nios2.c                      |   2 +-
 disas/ppc.c                        |   2 +-
 disas/riscv.c                      |   2 +-
 disas/s390.c                       |   2 +-
 disas/sh4.c                        |   2 +-
 disas/sparc.c                      |   2 +-
 disas/tci.c                        |   2 +-
 disas/xtensa.c                     |   2 +-
 exec.c                             |  42 ++--
 hmp.c                              |  12 +-
 include/block/qapi.h               |   9 +-
 include/disas/{bfd.h => dis-asm.h} |   5 +-
 include/exec/cpu-all.h             |   4 +-
 include/exec/cpu-common.h          |  13 --
 include/exec/log.h                 |   2 +-
 include/exec/memory-internal.h     |   3 +-
 include/exec/memory.h              |   3 +-
 include/monitor/monitor.h          |   1 -
 include/qemu-common.h              |   2 -
 include/qemu/cutils.h              |   2 -
 include/qemu/fprintf-fn.h          |  14 --
 include/qemu/qemu-print.h          |   4 +
 include/qemu/qsp.h                 |   6 +-
 include/qom/cpu.h                  |  24 +-
 include/sysemu/cpus.h              |   4 +-
 linux-user/alpha/cpu_loop.c        |   2 +-
 linux-user/cpu_loop-common.h       |   2 +-
 linux-user/cris/cpu_loop.c         |   2 +-
 linux-user/main.c                  |   2 +-
 linux-user/microblaze/cpu_loop.c   |   4 +-
 linux-user/s390x/cpu_loop.c        |   4 +-
 linux-user/sh4/cpu_loop.c          |   2 +-
 linux-user/sparc/cpu_loop.c        |   2 +-
 memory.c                           | 156 ++++++-------
 monitor.c                          |  30 +--
 qemu-img.c                         |   6 +-
 qemu-io-cmds.c                     |   2 +-
 qom/cpu.c                          |  11 +-
 target/alpha/cpu.c                 |  15 +-
 target/alpha/cpu.h                 |   5 +-
 target/alpha/helper.c              |  24 +-
 target/arm/arm-semi.c              |   2 +-
 target/arm/cpu.c                   |   1 -
 target/arm/cpu.h                   |   5 +-
 target/arm/helper.c                |  15 +-
 target/arm/translate-a64.c         |  82 +++----
 target/arm/translate.c             |  58 ++---
 target/arm/translate.h             |   7 +-
 target/cris/cpu.c                  |  14 +-
 target/cris/cpu.h                  |   5 +-
 target/cris/helper.c               |   2 +-
 target/cris/translate.c            |  36 +--
 target/hppa/cpu.c                  |  14 +-
 target/hppa/cpu.h                  |   4 +-
 target/hppa/helper.c               |  24 +-
 target/i386/cpu.c                  |  29 +--
 target/i386/cpu.h                  |   8 +-
 target/i386/hax-all.c              |   4 +-
 target/i386/helper.c               | 356 ++++++++++++++---------------
 target/i386/monitor.c              |   3 +-
 target/lm32/cpu.c                  |  14 +-
 target/lm32/cpu.h                  |   5 +-
 target/lm32/translate.c            |  36 +--
 target/m68k/cpu.h                  |   8 +-
 target/m68k/helper.c               | 129 +++++------
 target/m68k/monitor.c              |   2 +-
 target/m68k/translate.c            |  86 +++----
 target/microblaze/cpu.h            |   3 +-
 target/microblaze/helper.c         |   2 +-
 target/microblaze/translate.c      |  39 ++--
 target/mips/cpu.h                  |   2 +-
 target/mips/internal.h             |   3 +-
 target/mips/translate.c            |  77 ++++---
 target/mips/translate_init.inc.c   |   5 +-
 target/moxie/cpu.h                 |   3 +-
 target/moxie/helper.c              |   2 +-
 target/moxie/translate.c           |  22 +-
 target/nios2/cpu.h                 |   5 +-
 target/nios2/helper.c              |   2 +-
 target/nios2/mmu.c                 |   7 +-
 target/nios2/monitor.c             |   2 +-
 target/nios2/translate.c           |  24 +-
 target/openrisc/cpu.c              |  15 +-
 target/openrisc/cpu.h              |   5 +-
 target/openrisc/disas.c            |   2 +-
 target/openrisc/translate.c        |  11 +-
 target/ppc/cpu.h                   |  10 +-
 target/ppc/mmu-hash64.c            |   7 +-
 target/ppc/mmu-hash64.h            |   2 +-
 target/ppc/mmu_helper.c            |  70 +++---
 target/ppc/monitor.c               |   2 +-
 target/ppc/translate.c             | 170 +++++++-------
 target/ppc/translate_init.inc.c    |  28 +--
 target/riscv/cpu.c                 |  54 ++---
 target/riscv/cpu.h                 |   2 +-
 target/s390x/cpu.h                 |   2 +-
 target/s390x/cpu_models.c          |  21 +-
 target/s390x/helper.c              |  42 ++--
 target/s390x/internal.h            |   3 +-
 target/sh4/cpu.c                   |  17 +-
 target/sh4/cpu.h                   |   5 +-
 target/sh4/translate.c             |  27 +--
 target/sparc/cpu.c                 | 133 ++++++-----
 target/sparc/cpu.h                 |   7 +-
 target/sparc/ldst_helper.c         |  18 +-
 target/sparc/mmu_helper.c          |  97 ++++----
 target/sparc/monitor.c             |   2 +-
 target/tilegx/cpu.c                |  14 +-
 target/tricore/cpu.h               |   5 +-
 target/tricore/helper.c            |  15 +-
 target/tricore/translate.c         |  26 +--
 target/unicore32/cpu.h             |   3 +-
 target/unicore32/translate.c       |  39 ++--
 target/xtensa/cpu.h                |   7 +-
 target/xtensa/helper.c             |   7 +-
 target/xtensa/mmu_helper.c         |  24 +-
 target/xtensa/monitor.c            |   2 +-
 target/xtensa/translate.c          |  40 ++--
 tcg/tcg.c                          |  50 ++--
 tcg/tcg.h                          |   4 +-
 trace/simple.c                     |   7 +-
 trace/simple.h                     |   2 +-
 util/qemu-print.c                  |  27 +++
 util/qsp.c                         |  21 +-
 vl.c                               |   2 +-
 143 files changed, 1353 insertions(+), 1503 deletions(-)
 rename include/disas/{bfd.h => dis-asm.h} (99%)
 delete mode 100644 include/qemu/fprintf-fn.h

-- 
2.17.2


