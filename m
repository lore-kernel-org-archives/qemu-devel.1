Received: from eggs.gnu.org ([2001:4830:134:3::10]:56258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlx6-0006K8-IV
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlx5-0006r6-MY
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:00 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlx5-0006p8-Fx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:30:59 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Wed, 20 Dec 2017 22:23:01 +0100
Message-Id: <20171220212308.12614-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH v3 0/7]  Add aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Hello,

below patches add support for big-endian aarch64 to linux-user. Almost
everything is already in place. The patches just set up the CPU flags as
required for big-endianness, add a distinction in uname and make sure the
instructions for the signal trampoline end up in memory little-endian.
Finally, configure is extended to allow building of a
aarch64_be-linux-user target and scripts/qemu-binfmt-conf.sh to include
the binfmt magic for aarch64_be ELF files.

While at it, scripts/qemu-binfmt-conf.sh is changed again to separate
arm/aarch64 targets of differing endianness into separate families so
that the binfmt handler for the respective other endianness is indeed
registered.  Also, while not strictly relevant to aarch64 support, armeb
is actually added to the list of targets, binfmt handlers should
registered for.

With this I am able to run individual aarch64_be binaries as well as
chroot into a full-blown aarch64_be userland using binfmt_misc, running
and compiling things (Gentoo crossdev/native).

v3:
- drop changes to aarch64 host support from configure
- add binfmt arm CPU family separation
- add armeb to binfmt handler targets

v2:
- add binfmt magic to qemu-binfmt-conf.sh
- fix style problems (tab indenting)

Thanks,
Michael


Michael Weiser (7):
  linux-user: Add support for big-endian aarch64
  linux-user: Add separate aarch64_be uname
  linux-user: Fix endianess of aarch64 signal trampoline
  configure: Add aarch64_be-linux-user target
  linux-user: Add aarch64_be magic numbers to qemu-binfmt-conf.sh
  linux-user: Separate binfmt arm CPU families
  linux-user: Activate armeb handler registration

 configure                                 |  5 +++--
 default-configs/aarch64_be-linux-user.mak |  1 +
 linux-user/aarch64/target_syscall.h       |  4 ++++
 linux-user/main.c                         |  6 ++++++
 linux-user/signal.c                       | 10 +++++++---
 scripts/qemu-binfmt-conf.sh               | 15 +++++++++++----
 6 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 default-configs/aarch64_be-linux-user.mak

-- 
2.15.1
