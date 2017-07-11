Received: from eggs.gnu.org ([2001:4830:134:3::10]:54034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZz-0001Z7-Ak
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZu-0004Tj-P4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:15 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZu-0004TR-JT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:10 -0400
Received: by mail-qt0-f177.google.com with SMTP id 32so88789882qtv.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:42 -0300
Message-Id: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/18] docker/shippable: rework debian
 images, add powerpc ppc64el and amd64
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

This patchset add 3 more architectures to the cross-build farm.

Altough amd64 'cross' target sounds weird, I find it useful to cover
more codebase having libraries installed in image I don't need on my
workstation.

There is still some issue trying to cross-build mips64el-softmmu, it
seems the cross tools use the system outdated libfdt instead of the one
checkouted in the dtc submodule. I disabled this target for now.

The branch https://github.com/philmd/qemu/tree/shippable-docker-shippable_v6
can be checked at Shippable:
  https://app.shippable.com/github/philmd/qemu/runs/15/summary/console

The first time an image is built, the docker image is fully build in
~3min (cache miss). Then Shippable keeps this image cached.
Cross building QEMU takes ~6min (2 or 3 targets).
The first time a branch is pushed, each arch build will take ~9min, up
to 1h for the current 8 archs.
Subsequent pushes take less than 50min to build all archs.

v6:
- cleaning up Stretch based images
- restore powerpc image (based on debian Jessie)
- add ppc64el and amd64 images (based on debian Stretch)
- extend coverage enabling virgl/netmap/gcrypt on amd64
- extend coverage enabling nettle on arm64
- add Shippable yml filter rule to restrict branches to build

[most part of previous patchset merged in commit 469819a3e8e3]

v5:
- Addressed minor review feedback from Alex/Fam (improving a comment)
- Added Alex R-b

v4:
- Addressed review feedbacks from Fam (improving english, cleaner hashing)
- Added Alex R-b

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

Philippe Mathieu-Daudé (18):
  docker: rename debian stable -> 9 (Stretch)
  docker: add pkg-config and python-minimal packages to debian base
  docker: debian/s390x no more in unstable, now available in Stretch
  docker: remove packages now dependent of qemu in Stretch
  docker: add debian/armel based on Stretch
  docker: add debian/ppc64el based on Stretch
  docker: add debian/amd64
  docker: enable virgl coverage on amd64
  docker: enable netmap coverage on amd64
  docker: enable gcrypt coverage on amd64
  docker: enable nettle coverage on arm64
  shippable: add armel targets
  shippable: add ppc64el targets
  shippable: add x86_64 targets
  docker: add 'apt-fake' script which generate fake debian packages
  docker: add qemu:debian-jessie based on outdated jessie release
  shippable: add powerpc target
  shippable: restrict builds to master/staging and shippable* branches

 .shippable.yml                                     | 13 ++++++
 tests/docker/Makefile.include                      | 13 ++++--
 tests/docker/dockerfiles/debian-amd64-cross.docker | 38 ++++++++++++++++++
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
 13 files changed, 256 insertions(+), 35 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-amd64-cross.docker
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-ppc64el-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian8.docker
 rename tests/docker/dockerfiles/{debian.docker => debian9.docker} (59%)

-- 
2.13.2
