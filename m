Received: from eggs.gnu.org ([2001:4830:134:3::10]:37084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gT5fJ-0000EI-G5
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 08:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gT5fE-0003n2-Hp
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 08:50:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:34696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gT5fE-0003mF-CF
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 08:50:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gT5fD-0006Me-Dl
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 13:50:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 48B3D2E80CB
	for <qemu-devel@nongnu.org>; Sat,  1 Dec 2018 13:50:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Dec 2018 13:44:10 -0000
From: Kan Li <1805913@bugs.launchpad.net>
Reply-To: Bug 1805913 <1805913@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154353638253.10384.17899256838547579767.malonedeb@chaenomeles.canonical.com>
Message-Id: <154367185076.9921.17446235867573990030.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1805913] Re: readdir() returns NULL
 (errno=EOVERFLOW) for 32-bit user-static qemu on 64-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

More notes: this bug hits glibc-2.28 and later. It works on glibc-2.27.
Therefore to reproduce it it needs ubuntu 18.10 or later. Seems like it
works for 18.04.

This bug affects all Java programs that (implicitly) uses File.list() or
File.listFiles(). Also it makes dash not expanding wildcard
/some/directory/* . However, bash works because it uses glob() instead
of readdir().

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805913

Title:
  readdir() returns NULL (errno=3DEOVERFLOW) for 32-bit user-static qemu
  on 64-bit host

Status in QEMU:
  New

Bug description:
  This can be simply reproduced by compiling and running the attached C
  code (readdir-bug.c) under 32-bit user-static qemu, such as qemu-arm-
  static:

  # Setup docker for user-static binfmt
  docker run --rm --privileged multiarch/qemu-user-static:register --reset
  # Compile the code and run (readdir for / is fine, so create a new direct=
ory /test).
  docker run -v /path/to/qemu-arm-static:/usr/bin/qemu-arm-static -v /path/=
to/readdir-bug.c:/tmp/readdir-bug.c -it --rm arm32v7/ubuntu:18.10 bash -c '=
{ apt update && apt install -y gcc; } >&/dev/null && mkdir -p /test && cd /=
test && gcc /tmp/readdir-bug.c && ./a.out'
  dir=3D0xff5b4150
  readdir(dir)=3D(nil)
  errno=3D75: Value too large for defined data type

  Do remember to replace the /path/to/qemu-arm-static and /path/to
  /readdir-bug.c to the actual paths of the files.

  The root cause is in glibc:
  https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/=
linux/getdents.c;h=3D6d09a5be7057e2792be9150d3a2c7b293cf6fc34;hb=3Da5275ba5=
378c9256d18e582572b4315e8edfcbfb#l87

  By C standard, the return type of readdir() is DIR*, in which the
  inode number and offset are 32-bit integers, therefore, glibc calls
  getdents64() and check if the inode number and offset fits the 32-bit
  range, and reports EOVERFLOW if not.

  The problem here is for 32-bit user-static qemu running on 64-bit
  host, getdents64 simply passing through the inode number and offset
  from underlying getdents64 syscall (from 64-bit kernel), which is very
  likely to not fit into 32-bit range. On real hardware, the 32-bit
  kernel creates 32-bit inode numbers, therefore works properly.

  The glibc code makes sense to do the check to be conformant with C
  standard, therefore ideally it should be a fix on qemu side. I admit
  this is difficult because qemu has to maintain a mapping between
  underlying 64-bit inode numbers and 32-bit inode numbers, which would
  severely hurt the performance. I don't expect this could be fix
  anytime soon (or even there would be a fix), but it would be
  worthwhile to surface this issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805913/+subscriptions
