Received: from eggs.gnu.org ([2001:4830:134:3::10]:55367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKZ-00038J-HQ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKW-000107-94
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:11 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKW-0000zU-0V
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:08 -0400
Received: by mail-wm0-x22a.google.com with SMTP id h20-v6so2211706wmb.4
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:04:55 +0100
Message-Id: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 00/10] docker on non-x86 hosts
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

Our existing support for docker is fairly x86 centric. While docker
itself has support for multiple architectures not all architectures
are equal. For example Debian only packages the widest range of
cross-compilers in it's x86 images (although for example armhf is
available on aarch64 based images).

As the binfmt support is getting more solid we always have that fall
back option and I've converted a number of the guests that way.
Unfortunately I've overloaded the meaning of DOCKER_PARTIAL_IMAGES but
I was loathed to throw in yet another magic variable without some
discussion first. I'm not sure if my current path will end up with a
maze of twisty if/else statements all subtly alike.

Thoughts?

Alex Bennée (10):
  docker: rename docker-amd64 to docker-host
  docker: change docker-image to docker-all-images target
  docker: add a placeholder for handling non-x86 hosts
  docker: don't include docker-arm64-cross on aarch64 hosts
  docker: fall-back to binfmt_misc debian-mips64el-user-cross on non-x86
  docker: fall-back to binfmt_misc debian-ppc64el-user-cross on non-x86
  docker: fall-back to binfmt_misc debian-s390x-user-cross on non-x86
  docker: disable additional non-x86 images
  tests: tcg skip docker images we can't build
  tests/tcg: debian-mips64el-user-cross fallback

 Makefile                                      |  4 +-
 tests/docker/Makefile.include                 | 58 +++++++++++++++++--
 ...debian-amd64.docker => debian-host.docker} |  4 +-
 .../debian-mips64el-user-cross.docker         | 16 +++++
 .../debian-ppc64el-user-cross.docker          | 16 +++++
 .../debian-s390x-user-cross.docker            | 16 +++++
 tests/tcg/Makefile.include                    |  3 +
 tests/tcg/Makefile.probe                      |  2 +-
 tests/tcg/mips/Makefile.include               |  5 ++
 9 files changed, 116 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{debian-amd64.docker => debian-host.docker} (91%)
 create mode 100644 tests/docker/dockerfiles/debian-mips64el-user-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-ppc64el-user-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-s390x-user-cross.docker

-- 
2.17.1
