Received: from eggs.gnu.org ([2001:4830:134:3::10]:35497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLkp-0006Rf-Ec
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLkk-0001kN-CS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLkk-0001jk-6c
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:22 -0400
Received: by mail-wm0-x242.google.com with SMTP id y5so25527593wmh.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:11:53 +0200
Message-Id: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/22] add disable-tcg option for x86 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

changes from v3:

- patch 2: place ;; on a separate line [Daniel]

- patch 14: do not touch include/exec/helper-proto.h [Richard]

- patch 16: moved cpu_report_tpr_access hunk later [Richard]

- patch 18: renamed tcg_update_mxcsr [Richard], added missing
  call to cpu_post_load

- patch 20: do not touch bpt_helper.c, adjust caller in machine.c
  [Richard]

- patch 21: compile out bpt_helper.c [Richard]

Paolo Bonzini (10):
  configure: factor out list of supported Xen/KVM/HAX targets
  configure: early test for supported targets
  configure: add --disable-tcg configure option
  vl: convert -tb-size to qemu_strtoul
  monitor: disable "info jit" and "info opcount" if !TCG
  vapic: use tcg_enabled
  tcg: move tb_lock out of translate-all.h
  exec: elide calls to tb_lock and tb_unlock
  target/i386: move TLB refill function out of helper.c
  configure: warn on untested --disable-tcg

Yang Zhong (12):
  vl: add tcg_enabled() for tcg related code
  tcg: move page_size_init() function
  tcg: tcg_handle_interrupt() function
  tcg: make tcg_allowed global
  tcg: add the tcg-stub.c file into accel/stubs/
  tcg: add CONFIG_TCG guards in headers
  tcg: add the CONFIG_TCG into Makefiles
  target/i386: move cpu_sync_bndcs_hflags() function
  target/i386: make cpu_get_fp80()/cpu_set_fp80() static
  target/i386: split cpu_set_mxcsr() and make cpu_set_fpuc() inline
  target/i386: add the tcg_enabled() in target/i386/
  target/i386: add the CONFIG_TCG into Makefiles

 Makefile.target              |   4 +-
 accel/Makefile.objs          |   2 +-
 accel/stubs/Makefile.objs    |   1 +
 accel/stubs/tcg-stub.c       |  22 +++
 accel/tcg/Makefile.objs      |   2 +-
 accel/tcg/cpu-exec-common.c  |   2 +
 accel/tcg/tcg-all.c          |  35 +++-
 accel/tcg/translate-all.c    |  29 +---
 accel/tcg/translate-common.c |  56 -------
 bsd-user/main.c              |   1 -
 configure                    | 191 +++++++++++++++-------
 exec.c                       |  23 +++
 hmp-commands-info.hx         |   4 +
 hw/i386/kvmvapic.c           |   5 +-
 include/exec/cpu-defs.h      |   4 +-
 include/exec/cputlb.h        |   2 +-
 include/exec/exec-all.h      |  57 ++++---
 include/qemu-common.h        |   7 +-
 include/sysemu/accel.h       |   2 +-
 monitor.c                    |   2 +
 qom/cpu.c                    |   2 +
 target/i386/Makefile.objs    |   8 +-
 target/i386/cpu.c            |   4 +-
 target/i386/cpu.h            |  31 +++-
 target/i386/excp_helper.c    | 343 +++++++++++++++++++++++++++++++++++++++
 target/i386/fpu_helper.c     |  29 +---
 target/i386/helper.c         | 376 ++++---------------------------------------
 target/i386/machine.c        |  31 +++-
 target/i386/mpx_helper.c     |  30 ----
 tcg/tcg.h                    |   4 -
 vl.c                         |  14 +-
 31 files changed, 721 insertions(+), 602 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c
 delete mode 100644 accel/tcg/translate-common.c

-- 
1.8.3.1
