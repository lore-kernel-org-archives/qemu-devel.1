Received: from eggs.gnu.org ([2001:4830:134:3::10]:41915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOFxE-0008Ul-UF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOFxB-00060k-OZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:16:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOFxB-0005zb-Id
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:16:49 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 31 May 2018 13:16:37 +0800
Message-Id: <20180531051641.8473-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/4] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Patch 1: some more comment suggested by Markus on Out-Of-Band
handlers.

Patch 2: touch up iotests to make sure after enabling OOB the randomly
generated SHUTDOWN event won't fail any tests.  Without this change,
iotests (raw) will success but iotests (qcow2) may fail 2 tests out of
100+.  With this patch applied, all tests pass.  Kevin, Max, please
help have a look on this one.

Patch 3: revert the x-oob parameter, turn OOB on.

Patch 4: revert the x-oob parameter usage in test.  We can consider
squash this patch into patch 3 to make sure no test will break.
However I kept it separate at least for review.

Tests passed:

- make check
- iotests on both raw and qcow2

Please review.  Thanks,

Peter Xu (4):
  docs: mention shared state protect for OOB
  tests: iotests: don't compare SHUTDOWN event
  monitor: remove "x-oob", turn oob on by default
  Revert "tests: Add parameter to qtest_init_without_qmp_handshake"

 docs/devel/qapi-code-gen.txt     |  3 +++
 include/monitor/monitor.h        |  1 -
 tests/libqtest.h                 |  7 ++----
 monitor.c                        | 17 +-------------
 tests/libqtest.c                 | 10 ++++----
 tests/qmp-test.c                 |  6 ++---
 vl.c                             |  5 ----
 tests/qemu-iotests/060.out       |  1 -
 tests/qemu-iotests/067.out       |  5 ++++
 tests/qemu-iotests/071.out       |  2 --
 tests/qemu-iotests/081.out       |  1 -
 tests/qemu-iotests/087.out       |  6 -----
 tests/qemu-iotests/094.out       |  1 -
 tests/qemu-iotests/109.out       | 22 ------------------
 tests/qemu-iotests/117.out       |  1 -
 tests/qemu-iotests/119.out       |  1 -
 tests/qemu-iotests/120.out       |  1 -
 tests/qemu-iotests/127.out       |  1 -
 tests/qemu-iotests/140.out       |  1 -
 tests/qemu-iotests/143.out       |  1 -
 tests/qemu-iotests/156.out       |  1 -
 tests/qemu-iotests/176.out       |  8 -------
 tests/qemu-iotests/183.out       |  2 --
 tests/qemu-iotests/184.out       | 40 --------------------------------
 tests/qemu-iotests/185.out       |  5 ----
 tests/qemu-iotests/191.out       | 20 ----------------
 tests/qemu-iotests/195.out       | 20 ----------------
 tests/qemu-iotests/206.out       | 11 ---------
 tests/qemu-iotests/207.out       |  6 -----
 tests/qemu-iotests/210.out       |  6 -----
 tests/qemu-iotests/211.out       |  7 ------
 tests/qemu-iotests/212.out       |  8 -------
 tests/qemu-iotests/213.out       |  9 -------
 tests/qemu-iotests/common.filter |  5 +++-
 34 files changed, 22 insertions(+), 219 deletions(-)

-- 
2.17.0
