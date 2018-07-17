Received: from eggs.gnu.org ([2001:4830:134:3::10]:40852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4o-00031Z-0H
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4j-0004ZO-DR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4j-0004Yd-5q
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:55:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id e7-v6so2377981wrs.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:55:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:35 +0100
Message-Id: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 00/18] docker fixes (and one tcg
 test tweak)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I've missed the boat for today's rc1 but I'd like to get this merged
before rc2. The new docker.py change is technically new functionality
but I'm counting it as a usability bug fix as it replaces a random
back trace failure with a preemptive failure and message mentioning
binfmt_misc configuration. This would have saved Richard a lot of head
scratching as he tried to setup a powerpc-user setup to test his
setcontext fix (he had a custom binfmt_misc pointing to his src tree).

Finally we also drop the runcom test. It was cute that it got
resurrected but it is ultimately a pointless test for something I'm
sure no one actually uses.

There will be a follow-up RFC series after this that cleans-up some of
the rough edges when your host is not an x86_64 box but that series
won't be targeting the 3.0 release.

: The following patches need review
: patch docker/disable debian powerpc user cross.patch
: patch docker/drop QEMU_TARGET check fallback in EXECUTABLE.patch
: patch docker/Update debootstrap script after Debian migrat.patch
: patch docker/ignore distro versioning of debootstrap.patch
: patch docker/perform basic binfmt_misc validation in docke.patch
: patch tests/tcg remove runcom test.patch

Alex Bennée (17):
  tests/.gitignore: don't ignore docker tests
  docker: base debian-tricore on qemu:debian9
  docker: par down QEMU_CONFIGURE_OPTS in debian-tricore-cross
  docker: fail more gracefully on docker.py check
  docker: split configure_qemu from build_qemu
  docker: move make check into check_qemu helper
  docker: gracefully skip check_qemu
  docker: Makefile.include don't include partial images
  docker: disable debian-powerpc-user-cross
  docker: add test-unit runner
  docker: add expansion for docker-test-FOO to Makefile.include
  docker: drop QEMU_TARGET check, fallback in EXECUTABLE not set
  docker: add --hint to docker.py check
  docker: add commentary to debian-bootstrap.docker
  docker: ignore distro versioning of debootstrap
  docker: perform basic binfmt_misc validation in docker.py
  tests/tcg: remove runcom test

Philippe Mathieu-Daudé (1):
  docker: Update debootstrap script after Debian migration from Alioth
    to Salsa

 tests/.gitignore                              |   1 +
 tests/docker/Makefile.include                 |  26 ++-
 tests/docker/common.rc                        |  24 ++-
 tests/docker/docker.py                        |  40 +++-
 .../dockerfiles/debian-bootstrap.docker       |   1 +
 tests/docker/dockerfiles/debian-bootstrap.pre |  13 +-
 .../dockerfiles/debian-tricore-cross.docker   |   6 +-
 tests/docker/test-clang                       |   2 +-
 tests/docker/test-debug                       |   2 +-
 tests/docker/test-full                        |   2 +-
 tests/docker/test-quick                       |   2 +-
 tests/docker/test-unit                        |  21 ++
 tests/tcg/i386/Makefile.target                |   5 -
 tests/tcg/i386/README                         |   3 -
 tests/tcg/i386/pi_10.com                      | Bin 54 -> 0 bytes
 tests/tcg/i386/runcom.c                       | 192 ------------------
 16 files changed, 116 insertions(+), 224 deletions(-)
 create mode 100755 tests/docker/test-unit
 delete mode 100644 tests/tcg/i386/pi_10.com
 delete mode 100644 tests/tcg/i386/runcom.c

-- 
2.17.1
