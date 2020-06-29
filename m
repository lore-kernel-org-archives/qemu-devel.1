Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929CC23750
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929CC23750
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqVt-0000SN-SN
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jpqUn-0007fO-Sg
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jpqUl-0003CZ-Dn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C9B6BAC9F;
 Mon, 29 Jun 2020 09:54:33 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC 0/1] QEMU cpus.c refactoring part2
Date: Mon, 29 Jun 2020 11:54:30 +0200
Message-Id: <20200629095431.4251-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 22:46:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

This is based on and requires "QEMU cpus.c refactoring part1":

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09401.html

OPEN ITEMS:

* needs review
* requires HVF patches before this can be committed (Roman).
* investigate splitting into multiple patches

----

* Rebased on commit 255ae6e2158c743717bed76c9a2365ee4bcd326e,
"replay: notify the main loop when there are no instructions"

[SPLIT into part1 and part2]

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

Claudio Fontana (1):
  cpus: extract out accel-specific code to each accel

 MAINTAINERS                   |   1 +
 accel/Makefile.objs           |   2 +-
 accel/kvm/Makefile.objs       |   2 +
 accel/kvm/kvm-all.c           |  15 +-
 accel/kvm/kvm-cpus.c          |  94 +++++
 accel/kvm/kvm-cpus.h          |  17 +
 accel/qtest/Makefile.objs     |   2 +
 accel/qtest/qtest-cpus.c      | 105 +++++
 accel/qtest/qtest-cpus.h      |  17 +
 accel/{ => qtest}/qtest.c     |   7 +
 accel/stubs/kvm-stub.c        |   3 +-
 accel/tcg/Makefile.objs       |   1 +
 accel/tcg/tcg-all.c           |  12 +-
 accel/tcg/tcg-cpus.c          | 532 +++++++++++++++++++++++++
 accel/tcg/tcg-cpus.h          |  17 +
 hw/core/cpu.c                 |   1 +
 include/sysemu/cpus.h         |  33 ++
 include/sysemu/hw_accel.h     |  57 +--
 include/sysemu/kvm.h          |   2 +-
 softmmu/cpus.c                | 908 +++---------------------------------------
 stubs/Makefile.objs           |   1 +
 stubs/cpu-synchronize-state.c |  15 +
 target/i386/Makefile.objs     |   7 +-
 target/i386/hax-all.c         |   6 +-
 target/i386/hax-cpus.c        |  85 ++++
 target/i386/hax-cpus.h        |  17 +
 target/i386/hax-i386.h        |   2 +
 target/i386/hax-posix.c       |  12 +
 target/i386/hax-windows.c     |  20 +
 target/i386/hvf/Makefile.objs |   2 +-
 target/i386/hvf/hvf-cpus.c    | 141 +++++++
 target/i386/hvf/hvf-cpus.h    |  17 +
 target/i386/hvf/hvf.c         |   3 +
 target/i386/whpx-all.c        |   3 +
 target/i386/whpx-cpus.c       |  96 +++++
 target/i386/whpx-cpus.h       |  17 +
 36 files changed, 1357 insertions(+), 915 deletions(-)
 create mode 100644 accel/kvm/kvm-cpus.c
 create mode 100644 accel/kvm/kvm-cpus.h
 create mode 100644 accel/qtest/Makefile.objs
 create mode 100644 accel/qtest/qtest-cpus.c
 create mode 100644 accel/qtest/qtest-cpus.h
 rename accel/{ => qtest}/qtest.c (86%)
 create mode 100644 accel/tcg/tcg-cpus.c
 create mode 100644 accel/tcg/tcg-cpus.h
 create mode 100644 stubs/cpu-synchronize-state.c
 create mode 100644 target/i386/hax-cpus.c
 create mode 100644 target/i386/hax-cpus.h
 create mode 100644 target/i386/hvf/hvf-cpus.c
 create mode 100644 target/i386/hvf/hvf-cpus.h
 create mode 100644 target/i386/whpx-cpus.c
 create mode 100644 target/i386/whpx-cpus.h

-- 
2.16.4


