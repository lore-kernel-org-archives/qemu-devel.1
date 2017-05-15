Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHTx-0007Zw-0u
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHTq-00042Q-NH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45277 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHTq-0003rR-Al
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:14 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:40 +0200
Message-Id: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/16] Augment support for signal handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: laurent@vivier.eu, Miodrag.Dinic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, Petar.Jovanovic@rt-rk.com, yongbok.kim@imgtec.com, Milos.Stojanovic@rt-rk.com

Change from v1 to v2:
tswapal_target_sigset() is no longer static since it was breaking the bui=
ld.

This patch set deals with QEMU Linux user mode functionalities related to
signal handling. It is composed of four sections:

A. Extend strace support (patches 1-2, 8-9):

   Strace support is added for getuid(), gettid(), getppid(), geteuid(),
   tkill(), tgkill() and rt_sigqueueinfo(), along with support for printi=
ng
   the uinfo structure of rt_sigqueueinfo() of rt_tgsigqueueinfo() instea=
d
   of a pointer to it. Additionally, some minor fixes of inconsistent spa=
ces
   in the output of print_siginfo() are added.

B. Fix some signal handling issues (patches 3-5):

   Fix the ssetmask() system call by removing the invocation of
   sigorset() using the old and the new signal masks as arguments.
   Change the unlock_user() argument from arg1 to arg3 to match with
   lock_user(), since arg3 contains the pointer to the siginfo_t structur=
e.
   Change the type of the first argument of rt_sigqueinfo()
   from int to pid_t in the syscall declaration.

C. Adding support for rt_tgsigqueueinfo() (patches 6-7):

   Add a new system call: rt_tgsigqueueinfo().

   This system call is similar to rt_sigqueueinfo(), but instead of
   sending the signal and data to the whole thread group with the ID
   equal to the argument tgid, it sends it to a single thread within
   that thread group. The ID of the thread is specified by the tid
   argument.

   The implementation is based on the rt_sigqueueinfo() in linux-user
   mode, where the tid is added as the second argument and the
   previous second and third argument become arguments three and four,
   respectively.

D. Add support for larger target signal range (RFC patches 10-16):

   Add target signal mask tracking and multiplexing of target signals out
   of the host range. The patches are marked as RFC because they introduc=
e
   significant new functionalities regarding signal handling in QEMU.

   Currently, QEMU has a copy of the host signal and suspend masks and
   that is usually enough, since most of the time the signal mask of the
   target architecture is either the same length or narrower. If however
   the signal mask is wider, then part of it won't be tracked. The signal=
s
   that are in the target range but out of the host range were treated li=
ke
   faulty signals and couldn't be used. This problem is solved by enablin=
g
   the usage of one of the host signals as a multiplex for all the target
   signals that are out of range. In order to have the target signal mask=
s
   available, tracking of target signal masks is implemented.

   The rt_sigqueueinfo()/rt_tgsigqueueinfo() system calls multiplex targe=
t
   signals by setting the si_errno value to the actual value of the signa=
l
   and sending the signal to a predefined host signal number.
   The host_signal_handler() will pull out the multiplexed signals and se=
t
   their signal number to the correct value. The si_errno field is used
   here but this implementation can be replaced with any other unused fie=
ld
   in the uinfo structure. Using this implementation both rt_sigqueueinfo=
(),
   rt_tgsigqueueinfo(), as well as kill() (for pid > 0) and tgkill() can =
be
   emulated.

   The tkill() system call and kill() with the argument pid <=3D 0 couldn=
't
   be implemented simply using this method because it requires acquiring
   information about, and sending simultaneous signals to multiple thread=
s
   or processes. These functionalities are out of the scope of
   rt_sigqueueinfo()/rt_tgsigqueueinfo().

Milo=C5=A1 Stojanovi=C4=87 (16):
  linux-user: add strace for getuid(), gettid(), getppid(), geteuid()
  linux-user: add tkill(), tgkill() and rt_sigqueueinfo() strace
  linux-user: fix ssetmask() system call
  linux-user: fix mismatch of lock/unlock_user() invocations in
    rt_sigqueinfo() syscall
  linux-user: fix argument type declaration of rt_sigqueinfo() syscall
  linux-user: add support for rt_tgsigqueueinfo() system call
  linux-user: add rt_tgsigqueueinfo() strace
  linux-user: fix inconsistent spaces in print_siginfo() output
  linux-user: add strace support for uinfo structure of
    rt_sigqueueinfo() and rt_tgsigqueueinfo()
  [RFC] linux-user: add support for tracking the target signal mask
  [RFC] linux-user: add target_sigdelset() and target_sigorset()
  [RFC] linux-user: fix sigismember() check
  [RFC] linux-user: add functions for working with the target signal
    mask
  [RFC] linux-user: add functionality for tracking target signal mask
  [RFC] linux-user: add support for multiplexing larger target signals
  [RFC] linux-user: add support for multiplexing signals in
    rt_sigqueueinfo(), rt_tgsigqueueinfo(), kill() and tgkill()
    syscalls.

 linux-user/qemu.h         |  11 +++
 linux-user/signal.c       | 235 ++++++++++++++++++++++++++++++++++++++++=
+++++-
 linux-user/strace.c       | 177 ++++++++++++++++++++++++++++++++--
 linux-user/strace.list    |  16 ++--
 linux-user/syscall.c      | 208 +++++++++++++++++++++++++++++++++++++---
 linux-user/syscall_defs.h |  32 +++++++
 6 files changed, 651 insertions(+), 28 deletions(-)

--=20
1.9.1
