Received: from eggs.gnu.org ([209.51.188.92]:57557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzNPx-00039I-F6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzNPt-0003Pr-Jq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:16:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:60992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gzNPs-0003EB-3K
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:16:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gzNPl-0003qR-4e
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 15:16:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2212D2E80CE
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 15:16:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Feb 2019 15:09:55 -0000
From: Bug Watch Updater <1815889@bugs.launchpad.net>
Reply-To: Bug 1815889 <1815889@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155014036044.634.15252078016929169795.malonedeb@gac.canonical.com>
Message-Id: <155136659652.24430.11749337701465161133.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815889] Re: qemu-system-x86_64 crashed with
 signal 31 in __pthread_setaffinity_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 9 comments from the remote bug at
https://bugs.freedesktop.org/show_bug.cgi?id=3D109695.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2019-02-20T20:12:32+00:00 Ahzo wrote:

Since upgrading Mesa from 18.2 to 18.3, launching a QEMU virtual machine
with Spice OpenGL enabled (for virgl), causes QEMU to crash with SIGSYS
inside the radeonsi driver. The reason for this is that the QEMU sandbox
option 'resourcecontrol=3Ddeny' disables the sched_setaffinity syscall
called in pthread_setaffinity_np, which is now used by the radeonsi
driver.

A simple way to reproduce this problem is:
$ gdb --batch --ex run --ex bt --args qemu-system-x86_64 -spice gl=3Don -sa=
ndbox on,resourcecontrol=3Ddeny
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff45aa700 (LWP 23432)]
[New Thread 0x7ffff08e5700 (LWP 23433)]
[New Thread 0x7fffe3fff700 (LWP 23434)]
[New Thread 0x7fffe37fe700 (LWP 23435)]

Thread 4 "qemu-system-x86" received signal SIGSYS, Bad system call.
[Switching to Thread 0x7fffe3fff700 (LWP 23434)]
0x00007ffff68cc9cf in __pthread_setaffinity_new (th=3D<optimized out>, cpus=
etsize=3Dcpusetsize@entry=3D128, cpuset=3Dcpuset@entry=3D0x7fffe3ffe680) at=
 ../sysdeps/unix/sysv/linux/pthread_setaffinity.c:34
34	../sysdeps/unix/sysv/linux/pthread_setaffinity.c: No such file or direct=
ory.
#0  0x00007ffff68cc9cf in __pthread_setaffinity_new (th=3D<optimized out>, =
cpusetsize=3Dcpusetsize@entry=3D128, cpuset=3Dcpuset@entry=3D0x7fffe3ffe680=
) at ../sysdeps/unix/sysv/linux/pthread_setaffinity.c:34
#1  0x00007ffff12ba2b3 in util_queue_thread_func (input=3Dinput@entry=3D0x5=
5555640b1f0) at ../src/util/u_queue.c:252
#2  0x00007ffff12b9c17 in impl_thrd_routine (p=3D<optimized out>) at ../src=
/../include/c11/threads_posix.h:87
#3  0x00007ffff68c1fa3 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:486
#4  0x00007ffff67f280f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95


The problematic code at src/util/u_queue.c:252 was added in the following c=
ommit:
commit d877451b48a59ab0f9a4210fc736f51da5851c9a
Author: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
Date:   Mon Oct 1 15:51:06 2018 -0400

    util/u_queue: add UTIL_QUEUE_INIT_SET_FULL_THREAD_AFFINITY
    =

    Initial version discussed with Rob Clark under a different patch name.
    This approach leaves his driver unaffected.


Since setting the thread affinity seems non-essential here, the failing sys=
call should be handled gracefully, for example by setting a signal handler =
to ignore the SIGSYS signal.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/12

------------------------------------------------------------------------
On 2019-02-20T21:30:42+00:00 Marek Ol=C5=A1=C3=A1k wrote:

Mesa needs a way to query that it can't set thread affinity.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/13

------------------------------------------------------------------------
On 2019-02-21T17:15:56+00:00 Ahzo wrote:

To check for the availability of the syscall, one can try it in a child
process and see if the child is terminated by a signal, e.g. like this:

#include <stdbool.h>
#include <unistd.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <sys/wait.h>

static bool
can_set_affinity()
{
   pid_t pid =3D fork();
   int status =3D 0;
   if (!pid) {
      /* Disable coredumps, because a SIGSYS crash is expected. */
      struct rlimit limit =3D { 0 };
      limit.rlim_cur =3D 1;
      limit.rlim_max =3D 1;
      setrlimit(RLIMIT_CORE, &limit);
      /* Test the syscall in the child process. */
      syscall(SYS_sched_setaffinity, 0, 0, 0);
      _exit(0);
   } else if (pid < 0) {
      return false;
   }
   if (waitpid(pid, &status, 0) < 0) {
      return false;
   }
   if (WIFSIGNALED(status)) {
      /* The child process was terminated by a signal,
       * thus the syscall cannot be used.
       */
      return false;
   }
   return true;
}

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/14

------------------------------------------------------------------------
On 2019-02-27T14:42:21+00:00 Dan-freedesktop wrote:

(In reply to Ahzo from comment #2)
> To check for the availability of the syscall, one can try it in a child
> process and see if the child is terminated by a signal, e.g. like this:

Afraid not, QEMU's seccomp filter blocks use of fork() too :-)

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/27

------------------------------------------------------------------------
On 2019-02-27T14:45:24+00:00 Dan-freedesktop wrote:

(In reply to Ahzo from comment #0)
> The problematic code at src/util/u_queue.c:252 was added in the following
> commit:
> commit d877451b48a59ab0f9a4210fc736f51da5851c9a
> Author: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> Date:   Mon Oct 1 15:51:06 2018 -0400
> =

>     util/u_queue: add UTIL_QUEUE_INIT_SET_FULL_THREAD_AFFINITY
>     =

>     Initial version discussed with Rob Clark under a different patch name.
>     This approach leaves his driver unaffected.
> =

> =

> Since setting the thread affinity seems non-essential here, the failing
> syscall should be handled gracefully, for example by setting a signal
> handler to ignore the SIGSYS signal.

I'm curious what motivated this change to start with ?  Even if QEMU was
not enforcing seccomp filters, I think I'd consider it a bug for mesa to
be setting its process affinity in this way.  The mgmt application or
sysadmin has decided that the process must have a certain affinity,
based on how it/they want the host CPUs utilized. Why is mesa wanting to
override this administrative policy decision to restrict CPU usage ?

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/28

------------------------------------------------------------------------
On 2019-02-27T14:54:09+00:00 Alexdeucher wrote:

(In reply to Daniel P. Berrange from comment #4)
> =

> I'm curious what motivated this change to start with ?  Even if QEMU was =
not
> enforcing seccomp filters, I think I'd consider it a bug for mesa to be
> setting its process affinity in this way.  The mgmt application or sysadm=
in
> has decided that the process must have a certain affinity, based on how
> it/they want the host CPUs utilized. Why is mesa wanting to override this
> administrative policy decision to restrict CPU usage ?

To improve performance on modern multi-core NUMA architectures.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/29

------------------------------------------------------------------------
On 2019-02-27T23:14:50+00:00 elmarco wrote:

Sent a quick RFC for an env variable workaround on the ML "[PATCH] RFC:
Workaround for pthread_setaffinity_np() seccomp filtering".

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/30

------------------------------------------------------------------------
On 2019-02-28T00:15:48+00:00 Marek Ol=C5=A1=C3=A1k wrote:

(In reply to Daniel P. Berrange from comment #4)
> I'm curious what motivated this change to start with ?  Even if QEMU was =
not
> enforcing seccomp filters, I think I'd consider it a bug for mesa to be
> setting its process affinity in this way.  The mgmt application or sysadm=
in
> has decided that the process must have a certain affinity, based on how
> it/they want the host CPUs utilized. Why is mesa wanting to override this
> administrative policy decision to restrict CPU usage ?

The correct solution is to fix pthread_setaffinity such that it returns
an error code instead of crashing.

An even better solution would be to have a virtual thread affinity that
only the application can see and change, which should be silently masked
by administrative policies not visible to the application.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/31

------------------------------------------------------------------------
On 2019-02-28T10:21:44+00:00 Michel D=C3=A4nzer wrote:

(In reply to Marek Ol=C5=A1=C3=A1k from comment #7)
> An even better solution would be to have a virtual thread affinity that o=
nly
> the application can see and change, which should be silently masked by
> administrative policies not visible to the application.

Mesa doesn't really need explicit thread affinity at all. All it wants
is that certain sets of threads run on the same CPU module; it doesn't
care which particular CPU module that is. What's really needed is an API
to express this affinity between threads, instead of to specific CPU
cores.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889/comments/34


** Changed in: mesa
       Status: Unknown =3D> Confirmed

** Changed in: mesa
   Importance: Unknown =3D> High

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815889

Title:
  qemu-system-x86_64 crashed with signal 31 in
  __pthread_setaffinity_new()

Status in Mesa:
  Confirmed
Status in QEMU:
  New
Status in mesa package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  Triaged

Bug description:
  Unable to launch Default Fedora 29 images in gnome-boxes

  ProblemType: Crash
  DistroRelease: Ubuntu 19.04
  Package: qemu-system-x86 1:3.1+dfsg-2ubuntu1
  ProcVersionSignature: Ubuntu 4.19.0-12.13-generic 4.19.18
  Uname: Linux 4.19.0-12-generic x86_64
  ApportVersion: 2.20.10-0ubuntu20
  Architecture: amd64
  Date: Thu Feb 14 11:00:45 2019
  ExecutablePath: /usr/bin/qemu-system-x86_64
  KvmCmdLine: COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  MachineType: Dell Inc. Precision T3610
  ProcEnviron: PATH=3D(custom, user)
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-4.19.0-12-generic root=3DUU=
ID=3D939b509b-d627-4642-a655-979b44972d17 ro splash quiet vt.handoff=3D1
  Signal: 31
  SourcePackage: qemu
  StacktraceTop:
   __pthread_setaffinity_new (th=3D<optimized out>, cpusetsize=3D128, cpuse=
t=3D0x7f5771fbf680) at ../sysdeps/unix/sysv/linux/pthread_setaffinity.c:34
   () at /usr/lib/x86_64-linux-gnu/dri/radeonsi_dri.so
   () at /usr/lib/x86_64-linux-gnu/dri/radeonsi_dri.so
   start_thread (arg=3D<optimized out>) at pthread_create.c:486
   clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
  Title: qemu-system-x86_64 crashed with signal 31 in __pthread_setaffinity=
_new()
  UpgradeStatus: Upgraded to disco on 2018-11-14 (91 days ago)
  UserGroups: adm cdrom dip lpadmin plugdev sambashare sudo video
  dmi.bios.date: 11/14/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: A18
  dmi.board.name: 09M8Y8
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A01
  dmi.chassis.type: 7
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvrA18:bd11/14/2018:svnDellInc.:pnPrecision=
T3610:pvr00:rvnDellInc.:rn09M8Y8:rvrA01:cvnDellInc.:ct7:cvr:
  dmi.product.name: Precision T3610
  dmi.product.sku: 05D2
  dmi.product.version: 00
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/mesa/+bug/1815889/+subscriptions
