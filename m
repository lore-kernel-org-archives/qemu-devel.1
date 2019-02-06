Received: from eggs.gnu.org ([209.51.188.92]:38171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTId-0008Pc-En
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIb-0007s6-SO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:55:59 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:43 +0100
Message-Id: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] block: Try to create well-typed json:{}
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This series depends on my "Fix some filename generation issues" series.

Based-on: <20190201192935.18394-1-mreitz@redhat.com>


When qemu reports json:{} filename, it just uses whatever type you gave
an option in.  With -drive, all options are strings and they do not have
to pass the test of the typing firewall of the QAPI schema, so you just
get strings thrown back at you even if that does not match the schema.
(Also, if you use json:{} yourself, you=E2=80=99re free to give the optio=
ns as
strings as well.)

Example:

$ ./qemu-img info --image-opts driver=3Draw,size=3D512,file.driver=3Dnull=
-co
image: json:{"driver": "raw", "size": "512", "file": {"driver": "null-co"=
}}

@size is supposed to be an integer, according to the schema, so the
correct result would be (which is what you get after this series):

$ ./qemu-img info --image-opts driver=3Draw,size=3D512,file.driver=3Dnull=
-co
image: json:{"driver": "raw", "size": 512, "file": {"driver": "null-co"}}


This is achieved by patch 6, which makes bdrv_refresh_filename() run the
options through the flat-confused input visitor, and then through the
output visitor to get all to the correct type.  If anything fails, the
result is as before (hence the =E2=80=9CTry=E2=80=9D in the title).

There are cases where this cannot work.  Those are the ones where -drive
accepts something that is not allowed by the QAPI schema.  One of these
cases is rbd=E2=80=99s =3Dkeyvalue-pairs, which is just broken altogether=
, so
let=E2=80=99s simply ignore that.  (I don=E2=80=99t think anybody=E2=80=99=
s going to complain
that the json:{} filename they get is not correctly typed after they=E2=80=
=99ve
used that option.)

The other case (I know of) is qcow(2)=E2=80=99s encryption.  In the QAPI =
schema,
encrypt.format is not optional because it is the discriminator for which
kind of options to use.  However, for -drive, it is optional because the
qcow2 driver can infer the encryption format from the image header.

The solution that=E2=80=99s proposed by this series is to make flat union
discriminators optional and provide a default.  Both AES and LUKS
encryption allow only a key-secret option, so we can add a new
pseudo-format =E2=80=9Cauto=E2=80=9D that accepts exactly that option and=
 makes the
qcow2 driver read the real format from the image header.  This
pseudo-format is made the default for encrypt.format, and thus you can
then specify encrypt.key-secret without having to specify
encrypt.format (while still adhering to the QAPI schema).


So, in this series:
- The QAPI code generator is modified to allow optional discriminators
  for flat unions.  In such a case, a default-variant must be supplied
  to choose when the discriminator value is not present on the wire.
  - Accordingly, documentation, tests, and introspection are adjusted.

- This is used to make qcow=E2=80=99s and qcow2=E2=80=99s encrypt.format =
parameter
  optional.  It now defaults to =E2=80=9Cfrom-image=E2=80=9D which is a n=
ew
  pseudo-format that allows a key-secret to be given, and otherwise
  leaves it to the format driver to determine the encryption format.

- json:{} filenames are attempted to be typed correctly when they are
  generated, by running bs->full_open_options through a healthy mix of
  qdict_flatten(), the flat-confused input visitor for BlockdevOptions,
  and the output visitor.
  This may not always work but I hope it usually will.  Fingers crossed.
  (At least it won=E2=80=99t make things worse.)

- Tests, tests, tests.


(Yes, I know that =E2=80=9CIn this series tests, tests, tests.=E2=80=9D i=
s not a
 sentence.)


v3:
- Rebased
- Dropped the new superfluous empty struct
  ImageInfoSpecificQCow2EncryptionNoInfo, and moved some of its
  description to ImageInfoSpecificQCow2Encryption


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/8:[0037] [FC] 'qapi: Add default-variant for flat unions'
002/8:[----] [-C] 'docs/qapi: Document optional discriminators'
003/8:[0005] [FC] 'tests: Add QAPI optional discriminator tests'
004/8:[0021] [FC] 'qapi: Formalize qcow2 encryption probing'
005/8:[----] [--] 'qapi: Formalize qcow encryption probing'
006/8:[0006] [FC] 'block: Try to create well typed json:{} filenames'
007/8:[----] [--] 'iotests: Test internal option typing'
008/8:[0006] [FC] 'iotests: qcow2's encrypt.format is now optional'


Max Reitz (8):
  qapi: Add default-variant for flat unions
  docs/qapi: Document optional discriminators
  tests: Add QAPI optional discriminator tests
  qapi: Formalize qcow2 encryption probing
  qapi: Formalize qcow encryption probing
  block: Try to create well typed json:{} filenames
  iotests: Test internal option typing
  iotests: qcow2's encrypt.format is now optional

 docs/devel/qapi-code-gen.txt                  | 21 +++++-
 tests/Makefile.include                        |  5 +-
 qapi/block-core.json                          | 34 ++++++++--
 qapi/introspect.json                          |  8 +++
 ...ptional-discriminator-invalid-default.json | 12 ++++
 ...l-discriminator-invalid-specification.json | 12 ++++
 ...on-optional-discriminator-no-default.json} |  5 +-
 ...lat-union-superfluous-default-variant.json | 11 +++
 tests/qapi-schema/qapi-schema-test.json       | 11 +++
 block.c                                       | 68 ++++++++++++++++++-
 block/qcow2.c                                 |  3 +
 scripts/qapi/common.py                        | 58 +++++++++++++---
 scripts/qapi/doc.py                           | 10 ++-
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
 tests/qapi-schema/qapi-schema-test.out        | 10 +++
 tests/qapi-schema/test-qapi.py                |  2 +
 tests/qemu-iotests/059.out                    |  2 +-
 tests/qemu-iotests/087                        | 65 +++++++++++-------
 tests/qemu-iotests/087.out                    | 26 ++++++-
 tests/qemu-iotests/089                        | 25 +++++++
 tests/qemu-iotests/089.out                    |  9 +++
 tests/qemu-iotests/099.out                    |  4 +-
 tests/qemu-iotests/110.out                    |  2 +-
 tests/qemu-iotests/198.out                    |  4 +-
 tests/qemu-iotests/207.out                    | 10 +--
 39 files changed, 384 insertions(+), 64 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.json
 rename tests/qapi-schema/{flat-union-optional-discriminator.json =3D> fl=
at-union-optional-discriminator-no-default.json} (70%)
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.err
 rename tests/qapi-schema/{flat-union-optional-discriminator.exit =3D> fl=
at-union-optional-discriminator-invalid-default.exit} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.out =3D> fla=
t-union-optional-discriminator-invalid-default.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.out
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.out
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.e=
rr
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.exit
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.out

--=20
2.20.1
