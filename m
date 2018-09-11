Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJP-0008Qm-Ko
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJK-0007VE-IN
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:39 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzjJK-0007Sc-1J
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:34 -0400
Received: by mail-wm0-x243.google.com with SMTP id y2-v6so1152755wma.1
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:06:33 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Sep 2018 15:06:27 +0100
Message-Id: <20180911140631.18481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/4] Add Nios II cross-compiler and enable
 tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

tl;dr Nios II linux-user seems pretty broken

Following up on some mailing list queries about the state of Nios II
Thomas pointed out that buildroot could build cross-compilers for the
architecture. As a quick experiment I've enabled a docker based
buildroot and turned on tests/tcg for it.

The results are not very encouraging as both linux-test and test-mmap
fail although (impressively?) testthread passes.

The test-mmap failure looks like some sort of argument mangling
failure as arg6 of target_mmap looks negative/big and hence causes the
mmap to fail. I tried messing with the #ifdef mangling logic in
do_syscall1 but failed to get it working.

The linux-test failure seems like a missing lseek system call but I
have no doubt there are others given the bug reports on list.

This series includes a hack to min uname which we can't really merge.
This is because buildroot is focused on building system images so sets
the glibc minimum kernel version to whatever it builds for the system
image. I leave the problem of programatically tuning the
qemu_nios2_10m50_defconfig to build a general purpose glibc to whoever
wants to take this forward.

As I'm not particularly interested in this architecture I don't intend
to spend any more time on this. Given how broken linux-user is I
suspect most users of QEMU's Nios 2 emulation use softmmu. If there is
interest in fixing up linux-user then the docker and test/tcg patches
can be included when the fixups are sent to the list. I would argue
that any linux-user target should at the very least pass all of
tests/tcg/multiarch - it's not super comprehensive but it's all we
have at the moment. Perhaps we should consider deprecating the
obviously less used linux-user targets?

Alex Bennée (4):
  docker: add debian-buildroot-base
  docker: add buildroot-nios2-cross image
  linux-user/nios2: bump min uname to 4.16.0 [!HACK]
  tests/tcg: add nios2 architecture (NEEDS FIXES)

 linux-user/nios2/target_syscall.h             |  2 +-
 tests/docker/Makefile.include                 |  6 ++++-
 .../dockerfiles/buildroot-nios2-cross.docker  | 10 +++++++
 .../dockerfiles/debian-buildroot-base.docker  | 26 +++++++++++++++++++
 tests/tcg/nios2/Makefile.include              |  2 ++
 5 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/buildroot-nios2-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-buildroot-base.docker
 create mode 100644 tests/tcg/nios2/Makefile.include

-- 
2.17.1
