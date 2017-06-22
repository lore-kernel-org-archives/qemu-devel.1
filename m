Received: from eggs.gnu.org ([2001:4830:134:3::10]:56066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrY-0005Ie-Cw
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrV-0004Vv-76
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:32:56 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrV-0004Vj-22
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:32:53 -0400
Received: by mail-qk0-x235.google.com with SMTP id d14so3029818qkb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:32:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:10 -0300
Message-Id: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/21] travis: speedup to reduce failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

These patches try to improve our Travis CI usage (quite a few failures the last
days).

This series include Peter's "Automate coverity scan uploads via Travis"
patches (here numbered 3 to 6). See
https://www.mail-archive.com/qemu-devel@nongnu.org/msg457443.html

Patch 7 is expected to enter /master as of today.
Travis warned few months ago:
  "On Wednesday, June 21st 2017, we are going to update all our Ubuntu Trusty
  14.04 images."

Patches 2, 10 and 15 use 'travis_retry' feature to avoid aborting a job on
network failure, retrying 3 times (default).

Patches 8, 19 are upgrades allowing to use recent VMs/toolchains.

Patch 12 speed up builds using multicore parallelism, caring about not overkill
Travis hardware.

Patches 9, 11, 13, 17 speed up builds improving cache usage.

Patches 18, 21 silent warnings.

Patch 14 gives hint when ./configure fails.

Patch 16 split slow gprof/gcov job.

Finally patch 1 add a missing rule to build system-qemu binary before running
qtests.

time comparison:
----------------

current /master https://travis-ci.org/qemu/qemu/builds/245061137:
 Ran for 2 hrs 4 min 17 sec
 Total time 7 hrs 34 min 22 sec

this seris with 3 more jobs https://travis-ci.org/philmd/qemu/builds/245593509:
 Ran for 1 hr 26 min 35 sec
 Total time 6 hrs 32 min 49 sec

Regards,

Phil.

Peter Maydell (3):
  travis: install more library dependencies
  scripts/run-coverity-scan: Script to run Coverity Scan build
  travis: Add config to do a Coverity Scan upload

Philippe Mathieu-Daudé (18):
  tests: add missing dependency to build QTEST_QEMU_BINARY
  travis: retry if llvm.org timeouts
  travis: install more library dependencies
  travis: update sudo-enabled Trusty images
  travis: use gcc-6 sanitizers
  travis: enable multiple caching features
  travis: increase S3 cache timeout
  travis: cache git submodules
  travis: build using all available cores
  travis: improve ccache use
  travis: dump config.log if ./configure script fails
  travis: retry when git submodules initialization fails
  travis: split the gprof/gcov job
  travis/osx: don't update Homebrew cache
  travis/osx: silent texinfo warnings
  travis/osx: build using more Xcode versions
  MAINTAINERS: self-appoint me as reviewer in build/test automation
  ui/vnc: silent unuseful OSX clang warning

 .travis.yml               | 135 +++++++++++++++++++++++++++++-------
 MAINTAINERS               |   1 +
 scripts/run-coverity-scan | 170 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include    |   2 +-
 ui/Makefile.objs          |   8 +++
 5 files changed, 290 insertions(+), 26 deletions(-)
 create mode 100755 scripts/run-coverity-scan

-- 
2.11.0
