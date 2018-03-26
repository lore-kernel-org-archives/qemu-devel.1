Received: from eggs.gnu.org ([2001:4830:134:3::10]:38155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lml-0002Bm-6I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmg-0006gL-9P
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Lmg-0006g8-5E
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B654C4070219
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:07 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:38:53 +0800
Message-Id: <20180326063901.27425-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 0/8] Monitor: some oob related patches
 (fixes, new param, tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

I suppose these are all good even for 2.12, so marked in subject.
Tested with "make check" for all targets on x86_64, and iotest -raw.

Patch 1 fixes one OOB error message regression reported by Marc-Andre.

Patch 2 fixes one potential OOB problem when more than one clients are
there, reported by Marc-Andre (too).

Patch 3 introduce "-mon x-oob=3Don" parameter to allow user to
explicitly enable Out-Of-Band for a specific monitor.

Patch 4-6 are qapi-schema fixes and tests for Out-Of-Band.

Patch 7-8 add back the OOB test on the new parameter (with more
enhancements).

Please review, thanks.

Peter Xu (8):
  qmp: fix qmp_capabilities error regression
  qmp: cleanup qmp queues properly
  monitor: new parameter "x-oob"
  qapi: restrict allow-oob value to be "true"
  tests: let qapi-schema tests detect oob
  tests: add oob-test for qapi-schema
  tests: introduce qtest_init_with_qmp_format()
  tests: qmp-test: add test for new "x-oob"

 include/monitor/monitor.h               |   1 +
 monitor.c                               | 124 ++++++++++++++++++++++----=
------
 scripts/qapi/common.py                  |   2 +-
 tests/Makefile.include                  |   1 +
 tests/libqtest.c                        |  14 +++-
 tests/libqtest.h                        |  14 ++++
 tests/qapi-schema/doc-good.out          |   4 +-
 tests/qapi-schema/ident-with-escape.out |   2 +-
 tests/qapi-schema/indented-expr.out     |   4 +-
 tests/qapi-schema/oob-test.err          |   1 +
 tests/qapi-schema/oob-test.exit         |   1 +
 tests/qapi-schema/oob-test.json         |   2 +
 tests/qapi-schema/oob-test.out          |   0
 tests/qapi-schema/qapi-schema-test.json |   3 +
 tests/qapi-schema/qapi-schema-test.out  |  20 +++---
 tests/qapi-schema/test-qapi.py          |   4 +-
 tests/qmp-test.c                        |  84 ++++++++++++++++++++++
 tests/test-qmp-cmds.c                   |   4 ++
 vl.c                                    |   5 ++
 19 files changed, 233 insertions(+), 57 deletions(-)
 create mode 100644 tests/qapi-schema/oob-test.err
 create mode 100644 tests/qapi-schema/oob-test.exit
 create mode 100644 tests/qapi-schema/oob-test.json
 create mode 100644 tests/qapi-schema/oob-test.out

--=20
2.14.3
