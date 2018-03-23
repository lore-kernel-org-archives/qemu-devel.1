Received: from eggs.gnu.org ([2001:4830:134:3::10]:49437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezRmi-0002DE-0T
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezRme-00053U-T9
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:51:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:40052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ezRme-000539-La
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:51:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ezRmd-0006iC-Fa
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 18:51:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 72E1C2E8D36
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 18:51:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Mar 2018 18:37:01 -0000
From: =?utf-8?q?=C3=89ric_Hoffman?= <1673976@bugs.launchpad.net>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <152183022183.26239.10208426979115058383.malone@gac.canonical.com>
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

Hello

Sorry for the delay...

Actually, you only need the parent to get the status from the child,
which can be passed in other way than through common memory.

The idea is to use pipefd to actually wait for the child to either
terminate or successfully call execve.  As follow:


When the TARGET_NR_clone syscall is trapped, you do:
- Call do_fork(), as currently done
- In do_fork(), at the beginning, if CLONE_VFORK flag is set, keep track of=
 it (i.e. do not clear the flag, just clear the CLONE_VM, as currently done=
, to do a normal fork, i.e. the child have it's own copy of the memory segm=
ents).
- Just before the call to fork(), create a pipefd.
- The parent branch and then (if CLONE_VFORK is set) close the write end of=
 the pipe (it's own copy), and start looping (could be indefinitely, but pr=
eferably some sort of timeout logic could be set) on the read fd, waiting c=
ontinuously for status updates from the child.
- The child branch close the read-end of the pipe (it's own forked copy), s=
et the write-end fd flag FD_CLOEXEC (with fnctl()), and put the write fd in=
to it's QEMU state variables (parent vfork fd).
- The child then move on.

When the TARGET_NR_execve syscall is trapped (this is in child context), yo=
u do:
- Do everything as currently done, up to just before the safe_execve() call.
- Just before the call to safe_execve(), check if the QEMU state variable (=
parent vfork fd) is defined.  If so, tell the the parent (through the pipe)=
, that we are good so far, and about to call execve().  Note that the paren=
t just update the child status, but keep looping endlessly.
- Call the execve().
- If the above call return, an error occurred.  If this occur, check if the=
 QEMU state variable (parent vfork fd) is defined.  If so, tell whatever er=
ror status you got to the parent (through the pipe).  The parent update it'=
s child status, but again, continue to loop endlessly.
- Continue normally.

That's pretty much the bulk of the work done!  What will happen:
- Either the child will eventually call execve, which will succeed, at whic=
h point the write end of the pipe will be closed (because we set the pipe t=
o close on execve, with the FD_CLOEXEC flag).
- The child could be playing on us, and try to re-call execve() multiple ti=
mes (possibly with different arguments, executables path, etc.), but every =
time, the parent will just receive status update through the pipe.  And eve=
ntually, the above case will occur (success), and pipe will be closed.
- The child call _exit(), which will close the pipe again.
- The child get some horrible signal, get killed, or whatever else...  Pipe=
 still get closed.

The parent, on it's side, just update the status endlessly, UNTIL the
other end of the pipe get closed.  At this point, the read() of the pipe
will get a 'broken pipe' error.  This signal the parent to move on, and
return whatever status the child last provided.

Note that this status could initially be set to an error state (in case
the child die or call _exit() before calling execve()).

The only thing that could make the parent hang is if the child hang (and
never call execve() or _exit() or die...).  But the beauty is that this
is perfectly fine, because that is exactly the required behavior when
CLONE_VFORK flag is set (parent wait for the child).


This is a lot of description, but should be relatively easy and straightfor=
ward to implement.  Could this work?

There are a few examples similar to this on the Web, using pipefd, fork
and execve, for different applications.  Here, we just pass the status.

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
