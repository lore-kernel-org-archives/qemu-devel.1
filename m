Received: from eggs.gnu.org ([2001:4830:134:3::10]:36706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ajv-00038d-QP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ajr-0007af-O7
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:43 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ajr-0007aZ-Jm
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:39 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so8680372qkh.0
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:57:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:56:52 -0300
Message-Id: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/23] docker/shippable: cross-build mipsel and
 powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This patchset add 2 more architectures to the cross-build farm.

- Reorganize Dockerfiles to use less layers, resulting in smaller images.
  This also reduce time of image transfer, for example while using:
  `docker save qemu:debian | ssh remote docker load`
- Install more debian packages so the configure script enable more features and
  more code can be compiled/covered.
- There are still some incorrect multiarch packages on debian/jessie used in
  the docker images, add a script to generate fake packages and avoid
  dependencies issues.
- Modify the docker.py script to include an extra file while building images.

There is still some issue trying to cross-build mips64el-softmmu, it seems the
cross tools use the system outdated libfdt instead of the one checkouted in the
dtc submodule. I disabled this target for now.

I had some issues in some jobs, git reporting "Problem with the SSL CA cert"
trying to clone from github.com. I enabled GIT_CURL_VERBOSE but didn't want to
spend more time on this right now so I disabled the verification by setting
GIT_SSL_NO_VERIFY. Since we use Shippable services to compile the codebase and
not to release binaries it seemed Ok to me.

The branch https://github.com/philmd/qemu/tree/docker_shippable can be checked
here at Shippable:
  https://app.shippable.com/github/philmd/qemu/status/dashboard

With the free open source projects service, each arch builds in around ~9min,
the 5 jobs take ~44min in total. It seems each docker image is rebuilt from
scratch, maybe we could save a lot pushing/pulling to a registry.

Regards,

Phil.

Philippe Mathieu-Daudé (23):
  shippable: use C locale to simplify console output
  shippable: build using all available cpus
  shippable: ignore SSL verification
  docker: compact debian base
  docker: compact debian armhf
  docker: compact debian arm64
  docker: add extra libs to armhf target to extend codebase coverage
  docker: add extra libs to arm64 target to extend codebase coverage
  docker: add extra libs to s390x target to extend codebase coverage
  docker: add mipsel build target
  shippable: add mipsel target
  docker: let _copy_with_mkdir() sub_path argument be optional
  docker: add --include-file argument to 'build' command
  docker: add 'apt-fake' script which generate fake debian packages
  docker: fix mipsel debian/stable dependencies problem
  shippable: do not initialize submodules automatically
  shippable: use dtc submodule if distrib packages are too old
  shippable: temporary disable mips64el-softmmu build
  docker: add powerpc build target
  shippable: add powerpc target
  docker: fix powerpc debian/stable dependencies problem
  MAINTAINERS: add Shippable automation platform URL
  MAINTAINERS: self-appoint me as reviewer in build/test automation

 .shippable.yml                                     | 23 ++++++++++-
 MAINTAINERS                                        |  2 +
 tests/docker/Makefile.include                      |  7 +++-
 tests/docker/docker.py                             |  7 +++-
 tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
 tests/docker/dockerfiles/debian-arm64-cross.docker | 16 ++++++--
 tests/docker/dockerfiles/debian-armhf-cross.docker | 16 ++++++--
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 30 ++++++++++++++
 .../docker/dockerfiles/debian-powerpc-cross.docker | 30 ++++++++++++++
 tests/docker/dockerfiles/debian-s390x-cross.docker |  6 +++
 tests/docker/dockerfiles/debian.docker             | 24 ++++++-----
 11 files changed, 186 insertions(+), 21 deletions(-)
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker

-- 
2.11.0
