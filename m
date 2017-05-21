Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZV-0001Jp-Su
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZS-0007BP-Nt
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:21 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:35538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZS-0007B8-HU
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:18 -0400
Received: by mail-oi0-x229.google.com with SMTP id l18so129363108oig.2
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 20:30:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 21 May 2017 00:29:32 -0300
Message-Id: <20170521032956.27446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/24] docker/shippable: cross-build mipsel
 and powerpc targets
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

There is still some issue trying to cross-build mips64el-softmmu, it seems the
cross tools use the system outdated libfdt instead of the one checkouted in the
dtc submodule. I disabled this target for now.

The branch https://github.com/philmd/qemu/tree/docker_shippable_v3 can be
checked at Shippable:
  https://app.shippable.com/github/philmd/qemu/status/dashboard

Each arch builds in around ~9min. Using Shippable free open source projects
service, the 5 jobs take ~38-44min in total.

v3:
- Addressed review feedbacks from Fam:
- Keep building images in various layers, but use DEBIAN_FRONTEND=noninteractive
- Document '--extra-files', now it supports adding various files at once
- Checksum extra files to trigger a docker image rebuild if modified
- Use better regex to generate deb-src entries
- Reordered extra libs, to ease further add/remove diffs

v2:
- Addressed review feedback from Alex, added his R-B
- Fixed the "Problem with the SSL CA cert" problem while cloning from github.com
  installing the ca-certificates package.
- Squashed/split some commits
- use 'apt-get clean' instead of brutal 'rm -rf'
- checked how many cores are available on Shippable and use them fully
  (reduced total time from 44min to 38min)
- build armeb-linux-user target

v1:
- Reorganize Dockerfiles to use less layers, resulting in smaller images.
  This also reduce time of image transfer, for example while using:
  `docker save qemu:debian | ssh remote docker load`
- Install more debian packages so the configure script enable more features and
  more code can be compiled/covered.
- There are still some incorrect multiarch packages on debian/jessie used in
  the docker images, add a script to generate fake packages and avoid
  dependencies issues.
- Modify the docker.py script to include an extra file while building images.

Regards,

Phil.

Philippe Mathieu-Daudé (24):
  docker: let _copy_with_mkdir() sub_path argument be optional
  docker: add --include-files argument to 'build' command
  docker: rebuild image if 'extra files' checksum does not match
  docker: add 'apt-fake' script which generate fake debian packages
  docker: install ca-certificates package in base image
  docker: create deb-src entry and setup Emdebian in the same layer
  docker: use better regex to generate deb-src entries
  docker: use eatmydata, install common build packages in base image
  docker: use eatmydata in debian armhf image
  docker: use eatmydata in debian arm64 image
  docker: add extra libs to armhf target to extend codebase coverage
  docker: add extra libs to arm64 target to extend codebase coverage
  docker: add extra libs to s390x target to extend codebase coverage
  docker: add mipsel build target
  docker: add powerpc build target
  shippable: use C locale to simplify console output
  shippable: build using all available cpus
  shippable: do not initialize submodules automatically
  shippable: be verbose while building docker images
  shippable: add armeb-linux-user target
  shippable: add powerpc target
  shippable: add mipsel target
  MAINTAINERS: add Shippable automation platform URL
  MAINTAINERS: self-appoint me as reviewer in build/test automation

 .shippable.yml                                     | 23 +++++++++--
 MAINTAINERS                                        |  2 +
 tests/docker/Makefile.include                      |  8 +++-
 tests/docker/docker.py                             | 29 ++++++++++----
 tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
 tests/docker/dockerfiles/debian-arm64-cross.docker | 18 ++++++++-
 tests/docker/dockerfiles/debian-armhf-cross.docker | 18 ++++++++-
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 41 +++++++++++++++++++
 .../docker/dockerfiles/debian-powerpc-cross.docker | 40 +++++++++++++++++++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 10 +++++
 tests/docker/dockerfiles/debian.docker             | 18 +++++----
 11 files changed, 230 insertions(+), 23 deletions(-)
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker

-- 
2.11.0
