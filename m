Received: from eggs.gnu.org ([209.51.188.92]:55736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjv-0004i1-7H
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjt-0003xl-Jc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:47 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjs-0003iT-Ik
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:45 -0500
Received: by mail-pf1-x430.google.com with SMTP id c73so7181730pfe.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:34 +1100
Message-Id: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 00/49] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Since v5, I've split the patches into smaller pieces, and done
a few more syscalls.  But I've also been approaching them in a
more "systematic" way -- taking from the top of the switch.

I've been trying to fix up checkpatch failures as I've moved
code, but I've surely missed some.  I've also been trying to
share code between the "*at" syscalls and their original.

I've tested x86_64->armhf and aarch64->i386 vs LTP.

FYI, as measured by the line count of do_syscall1, this is
about 25% of the total job to be done.


r~


PS: Patch 2/49 is a debugging patch I forgot to remove.
Rather than regenerate the series, I just omitted it here.


Richard Henderson (49):
  linux-user: Setup split syscall infrastructure
  linux-user: Split out open, open_at
  linux-user: Share more code for open and openat
  linux-user: Tidy do_openat loop over fakes
  linux-user: Split out readlink, readlinkat
  linux-user: Split out close
  linux-user: Split out read, write
  linux-user: Reduce regpairs_aligned & target_offset64 ifdefs
  linux-user: Split out readv, writev
  linux-user: Split out pread64, pwrite64
  linux-user: Split out preadv, pwritev
  linux-user: Split out name_to_handle_at, open_by_handle_at
  linux-user: Split out ipc syscalls
  linux-user: Split out memory syscalls
  linux-user: Split out exit
  linux-user: Split out brk
  linux-user: Split out clone, fork, vfork
  linux-user: Split out wait4, waitid, waitpid
  linux-user: Implement rusage argument to waitid
  linux-user: Split out creat
  linux-user: Split out link, linkat
  linux-user: Split out unlink, unlinkat, rmdir
  linux-user: Split out execve
  linux-user: Implement execveat
  linux-user: Split out chdir
  linux-user: Split out time
  linux-user: Split out mknod, mknodat
  linux-user: Split out chmod, fchmod, fchmodat
  linux-user: Split out lseek, llseek
  linux-user: Split out getpid, getppid, getxpid
  linux-user: Split out mount
  linux-user: Split out umount, umount2
  linux-user: Split out stime
  linux-user: Split out alarm, pause
  linux-user: Split out utime, utimes, futimesat
  linux-user: Split out access, faccessat
  linux-user: Split out nice
  linux-user: Split out sync, syncfs
  linux-user: Split out kill
  linux-user: Split out rename, renameat, renameat2
  linux-user: Split out mkdir, mkdirat
  linux-user: Split out dup, dup2, dup3
  linux-user: Split out pipe, pipe2
  linux-user: Split out times
  linux-user: Split out acct
  linux-user: Move syscall_init to the end
  linux-user: Split out ioctl
  linux-user: Split out fcntl, fcntl64

 linux-user/syscall-defs.h      |  240 ++
 linux-user/syscall.h           |  102 +
 linux-user/strace.c            | 1258 +++-------
 linux-user/syscall-fcntl.inc.c |  322 +++
 linux-user/syscall-file.inc.c  | 1229 ++++++++++
 linux-user/syscall-ioctl.inc.c |  873 +++++++
 linux-user/syscall-ipc.inc.c   | 1086 +++++++++
 linux-user/syscall-mem.inc.c   |  244 ++
 linux-user/syscall-proc.inc.c  |  593 +++++
 linux-user/syscall-sig.inc.c   |   41 +
 linux-user/syscall-time.inc.c  |   44 +
 linux-user/syscall.c           | 4128 ++------------------------------
 configure                      |   20 -
 linux-user/strace.list         |  285 ---
 14 files changed, 5376 insertions(+), 5089 deletions(-)
 create mode 100644 linux-user/syscall-defs.h
 create mode 100644 linux-user/syscall.h
 create mode 100644 linux-user/syscall-fcntl.inc.c
 create mode 100644 linux-user/syscall-file.inc.c
 create mode 100644 linux-user/syscall-ioctl.inc.c
 create mode 100644 linux-user/syscall-ipc.inc.c
 create mode 100644 linux-user/syscall-mem.inc.c
 create mode 100644 linux-user/syscall-proc.inc.c
 create mode 100644 linux-user/syscall-sig.inc.c
 create mode 100644 linux-user/syscall-time.inc.c

-- 
2.17.2
