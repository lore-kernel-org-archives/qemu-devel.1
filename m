Received: from eggs.gnu.org ([2001:4830:134:3::10]:59637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2weK-00071F-Mi
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2weH-0001jE-HL
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:25:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2weH-0001iJ-6u
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:25:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  2 Apr 2018 12:24:51 +0200
Message-Id: <20180402102453.9883-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: fix sparc32plus emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

The sparc signal emulation is broken:
sparc has a special field called ka_restorer and to be used
in place of sa_restorer. Without it, the signal handler
exits and executes unexpected instructions.
(sparc64 has the same kind of problem but this change
doesn't fix it)

Once this problem is fixed, we can chroot in a shell and
execute "ls". And "ls" fails to read directory content
because flags of open() are not translated correctly.
To fix that, the second patch defines the good sparc
value for TARGET___O_TMPFILE.

Laurent Vivier (2):
  linux-user: define TARGET_ARCH_HAS_KA_RESTORER
  linux-user: fix TARGET___O_TMPFILE for sparc

 linux-user/signal.c       | 4 ++--
 linux-user/syscall.c      | 7 +++++--
 linux-user/syscall_defs.h | 5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.14.3
