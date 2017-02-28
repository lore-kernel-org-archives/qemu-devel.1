Received: from eggs.gnu.org ([2001:4830:134:3::10]:36099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIo-0007T7-Pn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIm-0000uR-2I
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:22 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:26:46 +0100
Message-Id: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Actually, the command line option is the least part of this series.
Its bulk is about building infrastructure and getting errors out of
the JSON parser[*].  The latter part could be spun out in its own
series, if that helps.  We'll see.

The design of the command line interface was discussed here:
Subject: Non-flat command line option argument syntax
Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html

This series is based on "[PULL 00/26] QAPI patches for 2017-02-28".
Available as branch blockdev-cmdline in my public repo
<http://repo.or.cz/w/qemu/armbru.git>.

[*] Who'd have thunk anyone actually wants to know what's wrong with
his JSON!

v2: Address review by Eric and Kevin
PATCH 03: Comment fixes, memory leak plugged
PATCH 05: Comment fix
PATCH 08+12: Announce followup work in commit message 
PATCH 18: Comment fix
PATCH 20: A missing test for failure fixed
PATCH 21: Option help text improved, loop to call qmp_blockdev_add()
          moved to the right place
PATCH 22: Commit message fix
PATCH 23: Commit message fix, qobject_input_get_keyval() fixed to set
          v->keyval, memory leaks plugged, test case tweaked to cover
	  leading zero, keyval_listify() thinko fixed (this is the
	  only non-trivial change in v2)

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
