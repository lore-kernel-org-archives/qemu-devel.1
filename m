Received: from eggs.gnu.org ([2001:4830:134:3::10]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HR-0003iY-Pl
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HQ-00037n-AJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Jul 2017 09:53:31 +0200
Message-Id: <1500537221-20556-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] Correct two minor QMP interface
 design flaws
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

blockdev-add and migrate-set-parameters overload empty strings to mean
something entirely different.  See my memo "qapi: Stop abusing
"special" values for something entirely different" for details.

    Message-ID: <87379zhrhn.fsf@dusky.pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04526.html

This series deprecates these usages of "" in favour of JSON null.
Because we're so close to the 2.10 freeze, the implementation is
intentionally stupid: rewrite null to "" at first opportunity.  The
proper way to do it would be rewriting "" to null, but that requires
fixing up code to work with null.  There are TODO comments for that.
I'm willing to take care of them in the next development cycle.

v2, because my pull request clashed with Juan's:
* Rebased, non-trivial conflicts in migration/migration.c
* PATCH 02: Commit message typo [Eric]
  	    Fix ppc [patchew]
* PATCH 03: qapi-code-gen.txt update [Eric]
* PATCH 09: Conflict resolution, somewhat ugly
* PATCH 10: Doc improvement [Eric]
  	    Conflict resolution

Markus Armbruster (10):
  qapi: Separate type QNull from QObject
  qapi: Use QNull for a more regular visit_type_null()
  qapi: Introduce a first class 'null' type
  tests/test-qobject-input-visitor: Drop redundant test
  block: Use JSON null instead of "" to disable backing file
  hmp: Clean up and simplify hmp_migrate_set_parameter()
  migration: Clean up around tls_creds, tls_hostname
  migration: Add TODO comments on duplication of QAPI_CLONE()
  migration: Unshare MigrationParameters struct for now
  migration: Use JSON null instead of "" to reset parameter to default

 blockdev.c                              |  14 +++++
 docs/devel/qapi-code-gen.txt            |  10 +--
 hmp.c                                   |  88 ++++++++++++--------------
 hw/ppc/spapr_drc.c                      |   4 +-
 include/qapi/qmp/qobject.h              |  10 ++-
 include/qapi/visitor-impl.h             |   3 +-
 include/qapi/visitor.h                  |   8 +--
 include/qemu/typedefs.h                 |   1 +
 migration/migration.c                   |  96 +++++++++++++++++++++++++---
 qapi-schema.json                        | 108 ++++++++++++++++++++++++++++----
 qapi/block-core.json                    |  29 ++++++---
 qapi/qapi-clone-visitor.c               |   5 +-
 qapi/qapi-dealloc-visitor.c             |   6 +-
 qapi/qapi-visit-core.c                  |   7 ++-
 qapi/qobject-input-visitor.c            |   6 +-
 qapi/qobject-output-visitor.c           |   5 +-
 qapi/string-input-visitor.c             |   8 ++-
 qapi/string-output-visitor.c            |   3 +-
 qapi/trace-events                       |   2 +-
 qobject/json-parser.c                   |   2 +-
 qobject/qnull.c                         |   8 ++-
 scripts/qapi.py                         |   5 +-
 target/i386/cpu.c                       |   4 +-
 target/ppc/translate_init.c             |   5 +-
 tests/check-qjson.c                     |   6 +-
 tests/check-qnull.c                     |  27 ++++----
 tests/qapi-schema/qapi-schema-test.json |   3 +-
 tests/qapi-schema/qapi-schema-test.out  |   1 +
 tests/qemu-iotests/085                  |   2 +-
 tests/qemu-iotests/139                  |   2 +-
 tests/test-qobject-input-visitor.c      |  24 ++++---
 tests/test-qobject-output-visitor.c     |  13 +++-
 32 files changed, 378 insertions(+), 137 deletions(-)

-- 
2.7.5
