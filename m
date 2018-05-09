Received: from eggs.gnu.org ([2001:4830:134:3::10]:59654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNR-0003S5-W4
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNQ-0006Xq-32
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:17 +0200
Message-Id: <20180509165530.29561-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/13] block: Try to create well typed json:{}
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The =E2=80=9CTry=E2=80=9D in the subject of this series means more or les=
s the same as
the =E2=80=9CTry=E2=80=9D in the subject line of
http://lists.nongnu.org/archive/html/qemu-block/2018-05/msg00061.html .

The difference is that it=E2=80=99s not so important here, because the wo=
rst
outcome is that in very narrow edge cases[1] (e.g. you trying to use
password-secret for rbd) we fail to generate a properly typed json:{}
filename -- but that is no regression over what we currently have.  In
the vast majority of cases[1], this series will result in proper
typing.

Or, well, I should add that I=E2=80=99m not quite sure about all the edge
cases[1], solely because the current bdrv_refresh_filename() code is a
mess, especially when it comes to gathering the blockdev options.  But
I do know that after my series to address that (=E2=80=9Cblock: Fix some
filename generation issues=E2=80=9D), it only comes down to a very small =
number
of edge cases (the only hard edge case is rbd=E2=80=99s =3Dkeyvalue-pairs=
, but
that is kaput anyway).[1]

But since this series does not have any hard requirement on that other
one, I decided to send it independently.


[1] You might have noticed a number of [1]s above.  This is because the
above text is as it was in a version of this series with only five
patches in it.  Then I noticed a not-so-edge case where converting to
QAPI broke down: qcow(2) encryption.  Since qcow and qcow2 now support
both the old AES and luks encryption, and every encryption type may
offer its own runtime options, you now have a flat union there (under
=E2=80=9Cencrypt=E2=80=9D) which is discriminated based on encrypt.format=
.
Now the qcow2 driver can of course detect the format from the image
header, so you don=E2=80=99t really have to specify it.  In fact, when yo=
ur
options don=E2=80=99t go through QAPI, you actually don=E2=80=99t have to=
.  So this is
exactly the not-so-edge case I was talking about.

QAPI cannot parse encrypt before it knows encrypt.format.  So it=E2=80=99=
s much
too late when the qcow2 driver detects encrypt.format in its
.bdrv_open() plementation.

I=E2=80=99m more than happy to take alternative suggestions, but this is =
an
issue we really cannot ignore (unlike =3Dkeyvalue-pairs), so the two
solutions I came up with are:

(1) Say auto-detection was a bad idea and make encrypt.format mandatory,
    even without QAPI.  This is always a possibility, but it does seem
    kind of cumbersome to users, so I wanted to explore the other option
    first, not knowing how deep into the rabbit hole that would lead.

(2) Allow flat union discriminators to be optional.  Since both AES and
    luks encryption in practice only allow a key-secret option, we can
    add a new runtime encryption pseudo-type, which is =E2=80=9Cfrom-imag=
e=E2=80=9D that
    only allows such a key-secret option.  Now, when the user does not
    specify encrypt.format, the format is assumed to be =E2=80=9Cfrom-ima=
ge=E2=80=9D
    which means that you can specify a key-secret and qcow/qcow2 will
    figure out what encryption to use.
    This allows to retain compatibility with the current interface, but
    it also means this series exploded, and maybe the idea is
    universally hated.
    One issue I can see with this approach is how it would fare with new
    encryption types added; specifically, what if we add some encryption
    type that does not have a key-secret but something else?  Do we add
    that something else to from-image and make everything optional?  Or
    do we require users to explicitly specify the encryption type for
    such a new type when it is not compatible with from-image?
    In any case, one thing we have to watch out for from now on is that
    drivers must not allow options to be optional that are mandatory in
    the QAPI schema.
    More generally, we have to make sure that the driver=E2=80=99s interf=
ace on
    -drive is compatible to QAPI.  But I guess everybody knows that, so
    it=E2=80=99s good to be a bit more specific and say that this doesn=E2=
=80=99t just
    mean that options must match.  Mandatoriness must match also.

So, OK, obviously I chose solution (2) for now.  What this means is that
in this series:

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

- qdict_stringify_for_keyval() is added, as already proposed/hinted at
  in the rbd QAPI discussion.  This includes movement of many
  block-specific QDict function declarations into an own header, as
  suggested by Markus.

- json:{} filenames are attempted to be typed correctly when they are
  generated, by running bs->full_open_options through a healthy mix of
  qdict_flatten(), qdict_stringify_for_keyval(), qdict_crumple(), the
  keyval input visitor for BlockdevOptions, and the output visitor.
  This may not always work but I hope it usually will.  Fingers crossed.
  (At least it won=E2=80=99t make things worse.)

- Tests, tests, tests.


(Yes, I know that =E2=80=9CIn this series tests, tests, tests.=E2=80=9D i=
s not a
 sentence.)


Max Reitz (13):
  qapi: Add default-variant for flat unions
  docs/qapi: Document optional discriminators
  tests: Add QAPI optional discriminator tests
  qapi: Formalize qcow2 encryption probing
  qapi: Formalize qcow encryption probing
  block: Add block-specific QDict header
  qdict: Add qdict_stringify_for_keyval()
  tests: Add qdict_stringify_for_keyval() test
  qdict: Make qdict_flatten() shallow-clone-friendly
  tests: Add QDict clone-flatten test
  block: Try to create well typed json:{} filenames
  iotests: Test internal option typing
  iotests: qcow2's encrypt.format is now optional

 docs/devel/qapi-code-gen.txt                       | 21 +++++-
 tests/Makefile.include                             |  3 +
 qapi/block-core.json                               | 72 ++++++++++++++++=
--
 qapi/introspect.json                               |  8 ++
 ...ion-optional-discriminator-invalid-default.json | 12 +++
 ...at-union-optional-discriminator-no-default.json | 11 +++
 .../flat-union-optional-discriminator.json         |  4 +-
 .../flat-union-superfluous-default-variant.json    | 11 +++
 include/block/qdict.h                              | 37 +++++++++
 include/qapi/qmp/qdict.h                           | 17 -----
 block.c                                            | 70 ++++++++++++++++=
-
 block/gluster.c                                    |  1 +
 block/iscsi.c                                      |  1 +
 block/nbd.c                                        |  1 +
 block/nfs.c                                        |  1 +
 block/parallels.c                                  |  1 +
 block/qcow.c                                       |  1 +
 block/qcow2.c                                      |  1 +
 block/qed.c                                        |  1 +
 block/quorum.c                                     |  1 +
 block/rbd.c                                        |  1 +
 block/sheepdog.c                                   |  1 +
 block/snapshot.c                                   |  1 +
 block/ssh.c                                        |  1 +
 block/vhdx.c                                       |  1 +
 block/vpc.c                                        |  1 +
 block/vvfat.c                                      |  1 +
 block/vxhs.c                                       |  1 +
 blockdev.c                                         |  1 +
 qobject/qdict.c                                    | 81 ++++++++++++++++=
++--
 tests/check-qdict.c                                | 88 ++++++++++++++++=
++++++
 tests/check-qobject.c                              |  1 +
 tests/test-replication.c                           |  1 +
 util/qemu-config.c                                 |  1 +
 scripts/qapi/common.py                             | 57 +++++++++++---
 scripts/qapi/doc.py                                |  8 +-
 scripts/qapi/introspect.py                         | 10 ++-
 scripts/qapi/visit.py                              | 33 +++++++-
 ...nion-optional-discriminator-invalid-default.err |  1 +
 ...ion-optional-discriminator-invalid-default.exit |  1 +
 ...nion-optional-discriminator-invalid-default.out |  0
 ...lat-union-optional-discriminator-no-default.err |  1 +
 ...at-union-optional-discriminator-no-default.exit |  1 +
 ...lat-union-optional-discriminator-no-default.out |  0
 .../flat-union-optional-discriminator.err          |  1 -
 .../flat-union-optional-discriminator.exit         |  2 +-
 .../flat-union-optional-discriminator.out          | 15 ++++
 .../flat-union-superfluous-default-variant.err     |  1 +
 .../flat-union-superfluous-default-variant.exit    |  1 +
 .../flat-union-superfluous-default-variant.out     |  0
 tests/qapi-schema/test-qapi.py                     |  2 +
 tests/qemu-iotests/059.out                         |  2 +-
 tests/qemu-iotests/087                             |  2 -
 tests/qemu-iotests/089                             | 25 ++++++
 tests/qemu-iotests/089.out                         |  9 +++
 tests/qemu-iotests/099.out                         |  4 +-
 tests/qemu-iotests/110.out                         |  2 +-
 tests/qemu-iotests/198.out                         |  4 +-
 tests/qemu-iotests/207.out                         | 10 +--
 59 files changed, 580 insertions(+), 68 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.json
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.json
 create mode 100644 include/block/qdict.h
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.out
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.out
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.exit
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.out

--=20
2.14.3
