Received: from eggs.gnu.org ([2001:4830:134:3::10]:59382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocQ-0006rp-SV
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocN-0000Z7-Jn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diocN-0000Xi-57
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AC9E1F58C
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 21:15:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:29 -0500
Message-Id: <20170818211542.5380-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/13] Preliminary libqtest cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Markus gave some good advice on my 'v4: Clean up around qmp() and hmp()'
series [1].  Among other things, we agreed that if I'm going to get rid
of the qtest_* layer of function wrappers, I should do it all the way
(rather than just on the qmp() functions), and up front.  So that's what
this series does - focus on the stuff that should be easier to commit
up front, while I still play around with the hairier stuff related to
improving the qmp() interfaces.

I'm naming this v5, even though most of it is new content (patch 1 was
posted independently [2], and patch 13 was 7/22 of v4).  The overall
diffstat is rather fun.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00595.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00385.html

Eric Blake (13):
  test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTING code
  qtest: Don't perform side effects inside assertion
  libqtest: Remove dead qtest_instances variable
  libqtest: Let socket_send() compute length
  libqtest: Use qemu_strtoul()
  libqtest: Topologically sort functions
  libqtest: Inline qtest_query_target_endianness()
  tests: Rely more on global_qtest
  libqtest: Shorten a couple more qtest_* functions
  libqtest: Drop qtest_init() and qtest_qmp_discard_response()
  libqtest: Drop many static inline qtest_ wrappers
  libqtest: Use global_qtest in qtest_sendf() and qtest_rsp()
  numa-test: Use hmp()

 tests/libqos/virtio.h    |   2 +-
 tests/libqtest.h         | 642 +++++++++--------------------------------=
------
 tests/libqtest.c         | 496 ++++++++++++++++++------------------
 qtest.c                  |  80 ++++--
 tests/fdc-test.c         |   2 +-
 tests/ide-test.c         |  10 +-
 tests/ipmi-bt-test.c     |   2 +-
 tests/ipmi-kcs-test.c    |   2 +-
 tests/libqos/libqos-pc.c |   2 +-
 tests/libqos/rtas.c      |   3 +-
 tests/numa-test.c        |  21 +-
 tests/postcopy-test.c    |  16 +-
 tests/qmp-test.c         |   2 +-
 tests/rtc-test.c         |   9 +-
 tests/tco-test.c         |   5 +-
 tests/test-qga.c         |  90 -------
 tests/vhost-user-test.c  |   3 +-
 tests/wdt_ib700-test.c   |  30 ++-
 18 files changed, 467 insertions(+), 950 deletions(-)

--=20
2.13.5
