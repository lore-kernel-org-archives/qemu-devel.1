Received: from eggs.gnu.org ([2001:4830:134:3::10]:51237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4JU-0008Oa-41
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4JQ-0007HW-Us
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:04 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4JQ-0007H3-Nv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:00 -0400
Received: by mail-wm0-x243.google.com with SMTP id p204so21563519wmg.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:34:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:31 +0200
Message-Id: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/22] add disable-tcg option for x86 build
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

Most of this series is the same as Yang Zhong's, except for:

1) less stubs usage

2) splitting patch 2 ("vl: add tcg_enabled() for tcg related code") [Thomas]

3) reworked configure [Thomas, Daniel]

Please review!

Paolo

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
 configure                    | 186 ++++++++++++++-------
 exec.c                       |  23 +++
 hmp-commands-info.hx         |   4 +
 hw/i386/kvmvapic.c           |   5 +-
 include/exec/cpu-defs.h      |   4 +-
 include/exec/cputlb.h        |   2 +-
 include/exec/exec-all.h      |  57 ++++---
 include/exec/helper-proto.h  |   2 +
 include/qemu-common.h        |   7 +-
 include/sysemu/accel.h       |   2 +-
 monitor.c                    |   2 +
 qom/cpu.c                    |   2 +
 target/i386/Makefile.objs    |   7 +-
 target/i386/bpt_helper.c     |  32 ++--
 target/i386/cpu.c            |   4 +-
 target/i386/cpu.h            |  28 +++-
 target/i386/excp_helper.c    | 343 +++++++++++++++++++++++++++++++++++++++
 target/i386/fpu_helper.c     |  29 +---
 target/i386/helper.c         | 378 ++++---------------------------------------
 target/i386/machine.c        |  23 ++-
 target/i386/mpx_helper.c     |  30 ----
 tcg/tcg.h                    |   4 -
 vl.c                         |  14 +-
 33 files changed, 735 insertions(+), 607 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c
 delete mode 100644 accel/tcg/translate-common.c

-- 
1.8.3.1
