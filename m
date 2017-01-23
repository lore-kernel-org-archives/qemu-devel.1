Received: from eggs.gnu.org ([2001:4830:134:3::10]:39180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cViuI-0004AR-RG
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cViuG-0008WA-Mn
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:59:54 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cViuG-0008VK-IN
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:59:52 -0500
Received: by mail-yw0-x244.google.com with SMTP id 17so18085778ywk.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 09:59:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 23 Jan 2017 09:59:45 -0800
Message-Id: <20170123175945.9260-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 00/25] New hppa-linux target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de

Version 2: drop patch 6 which caused the IPV6 compilation errors on
older systems.

I suspect that the systems simply do not have proper glibc support
for IPV6.  One can debate whether we want to get these constants
directly from <linux/*>, or whether we want to ifdef the support.

However, let's improve that bit of linux-user in another patch set.


r~


The following changes since commit d1c82f7cc34443841095f490345f86c9d8baca34:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170120-v2' into staging (2017-01-20 15:53:58 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20170123

for you to fetch changes up to ebe9383caefd56d519e965a5d87bca29f0aeffe3:

  target-hppa: Implement floating-point insns (2017-01-23 09:52:40 -0800)

----------------------------------------------------------------
hppa-linux target support

----------------------------------------------------------------
Helge Deller (3):
      linux-user: Handle TIOCSTART and TIOCSTOP
      linux-user: Add SIOCGPGRP, SIOCGSTAMP, SIOCGSTAMPNS
      linux-user: Add some hppa ioctls

Richard Henderson (22):
      Revert "Remove remainders of HPPA backend"
      linux-user: Support stack-grows-up in elfload.c
      linux-user: Handle ERFKILL and EHWPOISON
      linux-user: Add HPPA socket.h definitions
      linux-user: Add HPPA syscall numbers
      linux-user: Add HPPA termbits.h
      linux-user: Add HPPA target_syscall.h
      linux-user: Add HPPA definitions to syscall_defs.h
      linux-user: Add HPPA target_structs.h
      linux-user: Add HPPA target_signal.h and target_cpu.h
      linux-user: Add HPPA signal handling
      linux-user: Add HPPA startup and main loop
      target-hppa: Add softfloat specializations
      target-hppa: Add framework and enable compilation
      target-hppa: Add nullification framework
      target-hppa: Implement basic arithmetic
      target-hppa: Implement branches
      target-hppa: Implement linux-user gateway page
      target-hppa: Implement shifts and deposits
      target-hppa: Implement loads and stores
      target-hppa: Implement system and memory-management insns
      target-hppa: Implement floating-point insns

 MAINTAINERS                         |    6 +
 configure                           |    7 +-
 default-configs/hppa-linux-user.mak |    1 +
 disas.c                             |    2 +
 disas/Makefile.objs                 |    1 +
 disas/hppa.c                        | 2832 +++++++++++++++++++++++++
 fpu/softfloat-specialize.h          |   20 +-
 linux-user/alpha/target_syscall.h   |    2 +
 linux-user/elfload.c                |  259 ++-
 linux-user/errno_defs.h             |    3 +
 linux-user/hppa/sockbits.h          |   97 +
 linux-user/hppa/syscall_nr.h        |  353 ++++
 linux-user/hppa/target_cpu.h        |   35 +
 linux-user/hppa/target_signal.h     |   29 +
 linux-user/hppa/target_structs.h    |   54 +
 linux-user/hppa/target_syscall.h    |  237 +++
 linux-user/hppa/termbits.h          |  219 ++
 linux-user/ioctls.h                 |    8 +
 linux-user/main.c                   |  185 +-
 linux-user/mips/target_syscall.h    |    5 +
 linux-user/mips64/target_syscall.h  |    5 +
 linux-user/qemu.h                   |    3 +
 linux-user/signal.c                 |  191 +-
 linux-user/socket.h                 |    2 +
 linux-user/syscall.c                |   12 +
 linux-user/syscall_defs.h           |  154 +-
 linux-user/syscall_types.h          |    6 +
 target/hppa/Makefile.objs           |    1 +
 target/hppa/cpu-qom.h               |   52 +
 target/hppa/cpu.c                   |  164 ++
 target/hppa/cpu.h                   |  144 ++
 target/hppa/gdbstub.c               |  111 +
 target/hppa/helper.c                |  137 ++
 target/hppa/helper.h                |   66 +
 target/hppa/op_helper.c             |  570 +++++
 target/hppa/translate.c             | 3946 +++++++++++++++++++++++++++++++++++
 36 files changed, 9842 insertions(+), 77 deletions(-)
 create mode 100644 default-configs/hppa-linux-user.mak
 create mode 100644 disas/hppa.c
 create mode 100644 linux-user/hppa/sockbits.h
 create mode 100644 linux-user/hppa/syscall_nr.h
 create mode 100644 linux-user/hppa/target_cpu.h
 create mode 100644 linux-user/hppa/target_signal.h
 create mode 100644 linux-user/hppa/target_structs.h
 create mode 100644 linux-user/hppa/target_syscall.h
 create mode 100644 linux-user/hppa/termbits.h
 create mode 100644 target/hppa/Makefile.objs
 create mode 100644 target/hppa/cpu-qom.h
 create mode 100644 target/hppa/cpu.c
 create mode 100644 target/hppa/cpu.h
 create mode 100644 target/hppa/gdbstub.c
 create mode 100644 target/hppa/helper.c
 create mode 100644 target/hppa/helper.h
 create mode 100644 target/hppa/op_helper.c
 create mode 100644 target/hppa/translate.c
