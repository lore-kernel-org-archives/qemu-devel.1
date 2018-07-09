Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXye-0000lW-Im
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyb-0005Uc-CV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXyb-0005UL-5F
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id p1-v6so11409629wrs.9
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:07 +0100
Message-Id: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 00/10] various docker fixes
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

The addition of the cross compilers for check-tcg broke the ability to
run "make docker-test".  In truth this was probably already broken as
it attempts to run every single test with every single docker image
which isn't something that gets done on a regular basis.

Anyway the patches clean up the ability to do that in a sane way
although it still takes a long time to run the full test set.

To help with running a better subset I've expanded the individual
tests so you can now run a line like:

  make docker-test-build TARGET_LIST=aarch64-softmmu J=30

To make sure your favourite architecture still builds everywhere.

There is now also a docker-test-unit which just runs the unit tests
although we have to do a little re-factoring to make sure we don't
attempt to run "make check" steps when the docker image isn't capable
of it. This is also needed to make sure the other test-FOO build tests
don't choke on the check step.

Finally there is a minor tweak for .gitignore and a fix for docker.py
throwing backtraces when we attempt to calculate SID_AGE. A cleaner
re-factoring can be left for a future release.

Alex Bennée (10):
  tests/.gitignore: don't ignore docker tests
  docker: debian-tricore add git tools
  docker: fail more gracefully on docker.py check
  docker: split configure_qemu from build_qemu
  docker: move make check into check_qemu helper
  docker: gracefully skip check_qemu
  docker: Makefile.include don't include partial images
  docker: disable debian-powerpc-user-cross
  docker: add test-unit runner
  docker: add expansion for docker-test-FOO to Makefile.include

 tests/.gitignore                              |  1 +
 tests/docker/Makefile.include                 | 14 +++++++++--
 tests/docker/common.rc                        | 23 ++++++++++++++++++-
 tests/docker/docker.py                        |  7 +++++-
 .../dockerfiles/debian-tricore-cross.docker   |  3 +++
 tests/docker/test-clang                       |  2 +-
 tests/docker/test-debug                       |  2 +-
 tests/docker/test-full                        |  2 +-
 tests/docker/test-quick                       |  2 +-
 tests/docker/test-unit                        | 19 +++++++++++++++
 10 files changed, 67 insertions(+), 8 deletions(-)
 create mode 100755 tests/docker/test-unit

-- 
2.17.1
