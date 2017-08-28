Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Ig-0004l2-WD
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Id-0000qA-UJ
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:15 -0400
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:37521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dm9Id-0000pw-P4
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:11 -0400
Received: by mail-vk0-x22d.google.com with SMTP id q189so12098036vke.4
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 18:57:11 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Sun, 27 Aug 2017 20:56:40 -0500
Message-Id: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH 00/14] add support for Hypervisor.framework in
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

The following patchset adds to QEMU the supporting for macOS's native
hypervisor, Hypervisor.framework (hvf). The code base is taken from
Google's Android emulator at
https://android.googlesource.com/platform/external/qemu/+/emu-master-dev.

Apart from general code refactoring, some additional features were implemented:
retrieve the set of features supported by host cpu and hvf (cpuid);
dirty page tracking for VGA memory area; reimplementation of the event
injection mechanism to allow injection of exceptions during vmexits, which is
exemplified by the injection of a GP fault when the guest vmexits due to
execution of the vmcall instruction; changing the emulator's use of CPUState
structure in favor of CPUX86State, so as to in the future remove data structures
that are uselessly specific to hvf and unified some of the state between kvm/tcg
and hvf.
Some features initially planned to implement that didn't make it include:
page fault handling in the emulator and implementing the dummy_signal to handle
the SIG_IPI signal without race conditions. Hopefully these can be implemented
in the near future.

Sergio Andres Gomez Del Real (14):
  hvf: add support for Hypervisor.framework in the configure script
  hvf: add code base from Google's QEMU repository
  hvf: add conditional macros around hvf code in cpus.c
  hvf: add fields to CPUState and CPUX86State; add definitions
  hvf: use new helper functions for put/get xsave
  hvf: add compilation rules to Makefile.objs
  hvf: run hvf code through checkpatch.pl and fix style issues
  apic: add function to apic that will be used by hvf
  hvf: implement hvf_get_supported_cpuid
  hvf: refactor cpuid code
  hvf: implement vga dirty page tracking
  hvf: move fields from CPUState to CPUX86State
  hvf: refactor event injection code for hvf
  hvf: inject General Protection Fault when vmexit through vmcall

 configure                           |   32 +
 cpus.c                              |  107 +-
 hw/intc/apic.c                      |   11 +
 include/hw/i386/apic.h              |    1 +
 include/qom/cpu.h                   |    2 +
 include/sysemu/hvf.h                |  106 ++
 qemu-options.hx                     |   20 +-
 target/i386/Makefile.objs           |    1 +
 target/i386/cpu-qom.h               |    4 +-
 target/i386/cpu.c                   |  111 +-
 target/i386/cpu.h                   |   30 +
 target/i386/hvf-all.c               | 1123 ++++++++++++++++++
 target/i386/hvf-i386.h              |   48 +
 target/i386/hvf-utils/Makefile.objs |    1 +
 target/i386/hvf-utils/README.md     |    7 +
 target/i386/hvf-utils/vmcs.h        |  371 ++++++
 target/i386/hvf-utils/vmx.h         |  222 ++++
 target/i386/hvf-utils/x86.c         |  184 +++
 target/i386/hvf-utils/x86.h         |  476 ++++++++
 target/i386/hvf-utils/x86_cpuid.c   |  417 +++++++
 target/i386/hvf-utils/x86_cpuid.h   |   52 +
 target/i386/hvf-utils/x86_decode.c  | 2186 +++++++++++++++++++++++++++++++++++
 target/i386/hvf-utils/x86_decode.h  |  325 ++++++
 target/i386/hvf-utils/x86_descr.c   |  124 ++
 target/i386/hvf-utils/x86_descr.h   |   55 +
 target/i386/hvf-utils/x86_emu.c     | 1536 ++++++++++++++++++++++++
 target/i386/hvf-utils/x86_emu.h     |   32 +
 target/i386/hvf-utils/x86_flags.c   |  333 ++++++
 target/i386/hvf-utils/x86_flags.h   |  243 ++++
 target/i386/hvf-utils/x86_gen.h     |   36 +
 target/i386/hvf-utils/x86_mmu.c     |  273 +++++
 target/i386/hvf-utils/x86_mmu.h     |   28 +
 target/i386/hvf-utils/x86hvf.c      |  463 ++++++++
 target/i386/hvf-utils/x86hvf.h      |   22 +
 target/i386/kvm.c                   |    2 -
 vl.c                                |    7 +
 36 files changed, 8957 insertions(+), 34 deletions(-)
 create mode 100644 include/sysemu/hvf.h
 create mode 100644 target/i386/hvf-all.c
 create mode 100644 target/i386/hvf-i386.h
 create mode 100644 target/i386/hvf-utils/Makefile.objs
 create mode 100644 target/i386/hvf-utils/README.md
 create mode 100644 target/i386/hvf-utils/vmcs.h
 create mode 100644 target/i386/hvf-utils/vmx.h
 create mode 100644 target/i386/hvf-utils/x86.c
 create mode 100644 target/i386/hvf-utils/x86.h
 create mode 100644 target/i386/hvf-utils/x86_cpuid.c
 create mode 100644 target/i386/hvf-utils/x86_cpuid.h
 create mode 100644 target/i386/hvf-utils/x86_decode.c
 create mode 100644 target/i386/hvf-utils/x86_decode.h
 create mode 100644 target/i386/hvf-utils/x86_descr.c
 create mode 100644 target/i386/hvf-utils/x86_descr.h
 create mode 100644 target/i386/hvf-utils/x86_emu.c
 create mode 100644 target/i386/hvf-utils/x86_emu.h
 create mode 100644 target/i386/hvf-utils/x86_flags.c
 create mode 100644 target/i386/hvf-utils/x86_flags.h
 create mode 100644 target/i386/hvf-utils/x86_gen.h
 create mode 100644 target/i386/hvf-utils/x86_mmu.c
 create mode 100644 target/i386/hvf-utils/x86_mmu.h
 create mode 100644 target/i386/hvf-utils/x86hvf.c
 create mode 100644 target/i386/hvf-utils/x86hvf.h

-- 
2.14.1

Subject: [PATCH 00/15] 
