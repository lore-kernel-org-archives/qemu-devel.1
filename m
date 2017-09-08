Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPX-0005vY-BV
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPS-0000Ij-Jw
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPS-0000Hr-EM
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:53 +0800
Message-Id: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/7] Proof of concept to power up "make
 test" with docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

Recently it was brought up that "make test" is in an orphaned state, and making
it work would be a good thing because it has valuable test coverage for tcg:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04978.html

This RFC is an attempt to use docker to cross build the test binaries that will
be run by qemu-user and meanwhile rename it from "make test" to "make
check-tcg" to align with the naming convention of other test targets we have.

As the initial version only i386 is converted, not because it's easy, but
because it is a test set that covers the most types of rules we will need
(cross-build, run and compare result).

After these patches, "make check-tcg" will do the i386 tests with the new
rules first (which fails but that's out of the scope of this series), then
continue to do the old "make -C tests/tcg test" command. Once all tests are
moved into the new Makefile.include file, the old Makefile can be dropped.

Fam Zheng (7):
  Makefile: Rename TARGET_DIRS to TARGET_LIST
  docker: Add "cc" subcommand
  docker: Add fedora-i386-cross image
  tests: Build fix for hello-i386
  tests: Build fix for linux-test
  buildsys: Add "check-tcg" target
  tests: Move i386 tcg tests to check-tcg

 Makefile                                          | 21 ++++---
 configure                                         |  2 +-
 scripts/create_config                             |  2 +-
 tests/Makefile.include                            |  3 +-
 tests/docker/docker.py                            | 23 +++++++
 tests/docker/dockerfiles/fedora-i386-cross.docker | 13 ++++
 tests/tcg/Makefile                                | 60 ------------------
 tests/tcg/Makefile.include                        | 75 +++++++++++++++++++++++
 tests/tcg/hello-i386.c                            |  1 +
 tests/tcg/linux-test.c                            | 67 +++++++-------------
 10 files changed, 149 insertions(+), 118 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
 create mode 100644 tests/tcg/Makefile.include

-- 
2.13.5
