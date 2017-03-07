Received: from eggs.gnu.org ([2001:4830:134:3::10]:44385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QK-0001XO-9X
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QH-00067o-4E
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9QG-00067I-SX
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F02D981129
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 07:20:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v277KdfL016932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 02:20:40 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 08:20:13 +0100
Message-Id: <1488871237-12332-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Actually, the command line option is the least part of this series.
Its bulk is about building infrastructure and getting errors out of
the JSON parser.

The design of the command line interface was discussed here:
Subject: Non-flat command line option argument syntax
Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html

v3: A few commit messages touched up, code unchanged

The following changes since commit fbddc2e5608eb655493253d080598375db61a748:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-28' into staging (2017-03-06 10:18:33 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v3

for you to fetch changes up to de479f01438d974100ac9ec10ab82c2ee1ad124f:

  keyval: Support lists (2017-03-07 08:15:18 +0100)

----------------------------------------------------------------
block: Command line option -blockdev

----------------------------------------------------------------
Daniel P. Berrange (1):
      qapi: qobject input visitor variant for use with keyval_parse()

Markus Armbruster (23):
      test-qemu-opts: Cover qemu_opts_parse() of "no"
      tests: Fix gcov-files-test-qemu-opts-y, gcov-files-test-logging-y
      keyval: New keyval_parse()
      test-keyval: Cover use with qobject input visitor
      qapi: Factor out common part of qobject input visitor creation
      qapi: Factor out common qobject_input_get_keyval()
      qobject: Propagate parse errors through qobject_from_jsonv()
      libqtest: Fix qmp() & friends to abort on JSON parse errors
      qjson: Abort earlier on qobject_from_jsonf() misuse
      test-qobject-input-visitor: Abort earlier on bad test input
      qobject: Propagate parse errors through qobject_from_json()
      block: More detailed syntax error reporting for JSON filenames
      check-qjson: Test errors from qobject_from_json()
      test-visitor-serialization: Pass &error_abort to qobject_from_json()
      monitor: Assert qmp_schema_json[] is sane
      test-qapi-util: New, covering qapi/qapi-util.c
      qapi: New parse_qapi_name()
      keyval: Restrict key components to valid QAPI names
      qapi: New qobject_input_visitor_new_str() for convenience
      block: Initial implementation of -blockdev
      qapi: Improve how keyval input visitor reports unexpected dicts
      docs/qapi-code-gen.txt: Clarify naming rules
      keyval: Support lists

 block.c                              |   9 +-
 docs/qapi-code-gen.txt               |  61 ++--
 include/qapi/qmp/qjson.h             |   5 +-
 include/qapi/qobject-input-visitor.h |  21 ++
 include/qapi/util.h                  |   2 +
 include/qemu/option.h                |   3 +
 monitor.c                            |   2 +-
 qapi/qapi-util.c                     |  47 +++
 qapi/qobject-input-visitor.c         | 214 +++++++++++-
 qemu-options.hx                      |   7 +
 qobject/qjson.c                      |  14 +-
 tests/.gitignore                     |   2 +
 tests/Makefile.include               |  10 +-
 tests/check-qjson.c                  |  88 +++--
 tests/libqtest.c                     |   3 +-
 tests/test-keyval.c                  | 624 +++++++++++++++++++++++++++++++++++
 tests/test-qapi-util.c               |  85 +++++
 tests/test-qemu-opts.c               |   5 +
 tests/test-qobject-input-visitor.c   | 190 ++++++++++-
 tests/test-visitor-serialization.c   |   2 +-
 util/Makefile.objs                   |   1 +
 util/keyval.c                        | 394 ++++++++++++++++++++++
 vl.c                                 |  39 +++
 23 files changed, 1746 insertions(+), 82 deletions(-)
 create mode 100644 tests/test-keyval.c
 create mode 100644 tests/test-qapi-util.c
 create mode 100644 util/keyval.c

-- 
2.7.4
