Received: from eggs.gnu.org ([2001:4830:134:3::10]:52613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1evp32-0001yY-SQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1evp31-0005kK-SU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:53:20 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1evp31-0005jh-Jn
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:53:19 -0400
Received: by mail-lf0-x22a.google.com with SMTP id l191-v6so1016430lfe.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 11:53:19 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 13 Mar 2018 11:53:03 -0700
Message-Id: <20180313185303.21914-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 00/11] target/xtensa linux-user support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following series that adds linux-user support for
target/xtensa.
There's a trivial merge conflict with linux-user pull request from
Laurent Vivier.

Changes since v6 patch series:
- rebase to the current master.

The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180313-xtensa

for you to fetch changes up to be00d35eab124bb4e4e393ac2b0a451e065b7041:

  MAINTAINERS: fix W: address for xtensa (2018-03-13 11:30:23 -0700)

----------------------------------------------------------------
target/xtensa linux-user support.

- small cleanup for xtensa registers dumping (-d cpu);
- add support for debugging linux-user process with xtensa-linux-gdb
  (as opposed to xtensa-elf-gdb), which can only access unprivileged
  registers;
- enable MTTCG for target/xtensa;
- cleanup in linux-user/mmap area making sure that it works correctly
  with limited 30-bit-wide user address space;
- import xtensa-specific definitions from the linux kernel,
  conditionalize user-only/softmmu-only code and add handlers for
  signals, exceptions, process/thread creation and core registers dumping.

----------------------------------------------------------------
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
 include/exec/cpu-all.h                  |   6 +-
 include/exec/cpu_ldst.h                 |  16 +-
 linux-user/elfload.c                    |  58 +++++
 linux-user/main.c                       | 245 ++++++++++++++++++
 linux-user/mmap.c                       |  43 ++--
 linux-user/qemu.h                       |   1 -
 linux-user/signal.c                     | 256 ++++++++++++++++++-
 linux-user/syscall.c                    |  15 +-
 linux-user/syscall_defs.h               |  65 ++++-
 linux-user/xtensa/syscall.h             |   0
 linux-user/xtensa/syscall_nr.h          | 437 ++++++++++++++++++++++++++++++++
 linux-user/xtensa/target_cpu.h          |  22 ++
 linux-user/xtensa/target_elf.h          |  16 ++
 linux-user/xtensa/target_signal.h       |  28 ++
 linux-user/xtensa/target_structs.h      |  28 ++
 linux-user/xtensa/target_syscall.h      |  49 ++++
 linux-user/xtensa/termbits.h            | 328 ++++++++++++++++++++++++
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
 31 files changed, 1840 insertions(+), 115 deletions(-)
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
Thanks.
-- Max
