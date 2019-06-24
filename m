Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A4C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2BF20645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2BF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfT6H-0007so-9h
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSwj-00018Z-A6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwc-0004fl-KG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwN-00041x-Ht; Mon, 24 Jun 2019 13:39:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 972333087930;
 Mon, 24 Jun 2019 17:39:37 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A895D9C5;
 Mon, 24 Jun 2019 17:39:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:20 +0200
Message-Id: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 17:39:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

There are two explanations of this cover letter, a relative one (to v3)
and an absolute one.


*** Important note ***

The final patch in this series is an example that converts most of
block-core.json to use default values where possible.  We may decide to
take it or not.  It isn=E2=80=99t important for the main purpose of this =
series,
so I=E2=80=99d be very much fine with chopping it off.

(It does have a nice diff stat, though.)

*** Important note end ***


Relative explanation:

The actual functional goal of this series is to allow all blockdev
options that can be represented with -drive to have an equivalent with
-blockdev (safe for rbd=E2=80=99s =3Dkeyvalue-pairs).

To this end, qcow(2)=E2=80=99s encryption needs an =E2=80=9Cauto=E2=80=9D=
 format which can
automatically deduce the format from the image header.  To make things
nicer, I decided (already in v1) to make this format optional so users
could just specify encrypt.secret and let the format driver figure out
the rest.

Until v3, this was implemented by letting the discriminator of flat
unions be optional, as long as a default-value is provided.  Markus
(rightfully) complained that this is very specific and would be covered
by just having default values for QAPI struct members in general.
So now this version implements this.  This is a bit more complicated
than just implementing a default-variant, mainly because the latter only
needs to accept enum values, whereas a generally usable =E2=80=9Cdefault=E2=
=80=9D should
accept values of all QAPI types (to the extent what is reasonable).

So what was (until v3)

  { 'union': 'Foo',
    'base': { '*discr': 'SomeEnum' },
    'discriminator': 'discr',
    'default-variant': 'value1',
    'data': { 'value1': 'Bar', 'value2': 'Baz' } }

becomes

  { 'union': 'Foo',
    'base': { '*discr': { 'type': 'SomeEnum', 'default': 'value1' } },
    'discriminator': 'discr',
    'data': { 'value1': 'Bar', 'value2': 'Baz' } }



Absolute explanation:

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


This is achieved by patch 11, which makes bdrv_refresh_filename() run
the options through the flat-confused input visitor, and then through
the output visitor to get all to the correct type.  If anything fails,
the result is as before (hence the =E2=80=9CTry=E2=80=9D in the title).

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
discriminators optional and provide a default.  This is accomplished by
generally allowing default values to be provided for QAPI struct
members.

Both AES and LUKS encryption allow only a key-secret option, so we can
add a new pseudo-format =E2=80=9Cauto=E2=80=9D that accepts exactly that =
option and
makes the qcow2 driver read the real format from the image header.  This
pseudo-format is made the default for encrypt.format, and thus you can
then specify encrypt.key-secret without having to specify
encrypt.format (while still adhering to the QAPI schema).


So, in this series:
- The QAPI code generator is modified to allow default values for
  optional struct members.  This in turn allows flat union
  discriminators be optional, too, but only if a default value is
  provided.
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


v4:
- Drop the default-variant stuff and replace it by a more general
  concept of allowing default values for all QAPI struct members


git backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/14:[down] 'qapi: Parse numeric values'
002/14:[down] 'qapi: Move to_c_string() to common.py'
003/14:[down] 'qapi: Introduce default values for struct members'
004/14:[down] 'qapi: Allow optional discriminators'
005/14:[down] 'qapi: Document default values for struct members'
006/14:[down] 'test-qapi: Print struct members' default values'
007/14:[down] 'tests: Test QAPI default values for struct members'
008/14:[0044] [FC] 'tests: Add QAPI optional discriminator tests'
009/14:[0009] [FC] 'qapi: Formalize qcow2 encryption probing'
010/14:[0005] [FC] 'qapi: Formalize qcow encryption probing'
011/14:[0014] [FC] 'block: Try to create well typed json:{} filenames'
012/14:[----] [--] 'iotests: Test internal option typing'
013/14:[----] [--] 'iotests: qcow2's encrypt.format is now optional'
014/14:[down] 'block: Make use of QAPI defaults'


Max Reitz (14):
  qapi: Parse numeric values
  qapi: Move to_c_string() to common.py
  qapi: Introduce default values for struct members
  qapi: Allow optional discriminators
  qapi: Document default values for struct members
  test-qapi: Print struct members' default values
  tests: Test QAPI default values for struct members
  tests: Add QAPI optional discriminator tests
  qapi: Formalize qcow2 encryption probing
  qapi: Formalize qcow encryption probing
  block: Try to create well typed json:{} filenames
  iotests: Test internal option typing
  iotests: qcow2's encrypt.format is now optional
  block: Make use of QAPI defaults

 docs/devel/qapi-code-gen.txt                  |  81 +++++-
 tests/Makefile.include                        |  17 +-
 qapi/block-core.json                          | 180 +++++++++-----
 qapi/introspect.json                          |   9 +-
 tests/qapi-schema/bad-type-int.json           |   1 -
 tests/qapi-schema/enum-int-member.json        |   1 -
 ...l-discriminator-invalid-specification.json |  11 +
 ...on-optional-discriminator-no-default.json} |   5 +-
 tests/qapi-schema/qapi-schema-test.json       |  38 +++
 .../struct-member-alternate-default.json      |  10 +
 ...struct-member-bool-wrong-default-type.json |   3 +
 .../struct-member-enum-invalid-default.json   |   4 +
 ...struct-member-enum-wrong-default-type.json |   4 +
 .../struct-member-float-invalid-default.json  |   4 +
 ...truct-member-float-wrong-default-type.json |   3 +
 .../struct-member-int-wrong-default-type.json |   3 +
 .../struct-member-int8-erange-default.json    |   3 +
 .../struct-member-list-nonempty-default.json  |   4 +
 .../struct-member-non-optional-default.json   |   3 +
 .../struct-member-null-default.json           |   6 +
 .../struct-member-str-wrong-default-type.json |   3 +
 .../struct-member-uint8-erange-default.json   |   3 +
 .../struct-member-uint8-negative-default.json |   3 +
 block.c                                       |  68 ++++-
 block/file-posix.c                            |   9 -
 block/file-win32.c                            |   8 +-
 block/parallels.c                             |   6 +-
 block/qcow2.c                                 |  39 +--
 block/qed.c                                   |   3 -
 block/sheepdog.c                              |   3 -
 block/vdi.c                                   |   3 -
 block/vhdx.c                                  |  28 +--
 block/vpc.c                                   |   3 -
 blockdev.c                                    | 182 +++-----------
 monitor/hmp-cmds.c                            |  27 +-
 monitor/qmp-cmds.c                            |   3 +-
 scripts/qapi/commands.py                      |   2 +-
 scripts/qapi/common.py                        | 232 ++++++++++++++++--
 scripts/qapi/doc.py                           |  20 +-
 scripts/qapi/introspect.py                    |   8 +-
 scripts/qapi/types.py                         |   2 +-
 scripts/qapi/visit.py                         |  38 ++-
 tests/qapi-schema/bad-type-int.err            |   2 +-
 tests/qapi-schema/enum-int-member.err         |   2 +-
 ...al-discriminator-invalid-specification.err |   1 +
 ...-discriminator-invalid-specification.exit} |   0
 ...l-discriminator-invalid-specification.out} |   0
 ...nion-optional-discriminator-no-default.err |   1 +
 ...ion-optional-discriminator-no-default.exit |   1 +
 ...nion-optional-discriminator-no-default.out |   0
 .../flat-union-optional-discriminator.err     |   1 -
 tests/qapi-schema/leading-comma-list.err      |   2 +-
 tests/qapi-schema/qapi-schema-test.out        |  33 +++
 .../struct-member-alternate-default.err       |   1 +
 .../struct-member-alternate-default.exit      |   1 +
 .../struct-member-alternate-default.out       |   0
 .../struct-member-bool-wrong-default-type.err |   1 +
 ...struct-member-bool-wrong-default-type.exit |   1 +
 .../struct-member-bool-wrong-default-type.out |   0
 .../struct-member-enum-invalid-default.err    |   1 +
 .../struct-member-enum-invalid-default.exit   |   1 +
 .../struct-member-enum-invalid-default.out    |   0
 .../struct-member-enum-wrong-default-type.err |   1 +
 ...struct-member-enum-wrong-default-type.exit |   1 +
 .../struct-member-enum-wrong-default-type.out |   0
 .../struct-member-float-invalid-default.err   |   1 +
 .../struct-member-float-invalid-default.exit  |   1 +
 .../struct-member-float-invalid-default.out   |   0
 ...struct-member-float-wrong-default-type.err |   1 +
 ...truct-member-float-wrong-default-type.exit |   1 +
 ...struct-member-float-wrong-default-type.out |   0
 .../struct-member-int-wrong-default-type.err  |   1 +
 .../struct-member-int-wrong-default-type.exit |   1 +
 .../struct-member-int-wrong-default-type.out  |   0
 .../struct-member-int8-erange-default.err     |   1 +
 .../struct-member-int8-erange-default.exit    |   1 +
 .../struct-member-int8-erange-default.out     |   0
 .../struct-member-list-nonempty-default.err   |   1 +
 .../struct-member-list-nonempty-default.exit  |   1 +
 .../struct-member-list-nonempty-default.out   |   0
 .../struct-member-non-optional-default.err    |   1 +
 .../struct-member-non-optional-default.exit   |   1 +
 .../struct-member-non-optional-default.out    |   0
 .../struct-member-null-default.err            |   1 +
 .../struct-member-null-default.exit           |   1 +
 .../struct-member-null-default.out            |   0
 .../struct-member-str-wrong-default-type.err  |   1 +
 .../struct-member-str-wrong-default-type.exit |   1 +
 .../struct-member-str-wrong-default-type.out  |   0
 .../struct-member-uint8-erange-default.err    |   1 +
 .../struct-member-uint8-erange-default.exit   |   1 +
 .../struct-member-uint8-erange-default.out    |   0
 .../struct-member-uint8-negative-default.err  |   1 +
 .../struct-member-uint8-negative-default.exit |   1 +
 .../struct-member-uint8-negative-default.out  |   0
 tests/qapi-schema/test-qapi.py                |   8 +-
 tests/qemu-iotests/059.out                    |   2 +-
 tests/qemu-iotests/087                        |  65 +++--
 tests/qemu-iotests/087.out                    |  26 +-
 tests/qemu-iotests/089                        |  25 ++
 tests/qemu-iotests/089.out                    |   9 +
 tests/qemu-iotests/099.out                    |   4 +-
 tests/qemu-iotests/110.out                    |   2 +-
 tests/qemu-iotests/198.out                    |   4 +-
 104 files changed, 915 insertions(+), 384 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.json
 rename tests/qapi-schema/{flat-union-optional-discriminator.json =3D> fl=
at-union-optional-discriminator-no-default.json} (68%)
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.jso=
n
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.json
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
json
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.json
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.json
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.json
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.json
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.j=
son
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.json
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
json
 create mode 100644 tests/qapi-schema/struct-member-null-default.json
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.json
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
json
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.err
 rename tests/qapi-schema/{flat-union-optional-discriminator.exit =3D> fl=
at-union-optional-discriminator-invalid-specification.exit} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.out =3D> fla=
t-union-optional-discriminator-invalid-specification.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.out
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.e=
rr
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.err
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.exi=
t
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.out
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.err
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.exit
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.out
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
err
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
exit
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
out
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.err
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.exit
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.out
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.err
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.exit
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.out
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.err
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.exit
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.out
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.err
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.exit
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.out
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.e=
rr
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.e=
xit
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.o=
ut
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.err
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.exit
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.out
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
err
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
exit
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
out
 create mode 100644 tests/qapi-schema/struct-member-null-default.err
 create mode 100644 tests/qapi-schema/struct-member-null-default.exit
 create mode 100644 tests/qapi-schema/struct-member-null-default.out
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.err
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.exit
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.out
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
err
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
exit
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
out
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.err
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.exit
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.out

--=20
2.21.0


