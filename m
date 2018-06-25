Received: from eggs.gnu.org ([2001:4830:134:3::10]:56754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX4-0004wp-JG
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX0-0008BX-JV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:42 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXPX0-0008B6-D1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:38 -0400
Received: by mail-wr0-x236.google.com with SMTP id p12-v6so11630127wrn.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:19:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 12:19:25 +0100
Message-Id: <20180625111935.26108-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 00/10] Travis updates and code coverage
 tweaks
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

The main changes since last weeks RFC are that I ended up doing more
furtling than I wanted to make the Travis coverage report sane. Rather
than mess around with .travis.yml I pushed this all into a script.

I also got to the bottom of the missing coverage reports under
linux-user. It seems as though our exit path can not trigger the
coverage dump so we need to do it ourselves. As we have similar hacks
for GPROF and the gdbstub I ended up putting this is a new helper
function. The new file might be overkill though but I didn't want to
jam the helper in our already oversized main file. Maybe the syscalls
can move across later?

The Travis updates from Philippe are simple clean-ups including being
able to drop the silly wget pre-seed hack in favour of a limited
submodule checkout.

Anyway comments welcome.

Alex Bennée (8):
  build-system: remove per-test GCOV reporting
  .gitignore: add .gcov files
  docker: add gcovr to travis image
  travis: add gcovr summary for GCOV build
  build-system: add clean-coverage target
  build-system: add coverage-report target
  linux-user: introduce preexit_cleanup
  linux-user: add gcov support to preexit_cleanup

Philippe Mathieu-Daudé (2):
  travis: do not waste time cloning unused submodules
  travis: test out-of-tree builds

 .gitignore                             |  1 +
 .travis.yml                            | 14 ++++++++---
 Makefile                               | 24 ++++++++++++++++++
 docs/devel/testing.rst                 | 21 +++++++++++-----
 linux-user/Makefile.objs               |  2 +-
 linux-user/exit.c                      | 35 ++++++++++++++++++++++++++
 linux-user/qemu.h                      |  8 ++++++
 linux-user/syscall.c                   | 10 ++------
 scripts/coverage-summary.sh            | 27 ++++++++++++++++++++
 tests/Makefile.include                 | 10 --------
 tests/docker/dockerfiles/travis.docker |  2 +-
 11 files changed, 125 insertions(+), 29 deletions(-)
 create mode 100644 linux-user/exit.c
 create mode 100755 scripts/coverage-summary.sh

-- 
2.17.1
