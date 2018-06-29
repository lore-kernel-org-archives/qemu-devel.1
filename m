Received: from eggs.gnu.org ([2001:4830:134:3::10]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nk-00083l-If
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Ng-0006IS-6f
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:40 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:51025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Nf-0006Gq-W0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:36 -0400
Received: by mail-wm0-x22e.google.com with SMTP id v25-v6so2438434wmc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:52:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:11 +0100
Message-Id: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/21] Travis,
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

I've also included a fix for the mingw builds that failed when the
default all targets TARGET_LIST got passed to the build.

I'll put together a pull-request with everything that has been
reviewed next week in time for patch bomb peter^H^H^H^H^H^H^H^H^H^H
soft-freeze ;-)

Alex Bennée (15):
  build-system: remove per-test GCOV reporting
  .gitignore: add .gcov files
  docker: add gcovr to travis image
  travis: add gcovr summary for GCOV build
  build-system: add clean-coverage target
  build-system: add coverage-report target
  linux-user: introduce preexit_cleanup
  linux-user: add gcov support to preexit_cleanup
  docker: filter out linux-user builds for mingw
  docker: add env parser to docker.py build step
  docker: drop QEMU build-dep from bootstrap
  docker: add special handling for FROM:debian-%-user targets
  docker: add special rule for deboostrapped images
  docker: add linux-user powered cross builder for QEMU
  .shippable.yml: add linux-user cross-build for ppc-softmmu

Philippe Mathieu-Daudé (6):
  travis: do not waste time cloning unused submodules
  travis: test out-of-tree builds
  docker: ubuntu: Update the package list before installing new ones
  docker: ubuntu: Use SDL2
  docker: Clean the MXE base image
  docker: Do not run tests in 'intermediate' images

 .gitignore                                    |  1 +
 .shippable.yml                                |  8 +++
 .travis.yml                                   | 14 +++-
 Makefile                                      | 24 +++++++
 docs/devel/testing.rst                        | 21 ++++--
 linux-user/Makefile.objs                      |  2 +-
 linux-user/exit.c                             | 35 +++++++++
 linux-user/qemu.h                             |  8 +++
 linux-user/syscall.c                          | 10 +--
 scripts/coverage-summary.sh                   | 27 +++++++
 tests/Makefile.include                        | 10 ---
 tests/docker/Makefile.include                 | 72 ++++++++++++++++---
 tests/docker/docker.py                        | 14 +++-
 .../dockerfiles/debian-bootstrap.docker       |  2 -
 .../debian-powerpc-user-cross.docker          | 13 ++++
 tests/docker/dockerfiles/debian8-mxe.docker   |  2 +-
 tests/docker/dockerfiles/travis.docker        |  2 +-
 tests/docker/dockerfiles/ubuntu.docker        |  8 +--
 18 files changed, 228 insertions(+), 45 deletions(-)
 create mode 100644 linux-user/exit.c
 create mode 100755 scripts/coverage-summary.sh
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

-- 
2.17.1
