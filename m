Received: from eggs.gnu.org ([2001:4830:134:3::10]:58101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQC-0003Di-T4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQA-0002nH-4v
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:35:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQ9-0002mT-Ug
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:35:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:36 +0200
Message-Id: <20180627163551.31610-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/15] qapi: add #if pre-processor
 conditions to generated code (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi,

In order to clean-up some hacks in qapi (having to unregister commands
at runtime), I proposed a "[PATCH v5 02/20] qapi.py: add a simple #ifdef =
condition"

(see http://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03106.html).

However, we decided to drop that patch from the series and solve the
problem later. The main issues were:
- the syntax was awkward to the JSON schema and documentation
- the evaluation of the condition was done in the qapi scripts, with
  very limited capability
- each target/config would need different generated files.

Instead, it could defer the #if evaluation to the C-preprocessor.

With this series, top-level qapi JSON entity can take 'if' keys:

{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
  'if': 'defined(TEST_IF_STRUCT)' }

A benefit from having conditional schema is that introspection will
reflect more accurately the capability of the server. Another benefit
is that it may help to remove some dead code when disabling a
functionality.

Starting from patch "qapi: add conditions to VNC type/commands/events
on the schema", the series demonstrates adding conditions.

There are a lot more things one can make conditional in the QAPI
schema, like pci/kvm/xen/numa/vde/slirp/posix/win32/vsock/lzo etc etc,
however I am still evaluating the implication of such changes both
externally and internally, for those interested, I can share my wip
branch.

Comments welcome,

v6:
- subset of v5, which only adds top-level conditions (03-14,31 and
  applicable parts of 35-37)
- removed QAPI_REGENERATE test leftover
- comment ifcontext() usage
- simplify .start_if()/.end_if() with a single ._start_if member
- removed useless 'saved' variable
- renamed QAPIGenCSnippet -> QAPIGenCCode
- fix and add a test when a conditional command returns a common type
- use Markus version of "qapi-types: add #if conditions to types & visito=
rs"
- pylint fixes
- commit message fixes/changes
- rebased

v5:
- adapt to the new 'modular' / single generator design, making
  splitting schema a bit more complicated than before, when it was
  only at build-sys level. See "RFC: qapi: learn to split schema by
  'top-unit'" for the new apporach at splitting common and target
  parts.
- replace the #if-wrapper decorator with a @contextmanager (if necessary,
  this could be replaced by explicit begin/end calls instead now)
- better split of target events, introducing seperate limiter/emitter
- add a 'RFC: make RTC_CHANGE per-target' to show how conditional
  could be used and exercice the 'per-unit' event limiter
- +painful rebase
- add some r-b tags

v4:
- added "qlit: use QType instead of int" patch
- use a "default:" case in qobject_from_qlit()
- added a test for invalid 'if': ['']
- listify ifcond in constructors
- added "qapi: leave the ifcond attribute undefined until check()"
  patch (could be squashed)
- use a negative lookahead in "qapi: mcgen() shouldn't indent # lines"
- fix extra empty line in "qapi-introspect: add preprocessor
  conditions to generated QLit"
- added desugar/normalization passes, such as NAME -> { 'name': NAME }
- splitted "qapi: change enum visitor to take QAPISchemaMember"
- prettify test-qapi.py members output
- added missing #if wrapping for enum members in generated introspection
- clarified some error messages
- added "qapi: rename allow_dict to allow_implicit" patch for clarity
- added a seperate patch for "qapi: add a dictionnary form" for enum
  names
- added a seperate patch for "qapi: add a dictionnary form" for struct
  members
- squashed the patches adding #if to generated code (some types
  generate both enum and struct members for example, so a step-by-step
  is unnecessarily complicated to deal with)
- squashed some tests with related patch
- added "qapi: add an error in case a discriminator is conditionnal"
- add back VNC-specific crypto 'des-rfb' when VNC is disabled
- change the way unit filtering is done (so no -u means no filtering)
- made target.json the top-level documentation schema
- removed some blank lines in generated code output
- improve documentation, add various tests
- commit message improvements
- misc pycodestyle/pep8 fixes
- add r-b tags

v3:
- rebased (qlit is now merged upstream)
- solve the per-target #ifdef problem by using a target.json
  and new qapi generated target files
- update some commit messages based on Markus review
- more schema error reporting
- move the ifcond argument closer to info/doc
- use mcgen() in gen_if()/gen_endif()
- simplify "modify to_qlit() to take an optional suffix"
- fix generated qlit indentation
- fix temporary build break by merging #if types & visitors patch
- fix some redundant condtionals generation
- change enum visitor to take QAPISchemaMember
- reject unknown dictionnary keys in { .., 'if': ..}
- split qapi test visitor print() with trailing ',' trick

v2: after Markus review
 - "qboject: add literal qobject type", splitted & many updates
 - "qapi: generate a literal qobject for introspection", fixed leak
 - "visitor: pass size of strings array to enum visitor", rewrote as a
  series of patches to change char*[] to struct { int n, char *[] }.
 - split the "if" patches in parsing, tests, generation
 - added a docs/devel/qapi-code-gen.txt patch
 - added a patch to remove enum value assignment, to avoid "holes"
   with #if values
 - update #if VNC patch, compile out "info vnc", compile out des-rfb
 - dropped "qobject: replace dump_qobject() by qobject_to_string()" patch
 - dropped qapi.mk patch
 - other smaller changes

Marc-Andr=C3=A9 Lureau (14):
  qapi: add 'if' to top-level expressions
  tests
  qapi: pass 'if' condition into QAPISchemaEntity objects
  qapi: leave the ifcond attribute undefined until check()
  qapi: add 'ifcond' to visitor methods
  qapi: mcgen() shouldn't indent # lines
  qapi: add #if/#endif helpers
  qapi-introspect: modify to_qlit() to append ',' on level > 0
  qapi-introspect: add preprocessor conditions to generated QLit
  qapi/commands: add #if conditions to commands
  qapi/events: add #if conditions to events
  qapi: add 'If:' section to generated documentation
  qapi: add conditions to VNC type/commands/events on the schema
  qapi: add conditions to SPICE type/commands/events on the schema

Markus Armbruster (1):
  qapi-types: add #if conditions to types & visitors

 qapi/char.json                           |   8 +-
 qapi/ui.json                             |  75 +++---
 scripts/qapi/commands.py                 |  23 +-
 scripts/qapi/common.py                   | 283 ++++++++++++++++++-----
 scripts/qapi/doc.py                      |  32 +--
 scripts/qapi/events.py                   |   8 +-
 scripts/qapi/introspect.py               |  47 ++--
 scripts/qapi/types.py                    |  58 +++--
 scripts/qapi/visit.py                    |  41 ++--
 ui/vnc.h                                 |   2 +
 hmp.c                                    |   9 +-
 monitor.c                                |   3 -
 qmp.c                                    |  46 +---
 tests/test-qmp-cmds.c                    |  13 ++
 docs/devel/qapi-code-gen.txt             |  22 ++
 hmp-commands-info.hx                     |   2 +
 tests/Makefile.include                   |   4 +
 tests/qapi-schema/bad-if-empty-list.err  |   1 +
 tests/qapi-schema/bad-if-empty-list.exit |   1 +
 tests/qapi-schema/bad-if-empty-list.json |   3 +
 tests/qapi-schema/bad-if-empty-list.out  |   0
 tests/qapi-schema/bad-if-empty.err       |   1 +
 tests/qapi-schema/bad-if-empty.exit      |   1 +
 tests/qapi-schema/bad-if-empty.json      |   3 +
 tests/qapi-schema/bad-if-empty.out       |   0
 tests/qapi-schema/bad-if-list.err        |   1 +
 tests/qapi-schema/bad-if-list.exit       |   1 +
 tests/qapi-schema/bad-if-list.json       |   3 +
 tests/qapi-schema/bad-if-list.out        |   0
 tests/qapi-schema/bad-if.err             |   1 +
 tests/qapi-schema/bad-if.exit            |   1 +
 tests/qapi-schema/bad-if.json            |   3 +
 tests/qapi-schema/bad-if.out             |   0
 tests/qapi-schema/doc-good.json          |   2 +-
 tests/qapi-schema/doc-good.out           |   1 +
 tests/qapi-schema/doc-good.texi          |   2 +
 tests/qapi-schema/qapi-schema-test.json  |  26 +++
 tests/qapi-schema/qapi-schema-test.out   |  35 +++
 tests/qapi-schema/test-qapi.py           |  19 +-
 39 files changed, 554 insertions(+), 227 deletions(-)
 mode change 100644 =3D> 100755 scripts/qapi/doc.py
 create mode 100644 tests/qapi-schema/bad-if-empty-list.err
 create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 create mode 100644 tests/qapi-schema/bad-if-empty-list.json
 create mode 100644 tests/qapi-schema/bad-if-empty-list.out
 create mode 100644 tests/qapi-schema/bad-if-empty.err
 create mode 100644 tests/qapi-schema/bad-if-empty.exit
 create mode 100644 tests/qapi-schema/bad-if-empty.json
 create mode 100644 tests/qapi-schema/bad-if-empty.out
 create mode 100644 tests/qapi-schema/bad-if-list.err
 create mode 100644 tests/qapi-schema/bad-if-list.exit
 create mode 100644 tests/qapi-schema/bad-if-list.json
 create mode 100644 tests/qapi-schema/bad-if-list.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out

--=20
2.18.0.rc1
