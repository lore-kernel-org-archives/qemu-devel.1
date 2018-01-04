Received: from eggs.gnu.org ([2001:4830:134:3::10]:35517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX81Z-0006C9-Up
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX81W-0000OW-2D
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:05:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX81V-0008TQ-OG
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:05:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C926F2F7C3E
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:05:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:05 +0100
Message-Id: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/18] Various build-sys and sanitizer
 related fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a series that improves a bit the build system, and introduces
ASAN/UBSan by default when --enable-debug. Then it fixes a few leaks
that occur during make check: common and x86_64 target tests are leak
free after this series. The other targets will need some work to fix
the leaks & warnings.

v3:
- add ubsan too with --enable-debug, since it is recommended and has
  low runtime cost
- add a patch "compile with -Og or -O1 when --enable-debug", suggested
  by Paolo
- add 2 new fixes to pass full make check with asan/ubsan
- modify docker tests to run --enable-debug & asan with new test-debug
- add some r-b/a-b tags

v2:
- simplify "build-sys: silence make by default or V=3D0": make it a
  oneliner MAKEFLAGS, use --quiet.
- document print-VAR rule in docs/devel/build-system.txt
- fix ASAN coroutine instrumentation failure
- should fix builds on gcc 4.4.7 (centos 6)
- new coroutine test leak fix
- add some r-b tags

Marc-Andr=C3=A9 Lureau (18):
  build-sys: fix qemu-ga -pthread linking
  build-sys: silence make by default or V=3D0
  build-sys: add a rule to print a variable
  build-sys: compile with -Og or -O1 when --enable-debug
  tests/docker: add some sanitizers to fedora dockerfile
  tests/docker: add test-debug
  build-sys: add some sanitizers when --enable-debug if possible
  tests: fix check-qobject leak
  vl: fix direct firmware directories leak
  readline: add a free function
  tests: fix migration-test leak
  crypto: fix stack-buffer-overflow error
  qemu-config: fix leak in query-command-line-options
  tests: fix qmp-test leak
  ucontext: annotate coroutine stack for ASAN
  tests: fix coroutine leak in /basic/entered
  mips: fix potential fopen(NULL,...)
  disas/s390: fix global-buffer-overflow

 include/qemu/compiler.h                |  4 +++
 include/qemu/readline.h                |  1 +
 crypto/ivgen-essiv.c                   |  2 +-
 disas/s390.c                           | 16 +++++-------
 hw/nvram/ds1225y.c                     |  4 +--
 monitor.c                              |  2 +-
 tests/check-qobject.c                  |  2 ++
 tests/migration-test.c                 |  3 ++-
 tests/qmp-test.c                       |  3 ++-
 tests/test-coroutine.c                 |  1 -
 util/coroutine-ucontext.c              | 46 ++++++++++++++++++++++++++++=
++++++
 util/qemu-config.c                     |  3 ++-
 util/readline.c                        | 18 ++++++++++++-
 vl.c                                   |  9 ++++---
 Makefile                               |  7 ++++--
 configure                              | 23 +++++++++++++++--
 docs/devel/build-system.txt            | 13 ++++++++++
 rules.mak                              |  2 ++
 tests/docker/dockerfiles/fedora.docker |  4 +--
 tests/docker/test-clang                |  2 +-
 tests/docker/test-debug                | 26 +++++++++++++++++++
 tests/docker/test-mingw                |  2 --
 22 files changed, 162 insertions(+), 31 deletions(-)
 create mode 100755 tests/docker/test-debug

--=20
2.15.1.355.g36791d7216
