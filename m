Received: from eggs.gnu.org ([2001:4830:134:3::10]:48776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrh-0001YI-Nv
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDre-0007mQ-Ps
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDrZ-0007kj-BC
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72ABC87A76
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:40:53 +0200
Message-Id: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/18] monitor: various code simplification
 and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

I would suggest the following patches for 3.0:
 - monitor: consitify qmp_send_response() QDict argument
 - qmp: constify qmp_is_oob()
 - qga: process_event() simplification and leak fix
 - qmp: drop json_parser_parse() wrapper
 - json-parser: simplify and avoid JSONParserContext allocation
 - json-parser: further simplify freeing JSONParserContext
 - qjson: report an error if there are multiple results
 - qjson: report error on unterminated string
 - qjson: return parsing error if unterminated input
 - json-parser: set an error if parsing returned NULL
 - tests: add a qmp success-response test
 - qga: process_event() simplification

(they apply cleanly when cherry-picked, the remaining cleanups could be
defered after the release)

v2:
- add a code comment about need_resume variable
- update "qga: process_event() simplification" patch with req/rsp
  variables
- add "qmp: drop json_parser_parse()" patch
- add JSONParserContext allocation simplification patches
- add "qjson: report an error if there are multiple results"
- add "qjson: report error on unterminated string"
- add "qjson: return parsing error if unterminated input"
- document json_parser_parse() return behaviour
- add r-b tags

Marc-Andr=C3=A9 Lureau (18):
  tests: change /0.15/* tests to /qmp/*
  monitor: consitify qmp_send_response() QDict argument
  qmp: constify qmp_is_oob()
  Revert "qmp: isolate responses into io thread"
  monitor: no need to save need_resume
  qga: process_event() simplification and leak fix
  qmp: drop json_parser_parse() wrapper
  json-parser: simplify and avoid JSONParserContext allocation
  json-parser: further simplify freeing JSONParserContext
  qjson: report an error if there are multiple results
  qjson: report error on unterminated string
  qjson: return parsing error if unterminated input
  json-parser: set an error if parsing returned NULL
  json-lexer: make it safe to call multiple times
  tests: add a few qemu-qmp tests
  tests: add a qmp success-response test
  qga: process_event() simplification
  RFC: qmp: common 'id' handling & make QGA conform to QMP spec

 include/qapi/qmp/dispatch.h             |   2 +-
 include/qapi/qmp/json-parser.h          |   3 +-
 block.c                                 |   5 -
 monitor.c                               | 173 +++---------------------
 qapi/qmp-dispatch.c                     |  14 +-
 qapi/qobject-input-visitor.c            |   5 -
 qga/main.c                              |  66 +++------
 qobject/json-lexer.c                    |   5 +-
 qobject/json-parser.c                   |  59 +++-----
 qobject/json-streamer.c                 |   4 +-
 qobject/qjson.c                         |  24 +++-
 tests/check-qjson.c                     |  25 +++-
 tests/libqtest.c                        |   2 +-
 tests/qmp-test.c                        |  38 ++++++
 tests/test-qga.c                        |  13 +-
 tests/test-qmp-cmds.c                   |  27 +++-
 tests/qapi-schema/qapi-schema-test.json |   2 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 18 files changed, 190 insertions(+), 279 deletions(-)

--=20
2.18.0.129.ge3331758f1
