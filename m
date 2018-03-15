Received: from eggs.gnu.org ([2001:4830:134:3::10]:41270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewVhu-0008WI-FP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewVhp-0001Ih-Hw
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:26:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:54660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewVhp-0001Hk-BP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:26:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewVhm-0000Qo-BP
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 16:26:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C4F982E8230
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 16:26:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 16:17:57 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1749393 <1749393@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151859702399.9461.6832978283203997178.malonedeb@chaenomeles.canonical.com>
Message-Id: <152113067774.3926.2973583726995284822.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1749393] Re: sbrk() not working under qemu-user
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

There seem to be two parts to this. Firstly, with a big reserved-region,
which is the default for 32-bit-guest-on-64-bit-host, this code in
main.c:

        if (reserved_va) {
            mmap_next_start =3D reserved_va;
        }

says to start trying for the next mmap address at the top of the
reserved section, which is typically right at the top of the guest's
address space. This means that for a PIE executable we'll try to load it
at a very high address, which then means there's no space above the data
section for the brk segment.

Secondly, for the no-reserved-region case (-R 0, or 64-on-64), we still
fail, but this time because we've chosen to mmap the dynamic interpreter
at an address just above the executable. Again, no space to expand the
data segment and brk fails.

Linux kernel commit a87938b2e246b81 message says something about there
being a guaranteed 128MB "gap" between data segment and stack on x86-64
which we're obviously not honourin; presumbably there's similar
requirements for other archs. (As an aside, is bash really happy with
only having perhaps 128MB of allocatable memory? Otherwise it really
ought to use mmap rather than brk for its allocator.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1749393

Title:
  sbrk() not working under qemu-user with a PIE-compiled binary?

Status in QEMU:
  New
Status in qemu package in Ubuntu:
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
