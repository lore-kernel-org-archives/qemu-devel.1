Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMp-0002pP-Ib
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMl-0002kp-C0
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMl-0002kC-2R
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:11:59 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C33F6034
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:11:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EBvNU008017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:11:58 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:31 +0100
Message-Id: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/24] block: Command line option -blockdev
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

The following changes since commit aa3a982e674b09ae32502940f93ba98b3a8ad50e:

  qapi: Improve qobject visitor documentation (2017-03-05 09:14:20 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v2

for you to fetch changes up to 3a79d43588cff95636d5ccdfa77b372cfd6d8530:

  keyval: Support lists (2017-03-05 10:29:58 +0100)

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
