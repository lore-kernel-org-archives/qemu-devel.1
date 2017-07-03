Received: from eggs.gnu.org ([2001:4830:134:3::10]:57759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLp-0008Vu-Tj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLm-0001c6-NQ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:25314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyLm-0001bC-Bp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:02 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:08 +0800
Message-Id: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 00/15] add disable-tcg option for x86 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

This patchset rebased from Paolo's below patchset, which was based on
QEMU 2.0.50 version.
https://github.com/bonzini/qemu/tree/disable-tcg

Since qemu-system-x86_64 enabled kvm and TCG accelators by default, in
fact, the TCG accelator is NOT useful in the system build of x86 platform.
This patchset will disable TCG for x86 platform if --disable-tcg option is
added into ./configure command.

The new configure build command like below
(1)./configure
   tcg is defaultly enabled

(2)./configure --disable-tcg --target-list=x86_64-softmmu
   tcg is disabled in x86_64-softmmu

(3)./configure --disable-tcg --target-list=i386-softmmu
   tcg is disabled in i386-softmmu

How to verify disable-tcg option
(1)./configure
   a)all user and softmmu build are okay.
   b) CONFIG_TCG=y is set in $config_target_mak in all user and softmmu directory
   c)kvm starting vm is okay
     ./qemu-system-x86_64 -enable-kvm -cpu host -m 2G -smp cpus=4,cores=4,threads=1,\
       sockets=1 -drive format=raw,file=eywa.img,index=0,media=disk -nographic -serial \
       stdio -nodefaults
   d)tcg starting vm is okay
     ./qemu-system-x86_64 -m 2G -smp cpus=4,cores=4,threads=1,sockets=1 -drive format=raw,\
        file=eywa.img,index=0,media=disk -nographic -serial stdio -nodefaults

(2)./configure --disable-tcg --target-list=x86_64-softmmu
   a) softmmu build is okay.
   b) CONFIG_TCG=y is not set in $config_target_mak in x86_64-softmmu directory
   c) kvm starting vm is okay
     ./qemu-system-x86_64 -enable-kvm -cpu host -m 2G -smp cpus=4,cores=4,threads=1,\
       sockets=1 -drive format=raw,file=eywa.img,index=0,media=disk -nographic -serial \
       stdio -nodefaults
   d) tcg starting vm is aborted
      The log as below:
      "tcg" accelerator not found.
      No accelerator found!

(3)./configure --target-list=x86_64-softmmu,x86_64-linux-user
   ERROR: The current x86_64-linux-user can't support disable-tcg,
       only i386-softmmu|x86_64-softmmu support disable-tcg

(4)./configure --disable-tcg --target-list=arm-softmmu
   ERROR: The current arm-softmmu can't support disable-tcg,
       only i386-softmmu|x86_64-softmmu support disable-tcg

v2:
* updated patch 01 reviewed by Richard Henderson,Thomas Huth and Paolo.
  "echo "CONFIG_TCG" >> $config_target_mak" is more clean.
  add the error configure check for --disable-tcg.
  new patch is easy to extend to other platform.
* updated patch 02 reviewed by Paolo.
  remove CONFIG_TCG.
  add tcg_enabled() for tcg code.
* updated patch 03 reviewed by Paolo.
  move tcg_handle_interrupt() from translate-common.c to tcg-all.c.
* updated patch 09 reviewed by Paolo and Richard Henderson.
  moved the x86 related function out of stubs file.
  added patch 14 for x86 related tcg functions.
* updated the flush_icache_range() reviewed by Paolo.
  deleted this patch and the compile is still okay. So there will not this 
  patch in future release. 
* updated patch 12 reviewed by Richard Henderson.
  removed the CONFIG_TCG in CPUX86State struct. cpu-defs.h has disabled 
  CPU_COMMON_TLB if tcg is disabled.


Yang Zhong (15):
  configure: add the disable-tcg option
  vl: add tcg_enabled() for tcg related code
  tcg: tcg_handle_interrupt() function
  tcg: change tcg_enabled()
  tcg: move page_size_init() function
  kvmvapic: remove tcg related code
  tcg: move cpu_sync_bndcs_hflags() function
  tcg: make cpu_get_fp80()/cpu_set_fp80() static
  tcg: add the tcg-stub.c file into accel/stubs/
  tcg: move tb related lock functions
  tcg: split cpu_set_mxcsr() and make cpu_set_fpuc() inline
  tcg: disable tcg in CPUX86State struct
  tcg: add the CONFIG_TCG for header
  tcg: add the tcg_enabled() in target/i386/
  tcg: add the CONFIG_TCG into Makefiles

 Makefile.target              |  4 +-
 accel/Makefile.objs          |  2 +-
 accel/stubs/Makefile.objs    |  1 +
 accel/stubs/tcg-stub.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/Makefile.objs      |  2 +-
 accel/tcg/cpu-exec.c         |  1 +
 accel/tcg/cputlb.c           |  1 +
 accel/tcg/tcg-all.c          | 36 ++++++++++++++++-
 accel/tcg/translate-all.c    | 24 +----------
 accel/tcg/translate-all.h    |  3 ++
 accel/tcg/translate-common.c | 56 --------------------------
 bsd-user/main.c              |  1 +
 configure                    | 43 +++++++++++++++++++-
 exec.c                       | 20 ++++++++++
 hw/i386/kvmvapic.c           | 24 -----------
 include/exec/cpu-defs.h      |  4 +-
 include/exec/cputlb.h        |  2 +-
 include/exec/exec-all.h      | 53 +++++++++++++------------
 include/exec/helper-proto.h  |  2 +
 include/qemu-common.h        |  7 +++-
 include/sysemu/accel.h       |  2 +-
 linux-user/main.c            |  2 +-
 qom/cpu.c                    |  2 +
 target/i386/Makefile.objs    |  7 ++--
 target/i386/bpt_helper.c     | 26 +++++++++---
 target/i386/cpu.c            |  4 +-
 target/i386/cpu.h            | 22 +++++++++--
 target/i386/fpu_helper.c     | 29 +-------------
 target/i386/helper.c         | 34 +++++++++++++++-
 target/i386/machine.c        | 23 ++++++++++-
 target/i386/mpx_helper.c     | 30 --------------
 tcg/tcg.h                    |  4 --
 trace/control-target.c       |  1 -
 vl.c                         | 15 +++++--
 34 files changed, 358 insertions(+), 223 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c
 delete mode 100644 accel/tcg/translate-common.c

-- 
1.9.1
