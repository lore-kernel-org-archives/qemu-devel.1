Received: from eggs.gnu.org ([2001:4830:134:3::10]:38641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007xA-MD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bX-0007sv-RU
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bX-0007sD-Jo
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:20 +0200
Message-Id: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/32] Command line QAPIfication
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is a prototype to demonstrate where I'm headed.  PATCH 01-28 are
infrastructure, PATCH 29-32 QAPIfy a few options.

Plenty of infrastrucure work remains.  Some of it is marked TODO/FIXME
in the patches.  I've excluded work to improve backward keyval.c
compatibility with QemuOpts quirks for now.

Command line introspection is provided by query-qmp-schema for now.
Perhaps it should be separate.  See PATCH 25.

Documentation is generated into qemu-qmp-ref.*.  Perhaps it should be
separate.  See PATCH 26.

main() iterates over argv[] twice.  The second loop "executes" some
options directly.  PATCH 29+30 QAPIfy two of them.  Other options it
converts into a more convenient form, for later execution.  PATCH
31+32 QAPIfy two of them: the conversion becomes a no-op, because
QAPIfication already produces a convenient data type.

"Later execution" means the command line is executed in some magic
order mortal users can't predict.  Strict left-to-right would be
simpler and cleaner, but backward compatibility may compel us to
remain complicated and unclean.

qemu-img already duplicates --option.  I suspect we'll end up wanting
to QAPIfy that as well, sharing the common part of the QAPI schema.

Based-on: 20171002111111.26932-1-armbru@redhat.com
    [PULL 0/3] QAPI patches for 2017-10-02
Based-on: 20171002134538.23332-1-armbru@redhat.com
    [PATCH 0/3] hmp-commands-info: Texinfo fixes
Based-on: 20171002140307.5292-1-armbru@redhat.com
    [PATCH 0/8] qemu-options: Texinfo and --help fixes
Based-on: 20171002141341.24616-1-armbru@redhat.com
    [PATCH 00/11] qapi: Cleanups around qapi2texi

Markus Armbruster (32):
  tests/qapi-schema: Improve coverage of '@'
  texi2pod: Support @verbatim environment
  qapi2texi: Fix for examples containing '@'
  qapi2texi: Fix for '@' not followed by \w character
  qapi2texi: Provide access to Texinfo markup
  qapi2texi: Drop | example markup
  qapi: Drop superfluous allow_optional=True
  qapi: Simplify check_name() parameters
  qapi: check_type() parameter allow_optional is now unused, drop
  qapi: Don't run generators twice
  qapi: Drop the options to generate only .c or .h
  qapi: Use argparse to parse command line arguments
  qapi: Use argparse to open schema file
  qapi: Rework generated code for built-in types
  tests/qapi-schema: Improve simple union coverage
  qapi: Factor out _make_implicit_wrapper_type()
  qapi: Fix simple union lowering with multiple schemas
  docs/devel/qapi-code-gen.txt: Rewrite section on schema syntax
  qapi: Accept double-quoted strings
  qapi: Frontend for defining command line options
  qapi: Define QAPIOptionKind and QAPIOption automatically
  qapi: New helper c_string()
  qapi-options: Command line option backend
  qapi-options: Generate help string
  qapi-introspect: Include command line options information
  qapi2texi: Include command line options information
  os-posix: Drop misleading comment
  vl: QAPIfy command line option definition
  qapi/options: QAPIfy --echr argument type
  qapi/options: QAPIfy --watchdog-action argument type
  qapi/options: QAPIfy --blockdev argument type
  qapi/options: QAPIfy --add-fd argument type

 .gitignore                               |    4 +-
 Makefile                                 |  101 +-
 Makefile.objs                            |    4 +-
 docs/devel/qapi-code-gen.txt             |   83 +-
 include/qemu-common.h                    |    2 +-
 os-posix.c                               |   27 +-
 os-win32.c                               |    3 +-
 qapi-schema.json                         |    9 +-
 qapi/introspect.json                     |   22 +-
 qapi/options.json                        | 4574 ++++++++++++++++++++++++++++++
 qemu-doc.texi                            |    4 +-
 qemu-options-wrapper.h                   |   41 -
 qemu-options.h                           |   36 -
 qemu-options.hx                          | 4256 ---------------------------
 qga/Makefile.objs                        |    1 +
 scripts/qapi-commands.py                 |   13 +-
 scripts/qapi-event.py                    |   12 +-
 scripts/qapi-introspect.py               |   44 +-
 scripts/qapi-options.py                  |  212 ++
 scripts/qapi-types.py                    |   78 +-
 scripts/qapi-visit.py                    |   74 +-
 scripts/qapi.py                          |  350 ++-
 scripts/qapi2texi.py                     |   88 +-
 scripts/texi2pod.pl                      |   11 +-
 tests/Makefile.include                   |   56 +-
 tests/qapi-schema/builtins.err           |    0
 tests/qapi-schema/builtins.exit          |    1 +
 tests/qapi-schema/builtins.json          |    1 +
 tests/qapi-schema/builtins.out           |   33 +
 tests/qapi-schema/comments.out           |    3 -
 tests/qapi-schema/doc-bad-section.out    |    3 -
 tests/qapi-schema/doc-good.json          |   46 +-
 tests/qapi-schema/doc-good.out           |   70 +-
 tests/qapi-schema/doc-good.texi          |   82 +-
 tests/qapi-schema/empty.out              |    3 -
 tests/qapi-schema/event-case.out         |    3 -
 tests/qapi-schema/ident-with-escape.out  |    3 -
 tests/qapi-schema/include-relpath.out    |    3 -
 tests/qapi-schema/include-repetition.out |    3 -
 tests/qapi-schema/include-simple.out     |    3 -
 tests/qapi-schema/indented-expr.out      |    3 -
 tests/qapi-schema/qapi-schema-test.json  |   26 +-
 tests/qapi-schema/qapi-schema-test.out   |   64 +-
 tests/qapi-schema/test-qapi.py           |   22 +-
 tests/test-qapi-options.c                |   74 +
 vl.c                                     |  809 +++---
 46 files changed, 6151 insertions(+), 5209 deletions(-)
 create mode 100644 qapi/options.json
 delete mode 100644 qemu-options-wrapper.h
 delete mode 100644 qemu-options.h
 delete mode 100644 qemu-options.hx
 create mode 100644 scripts/qapi-options.py
 create mode 100644 tests/qapi-schema/builtins.err
 create mode 100644 tests/qapi-schema/builtins.exit
 create mode 100644 tests/qapi-schema/builtins.json
 create mode 100644 tests/qapi-schema/builtins.out
 create mode 100644 tests/test-qapi-options.c

-- 
2.13.6
