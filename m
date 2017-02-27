Received: from eggs.gnu.org ([2001:4830:134:3::10]:44651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-000670-97
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMT-000114-Kt
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:26 +0100
Message-Id: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Actually, the command line option is the least part of this series.
Its bulk is about building infrastructure and getting errors out of
the JSON parser[*].  The latter part could be spun out in its own
series, if that helps.  We'll see.

The design of the command line interface was discussed here:
Subject: Non-flat command line option argument syntax
Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html

This series is based on "[PATCH v2 00/26] qapi: QMP dispatch and input
visitor work".  Available as branch blockdev-cmdline in my public repo
<http://repo.or.cz/w/qemu/armbru.git>, except that one still has a
patch to add implied value sugar, followed by its revert.

It supersedes "[PATCH RFC v3 0/5] block: Crude initial implementation
of -blockdev".

[*] Who'd have thunk anyone actually wants to know what's wrong with
his JSON!

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
  qapi: New qobject_input_visitor_new_str() for convenience
  block: Initial implementation of -blockdev
  qapi: Improve how keyval input visitor reports unexpected dicts
  docs/qapi-code-gen.txt: Clarify naming rules
  test-qapi-util: New, covering qapi/qapi-util.c
  qapi: New parse_qapi_name()
  keyval: Restrict key components to valid QAPI names
  keyval: Support lists

 block.c                              |   9 +-
 docs/qapi-code-gen.txt               |  61 ++--
 include/qapi/qmp/qjson.h             |   8 +-
 include/qapi/qobject-input-visitor.h |  21 ++
 include/qapi/util.h                  |   2 +
 include/qemu/option.h                |   3 +
 monitor.c                            |   2 +-
 qapi/qapi-util.c                     |  47 +++
 qapi/qobject-input-visitor.c         | 210 +++++++++++-
 qemu-options.hx                      |   7 +
 qobject/qjson.c                      |  14 +-
 tests/.gitignore                     |   2 +
 tests/Makefile.include               |  10 +-
 tests/check-qjson.c                  |  88 +++--
 tests/libqtest.c                     |   3 +-
 tests/test-keyval.c                  | 619 +++++++++++++++++++++++++++++++++++
 tests/test-qapi-util.c               |  85 +++++
 tests/test-qemu-opts.c               |   5 +
 tests/test-qobject-input-visitor.c   | 190 ++++++++++-
 tests/test-visitor-serialization.c   |   2 +-
 util/Makefile.objs                   |   1 +
 util/keyval.c                        | 385 ++++++++++++++++++++++
 vl.c                                 |  39 +++
 23 files changed, 1730 insertions(+), 83 deletions(-)
 create mode 100644 tests/test-keyval.c
 create mode 100644 tests/test-qapi-util.c
 create mode 100644 util/keyval.c

-- 
2.7.4
