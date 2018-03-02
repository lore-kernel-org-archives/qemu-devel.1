Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1erryC-0004Rc-Vj
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1erry7-000228-VJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:12:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:40782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1erry7-00021q-Pg
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:11:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1erry5-0005Bh-Ki
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 21:11:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0F51A2E823D
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 21:11:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Mar 2018 20:59:15 -0000
From: =?utf-8?q?=C3=89ric_Hoffman?= <1673976@bugs.launchpad.net>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <152002435576.7787.3463797608545567500.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] Re: linux-user clone() can't handle
 glibc posix_spawn() (causes locale-gen to assert)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ok, yes you are right...

I have looked a bit more on the source code, and indeed, I think
understand the issue with the VFORK with QEMU.  Please correct me if I'm
wrong...

- In the syscall trap handler, it has to use the fork() function to emulate=
 the vfork() due to restriction of the vfork() function (as QEMU must conti=
nue to control the flow of instruction past the call to vfork(), and do a l=
ot more things in the child thread before ending up performing a execve() o=
r _exit())
- Also, it can not do a wait() for the emulated child, as this child will c=
ontinue to exist even after it calls execve(), so the parent would stall.
- Then, I taught about doing condition signalling, like waiting for a pthre=
ad condition signal that the child would send once it come to the point of =
performing the _exit() or execve(), but the child would, for example, need =
to know if execve() was successful, or otherwise the child would continue a=
nd set an error flag and then call _exit().  We do need that error flag bef=
ore continuing the execution on the parent.  So we can not signal back to t=
he parent that the 'emulated vfork' is OK before calling execve(), but we c=
an not wait after execve() because if the call is successful, there is no r=
eturn from that function, and code goes outside the control of QEMU.

So, I taught of an idea...  What if, in the TARGET_NR_clone syscall trap, w=
hen we are called upon a CLONE_VFORK, we do:
- Do a regular fork, as it's currently done, with CLONE_VM flag (so the chi=
ld share the same memory as the parent).  However, we also set a state flag=
 that we are in this 'vfork emulation' mode just before the fork (more on t=
hat bellow...).
- Let the parent wait for the child to terminate (again, more on that bello=
w...).
- Let the child return normally and continue execution, as if the parent wa=
s waiting.

Then, eventually the child will eventually either end up in the TARGET_NR_e=
xecve or __NR_exit_group syscall trap.  At which point:
- The child check if it is in 'vfork emulation' mode.  If not, then there's=
 nothing special, just continue the way the code is currently written.  If =
the flag is set, then follow on with the steps bellow...
- The child set a flag that tell where it is (TARGET_NR_execve or __NR_exit=
_group, and the arguments passed to that syscall), and that everything is o=
k (it has not simply died meanwhile).
- The child terminate, which resume the parent's execution.

The parent then:
- Clear the 'vfork emulation' flag.
- Look at where the child left (was it performing TARGET_NR_execve or __NR_=
exit_group syscall?  What was the arguments passed to the syscall?).  This =
is pretty easy since the child was writing to the parent's memory space the=
 whole time (CLONE_VM).  The parent could even use a flag allocated on it's=
 stack before the fork(), since the child will have run with it's own stack=
 during that time (so the parent stack is still intact).
- Now that we know what the child wanted to do (what syscall and which para=
meters), the parent (which at his point has no more 'leftover' child), can =
then do a *real* vfork, or otherwise return the proper error code.

It's a bit far fetched, and I'm far from implying that I know much about
QEMU, but this is an idea :-)  Sound like it's pretty straightforward
though.  Basically we just wait for the code between the _clone()
function and the _execve/_exit function to complete, at which point we
take action and we are in measure to assess the status code (and do the
real vfork).

Regards,
Eric

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673976

Title:
  linux-user clone() can't handle glibc posix_spawn() (causes locale-gen
  to assert)

Status in QEMU:
  New

Bug description:
  I'm running a command (locale-gen) inside of an armv7h chroot mounted
  on my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
  chroot file system and I get a core dump.

  locale-gen
  Generating locales...
  =C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:=
360: __spawnix: Assertion `ec >=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  /usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped)=
 localedef -i $input -c -f $charset -A /usr/share/locale/locale.alias $loca=
le

  I've done this same thing successfully for years, but this breakage
  has appeared some time in the last 3 or so months. Possibly with the
  update to qemu version 2.8.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673976/+subscriptions
