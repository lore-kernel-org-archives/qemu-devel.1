Received: from eggs.gnu.org ([209.51.188.92]:52198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn22A-0003c8-Db
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn221-0000g5-QI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn21x-0000Wy-O1
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id s12so10415055wrt.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:03 +0000
Message-Id: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 00/14] testing/next (binfmt_misc,
 vm-build and BSD CI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the current state of my testing/next branch. It contains a
collection of various fixes from people including a new CI file for
testing BSD's. I've also borrowed Paolo's docker tweak to the centos7
image which I can drop if it gets merged in the meantime.

I've made a number of tweaks to docker.py which make the handling of
binfmt_misc less magical (including skipping copying the binary if
persistent mapping is being used).

The vm-build changes are mainly to improve granularity for testing so
you can run something like:

  make vm-build-all TARGET_LIST=aarch64-softmmu BUILD_TARGET=check-softfloat

to pick a random example ;-)

OpenBSD still seems a bit broken though.

There is also an attempt to run 32 bit workloads through KVM. However
while all x86_64 machines can run 32bit guests (as far as I'm aware)
it is not quite so simple for ARM. There are for example aarch64 chips
that can't run aarch32 guests. Maybe basevm.py should instead use
--accel kvm:tcg rather than replicating the probing that QEMU can do
itself?

The following patches need review:

  : patch 0006/tests make docker.py update use configured binfmt.patch
  : patch 0007/tests make docker.py check for persistent configs.patch
  : patch 0008/tests docker.py be even smarter with persistent b.patch
  : patch 0009/tests PEP8 cleanup of docker.py mostly white spac.patch
  : patch 0011/tests vm call make check directly for netbsd free.patch
  : patch 0012/tests vm add build target option.patch
  : patch 0013/tests vm expose BUILD_TARGET TARGET_LIST and EXTR.patch
  : patch 0014/scripts qemu.py allow arches use KVM for their 32.patch

Alex Bennée (8):
  tests: make docker.py update use configured binfmt path
  tests: make docker.py check for persistent configs
  tests: docker.py be even smarter with persistent binfmt_misc
  tests: PEP8 cleanup of docker.py, mostly white space
  tests/vm: call make check directly for netbsd/freebsd/ubuntu.i386
  tests/vm: add --build-target option
  tests/vm: expose BUILD_TARGET, TARGET_LIST and EXTRA_CONFIGURE_OPTS
  scripts/qemu.py: allow arches use KVM for their 32bit cousins

Daniel P. Berrangé (1):
  travis: stop requesting libffi & gettext from homebrew

Ed Maste (1):
  .cirrus.yml: basic compile and test for FreeBSD

Gerd Hoffmann (1):
  tests/vm: move images to $HOME/.cache/qemu-vm/images

Paolo Bonzini (1):
  docker: disable Xen on CentOS 7

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Add an entry for scripts/archive-source.sh
  archive-source.sh: Clone the submodules locally

 .cirrus.yml                             |  16 ++++
 .travis.yml                             |   2 -
 MAINTAINERS                             |   9 ++
 scripts/archive-source.sh               |   9 +-
 scripts/qemu.py                         |  11 ++-
 tests/docker/docker.py                  | 110 +++++++++++++++++-------
 tests/docker/dockerfiles/centos7.docker |   5 +-
 tests/vm/Makefile.include               |  22 +++--
 tests/vm/basevm.py                      |   3 +
 tests/vm/freebsd                        |   3 +-
 tests/vm/netbsd                         |   3 +-
 tests/vm/ubuntu.i386                    |   3 +-
 12 files changed, 144 insertions(+), 52 deletions(-)
 create mode 100644 .cirrus.yml

-- 
2.17.1
