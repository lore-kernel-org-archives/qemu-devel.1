Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F350820888
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F350820888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEWv-0004bE-Vj
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdEV7-0002v0-0n
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdEV5-000438-OO
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:54:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B2786AC85;
 Mon, 25 May 2020 14:54:46 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v3 0/4] QEMU cpus.c refactoring
Date: Mon, 25 May 2020 16:54:36 +0200
Message-Id: <20200525145440.29728-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Motivation and higher level steps:

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html

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

*** BLURB HERE ***

Claudio Fontana (4):
  softmmu: move softmmu only files from root
  cpu-throttle: new module, extracted from cpus.c
  cpu-timers, icount: new modules
  cpus: extract out accel-specific code to each accel

 MAINTAINERS                                  |   14 +-
 Makefile.target                              |    7 +-
 accel/kvm/Makefile.objs                      |    2 +
 accel/kvm/kvm-all.c                          |   15 +-
 accel/kvm/kvm-cpus-interface.c               |   94 ++
 accel/kvm/kvm-cpus-interface.h               |    8 +
 accel/qtest.c                                |   88 +-
 accel/stubs/kvm-stub.c                       |    3 +-
 accel/tcg/Makefile.objs                      |    1 +
 accel/tcg/cpu-exec.c                         |   43 +-
 accel/tcg/tcg-all.c                          |   19 +-
 accel/tcg/tcg-cpus-interface.c               |  523 ++++++
 accel/tcg/tcg-cpus-interface.h               |    8 +
 accel/tcg/translate-all.c                    |    3 +-
 cpus.c                                       | 2290 --------------------------
 docs/replay.txt                              |    6 +-
 exec.c                                       |    4 -
 hw/core/cpu.c                                |    1 +
 hw/core/ptimer.c                             |    6 +-
 hw/i386/x86.c                                |    1 +
 include/exec/cpu-all.h                       |    4 +
 include/exec/exec-all.h                      |    4 +-
 include/hw/core/cpu.h                        |   37 -
 include/qemu/main-loop.h                     |    5 +
 include/qemu/timer.h                         |   22 +-
 include/sysemu/cpu-throttle.h                |   50 +
 include/sysemu/cpu-timers.h                  |   72 +
 include/sysemu/cpus.h                        |   44 +-
 include/sysemu/hvf.h                         |    1 -
 include/sysemu/hw_accel.h                    |   57 +-
 include/sysemu/kvm.h                         |    2 +-
 include/sysemu/qtest.h                       |    2 +
 include/sysemu/replay.h                      |    4 +-
 migration/migration.c                        |    1 +
 migration/ram.c                              |    1 +
 replay/replay.c                              |    6 +-
 softmmu/Makefile.objs                        |   13 +
 arch_init.c => softmmu/arch_init.c           |    0
 balloon.c => softmmu/balloon.c               |    0
 softmmu/cpu-throttle.c                       |  122 ++
 softmmu/cpu-timers.c                         |  267 +++
 softmmu/cpus.c                               |  741 +++++++++
 softmmu/icount.c                             |  496 ++++++
 ioport.c => softmmu/ioport.c                 |    0
 memory.c => softmmu/memory.c                 |    0
 memory_mapping.c => softmmu/memory_mapping.c |    0
 qtest.c => softmmu/qtest.c                   |   34 +-
 softmmu/timers-state.h                       |   45 +
 softmmu/vl.c                                 |    8 +-
 stubs/Makefile.objs                          |    4 +-
 stubs/clock-warp.c                           |    4 +-
 stubs/cpu-get-clock.c                        |    3 +-
 stubs/cpu-get-icount.c                       |   21 -
 stubs/cpu-synchronize-state.c                |   15 +
 stubs/icount.c                               |   22 +
 stubs/qemu-timer-notify-cb.c                 |    8 +
 stubs/qtest.c                                |    5 +
 target/alpha/translate.c                     |    3 +-
 target/arm/helper.c                          |    7 +-
 target/i386/Makefile.objs                    |    7 +-
 target/i386/hax-all.c                        |    6 +-
 target/i386/hax-cpus-interface.c             |   85 +
 target/i386/hax-cpus-interface.h             |    8 +
 target/i386/hax-i386.h                       |    2 +
 target/i386/hax-posix.c                      |   12 +
 target/i386/hax-windows.c                    |   20 +
 target/i386/hvf/Makefile.objs                |    2 +-
 target/i386/hvf/hvf-cpus-interface.c         |   92 ++
 target/i386/hvf/hvf-cpus-interface.h         |    8 +
 target/i386/hvf/hvf.c                        |    5 +-
 target/i386/whpx-all.c                       |    3 +
 target/i386/whpx-cpus-interface.c            |   96 ++
 target/i386/whpx-cpus-interface.h            |    8 +
 target/riscv/csr.c                           |    8 +-
 tests/ptimer-test-stubs.c                    |    7 +-
 tests/test-timed-average.c                   |    2 +-
 util/main-loop.c                             |    4 +-
 util/qemu-timer.c                            |   12 +-
 78 files changed, 3136 insertions(+), 2517 deletions(-)
 create mode 100644 accel/kvm/kvm-cpus-interface.c
 create mode 100644 accel/kvm/kvm-cpus-interface.h
 create mode 100644 accel/tcg/tcg-cpus-interface.c
 create mode 100644 accel/tcg/tcg-cpus-interface.h
 delete mode 100644 cpus.c
 create mode 100644 include/sysemu/cpu-throttle.h
 create mode 100644 include/sysemu/cpu-timers.h
 rename arch_init.c => softmmu/arch_init.c (100%)
 rename balloon.c => softmmu/balloon.c (100%)
 create mode 100644 softmmu/cpu-throttle.c
 create mode 100644 softmmu/cpu-timers.c
 create mode 100644 softmmu/cpus.c
 create mode 100644 softmmu/icount.c
 rename ioport.c => softmmu/ioport.c (100%)
 rename memory.c => softmmu/memory.c (100%)
 rename memory_mapping.c => softmmu/memory_mapping.c (100%)
 rename qtest.c => softmmu/qtest.c (95%)
 create mode 100644 softmmu/timers-state.h
 delete mode 100644 stubs/cpu-get-icount.c
 create mode 100644 stubs/cpu-synchronize-state.c
 create mode 100644 stubs/icount.c
 create mode 100644 stubs/qemu-timer-notify-cb.c
 create mode 100644 target/i386/hax-cpus-interface.c
 create mode 100644 target/i386/hax-cpus-interface.h
 create mode 100644 target/i386/hvf/hvf-cpus-interface.c
 create mode 100644 target/i386/hvf/hvf-cpus-interface.h
 create mode 100644 target/i386/whpx-cpus-interface.c
 create mode 100644 target/i386/whpx-cpus-interface.h

-- 
2.16.4


