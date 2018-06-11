Received: from eggs.gnu.org ([2001:4830:134:3::10]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnX-0001kf-WA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnV-000825-Lj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:51:53 +0200
Message-Id: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] block: Try to create well typed
 json:{} filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

See cover letter of v1 here:
http://lists.nongnu.org/archive/html/qemu-block/2018-05/msg00290.html


This series depends on Markus's series "block: Configuration fixes and
rbd authentication":

Based-on: <20180607062559.16127-1-armbru@redhat.com>


Changes in v2:
- Rebased on top of Markus's series, which allowed my to drop
  qdict_stringify_for_keyval(), and the patch moving block-specific
  QDict functions into an own header
- %s/2.13/3.0/g

- Patch 1: [Eric]
  - s/must/will/
  - Set the discriminator field to its default value when not given,
    which simplifies the code both here and hopefully in the users, too
- Patch 3: [Eric]
  - Rename existing optional discriminator test and keep it as an error
    test, instead of making it pass
  - Add passing test to qapi-schema-test
- Patch 4: [Daniel]
  - %s/from-image/auto/g
  - Actually handle that format when specified explicitly
- Patch 5: [Eric/Daniel]
  - Reduced complexity by just defaulting to 'aes'
- Patch 6: Rewritten because of the rebase
- Patch 7: Rebase conflicts
- Patch 8:
  - Use qobject_input_visitor_new_flat_confused() from Markus's series
  - Some rebase conflicts in test outputs
  - Also, 198 now explicitly emits '"format": "auto"' due to visitors
    now setting the discriminator field to the default value, thanks to
    the change to patch 1 (working as intended, I suppose)
- Patch 10: Added a couple of qcow2+LUKS blockdev-add test cases for
            various values of encrypt.format


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/10:[0032] [FC] 'qapi: Add default-variant for flat unions'
002/10:[----] [--] 'docs/qapi: Document optional discriminators'
003/10:[0048] [FC] 'tests: Add QAPI optional discriminator tests'
004/10:[0025] [FC] 'qapi: Formalize qcow2 encryption probing'
005/10:[0027] [FC] 'qapi: Formalize qcow encryption probing'
006/10:[0042] [FC] 'qdict: Make qdict_flatten() shallow-clone-friendly'
007/10:[0002] [FC] 'tests: Add QDict clone-flatten test'
008/10:[0035] [FC] 'block: Try to create well typed json:{} filenames'
009/10:[----] [--] 'iotests: Test internal option typing'
010/10:[0089] [FC] 'iotests: qcow2's encrypt.format is now optional'


Max Reitz (10):
  qapi: Add default-variant for flat unions
  docs/qapi: Document optional discriminators
  tests: Add QAPI optional discriminator tests
  qapi: Formalize qcow2 encryption probing
  qapi: Formalize qcow encryption probing
  qdict: Make qdict_flatten() shallow-clone-friendly
  tests: Add QDict clone-flatten test
  block: Try to create well typed json:{} filenames
  iotests: Test internal option typing
  iotests: qcow2's encrypt.format is now optional

 docs/devel/qapi-code-gen.txt                  | 21 +++++-
 tests/Makefile.include                        |  5 +-
 qapi/block-core.json                          | 47 +++++++++++--
 qapi/introspect.json                          |  8 +++
 ...ptional-discriminator-invalid-default.json | 12 ++++
 ...l-discriminator-invalid-specification.json | 12 ++++
 ...on-optional-discriminator-no-default.json} |  5 +-
 ...lat-union-superfluous-default-variant.json | 11 ++++
 tests/qapi-schema/qapi-schema-test.json       |  9 +++
 block.c                                       | 66 ++++++++++++++++++-
 block/qcow2.c                                 |  3 +
 qobject/block-qdict.c                         | 19 ++++--
 tests/check-block-qdict.c                     | 33 ++++++++++
 scripts/qapi/common.py                        | 57 +++++++++++++---
 scripts/qapi/doc.py                           |  8 ++-
 scripts/qapi/introspect.py                    | 10 ++-
 scripts/qapi/visit.py                         | 13 ++++
 ...optional-discriminator-invalid-default.err |  1 +
 ...tional-discriminator-invalid-default.exit} |  0
 ...ptional-discriminator-invalid-default.out} |  0
 ...al-discriminator-invalid-specification.err |  1 +
 ...l-discriminator-invalid-specification.exit |  1 +
 ...al-discriminator-invalid-specification.out |  0
 ...nion-optional-discriminator-no-default.err |  1 +
 ...ion-optional-discriminator-no-default.exit |  1 +
 ...nion-optional-discriminator-no-default.out |  0
 .../flat-union-optional-discriminator.err     |  1 -
 ...flat-union-superfluous-default-variant.err |  1 +
 ...lat-union-superfluous-default-variant.exit |  1 +
 ...flat-union-superfluous-default-variant.out |  0
 tests/qapi-schema/qapi-schema-test.out        |  9 +++
 tests/qapi-schema/test-qapi.py                |  2 +
 tests/qemu-iotests/059.out                    |  2 +-
 tests/qemu-iotests/087                        | 65 ++++++++++--------
 tests/qemu-iotests/087.out                    | 26 +++++++-
 tests/qemu-iotests/089                        | 25 +++++++
 tests/qemu-iotests/089.out                    |  9 +++
 tests/qemu-iotests/099.out                    |  4 +-
 tests/qemu-iotests/110.out                    |  2 +-
 tests/qemu-iotests/198.out                    |  4 +-
 tests/qemu-iotests/207.out                    | 10 +--
 41 files changed, 436 insertions(+), 69 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.json
 rename tests/qapi-schema/{flat-union-optional-discriminator.json => flat-union-optional-discriminator-no-default.json} (70%)
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
 rename tests/qapi-schema/{flat-union-optional-discriminator.exit => flat-union-optional-discriminator-invalid-default.exit} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.out => flat-union-optional-discriminator-invalid-default.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.out
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.out
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.exit
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.out

-- 
2.17.1
