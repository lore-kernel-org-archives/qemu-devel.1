Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67910C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D5320E65
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D5320E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAzb-00043d-RX
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxX-0002OV-2f
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxU-0005Oo-E1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8C60FAB93;
 Mon,  9 Nov 2020 17:27:58 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v1 00/10] i386 cleanup
Date: Mon,  9 Nov 2020 18:27:45 +0100
Message-Id: <20201109172755.16500-1-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 21:17:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Cameron Esfahani <dirty@apple.com>, haxm-team@intel.com,
 Claudio Fontana <cfontana@suse.de>, Anthony Perard <anthony.perard@citrix.com>,
 Bruce Rogers <brogers@suse.com>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

this is very much a RFC, I have started to look at the i386
target dir and how to start refactoring and splitting up
things better, moving more and more of the code to
accelerator-specific parts that are conditionally compiled.

In this RFC I start by moving all i386-specific accelerators into
target/i386/accel/, away from the main target directory,

then I go on and strip away all the cpu dump code out of helper.c
into a new file. There is a large amount of checkpatch warnings
and errors, but this is due to the copy paste of the old code,
we might need to clean up the state of the dump code in a later
change if necessary.

After that I take out tcg-specific stuff from cpu.h and from
helper.c and put it in helper-tcg.h and in a new tcg-cpu module,
(that will be renamed later in the series as its role changes).

After this I considered and implemented a few options,
but after some initial evaluation I concluded that a good idea
could possibly be to introduce a new MODULE_INIT phase,

MODULE_INIT_ACCEL_CPU

that I could use to put all existing cpus accel interface
initializations,
and that I could also use to put all accelerator specific
cpu module registrations, deferring the usual registration
at MODULE_INIT_QOM time.
This deferring allows to make all x86 cpu models children
of an accel-specific cpu type, in turn having as parent
the generic TYPE_X86_CPU.

There are for sure other options out there, so let me know if
this way seems promising, or if you have other ideas on how
to proceed here, especially in the last 3 patches..

Motivation and higher level steps:

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html

Thank you for your comments,

Ciao,

Claudio

Claudio Fontana (10):
  i386: move kvm accel files into accel/kvm/
  i386: move whpx accel files to accel/whpx/
  i386: move hax accel files to accel/hax/
  i386: move hvf accel files into accel/hvf/
  i386: move TCG accel files into accel/tcg/
  i386: move cpu dump out of helper.c into cpu-dump.c
  i386: move TCG cpu class initialization out of helper.c
  module: introduce MODULE_INIT_ACCEL_CPU
  i386: split cpu.c and defer x86 models registration
  module: add priority to module_init

 MAINTAINERS                                 |  12 +-
 accel/kvm/kvm-all.c                         |  11 +-
 accel/qtest/qtest.c                         |  10 +-
 accel/tcg/tcg-all.c                         |  11 +-
 accel/xen/xen-all.c                         |  12 +-
 bsd-user/main.c                             |   4 +
 hw/i386/fw_cfg.c                            |   2 +-
 hw/i386/intel_iommu.c                       |   2 +-
 hw/i386/kvm/apic.c                          |   2 +-
 hw/i386/kvm/clock.c                         |   2 +-
 hw/i386/microvm.c                           |   2 +-
 hw/i386/pc.c                                |   2 +-
 hw/i386/pc_piix.c                           |   1 +
 hw/i386/x86.c                               |   2 +-
 include/qemu/module.h                       |  17 +
 linux-user/main.c                           |  10 +-
 meson.build                                 |   1 +
 softmmu/vl.c                                |   6 +
 target/i386/{ => accel/hax}/hax-all.c       |  12 +-
 target/i386/{ => accel/hax}/hax-cpus.c      |   0
 target/i386/{ => accel/hax}/hax-cpus.h      |   0
 target/i386/{ => accel/hax}/hax-i386.h      |   6 +-
 target/i386/{ => accel/hax}/hax-interface.h |   0
 target/i386/{ => accel/hax}/hax-mem.c       |   0
 target/i386/{ => accel/hax}/hax-posix.c     |   0
 target/i386/{ => accel/hax}/hax-posix.h     |   0
 target/i386/{ => accel/hax}/hax-windows.c   |   0
 target/i386/{ => accel/hax}/hax-windows.h   |   0
 target/i386/accel/hax/meson.build           |   7 +
 target/i386/{ => accel}/hvf/README.md       |   0
 target/i386/accel/hvf/hvf-cpu-type.c        |  78 +++
 target/i386/{ => accel}/hvf/hvf-cpus.c      |   0
 target/i386/{ => accel}/hvf/hvf-cpus.h      |   0
 target/i386/{ => accel}/hvf/hvf-i386.h      |   0
 target/i386/{ => accel}/hvf/hvf.c           |  10 +-
 target/i386/{ => accel}/hvf/meson.build     |   1 +
 target/i386/{ => accel}/hvf/panic.h         |   0
 target/i386/{ => accel}/hvf/vmcs.h          |   0
 target/i386/{ => accel}/hvf/vmx.h           |   0
 target/i386/{ => accel}/hvf/x86.c           |   0
 target/i386/{ => accel}/hvf/x86.h           |   0
 target/i386/{ => accel}/hvf/x86_cpuid.c     |   0
 target/i386/{ => accel}/hvf/x86_decode.c    |   0
 target/i386/{ => accel}/hvf/x86_decode.h    |   0
 target/i386/{ => accel}/hvf/x86_descr.c     |   0
 target/i386/{ => accel}/hvf/x86_descr.h     |   0
 target/i386/{ => accel}/hvf/x86_emu.c       |   0
 target/i386/{ => accel}/hvf/x86_emu.h       |   0
 target/i386/{ => accel}/hvf/x86_flags.c     |   0
 target/i386/{ => accel}/hvf/x86_flags.h     |   0
 target/i386/{ => accel}/hvf/x86_mmu.c       |   0
 target/i386/{ => accel}/hvf/x86_mmu.h       |   0
 target/i386/{ => accel}/hvf/x86_task.c      |   0
 target/i386/{ => accel}/hvf/x86_task.h      |   0
 target/i386/{ => accel}/hvf/x86hvf.c        |   0
 target/i386/{ => accel}/hvf/x86hvf.h        |   0
 target/i386/{ => accel/kvm}/hyperv-proto.h  |   0
 target/i386/{ => accel/kvm}/hyperv-stub.c   |   0
 target/i386/{ => accel/kvm}/hyperv.c        |   0
 target/i386/{ => accel/kvm}/hyperv.h        |   0
 target/i386/accel/kvm/kvm-cpu-type.c        | 161 ++++++
 target/i386/accel/kvm/kvm-cpu-type.h        |  41 ++
 target/i386/{ => accel/kvm}/kvm-stub.c      |   0
 target/i386/{ => accel/kvm}/kvm.c           |   3 +-
 target/i386/{ => accel/kvm}/kvm_i386.h      |   0
 target/i386/accel/kvm/meson.build           |   8 +
 target/i386/accel/kvm/trace-events          |   7 +
 target/i386/accel/kvm/trace.h               |   1 +
 target/i386/{ => accel/tcg}/bpt_helper.c    |   1 +
 target/i386/{ => accel/tcg}/cc_helper.c     |   1 +
 target/i386/{ => accel/tcg}/excp_helper.c   |   1 +
 target/i386/{ => accel/tcg}/fpu_helper.c    |  33 +-
 target/i386/{ => accel/tcg}/int_helper.c    |   1 +
 target/i386/{ => accel/tcg}/mem_helper.c    |   1 +
 target/i386/accel/tcg/meson.build           |  14 +
 target/i386/{ => accel/tcg}/misc_helper.c   |   1 +
 target/i386/{ => accel/tcg}/mpx_helper.c    |   1 +
 target/i386/{ => accel/tcg}/seg_helper.c    |   1 +
 target/i386/{ => accel/tcg}/smm_helper.c    |   2 +
 target/i386/{ => accel/tcg}/svm_helper.c    |   1 +
 target/i386/accel/tcg/tcg-cpu-type.c        | 176 +++++++
 target/i386/accel/tcg/tcg-cpu-type.h        |  25 +
 target/i386/{ => accel/tcg}/tcg-stub.c      |   0
 target/i386/{ => accel/tcg}/translate.c     |   1 +
 target/i386/accel/whpx/meson.build          |   4 +
 target/i386/{ => accel/whpx}/whp-dispatch.h |   0
 target/i386/{ => accel/whpx}/whpx-all.c     |  11 +-
 target/i386/{ => accel/whpx}/whpx-cpus.c    |   0
 target/i386/{ => accel/whpx}/whpx-cpus.h    |   0
 target/i386/cpu-dump.c                      | 538 +++++++++++++++++++
 target/i386/cpu.c                           | 489 ++++--------------
 target/i386/cpu.h                           | 126 +----
 target/i386/helper-tcg.h                    | 112 ++++
 target/i386/helper.c                        | 539 +-------------------
 target/i386/host-cpu.c                      | 201 ++++++++
 target/i386/host-cpu.h                      |  21 +
 target/i386/machine.c                       |   4 +-
 target/i386/meson.build                     |  41 +-
 target/i386/trace-events                    |   6 -
 99 files changed, 1678 insertions(+), 1118 deletions(-)
 rename target/i386/{ => accel/hax}/hax-all.c (99%)
 rename target/i386/{ => accel/hax}/hax-cpus.c (100%)
 rename target/i386/{ => accel/hax}/hax-cpus.h (100%)
 rename target/i386/{ => accel/hax}/hax-i386.h (95%)
 rename target/i386/{ => accel/hax}/hax-interface.h (100%)
 rename target/i386/{ => accel/hax}/hax-mem.c (100%)
 rename target/i386/{ => accel/hax}/hax-posix.c (100%)
 rename target/i386/{ => accel/hax}/hax-posix.h (100%)
 rename target/i386/{ => accel/hax}/hax-windows.c (100%)
 rename target/i386/{ => accel/hax}/hax-windows.h (100%)
 create mode 100644 target/i386/accel/hax/meson.build
 rename target/i386/{ => accel}/hvf/README.md (100%)
 create mode 100644 target/i386/accel/hvf/hvf-cpu-type.c
 rename target/i386/{ => accel}/hvf/hvf-cpus.c (100%)
 rename target/i386/{ => accel}/hvf/hvf-cpus.h (100%)
 rename target/i386/{ => accel}/hvf/hvf-i386.h (100%)
 rename target/i386/{ => accel}/hvf/hvf.c (99%)
 rename target/i386/{ => accel}/hvf/meson.build (92%)
 rename target/i386/{ => accel}/hvf/panic.h (100%)
 rename target/i386/{ => accel}/hvf/vmcs.h (100%)
 rename target/i386/{ => accel}/hvf/vmx.h (100%)
 rename target/i386/{ => accel}/hvf/x86.c (100%)
 rename target/i386/{ => accel}/hvf/x86.h (100%)
 rename target/i386/{ => accel}/hvf/x86_cpuid.c (100%)
 rename target/i386/{ => accel}/hvf/x86_decode.c (100%)
 rename target/i386/{ => accel}/hvf/x86_decode.h (100%)
 rename target/i386/{ => accel}/hvf/x86_descr.c (100%)
 rename target/i386/{ => accel}/hvf/x86_descr.h (100%)
 rename target/i386/{ => accel}/hvf/x86_emu.c (100%)
 rename target/i386/{ => accel}/hvf/x86_emu.h (100%)
 rename target/i386/{ => accel}/hvf/x86_flags.c (100%)
 rename target/i386/{ => accel}/hvf/x86_flags.h (100%)
 rename target/i386/{ => accel}/hvf/x86_mmu.c (100%)
 rename target/i386/{ => accel}/hvf/x86_mmu.h (100%)
 rename target/i386/{ => accel}/hvf/x86_task.c (100%)
 rename target/i386/{ => accel}/hvf/x86_task.h (100%)
 rename target/i386/{ => accel}/hvf/x86hvf.c (100%)
 rename target/i386/{ => accel}/hvf/x86hvf.h (100%)
 rename target/i386/{ => accel/kvm}/hyperv-proto.h (100%)
 rename target/i386/{ => accel/kvm}/hyperv-stub.c (100%)
 rename target/i386/{ => accel/kvm}/hyperv.c (100%)
 rename target/i386/{ => accel/kvm}/hyperv.h (100%)
 create mode 100644 target/i386/accel/kvm/kvm-cpu-type.c
 create mode 100644 target/i386/accel/kvm/kvm-cpu-type.h
 rename target/i386/{ => accel/kvm}/kvm-stub.c (100%)
 rename target/i386/{ => accel/kvm}/kvm.c (99%)
 rename target/i386/{ => accel/kvm}/kvm_i386.h (100%)
 create mode 100644 target/i386/accel/kvm/meson.build
 create mode 100644 target/i386/accel/kvm/trace-events
 create mode 100644 target/i386/accel/kvm/trace.h
 rename target/i386/{ => accel/tcg}/bpt_helper.c (99%)
 rename target/i386/{ => accel/tcg}/cc_helper.c (99%)
 rename target/i386/{ => accel/tcg}/excp_helper.c (99%)
 rename target/i386/{ => accel/tcg}/fpu_helper.c (99%)
 rename target/i386/{ => accel/tcg}/int_helper.c (99%)
 rename target/i386/{ => accel/tcg}/mem_helper.c (99%)
 create mode 100644 target/i386/accel/tcg/meson.build
 rename target/i386/{ => accel/tcg}/misc_helper.c (99%)
 rename target/i386/{ => accel/tcg}/mpx_helper.c (99%)
 rename target/i386/{ => accel/tcg}/seg_helper.c (99%)
 rename target/i386/{ => accel/tcg}/smm_helper.c (99%)
 rename target/i386/{ => accel/tcg}/svm_helper.c (99%)
 create mode 100644 target/i386/accel/tcg/tcg-cpu-type.c
 create mode 100644 target/i386/accel/tcg/tcg-cpu-type.h
 rename target/i386/{ => accel/tcg}/tcg-stub.c (100%)
 rename target/i386/{ => accel/tcg}/translate.c (99%)
 create mode 100644 target/i386/accel/whpx/meson.build
 rename target/i386/{ => accel/whpx}/whp-dispatch.h (100%)
 rename target/i386/{ => accel/whpx}/whpx-all.c (99%)
 rename target/i386/{ => accel/whpx}/whpx-cpus.c (100%)
 rename target/i386/{ => accel/whpx}/whpx-cpus.h (100%)
 create mode 100644 target/i386/cpu-dump.c
 create mode 100644 target/i386/helper-tcg.h
 create mode 100644 target/i386/host-cpu.c
 create mode 100644 target/i386/host-cpu.h

-- 
2.26.2


