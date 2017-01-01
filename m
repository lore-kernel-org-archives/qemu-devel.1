Received: from eggs.gnu.org ([2001:4830:134:3::10]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cNdTe-0006gl-DQ
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cNdTZ-0002Wr-Fw
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cNdTZ-0002Vw-9h
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:34:53 -0500
From: Peter Xu <peterx@redhat.com>
Date: Sun,  1 Jan 2017 18:34:44 +0800
Message-Id: <1483266886-25050-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 0/2] run_tests: support
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

run_tests.sh is getting slower. Maybe it's time to let it run faster.
An obvious issue is that, we were running the tests sequentially in
the past.

This series provides another new "-j" parameter. "-j 8" means we run
the tests on 8 task queues. That'll fasten the script a lot. A very
quick test of mine shows 3x speed boost with 8 task queues.

Most of the changes are in scripts/tash.bash of patch 2, which
implemented the main logic for task managements. Please see commit
message for more information.

I did a quick "make standalone" test to make sure this series won't
break it. However I am not sure whether it'll break other thing that I
don't know...

Please kindly review, thanks.

Peter Xu (2):
  run_tests: provide RUNTIME_log_file
  run_tests: allow run tests in parallel

 run_tests.sh            |  30 +++++++---
 scripts/functions.bash  |  25 +++++++-
 scripts/global.bash     |  14 +++++
 scripts/mkstandalone.sh |   1 +
 scripts/task.bash       | 156 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 217 insertions(+), 9 deletions(-)
 create mode 100644 scripts/global.bash
 create mode 100644 scripts/task.bash

-- 
2.7.4
