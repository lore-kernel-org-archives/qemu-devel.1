Received: from eggs.gnu.org ([2001:4830:134:3::10]:40600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elsci-0000qd-Jx
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elscd-0007zB-Nm
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:41:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:54124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elscd-0007y2-HB
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:40:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elscb-0006p5-K7
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 08:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7521D2E80D4
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 08:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2018 08:30:23 -0000
From: =?utf-8?q?Rapha=C3=ABl_Hertzog?= <hertzog@debian.org>
Reply-To: Bug 1749393 <1749393@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151859702399.9461.6832978283203997178.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1749393] [NEW] sbrk() not working under qemu-user
 with a PIE-compiled binary?
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

In Debian unstable, we recently switched bash to be a PIE-compiled
binary (for hardening). Unfortunately this resulted in bash being broken
when run under qemu-user (for all target architectures, host being amd64
for me).

$ sudo chroot /srv/chroots/sid-i386/ qemu-i386-static /bin/bash
bash: xmalloc: .././shell.c:1709: cannot allocate 10 bytes (0 bytes allocat=
ed)

bash has its own malloc implementation based on sbrk():
https://git.savannah.gnu.org/cgit/bash.git/tree/lib/malloc/malloc.c

When we disable this internal implementation and rely on glibc's malloc,
then everything is fine. But it might be that glibc has a fallback when
sbrk() is not working properly and it might hide the underlying problem
in qemu-user.

This issue has also been reported to the bash upstream author and he sugges=
ted that the issue might be in qemu-user so I'm opening a ticket here. Here=
's the discussion with the bash upstream author:
https://lists.gnu.org/archive/html/bug-bash/2018-02/threads.html#00080

You can find the problematic bash binary in that .deb file:
http://snapshot.debian.org/archive/debian/20180206T154716Z/pool/main/b/bash=
/bash_4.4.18-1_i386.deb

The version of qemu I have been using is 2.11 (Debian package qemu-user-
static version 1:2.11+dfsg-1) but I have had reports that the problem is
reproducible with older versions (back to 2.8 at least).

Here are the related Debian bug reports:
https://bugs.debian.org/889869
https://bugs.debian.org/865599

It's worth noting that bash used to have this problem (when compiled as a P=
IE binary) even when run directly but then something got fixed in the kerne=
l and now the problem only appears when run under qemu-user:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1518483

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1749393

Title:
  sbrk() not working under qemu-user with a PIE-compiled binary?

Status in QEMU:
  New

Bug description:
  In Debian unstable, we recently switched bash to be a PIE-compiled
  binary (for hardening). Unfortunately this resulted in bash being
  broken when run under qemu-user (for all target architectures, host
  being amd64 for me).

  $ sudo chroot /srv/chroots/sid-i386/ qemu-i386-static /bin/bash
  bash: xmalloc: .././shell.c:1709: cannot allocate 10 bytes (0 bytes alloc=
ated)

  bash has its own malloc implementation based on sbrk():
  https://git.savannah.gnu.org/cgit/bash.git/tree/lib/malloc/malloc.c

  When we disable this internal implementation and rely on glibc's
  malloc, then everything is fine. But it might be that glibc has a
  fallback when sbrk() is not working properly and it might hide the
  underlying problem in qemu-user.

  This issue has also been reported to the bash upstream author and he sugg=
ested that the issue might be in qemu-user so I'm opening a ticket here. He=
re's the discussion with the bash upstream author:
  https://lists.gnu.org/archive/html/bug-bash/2018-02/threads.html#00080

  You can find the problematic bash binary in that .deb file:
  http://snapshot.debian.org/archive/debian/20180206T154716Z/pool/main/b/ba=
sh/bash_4.4.18-1_i386.deb

  The version of qemu I have been using is 2.11 (Debian package qemu-
  user-static version 1:2.11+dfsg-1) but I have had reports that the
  problem is reproducible with older versions (back to 2.8 at least).

  Here are the related Debian bug reports:
  https://bugs.debian.org/889869
  https://bugs.debian.org/865599

  It's worth noting that bash used to have this problem (when compiled as a=
 PIE binary) even when run directly but then something got fixed in the ker=
nel and now the problem only appears when run under qemu-user:
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1518483

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1749393/+subscriptions
