Received: from eggs.gnu.org ([2001:4830:134:3::10]:42263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrZz-0004Af-3n
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrZv-0000qq-2G
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePrZu-0000nh-Sk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 405EC6A7D8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:07:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:46 +0100
Message-Id: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/13] Various build-sys and ASAN related
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a small series that improves a bit the build system, and
introduce ASAN by default when --enable-debug. Them it fixes a few
leaks that occur during make check: common and x86_64 target tests are
leak free after this series, the other targets will need some
work. Finally, the last patch should help ASAN and remove some
false-positive, unfortunately it crashes ASAN and may be
incorrect. Help welcome!

v2:
- simplify "build-sys: silence make by default or V=3D0": make it a
  oneliner MAKEFLAGS, use --quiet.
- document print-VAR rule in docs/devel/build-system.txt
- fix ASAN coroutine instrumentation failure
- should fix builds on gcc 4.4.7 (centos 6)
- new coroutine test leak fix
- add some r-b tags

Marc-Andr=C3=A9 Lureau (13):
  build-sys: fix qemu-ga -pthread linking
  build-sys: silence make by default or V=3D0
  build-sys: add a rule to print a variable
  build-sys: add AddressSanitizer when --enable-debug if possible
  tests: fix check-qobject leak:
  vl: fix direct firmware directories leak
  readline: add a free function
  tests: fix migration-test leak
  crypto: fix stack-buffer-overflow error
  qemu-config: fix leak in query-command-line-options
  tests: fix qmp-test leak
  ucontext: annotate coroutine stack for ASAN
  tests: fix coroutine leak in /basic/entered

 include/qemu/compiler.h     |  4 ++++
 include/qemu/readline.h     |  1 +
 crypto/ivgen-essiv.c        |  2 +-
 monitor.c                   |  2 +-
 tests/check-qobject.c       |  2 ++
 tests/migration-test.c      |  3 ++-
 tests/qmp-test.c            |  3 ++-
 tests/test-coroutine.c      |  1 -
 util/coroutine-ucontext.c   | 46 +++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-config.c          |  3 ++-
 util/readline.c             | 18 +++++++++++++++++-
 vl.c                        |  9 ++++++---
 Makefile                    |  7 +++++--
 configure                   |  6 ++++++
 docs/devel/build-system.txt | 13 +++++++++++++
 rules.mak                   |  2 ++
 16 files changed, 110 insertions(+), 12 deletions(-)

--=20
2.15.1.355.g36791d7216
