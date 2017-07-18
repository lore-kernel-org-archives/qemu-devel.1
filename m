Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGR7-0000WH-FC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGR3-0004lr-BA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:25 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:35053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGR3-0004lb-6Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:21 -0400
Received: by mail-qk0-x234.google.com with SMTP id p73so4514139qka.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:32:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:28 -0300
Message-Id: <20170718003159.10200-1-f4bug@amsat.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/31] Updated Travis Queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

a bit late, but in case you can take some for 2.10:

v2:
- cleanup few packages (to improve image caching)
- dropped mipsEL and keep mipsEB image (32-bit big endian)
- add mips64EL (64-bit little endian)
- add mingw32 and mingw64 targets (shared libs, could be static)
- add debian Ports image [can be dropped, use as base for SH4 for 2.11]

Regards,

Phil.

On 07/17/2017 11:48 AM, Alex Bennée wrote:
> Hi,
> 
> This is the current status of the travis/next patch queue. The
> includes updates from Paolo to allow parallelism while testing in the
> docker environment. I've extended the travis image so we can actually
> run our travis.py script in the Travis image.
> 
> There are also a number of updates from Phillipe which add a bunch of
> additional cross compile targets to our shippable setup. The cachinfo
> patch is temporary and won't make the pull as it is already queued in
> Richard's tcg-next.
> 
> I'm currently trying to catch one of our Travis hangs in the act
> (postcopy-test) but it seems to be very much a heavy load race
> condition which annoyingly stops happening once you try and get
> debugging tools on it. This is the reason I've updated the travis
> docker image to include the debug tools;-)
> 
> As long as there are no screams of outrage I'll roll a pullreq for
> softfreeze tomorrow.
> 
> Alex.

Alex Bennée (3):
  docker: include python-yaml in travis.docker
  docker: add debug tools to travis.docker
  docker: add debian/powerpc based on Jessie

Paolo Bonzini (2):
  docker: allow customizing Travis global_env variables
  travis: move make -j flag out of script

Philippe Mathieu-Daudé (26):
  docker: rename debian stable -> 9 (Stretch)
  docker: add common packages to debian base
  docker: debian/s390x no more in unstable, now available in Stretch
  docker: remove packages now dependent of qemu in Stretch
  docker: optimize debian9 base image
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
  util/cacheinfo: add missing include
  docker: add qemu:debian-jessie based on outdated jessie release
  docker: add 'apt-fake' script which generate fake debian packages
  shippable: add powerpc target
  docker: add debian/mips[eb] images
  shippable: use debian/mips[eb] targets
  docker: add debian/mips64el image
  shippable: add mips64el targets
  docker: add MXE (M cross environment) base image for MinGW-w64
  shippable: add win32/64 targets
  docker: add debian Ports base image

 .shippable.yml                                     | 19 +++++++--
 .travis.yml                                        |  3 +-
 tests/docker/Makefile.include                      | 17 ++++++--
 tests/docker/dockerfiles/debian-amd64.docker       | 39 ++++++++++++++++++
 tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
 tests/docker/dockerfiles/debian-arm64-cross.docker | 10 ++---
 tests/docker/dockerfiles/debian-armel-cross.docker | 24 +++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker |  7 +---
 tests/docker/dockerfiles/debian-mips-cross.docker  | 29 ++++++++++++++
 .../dockerfiles/debian-mips64el-cross.docker       | 30 ++++++++++++++
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 16 ++++----
 tests/docker/dockerfiles/debian-ports.docker       | 34 ++++++++++++++++
 .../docker/dockerfiles/debian-powerpc-cross.docker | 40 +++++++++++++++++++
 .../docker/dockerfiles/debian-ppc64el-cross.docker | 25 ++++++++++++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 23 +++++------
 tests/docker/dockerfiles/debian-win32-cross.docker | 32 +++++++++++++++
 tests/docker/dockerfiles/debian-win64-cross.docker | 32 +++++++++++++++
 tests/docker/dockerfiles/debian8-mxe.docker        | 18 +++++++++
 tests/docker/dockerfiles/debian8.docker            | 36 +++++++++++++++++
 .../dockerfiles/{debian.docker => debian9.docker}  | 17 ++++++--
 tests/docker/dockerfiles/travis.docker             |  2 +-
 tests/docker/travis.py                             |  6 +--
 util/cacheinfo.c                                   |  1 +
 23 files changed, 460 insertions(+), 46 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-amd64.docker
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-ports.docker
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-ppc64el-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian8-mxe.docker
 create mode 100644 tests/docker/dockerfiles/debian8.docker
 rename tests/docker/dockerfiles/{debian.docker => debian9.docker} (52%)

-- 
2.13.2
