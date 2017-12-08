Received: from eggs.gnu.org ([2001:4830:134:3::10]:46534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN6zs-0006fl-4Y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN6zn-0007Op-BC
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eN6zn-0007Nm-5M
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAFD185363
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 00:58:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Dec 2017 01:58:13 +0100
Message-Id: <20171208005825.14587-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/12] Various build-sys and ASAN related fixes
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

Marc-Andr=C3=A9 Lureau (12):
  build-sys: fix qemu-ga -pthread linking
  build-sys: silence make by default
  build-sys: add a rule to print a variable
  build-sys: add AddressSanitizer when --enable-debug if possible
  tests: fix check-qobject leak:
  vl: fix direct firmware directories leak
  readline: add a free function
  tests: fix migration-test leak
  crypto: fix stack-buffer-overflow error
  qemu-config: fix leak in query-command-line-options
  tests: fix qmp-test leak
  WIP ucontext: annotate coroutine stack for ASAN

 include/qemu/readline.h   |  1 +
 crypto/ivgen-essiv.c      |  2 +-
 monitor.c                 |  2 +-
 tests/check-qobject.c     |  2 ++
 tests/migration-test.c    |  3 ++-
 tests/qmp-test.c          |  3 ++-
 util/coroutine-ucontext.c | 47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-config.c        |  3 ++-
 util/readline.c           | 18 +++++++++++++++++-
 vl.c                      |  9 ++++++---
 Makefile                  |  5 ++++-
 configure                 |  6 ++++++
 rules.mak                 |  5 +++++
 13 files changed, 96 insertions(+), 10 deletions(-)

--=20
2.15.1.355.g36791d7216
