Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPjG-0003TO-82
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPjC-0008VW-V5
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbPjC-0008Uo-N2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3E53E9003
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:13:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 14:13:42 +0200
Message-Id: <20180706121354.2021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/12] RFC: monitor: various code
 simplification and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series is a rebased subset of "[PATCH v3 00/38] RFC: monitor: add
asynchronous command type" with code cleanups and improvements that
are worth to consider for 3.0.

The series applies on master, and will conflict with the pending
series "[PATCH 0/9] monitor: enable OOB by default" from Peter.

In particular, reverting "qmp: isolate responses into io thread" is
quite intrusive, but is a nice simplification that is worth to
consider before modifying/maintaining it further. Also, "monitor: no
need to save need_resume" could be dropped if Peter "[PATCH 5/9]
monitor: suspend monitor instead of send CMD_DROP" is adopted (see
discussion about need_resume there).

The last patch, "RFC: qmp: rework 'id' handling" simplifies a bit
monitor "id" handling, and makes qemu-ga conform to the QMP
specification by copying "id" from the request in the reply.  This is
the opposite to Markus change "qmp qemu-ga: Revert change that
accidentally made qemu-ga accept 'id'".

(the first patch is already in Markus qapi-next branch, it is there
for patchew testing)

Marc-Andr=C3=A9 Lureau (12):
  tests: change /0.15/* tests to /qmp/*
  monitor: consitify qmp_send_response() QDict argument
  qmp: constify qmp_is_oob()
  Revert "qmp: isolate responses into io thread"
  monitor: no need to save need_resume
  qga: process_event() simplification and leak fix
  json-parser: always set an error if return NULL
  json-lexer: make it safe to call multiple times
  tests: add a few qemu-qmp tests
  tests: add a qmp success-response test
  qga: process_event() simplification
  RFC: qmp: rework 'id' handling

 include/qapi/qmp/dispatch.h             |   2 +-
 block.c                                 |   5 -
 monitor.c                               | 171 +++---------------------
 qapi/qmp-dispatch.c                     |  12 +-
 qapi/qobject-input-visitor.c            |   5 -
 qga/main.c                              |  66 +++------
 qobject/json-lexer.c                    |   5 +-
 qobject/json-parser.c                   |   8 +-
 tests/qmp-test.c                        |  38 ++++++
 tests/test-qga.c                        |  13 +-
 tests/test-qmp-cmds.c                   |  27 +++-
 tests/qapi-schema/qapi-schema-test.json |   2 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 13 files changed, 129 insertions(+), 227 deletions(-)

--=20
2.18.0.rc1
