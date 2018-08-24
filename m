Received: from eggs.gnu.org ([2001:4830:134:3::10]:33089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHof-0002GI-Ub
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoc-0001bT-6a
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoa-0001Y2-3Z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED46C40241C5
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF0B621BE
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:08 +0200
Message-Id: <20180824193206.25475-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/58] QObject patches for 2018-08-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 1dfb85a8755096beecf182a617493d539259cb=
ea:

  Merge remote-tracking branch 'remotes/juanquintela/tags/check/20180822'=
 into staging (2018-08-24 14:46:31 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qobject-2018-08-24

for you to fetch changes up to 37aded92c27d0e56cd27f1c29494fc9f8c873cdd:

  json: Update references to RFC 7159 to RFC 8259 (2018-08-24 20:27:14 +0=
200)

----------------------------------------------------------------
QObject patches for 2018-08-24

JSON is such a simple language, so writing a parser should be easy,
shouldn't it?  Well, the evidence is in, and it's a lot of patches.
Summary of fixes:

* Reject ASCII control characters in strings as RFC 7159 specifies

* Reject all invalid UTF-8 sequences, not just some

* Reject invalid \uXXXX escapes

* Implement \uXXXX surrogate pairs as specified by RFC 7159

* Don't ignore \u0000 silently, map it to \xC0\80 (modified UTF-8)

* qobject_from_json() is ridicilously broken for input containing more
  than one value, fix

* Don't ignore trailing unterminated structures

* Less cavalierly cruel error reporting

Topped off with tests and cleanups.

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      json: remove useless return value from lexer/parser
      json-parser: simplify and avoid JSONParserContext allocation

Markus Armbruster (56):
      docs/interop/qmp-spec: How to force known good parser state
      check-qjson: Cover multiple JSON objects in same string
      check-qjson: Cover blank and lexically erroneous input
      check-qjson: Cover whitespace more thoroughly
      qmp-cmd-test: Split off qmp-test
      qmp-test: Cover syntax and lexical errors
      test-qga: Clean up how we test QGA synchronization
      check-qjson: Cover escaped characters more thoroughly, part 1
      check-qjson: Streamline escaped_string()'s test strings
      check-qjson: Cover escaped characters more thoroughly, part 2
      check-qjson: Consolidate partly redundant string tests
      check-qjson: Cover UTF-8 in single quoted strings
      check-qjson: Simplify utf8_string()
      check-qjson: Fix utf8_string() to test all invalid sequences
      check-qjson qmp-test: Cover control characters more thoroughly
      check-qjson: Cover interpolation more thoroughly
      json: Fix lexer to include the bad character in JSON_ERROR token
      json: Reject unescaped control characters
      json: Revamp lexer documentation
      json: Tighten and simplify qstring_from_escaped_str()'s loop
      check-qjson: Document we expect invalid UTF-8 to be rejected
      json: Reject invalid UTF-8 sequences
      json: Report first rather than last parse error
      json: Leave rejecting invalid UTF-8 to parser
      json: Accept overlong \xC0\x80 as U+0000 ("modified UTF-8")
      json: Leave rejecting invalid escape sequences to parser
      json: Simplify parse_string()
      json: Reject invalid \uXXXX, fix \u0000
      json: Fix \uXXXX for surrogate pairs
      check-qjson: Fix and enable utf8_string()'s disabled part
      json: Have lexer call streamer directly
      json: Redesign the callback to consume JSON values
      json: Don't pass null @tokens to json_parser_parse()
      json: Don't create JSON_ERROR tokens that won't be used
      json: Rename token JSON_ESCAPE & friends to JSON_INTERP
      json: Treat unwanted interpolation as lexical error
      json: Pass lexical errors and limit violations to callback
      json: Leave rejecting invalid interpolation to parser
      json: Replace %I64d, %I64u by %PRId64, %PRIu64
      json: Improve names of lexer states related to numbers
      qjson: Fix qobject_from_json() & friends for multiple values
      json: Fix latent parser aborts at end of input
      json: Fix streamer not to ignore trailing unterminated structures
      json: Assert json_parser_parse() consumes all tokens on success
      qjson: Have qobject_from_json() & friends reject empty and blank
      json: Enforce token count and size limits more tightly
      json: Streamline json_message_process_token()
      json: Unbox tokens queue in JSONMessageParser
      json: Make JSONToken opaque outside json-parser.c
      qobject: Drop superfluous includes of qemu-common.h
      json: Clean up headers
      tests/drive_del-test: Fix harmless JSON interpolation bug
      json: Keep interpolation state in JSONParserContext
      json: Improve safety of qobject_from_jsonf_nofail() & friends
      json: Support %% in JSON strings when interpolating
      json: Update references to RFC 7159 to RFC 8259

 MAINTAINERS                      |    1 +
 block.c                          |    5 -
 docs/interop/qmp-spec.txt        |   42 +-
 include/qapi/qmp/json-lexer.h    |   56 --
 include/qapi/qmp/json-parser.h   |   36 +-
 include/qapi/qmp/json-streamer.h |   46 --
 include/qapi/qmp/qerror.h        |    3 -
 include/qapi/qmp/qnum.h          |    2 +-
 include/qemu/unicode.h           |    1 +
 monitor.c                        |   21 +-
 qapi/introspect.json             |    2 +-
 qapi/qmp-dispatch.c              |    1 -
 qapi/qobject-input-visitor.c     |    5 -
 qga/main.c                       |   15 +-
 qobject/json-lexer.c             |  317 +++++-------
 qobject/json-parser-int.h        |   54 ++
 qobject/json-parser.c            |  379 +++++++-------
 qobject/json-streamer.c          |  126 +++--
 qobject/qbool.c                  |    1 -
 qobject/qjson.c                  |   31 +-
 qobject/qlist.c                  |    1 -
 qobject/qnull.c                  |    1 -
 qobject/qnum.c                   |    1 -
 qobject/qobject.c                |    1 -
 qobject/qstring.c                |    1 -
 tests/Makefile.include           |    3 +
 tests/check-qjson.c              | 1058 ++++++++++++++++++++------------=
------
 tests/drive_del-test.c           |    8 +-
 tests/libqtest.c                 |   57 +-
 tests/libqtest.h                 |   13 +
 tests/qmp-cmd-test.c             |  213 ++++++++
 tests/qmp-test.c                 |  252 +++------
 tests/test-qga.c                 |    3 +-
 util/unicode.c                   |   69 ++-
 34 files changed, 1484 insertions(+), 1341 deletions(-)
 delete mode 100644 include/qapi/qmp/json-lexer.h
 delete mode 100644 include/qapi/qmp/json-streamer.h
 create mode 100644 qobject/json-parser-int.h
 create mode 100644 tests/qmp-cmd-test.c

--=20
2.17.1
