Received: from eggs.gnu.org ([2001:4830:134:3::10]:54272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzqV-0005Lw-Lg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzqS-0000Q8-Fr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:27 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:55013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZzqS-0000Pp-5E
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:24 -0400
Received: by mail-wm0-x231.google.com with SMTP id i139-v6so9260215wmf.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:30:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  2 Jul 2018 15:30:01 +0100
Message-Id: <20180702143021.18864-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/20] Travis,
 Code Coverage and Cross Build updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Friday's code dump suffered a little from a rushed posting before the
weekend so I spent this morning cleaning up a few of the rough edges.
This version is much better for it:

  - Dropped .shippable changes

In the end it looks like building the ppc image won't work in
QEMU as it's pre-ci environment hasn't enough in it to build the
qemu-ppc linux user we need.

  - Better boostrap rule naming

The rule is now docker-binfmt-image-debian-% which means you can now
build any arbitrarily named debian-% image. If we are going support
similar binfmt bootstrapping for other distributions I suggest we
follow a similar scheme. Does anyone know if anything as funky as
debootstrap exists for anything else?

With a minor tweak to the debootstrap helper script you can now
boostrap Ubuntu images as well.

  - Dropped docker.py env hack (not needed)
  - Removed stray whitespace changes

The rest works as I outlined in the v2 message:

  I've picked up some more of Philippe's fixes and in the process had
  another look at the problem of cross compiling powerpc. In the end the
  consensus seems to be a linux-user build was the best solution as
  there are still supported native powerpc toolchains in Jessie (until
  2020). So I dusted off my old linux-user patches and tries to plumb
  them in a little better. Assuming you have ppc-linux-user in your
  target list and it's a --static you can just run:

    docker-test-build@debian-powerpc-user-cross TARGET_LIST=ppc-softmmu

  And it does the right thing. Once the debian-powerpc-user base image
  is created you can change your configuration and things will still
  work (until the debian-bootstrap recipe is changed and needs to be
  re-built).

It would be great if I could get reviews for the final few patches:

  patch 0011/docker filter out linux user builds for mingw.patch
  patch 0016/docker drop QEMU build dep from bootstrap.patch
  patch 0017/docker debian bootstrap.pre allow customising of .patch
  patch 0018/docker add special handling for FROM debian user .patch
  patch 0019/docker add special rule for deboostrapped images.patch
  patch 0020/docker add linux user powered cross builder for Q.patch

I'll send a pull request tomorrow for soft-freeze.

Alex Bennée (14):
  build-system: remove per-test GCOV reporting
  .gitignore: add .gcov files
  docker: add gcovr to travis image
  travis: add gcovr summary for GCOV build
  build-system: add clean-coverage target
  build-system: add coverage-report target
  linux-user: introduce preexit_cleanup
  linux-user: add gcov support to preexit_cleanup
  docker: filter out linux-user builds for mingw
  docker: drop QEMU build-dep from bootstrap
  docker: debian-bootstrap.pre allow customising of variant/url
  docker: add special handling for FROM:debian-%-user targets
  docker: add special rule for deboostrapped images
  docker: add linux-user powered cross builder for QEMU

Philippe Mathieu-Daudé (6):
  travis: do not waste time cloning unused submodules
  travis: test out-of-tree builds
  docker: ubuntu: Update the package list before installing new ones
  docker: ubuntu: Use SDL2
  docker: Clean the MXE base image
  docker: Do not run tests in 'intermediate' images

 .gitignore                                    |  1 +
 .travis.yml                                   | 14 +++-
 MAINTAINERS                                   |  1 +
 Makefile                                      | 24 +++++++
 docs/devel/testing.rst                        | 21 ++++--
 linux-user/Makefile.objs                      |  2 +-
 linux-user/exit.c                             | 35 ++++++++++
 linux-user/qemu.h                             |  8 +++
 linux-user/syscall.c                          | 10 +--
 scripts/travis/coverage-summary.sh            | 27 +++++++
 tests/Makefile.include                        | 10 ---
 tests/docker/Makefile.include                 | 70 +++++++++++++++++--
 tests/docker/docker.py                        |  4 ++
 .../dockerfiles/debian-bootstrap.docker       |  2 -
 tests/docker/dockerfiles/debian-bootstrap.pre | 11 ++-
 .../debian-powerpc-user-cross.docker          | 13 ++++
 tests/docker/dockerfiles/debian8-mxe.docker   |  2 +-
 tests/docker/dockerfiles/travis.docker        |  2 +-
 tests/docker/dockerfiles/ubuntu.docker        |  8 +--
 19 files changed, 222 insertions(+), 43 deletions(-)
 create mode 100644 linux-user/exit.c
 create mode 100755 scripts/travis/coverage-summary.sh
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

-- 
2.17.1
