Received: from eggs.gnu.org ([2001:4830:134:3::10]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXP7A-0001U9-Tl
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXP75-0005Bx-V7
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:20:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXP75-0005AU-Lu
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:20:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C558B5D68C
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 10:20:34 +0000 (UTC)
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56c7640b-3db2-f242-c511-532556c2dfcb@redhat.com>
Date: Fri, 5 Jan 2018 11:20:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/18] Various build-sys and sanitizer
 related fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, eblake@redhat.com

On 04/01/2018 17:05, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> This is a series that improves a bit the build system, and introduces
> ASAN/UBSan by default when --enable-debug. Then it fixes a few leaks
> that occur during make check: common and x86_64 target tests are leak
> free after this series. The other targets will need some work to fix
> the leaks & warnings.
>=20
> v3:
> - add ubsan too with --enable-debug, since it is recommended and has
>   low runtime cost
> - add a patch "compile with -Og or -O1 when --enable-debug", suggested
>   by Paolo
> - add 2 new fixes to pass full make check with asan/ubsan
> - modify docker tests to run --enable-debug & asan with new test-debug
> - add some r-b/a-b tags
>=20
> v2:
> - simplify "build-sys: silence make by default or V=3D0": make it a
>   oneliner MAKEFLAGS, use --quiet.
> - document print-VAR rule in docs/devel/build-system.txt
> - fix ASAN coroutine instrumentation failure
> - should fix builds on gcc 4.4.7 (centos 6)
> - new coroutine test leak fix
> - add some r-b tags
>=20
> Marc-Andr=C3=A9 Lureau (18):
>   build-sys: fix qemu-ga -pthread linking
>   build-sys: silence make by default or V=3D0
>   build-sys: add a rule to print a variable
>   build-sys: compile with -Og or -O1 when --enable-debug
>   tests/docker: add some sanitizers to fedora dockerfile
>   tests/docker: add test-debug
>   build-sys: add some sanitizers when --enable-debug if possible
>   tests: fix check-qobject leak
>   vl: fix direct firmware directories leak
>   readline: add a free function
>   tests: fix migration-test leak
>   crypto: fix stack-buffer-overflow error
>   qemu-config: fix leak in query-command-line-options
>   tests: fix qmp-test leak
>   ucontext: annotate coroutine stack for ASAN
>   tests: fix coroutine leak in /basic/entered
>   mips: fix potential fopen(NULL,...)
>   disas/s390: fix global-buffer-overflow
>=20
>  include/qemu/compiler.h                |  4 +++
>  include/qemu/readline.h                |  1 +
>  crypto/ivgen-essiv.c                   |  2 +-
>  disas/s390.c                           | 16 +++++-------
>  hw/nvram/ds1225y.c                     |  4 +--
>  monitor.c                              |  2 +-
>  tests/check-qobject.c                  |  2 ++
>  tests/migration-test.c                 |  3 ++-
>  tests/qmp-test.c                       |  3 ++-
>  tests/test-coroutine.c                 |  1 -
>  util/coroutine-ucontext.c              | 46 ++++++++++++++++++++++++++=
++++++++
>  util/qemu-config.c                     |  3 ++-
>  util/readline.c                        | 18 ++++++++++++-
>  vl.c                                   |  9 ++++---
>  Makefile                               |  7 ++++--
>  configure                              | 23 +++++++++++++++--
>  docs/devel/build-system.txt            | 13 ++++++++++
>  rules.mak                              |  2 ++
>  tests/docker/dockerfiles/fedora.docker |  4 +--
>  tests/docker/test-clang                |  2 +-
>  tests/docker/test-debug                | 26 +++++++++++++++++++
>  tests/docker/test-mingw                |  2 --
>  22 files changed, 162 insertions(+), 31 deletions(-)
>  create mode 100755 tests/docker/test-debug
>=20

Queued, thanks.

Paolo
