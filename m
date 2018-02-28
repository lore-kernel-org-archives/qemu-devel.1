Received: from eggs.gnu.org ([2001:4830:134:3::10]:45854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vg-0005YE-Qx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vf-0000H7-LD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:24 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:41325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1er8vf-0000GH-DO
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:23 -0500
Received: by mail-lf0-x242.google.com with SMTP id m69so5623262lfe.8
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:06:23 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 13:06:05 -0800
Message-Id: <20180228210616.2756-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 00/11] linux-user support for target/xtensa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds linux-user support for target/xtensa.
It starts with a small cleanup for xtensa registers dumping.
It adds support for debugging linux-user process with xtensa-linux-gdb
(as opposed to xtensa-elf-gdb), which can only access unprivileged
registers.
It then enables MTTCG for xtensa.
It continues with a cleanup in linux-user/mmap area making sure that it
works correctly with limited 30-bit-wide user address space.
It then imports xtensa-specific definitions from the linux kernel,
conditionalizes user-only/softmmu-only code and adds handlers for signals
exceptions, process/thread creation and core registers dumping.

Max Filippov (11):
  target/xtensa: dump correct physical registers
  target/xtensa: mark register windows in the dump
  target/xtensa: use correct number of registers in gdbstub
  target/xtensa: support MTTCG
  linux-user: fix mmap/munmap/mprotect/mremap/shmat
  linux-user: fix assertion in shmdt
  linux-user: fix target_mprotect/target_munmap error return values
  linux-user: drop unused target_msync function
  target/xtensa: add linux-user support
  qemu-binfmt-conf.sh: add qemu-xtensa
  MAINTAINERS: fix W: address for xtensa

 MAINTAINERS                             |   2 +-
 configure                               |   1 +
 default-configs/xtensa-linux-user.mak   |   1 +
 default-configs/xtensaeb-linux-user.mak |   1 +
 include/exec/cpu-all.h                  |   2 +-
 include/exec/cpu_ldst.h                 |  12 +-
 linux-user/elfload.c                    |  58 +++++
 linux-user/main.c                       | 245 ++++++++++++++++++
 linux-user/mmap.c                       |  43 ++--
 linux-user/qemu.h                       |   1 -
 linux-user/signal.c                     | 257 ++++++++++++++++++-
 linux-user/syscall.c                    |  13 +-
 linux-user/syscall_defs.h               |  65 ++++-
 linux-user/xtensa/syscall.h             |   0
 linux-user/xtensa/syscall_nr.h          | 437 ++++++++++++++++++++++++++++++++
 linux-user/xtensa/target_cpu.h          |  22 ++
 linux-user/xtensa/target_elf.h          |  16 ++
 linux-user/xtensa/target_signal.h       |  28 ++
 linux-user/xtensa/target_structs.h      |  28 ++
 linux-user/xtensa/target_syscall.h      |  49 ++++
 linux-user/xtensa/termbits.h            | 327 ++++++++++++++++++++++++
 scripts/qemu-binfmt-conf.sh             |  12 +-
 target/xtensa/Makefile.objs             |   3 +-
 target/xtensa/cpu.c                     |  26 +-
 target/xtensa/cpu.h                     |  60 +++--
 target/xtensa/gdbstub.c                 |  14 +-
 target/xtensa/helper.c                  |  58 ++++-
 target/xtensa/helper.h                  |   4 +
 target/xtensa/op_helper.c               |  50 +++-
 target/xtensa/overlay_tool.h            |  11 +-
 target/xtensa/translate.c               |  99 ++++++--
 31 files changed, 1835 insertions(+), 110 deletions(-)
 create mode 100644 default-configs/xtensa-linux-user.mak
 create mode 100644 default-configs/xtensaeb-linux-user.mak
 create mode 100644 linux-user/xtensa/syscall.h
 create mode 100644 linux-user/xtensa/syscall_nr.h
 create mode 100644 linux-user/xtensa/target_cpu.h
 create mode 100644 linux-user/xtensa/target_elf.h
 create mode 100644 linux-user/xtensa/target_signal.h
 create mode 100644 linux-user/xtensa/target_structs.h
 create mode 100644 linux-user/xtensa/target_syscall.h
 create mode 100644 linux-user/xtensa/termbits.h

-- 
2.11.0
