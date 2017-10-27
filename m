Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e89FS-0007vJ-3q
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e89FN-0006rg-7t
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:20:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e89FN-0006rI-1P
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:20:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e89FM-00064V-1J
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 18:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1B5F2E80CB
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 18:20:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 18:09:20 -0000
From: Thomas Moschny <1728116@bugs.launchpad.net>
Reply-To: Bug 1728116 <1728116@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150912776103.20350.959452179379767829.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728116] [NEW] Empty /proc/self/auxv (linux-user)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The userspace Linux API virtualization used to fake access to
/proc/self/auxv, to provide meaningful data for the guest process.

For newer qemu versions, this fails: The openat() is intercepted, but
there's no content: /proc/self/auxv has length zero (i.e. reading from
it returns 0 bytes).

Good:

$ x86_64-linux-user/qemu-x86_64 /usr/bin/cat /proc/self/auxv | wc -c
256 /proc/self/auxv

Bad:

$ x86_64-linux-user/qemu-x86_64 /usr/bin/cat /proc/self/auxv | wc -c
0 /proc/self/auxv

This worked in 2.7.1, and fails in 2.10.1.

This causes e.g. any procps-ng-based tool to segfault while reading from
/proc/self/auxv in an endless loop (probably worth another bug
report...)

Doing a "git bisect" shows that this commit:
https://github.com/qemu/qemu/commit/7c4ee5bcc introduced the problem.

It might be a simple logic (subtraction in the wrong direction?) or
sign-ness error: Adding some logging (to v2.10.1)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a..49285f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7469,6 +7469,9 @@ static int open_self_auxv(void *cpu_env, int fd)
     abi_ulong len =3D ts->info->auxv_len;
     char *ptr;
 =

+    gemu_log(TARGET_ABI_FMT_lu"\n", len);
+    gemu_log(TARGET_ABI_FMT_ld"\n", len);
+
     /*
      * Auxiliary vector is stored in target process stack.
      * read in whole auxv vector and copy it to file

shows this output:

$  x86_64-linux-user/qemu-x86_64 /usr/bin/cat /proc/self/auxv | wc -c
18446744073709551264
-352
0

And 352 could be the expected length.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728116

Title:
  Empty /proc/self/auxv (linux-user)

Status in QEMU:
  New

Bug description:
  The userspace Linux API virtualization used to fake access to
  /proc/self/auxv, to provide meaningful data for the guest process.

  For newer qemu versions, this fails: The openat() is intercepted, but
  there's no content: /proc/self/auxv has length zero (i.e. reading from
  it returns 0 bytes).

  Good:

  $ x86_64-linux-user/qemu-x86_64 /usr/bin/cat /proc/self/auxv | wc -c
  256 /proc/self/auxv

  Bad:

  $ x86_64-linux-user/qemu-x86_64 /usr/bin/cat /proc/self/auxv | wc -c
  0 /proc/self/auxv

  This worked in 2.7.1, and fails in 2.10.1.

  This causes e.g. any procps-ng-based tool to segfault while reading
  from /proc/self/auxv in an endless loop (probably worth another bug
  report...)

  Doing a "git bisect" shows that this commit:
  https://github.com/qemu/qemu/commit/7c4ee5bcc introduced the problem.

  It might be a simple logic (subtraction in the wrong direction?) or
  sign-ness error: Adding some logging (to v2.10.1)

  diff --git a/linux-user/syscall.c b/linux-user/syscall.c
  index 9b6364a..49285f9 100644
  --- a/linux-user/syscall.c
  +++ b/linux-user/syscall.c
  @@ -7469,6 +7469,9 @@ static int open_self_auxv(void *cpu_env, int fd)
       abi_ulong len =3D ts->info->auxv_len;
       char *ptr;
   =

  +    gemu_log(TARGET_ABI_FMT_lu"\n", len);
  +    gemu_log(TARGET_ABI_FMT_ld"\n", len);
  +
       /*
        * Auxiliary vector is stored in target process stack.
        * read in whole auxv vector and copy it to file

  shows this output:

  $  x86_64-linux-user/qemu-x86_64 /usr/bin/cat /proc/self/auxv | wc -c
  18446744073709551264
  -352
  0

  And 352 could be the expected length.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728116/+subscriptions
