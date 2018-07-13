Received: from eggs.gnu.org ([2001:4830:134:3::10]:57205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx19-0004lO-Iz
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx16-0003aW-D2
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdx16-0003ZM-4p
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id g6-v6so16012554wrp.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:17:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:25 +0100
Message-Id: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 00/16] various docker fixes
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

Unfortunately this series grew a little while I was re-basing as I
noticed a couple of bugs. An upstream change in debootstrap which I'd
been happily using for Ubuntu images caused a breakage which I've
hopefully now fixed:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=903657

However since I upgraded by devbox I hadn't clocked to the fact I
should have been using the stable debootstrap anyway but our ugly
shell version check failed to pick it up. That's now fixed and I can
now bootstrap away.

I grabbed a couple of Philippe's patches while I was at it as they
were relevant to the other changes. It does mean the un-reviewed count
has gone up slightly:

  patch docker/base debian tricore on qemu debian9.patch
  patch docker/split configure_qemu from build_qemu.patch
  patch docker/move make check into check_qemu helper.patch
  patch docker/gracefully skip check_qemu.patch
  patch docker/Makefile.include don t include partial images.patch
  patch docker/disable debian powerpc user cross.patch
  patch docker/add test unit runner.patch
  patch docker/add expansion for docker test FOO to Makefile.patch
  patch docker/drop QEMU_TARGET check fallback in EXECUTABLE.patch
  patch docker/add hint to docker.py check.patch
  patch docker/add commentary to debian bootstrap.docker.patch
  patch docker/ignore distro versioning of debootstrap.patch


Alex Bennée (14):
  tests/.gitignore: don't ignore docker tests
  docker: base debian-tricore on qemu:debian9
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

Philippe Mathieu-Daudé (2):
  shippable: Build the TriCore docker image
  docker: Update debootstrap script after Debian migration from Alioth
    to Salsa

 .shippable.yml                                |  2 ++
 tests/.gitignore                              |  1 +
 tests/docker/Makefile.include                 | 26 ++++++++++++-------
 tests/docker/common.rc                        | 23 +++++++++++++++-
 tests/docker/docker.py                        | 10 +++++--
 .../dockerfiles/debian-bootstrap.docker       |  1 +
 tests/docker/dockerfiles/debian-bootstrap.pre | 13 ++++++----
 .../dockerfiles/debian-tricore-cross.docker   |  2 +-
 tests/docker/test-clang                       |  2 +-
 tests/docker/test-debug                       |  2 +-
 tests/docker/test-full                        |  2 +-
 tests/docker/test-quick                       |  2 +-
 tests/docker/test-unit                        | 21 +++++++++++++++
 13 files changed, 85 insertions(+), 22 deletions(-)
 create mode 100755 tests/docker/test-unit

-- 
2.17.1
