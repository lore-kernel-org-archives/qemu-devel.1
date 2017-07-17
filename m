Received: from eggs.gnu.org ([2001:4830:134:3::10]:36798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KS-0005rP-G6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KN-00021J-Sl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:56 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KN-00020Z-KK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:51 -0400
Received: by mail-wr0-x22d.google.com with SMTP id w4so23879672wrb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:48:51 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:25 +0100
Message-Id: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 00/23] Current Travis Queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the current status of the travis/next patch queue. The
includes updates from Paolo to allow parallelism while testing in the
docker environment. I've extended the travis image so we can actually
run our travis.py script in the Travis image.

There are also a number of updates from Phillipe which add a bunch of
additional cross compile targets to our shippable setup. The cachinfo
patch is temporary and won't make the pull as it is already queued in
Richard's tcg-next.

I'm currently trying to catch one of our Travis hangs in the act
(postcopy-test) but it seems to be very much a heavy load race
condition which annoyingly stops happening once you try and get
debugging tools on it. This is the reason I've updated the travis
docker image to include the debug tools ;-)

As long as there are no screams of outrage I'll roll a pullreq for
softfreeze tomorrow.

Alex.

Alex Bennée (3):
  docker: include python-yaml in travis.docker
  docker: add debug tools to travis.docker
  docker: add debian/powerpc based on Jessie

Paolo Bonzini (2):
  docker: allow customizing Travis global_env variables
  travis: move make -j flag out of script

Philippe Mathieu-Daudé (18):
  docker: rename debian stable -> 9 (Stretch)
  docker: add pkg-config and python-minimal packages to debian base
  docker: debian/s390x no more in unstable, now available in Stretch
  docker: remove packages now dependent of qemu in Stretch
  docker: add debian/armel based on Stretch
  docker: add debian/ppc64el based on Stretch
  docker: add debian/amd64 based on Stretch
  docker: enable virgl to extend code coverage on amd64
  docker: enable netmap to extend code coverage on amd64
  docker: enable gcrypt to extend code coverage on amd64
  docker: enable nettle to extend code coverage on arm64
  shippable: add armel targets
  shippable: add ppc64el targets
  shippable: add x86_64 targets
  util/cacheinfo: add missing include (TEMP)
  docker: add 'apt-fake' script which generate fake debian packages
  docker: add qemu:debian-jessie based on outdated jessie release
  shippable: add powerpc target

 .shippable.yml                                     |  8 ++++
 .travis.yml                                        |  3 +-
 tests/docker/Makefile.include                      | 13 ++++--
 tests/docker/dockerfiles/debian-amd64.docker       | 39 ++++++++++++++++++
 tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
 tests/docker/dockerfiles/debian-arm64-cross.docker | 10 ++---
 tests/docker/dockerfiles/debian-armel-cross.docker | 24 +++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker |  7 +---
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  7 +---
 .../docker/dockerfiles/debian-powerpc-cross.docker | 40 +++++++++++++++++++
 .../docker/dockerfiles/debian-ppc64el-cross.docker | 24 +++++++++++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 23 +++++------
 tests/docker/dockerfiles/debian8.docker            | 31 +++++++++++++++
 .../dockerfiles/{debian.docker => debian9.docker}  | 15 +++++--
 tests/docker/dockerfiles/travis.docker             |  2 +-
 tests/docker/travis.py                             |  6 +--
 util/cacheinfo.c                                   |  1 +
 17 files changed, 259 insertions(+), 40 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-amd64.docker
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-ppc64el-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian8.docker
 rename tests/docker/dockerfiles/{debian.docker => debian9.docker} (59%)

-- 
2.13.0
