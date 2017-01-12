Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRWBr-0008BN-Cp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRWBn-00021y-D8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRWBn-00021l-7l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:36:35 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 12 Jan 2017 11:36:19 +0800
Message-Id: <1484192182-13760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v6 0/3] run_tests: support
 concurrent test execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

v6:
- some tunes on how to rm/mv logs/logs.old [Drew]
- fix errno to 2 when param parse fail [Drew]
- add one more patch to fix *) case errno [Drew]
  (please either take/squash/... this one)
- comment fix again [Drew]

v5:
- add "/" at start/end of line where proper [Drew]
- remove useless newline in Makefile [Drew]
- don't check "mv" since it won't fail [Drew]
- avoid using '"s in (( )) [Drew]
- comment fix [Drew]

v4:
- add .gitignore for logs/ [Drew]
- instead of create globals.bash, renaming function.bash into
  common.bash, put globals inside [Drew]
- instead of removing logs/ directly when start run_tests, move it
  into logs.old so we at least have the last time result cached [Drew]
- s/ut_/unittest_/ through the whole series [Drew]
- remove unittest_log_summary var [Drew]
- remove radim's s-b in patch 2 since it does not suite [Drew]
- tiny fix on the usage lines [Drew]
- use bash arithmetic where proper [Drew]
- remove ut_in_parallel since not used [Drew]

v3:
- better handling for ctrl-c during run_tests.sh [Radim]

v2:
- patch 1: do per-test logging in all cases
- patch 2: throw away task.bash, instead, take Radim's suggestion to
  use jobs

run_tests.sh is getting slower. Maybe it's time to let it run faster.
An obvious issue is that, we were running the tests sequentially in
the past.

This series provides another new "-j" parameter. "-j 8" means we run
the tests on 8 task queues. That'll fasten the script a lot. A very
quick test of mine shows 3x speed boost with 8 task queues.

Please review, thanks.

Peter Xu (3):
  run_tests: fix errno for param parsing
  run_tests: put logs into per-test file
  run_tests: allow run tests in parallel

 .gitignore                              |  3 ++-
 Makefile                                |  5 ++---
 run_tests.sh                            | 33 +++++++++++++++++++++++----------
 scripts/{functions.bash => common.bash} | 27 +++++++++++++++++++++++++--
 scripts/mkstandalone.sh                 |  2 +-
 5 files changed, 53 insertions(+), 17 deletions(-)
 rename scripts/{functions.bash => common.bash} (63%)

-- 
2.7.4
