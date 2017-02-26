Received: from eggs.gnu.org ([2001:4830:134:3::10]:37434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bg-0004U7-Lw
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bd-0004M8-Gf
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ci6bd-0004LB-9C
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CD5A37EE7
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:43:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1QLhkgF001802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 16:43:47 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 26 Feb 2017 22:43:18 +0100
Message-Id: <1488145424-14974-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/26] qapi: QMP dispatch and input visitor
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2:
* PATCH 19-20+22+24-25: New
* PATCH 03: Update MAINTAINERS new file
* PATCH 21+23: New test_visitor_in_fail_list_nested(), string visitor
  patch tweaked, comments polished
* PATCH 23: full_name() bugs fixed

Markus Armbruster (26):
  qga: Fix crash on non-dictionary QMP argument
  libqtest: Work around a "QMP wants a newline" bug
  qmp-test: New, covering basic QMP protocol
  qmp: Dumb down how we run QMP command registration
  qmp: Clean up how we enforce capability negotiation
  qmp: Drop duplicated QMP command object checks
  qmp: Eliminate silly QERR_QMP_* macros
  qmp: Improve QMP dispatch error messages
  qapi: Improve a QObject input visitor error message
  qapi: Clean up after commit 3d344c2
  qapi: Make QObject input visitor set *list reliably
  qapi: Improve qobject input visitor error reporting
  qapi: Drop string input visitor method optional()
  qapi: Make string input and opts visitor require non-null input
  qom: Make object_property_set_qobject()'s input visitor strict
  test-qobject-input-visitor: Use strict visitor
  qapi: Drop unused non-strict qobject input visitor
  tests-qobject-input-strict: Merge into test-qobject-input-visitor
  test-string-input-visitor: Tear down existing test automatically
  test-string-input-visitor: Improve list coverage
  tests: Cover partial input visit of list
  test-qobject-input-visitor: Cover missing nested struct member
  qapi: Make input visitors detect unvisited list tails
  tests: Cover input visit beyond end of list
  qapi: Fix object input visit beyond end of list
  qapi: Improve qobject visitor documentation

 MAINTAINERS                           |   1 +
 block/nbd.c                           |   2 +-
 block/nfs.c                           |   2 +-
 block/ssh.c                           |   2 +-
 docs/qapi-code-gen.txt                |   2 +-
 hw/ppc/spapr_drc.c                    |   5 +
 include/monitor/monitor.h             |   1 +
 include/qapi/qmp/qerror.h             |   9 -
 include/qapi/qobject-input-visitor.h  |  40 +++-
 include/qapi/qobject-output-visitor.h |  35 +++-
 include/qapi/visitor-impl.h           |   7 +-
 include/qapi/visitor.h                |  19 +-
 include/qemu/module.h                 |   2 -
 monitor.c                             | 149 +++++--------
 qapi/opts-visitor.c                   |  12 ++
 qapi/qapi-visit-core.c                |   8 +
 qapi/qmp-dispatch.c                   |  22 +-
 qapi/qobject-input-visitor.c          | 218 ++++++++++++-------
 qapi/string-input-visitor.c           |  97 +++++----
 qapi/trace-events                     |   1 +
 qga/main.c                            |   2 +-
 qmp.c                                 |   2 +-
 qom/qom-qobject.c                     |   4 +-
 scripts/qapi-commands.py              |   7 +-
 scripts/qapi-visit.py                 |   3 +
 target/s390x/cpu_models.c             |   2 +-
 tests/Makefile.include                |   9 +-
 tests/check-qnull.c                   |   2 +-
 tests/libqtest.c                      |  29 ++-
 tests/libqtest.h                      |   8 +
 tests/qmp-test.c                      | 139 +++++++++++++
 tests/test-opts-visitor.c             |  80 +++++++
 tests/test-qga.c                      |   2 +-
 tests/test-qmp-commands.c             |   4 +-
 tests/test-qobject-input-strict.c     | 381 ----------------------------------
 tests/test-qobject-input-visitor.c    | 259 ++++++++++++++++++++++-
 tests/test-string-input-visitor.c     | 132 +++++++++---
 tests/test-visitor-serialization.c    |   2 +-
 trace-events                          |   1 -
 vl.c                                  |   2 +-
 40 files changed, 994 insertions(+), 710 deletions(-)
 create mode 100644 tests/qmp-test.c
 delete mode 100644 tests/test-qobject-input-strict.c

-- 
2.7.4
