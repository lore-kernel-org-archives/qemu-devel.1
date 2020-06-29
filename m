Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF46223341
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF46223341
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqDB-0001XB-Uh
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jpqCQ-0000Hh-Bg
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:35:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jpqCO-00082f-9M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:35:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A8E9FAD8D;
 Mon, 29 Jun 2020 09:35:33 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/3] QEMU cpus.c refactoring part1
Date: Mon, 29 Jun 2020 11:35:01 +0200
Message-Id: <20200629093504.3228-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 22:46:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Claudio Fontana <cfontana@suse.de>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Motivation and higher level steps:

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html

Previous series: [RFC RESEND v7 0/4] QEMU cpus.c refactoring

This series is already reviewed, and is a split of the first three patches
from the previous series (RFC). The forth and last of the previous series
will then be posted separately.

PREVIOUS DISCUSSIONS:

* should we reorder patches or moves inside patches to avoid code going
  from cpus.c to softmmu/cpus.c and then again to softmmu/somethingelse.c ?
  (Philippe)

* some questions about headers in include/softmmu (Philippe)


[SPLIT into TWO series, changed from RFC to PATCH]
----

v6 -> v7:

* rebased changes on top of Pavel Dovgalyuk changes to dma-helpers.c
  "icount: make dma reads deterministic"

----

v5 -> v6:

* rebased changes on top of Emilio G. Cota changes to cpus.c
  "cpu: convert queued work to a QSIMPLEQ"

* keep a pointer in cpus.c instead of a copy of CpusAccel
  (Alex)

----


v4 -> v5: rebase on latest master

* rebased changes on top of roman series to remove one of the extra states for hvf.
  (Is the result now functional for HVF?)

* rebased changes on top of icount changes and fixes to icount_configure and
  the new shift vmstate. (Markus)

v3 -> v4:

* overall: added copyright headers to all files that were missing them
  (used copyright and license of the module the stuff was extracted from).
  For the new interface files, added SUSE LLC.

* 1/4 (move softmmu only files from root):

  MAINTAINERS: moved softmmu/cpus.c to its final location (from patch 2)

* 2/4 (cpu-throttle):

  MAINTAINERS (to patch 1),
  copyright Fabrice Bellard and license from cpus.c

* 3/4 (cpu-timers, icount):

  - MAINTAINERS: add cpu-timers.c and icount.c to Paolo

  - break very long lines (patchew)

  - add copyright SUSE LLC, GPLv2 to cpu-timers.h

  - add copyright Fabrice Bellard and license from cpus.c to timers-state.h
    as it is lifted from cpus.c

  - vl.c: in configure_accelerators bail out if icount_enabled()
    and !tcg_enabled() as qtest does not enable icount anymore.

* 4/4 (accel stuff to accel):

  - add copyright SUSE LLC to files that mostly only consist of the
    new interface. Add whatever copyright was in the accelerator code
    if instead they mostly consist of accelerator code.

  - change a comment to mention the result of the AccelClass experiment

  - moved qtest accelerator into accel/qtest/ , make it like the others.

  - rename xxx-cpus-interface to xxx-cpus (remove "interface" from names)

  - rename accel_int to cpus_accel

  - rename CpusAccel functions from cpu_synchronize_* to synchronize_*


--------

v2 -> v3:

* turned into a 4 patch series, adding a first patch moving
  softmmu code currently in top_srcdir to softmmu/

* cpu-throttle: moved to softmmu/

* cpu-timers, icount:

  - moved to softmmu/

  - fixed assumption of qtest_enabled() => icount_enabled()
  causing the failure of check-qtest-arm goal, in test-arm-mptimer.c

  Fix is in hw/core/ptimer.c,

  where the artificial timeout rate limit should not be applied
  under qtest_enabled(), in a similar way to how it is not applied
  for icount_enabled().

* CpuAccelInterface: no change.


--------


v1 -> v2:

* 1/3 (cpu-throttle): provide a description in the commit message

* 2/3 (cpu-timers, icount): in this v2 separate icount from cpu-timers,
  as icount is actually TCG-specific. Only build it under CONFIG_TCG.

  To do this, qtest had to be detached from icount. To this end, a
  trivial global counter for qtest has been introduced.

* 3/3 (CpuAccelInterface): provided a description.

This is point 8) in that plan. The idea is to extract the unrelated parts
in cpus, and register interfaces from each single accelerator to the main
cpus module (cpus.c).

While doing this RFC, I noticed some assumptions about Windows being
either TCG or HAX (not considering WHPX) that might need to be revisited.
I added a comment there.

The thing builds successfully based on Linux cross-compilations for
windows/hax, windows/whpx, and I got a good build on Darwin/hvf.

Tests run successully for tcg and kvm configurations, but did not test on
windows or darwin.

Welcome your feedback and help on this,

Claudio

Claudio Fontana (3):
  softmmu: move softmmu only files from root
  cpu-throttle: new module, extracted from cpus.c
  cpu-timers, icount: new modules

 MAINTAINERS                                  |  15 +-
 Makefile.target                              |   7 +-
 accel/qtest.c                                |   6 +-
 accel/tcg/cpu-exec.c                         |  43 +-
 accel/tcg/tcg-all.c                          |   7 +-
 accel/tcg/translate-all.c                    |   3 +-
 dma-helpers.c                                |   4 +-
 docs/replay.txt                              |   6 +-
 exec.c                                       |   4 -
 hw/core/ptimer.c                             |   8 +-
 hw/i386/x86.c                                |   1 +
 include/exec/cpu-all.h                       |   4 +
 include/exec/exec-all.h                      |   4 +-
 include/hw/core/cpu.h                        |  37 --
 include/qemu/main-loop.h                     |   5 +
 include/qemu/timer.h                         |  22 +-
 include/sysemu/cpu-throttle.h                |  68 +++
 include/sysemu/cpu-timers.h                  |  81 +++
 include/sysemu/cpus.h                        |  12 +-
 include/sysemu/qtest.h                       |   2 +
 include/sysemu/replay.h                      |   4 +-
 migration/migration.c                        |   1 +
 migration/ram.c                              |   1 +
 replay/replay.c                              |   6 +-
 softmmu/Makefile.objs                        |  13 +
 arch_init.c => softmmu/arch_init.c           |   0
 balloon.c => softmmu/balloon.c               |   0
 softmmu/cpu-throttle.c                       | 122 ++++
 softmmu/cpu-timers.c                         | 284 +++++++++
 cpus.c => softmmu/cpus.c                     | 839 +--------------------------
 softmmu/icount.c                             | 499 ++++++++++++++++
 ioport.c => softmmu/ioport.c                 |   0
 memory.c => softmmu/memory.c                 |   0
 memory_mapping.c => softmmu/memory_mapping.c |   0
 qtest.c => softmmu/qtest.c                   |  34 +-
 softmmu/timers-state.h                       |  69 +++
 softmmu/vl.c                                 |   8 +-
 stubs/Makefile.objs                          |   3 +-
 stubs/clock-warp.c                           |   4 +-
 stubs/cpu-get-clock.c                        |   3 +-
 stubs/cpu-get-icount.c                       |  21 -
 stubs/icount.c                               |  22 +
 stubs/qemu-timer-notify-cb.c                 |   8 +
 stubs/qtest.c                                |   5 +
 target/alpha/translate.c                     |   3 +-
 target/arm/helper.c                          |   7 +-
 target/riscv/csr.c                           |   8 +-
 tests/ptimer-test-stubs.c                    |   7 +-
 tests/test-timed-average.c                   |   2 +-
 util/main-loop.c                             |   4 +-
 util/qemu-timer.c                            |  12 +-
 51 files changed, 1343 insertions(+), 985 deletions(-)
 create mode 100644 include/sysemu/cpu-throttle.h
 create mode 100644 include/sysemu/cpu-timers.h
 rename arch_init.c => softmmu/arch_init.c (100%)
 rename balloon.c => softmmu/balloon.c (100%)
 create mode 100644 softmmu/cpu-throttle.c
 create mode 100644 softmmu/cpu-timers.c
 rename cpus.c => softmmu/cpus.c (59%)
 create mode 100644 softmmu/icount.c
 rename ioport.c => softmmu/ioport.c (100%)
 rename memory.c => softmmu/memory.c (100%)
 rename memory_mapping.c => softmmu/memory_mapping.c (100%)
 rename qtest.c => softmmu/qtest.c (95%)
 create mode 100644 softmmu/timers-state.h
 delete mode 100644 stubs/cpu-get-icount.c
 create mode 100644 stubs/icount.c
 create mode 100644 stubs/qemu-timer-notify-cb.c

-- 
2.16.4

