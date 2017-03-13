Received: from eggs.gnu.org ([2001:4830:134:3::10]:54879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnNH6-0006nH-Sl
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnNH1-0007o0-Gz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:32:24 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:33342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnNH0-0007nY-Pz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:32:19 -0400
Received: by mail-lf0-x229.google.com with SMTP id a6so61682112lfa.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Mar 2017 10:32:03 +0000
Message-ID: <CAJ+F1CKiE2FHjS0_K2F+yS-ByZMtVVFh6+NLm_q4_myeg=_KdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/47] qapi: Put type information
 back into QMP documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <armbru@redhat.com>
wrote:

> I'm proposing this is 2.9 because it fixes a documentation regression.
> It affects only documentation; generated C code is unchanged except
> for the removal of trailing space in PATCH 46.
>
> Based on my qapi-next branch, which contains Marc-Andr=C3=A9's PATCH 1/2.
>
> Marc-Andr=C3=A9's work to merge qmp-commands.txt and qmp-events.txt into
> the QAPI schema and generate their replacements from the schema
> (commit b6af8ea..56e8bdd) was a big step forward.  As committed, it
> also was a step back: the documentation lost information on JSON
> types, because I didn't like Marc-Andr=C3=A9's patch to add it.  He
> reposted it for further review afterwards:
>
>     Subject: [PATCH 0/2] qapi2texi: add type information
>     Message-Id: <20170125130308.16104-1-marcandre.lureau@redhat.com>
>     https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05432.html
>
> His PATCH 1/2 is a straightforward cleanup.  His PATCH 2/2 adds type
> descriptions in a new formal language to the generated documentation.
> Quoting the commit message:
>
>     Array types have the following syntax: type[]. Ex: str[].
>
>     - Struct, commands and events use the following members syntax:
>
>       { 'member': type, ('foo': str), ... }
>
>     Optional members are under parentheses.
>
>     A structure with a base type will have 'BaseStruct +' prepended.
>
>     - Alternates use the following syntax:
>
>       [ 'foo': type, 'bar': type, ... ]
>
>     - Simple unions use the following syntax:
>
>       { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar': type... ] }
>
>     - Flat unions use the following syntax:
>
>       BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar': type... ]
>
> End quote.  Looks like this in generated documentation:
>
>  -- Event: VNC_CONNECTED {'server': VncServerInfo, 'client':
>           VncBasicInfo}
>
>      Emitted when a VNC client establishes a connection
>      ''server''
>           server information
>      ''client''
>           client information
>
>      Note: This event is emitted before any authentication takes place,
>      thus the authentication ID is not provided
> [...]
>
>  -- Struct: VncServerInfo VncBasicInfo + {('auth': str)}
>
>      The network connection information for server
>      ''auth'' (optional)
>           authentication method used for the plain (non-websocket) VNC
>           server
>
>      Since: 2.1
>
>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D ['inet'=
:
>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
>           VsockSocketAddress, 'fd': String] }
>
>      Captures the address of a socket, which could also be a named file
>      descriptor
>
>      Since: 1.3
>
> Here's my counter-proposal: instead of inventing a formal language,
> fix the natural language documentation to actually mention *all*
> members, and add type information in a plain, easy-to-understand way.
> Looks like this:
>
>  -- Event: VNC_CONNECTED
>
>      Emitted when a VNC client establishes a connection
>
>      Arguments:
>      'server: VncServerInfo'
>           server information
>      'client: VncBasicInfo'
>           client information
>
>      Note: This event is emitted before any authentication takes place,
>      thus the authentication ID is not provided
> [...]
>
>  -- Object: VncServerInfo
>
>      The network connection information for server
>
>      Members:
>      'auth: string' (optional)
>           authentication method used for the plain (non-websocket) VNC
>           server
>      The members of 'VncBasicInfo'
>
>      Since: 2.1
>
>  -- Object: SocketAddress
>
>      Captures the address of a socket, which could also be a named file
>      descriptor
>
>      Members:
>      'type'
>           One of "inet", "unix", "vsock", "fd"
>      'data: InetSocketAddress' when 'type' is "inet"
>      'data: UnixSocketAddress' when 'type' is "unix"
>      'data: VsockSocketAddress' when 'type' is "vsock"
>      'data: String' when 'type' is "fd"
>
>      Since: 1.3
>
>
I like both, to me they serve different purposes. I like to have a short
overview / signature and then a more detailed documentation for each field.

Additionally, my series fixes a number of bugs and cleans up along the
> way.  In particular, it converts qapi2texi.py from parse trees to the
> visitor interface the other generators use.
>
>
Your series failed to apply in patchew, and I can't find the branch in your
repo. Could you publish it?


> Future generated documentation work includes eliding types that aren't
> visible in QMP (like introspection does), and making uses of type
> names links in HTML.
>
>
Yes, links would be really nice.

Thanks


> Markus Armbruster (47):
>   qapi: Factor QAPISchemaParser._include() out of .__init__()
>   qapi: Make doc comments optional where we don't need them
>   qapi: Back out doc comments added just to please qapi.py
>   docs/qapi-code-gen.txt: Drop confusing reference to 'gen'
>   qapi: Have each QAPI schema declare its returns white-list
>   qapi: Have each QAPI schema declare its name rule violations
>   qapi: Clean up build of generated documentation
>   tests/qapi-schema: Cover empty union base
>   qapi: Fix to reject empty union base gracefully
>   qapi2texi: Fix up output around #optional
>   qapi: Avoid unwanted blank lines in QAPIDoc
>   qapi/rocker: Fix up doc comment notes on optional members
>   qapi: Fix QAPISchemaEnumType.is_implicit() for 'QType'
>   qapi: Prepare for requiring more complete documentation
>   qapi: Conjure up QAPIDoc.ArgSection for undocumented members
>   qapi2texi: Convert to QAPISchemaVisitor
>   qapi: The #optional tag is redundant, drop
>   qapi: Use raw strings for regular expressions consistently
>   qapi: Prefer single-quoted strings more consistently
>   qapi2texi: Plainer enum value and member name formatting
>   qapi2texi: Present the table of members more clearly
>   qapi2texi: Explain enum value undocumentedness more clearly
>   qapi2texi: Don't hide undocumented members and arguments
>   qapi2texi: Implement boxed argument documentation
>   qapi2texi: Include member type in generated documentation
>   qapi2texi: Generate reference to base type members
>   qapi2texi: Generate documentation for variant members
>   qapi2texi: Generate descriptions for simple union tags
>   qapi2texi: Use category "Object" for all object types
>   tests/qapi-schema: Improve doc / expression mismatch coverage
>   qapi: Fix detection of doc / expression mismatch
>   qapi: Move detection of doc / expression name mismatch
>   qapi: Improve error message on @NAME: in free-form doc
>   qapi: Move empty doc section checking to doc parser
>   tests/qapi-schema: Rename doc-bad-args to doc-bad-command-arg
>   tests/qapi-schema: Improve coverage of bogus member docs
>   qapi: Fix detection of bogus member documentation
>   qapi: Eliminate check_docs() and drop QAPIDoc.expr
>   qapi: Drop unused variable events
>   qapi: Simplify what gets stored in enum_types
>   qapi: Factor add_name() calls out of the meta conditional
>   qapi: enum_types is a list used like a dict, make it one
>   qapi: struct_types is a list used like a dict, make it one
>   qapi: union_types is a list used like a dict, make it one
>   qapi: Drop unused .check_clash() parameter schema
>   qapi: Make pylint a bit happier
>   qapi: Fix a misleading parser error message
>
>  .gitignore                                         |  10 +-
>  Makefile                                           |  27 +-
>  docs/qapi-code-gen.txt                             |  81 +--
>  docs/qemu-qmp-ref.texi                             |   2 +-
>  docs/writing-qmp-commands.txt                      |   4 +-
>  qapi-schema.json                                   | 403 ++++++-------
>  qapi/block-core.json                               | 428 +++++++-------
>  qapi/block.json                                    |   8 +-
>  qapi/crypto.json                                   |  22 +-
>  qapi/event.json                                    |  10 +-
>  qapi/introspect.json                               |   6 +-
>  qapi/rocker.json                                   |  88 +--
>  qapi/trace.json                                    |   6 +-
>  qga/qapi-schema.json                               |  55 +-
>  rules.mak                                          |   2 +-
>  scripts/qapi-commands.py                           |   6 +-
>  scripts/qapi-event.py                              |   2 +-
>  scripts/qapi-introspect.py                         |   4 +-
>  scripts/qapi-types.py                              |   4 +-
>  scripts/qapi-visit.py                              |   5 +-
>  scripts/qapi.py                                    | 632
> ++++++++++-----------
>  scripts/qapi2texi.py                               | 298 +++++-----
>  tests/Makefile.include                             |   9 +-
>  tests/qapi-schema/alternate-any.err                |   2 +-
>  tests/qapi-schema/alternate-any.json               |   4 -
>  tests/qapi-schema/alternate-array.err              |   2 +-
>  tests/qapi-schema/alternate-array.json             |   7 -
>  tests/qapi-schema/alternate-base.err               |   2 +-
>  tests/qapi-schema/alternate-base.json              |   7 -
>  tests/qapi-schema/alternate-clash.err              |   2 +-
>  tests/qapi-schema/alternate-clash.json             |   4 -
>  tests/qapi-schema/alternate-conflict-dict.err      |   2 +-
>  tests/qapi-schema/alternate-conflict-dict.json     |  10 -
>  tests/qapi-schema/alternate-conflict-string.err    |   2 +-
>  tests/qapi-schema/alternate-conflict-string.json   |   7 -
>  tests/qapi-schema/alternate-empty.err              |   2 +-
>  tests/qapi-schema/alternate-empty.json             |   4 -
>  tests/qapi-schema/alternate-nested.err             |   2 +-
>  tests/qapi-schema/alternate-nested.json            |   7 -
>  tests/qapi-schema/alternate-unknown.err            |   2 +-
>  tests/qapi-schema/alternate-unknown.json           |   4 -
>  tests/qapi-schema/args-alternate.err               |   2 +-
>  tests/qapi-schema/args-alternate.json              |   8 -
>  tests/qapi-schema/args-any.err                     |   2 +-
>  tests/qapi-schema/args-any.json                    |   4 -
>  tests/qapi-schema/args-array-empty.err             |   2 +-
>  tests/qapi-schema/args-array-empty.json            |   4 -
>  tests/qapi-schema/args-array-unknown.err           |   2 +-
>  tests/qapi-schema/args-array-unknown.json          |   4 -
>  tests/qapi-schema/args-bad-boxed.err               |   2 +-
>  tests/qapi-schema/args-bad-boxed.json              |   4 -
>  tests/qapi-schema/args-boxed-anon.err              |   2 +-
>  tests/qapi-schema/args-boxed-anon.json             |   4 -
>  tests/qapi-schema/args-boxed-empty.err             |   2 +-
>  tests/qapi-schema/args-boxed-empty.json            |   8 -
>  tests/qapi-schema/args-boxed-string.err            |   2 +-
>  tests/qapi-schema/args-boxed-string.json           |   4 -
>  tests/qapi-schema/args-int.err                     |   2 +-
>  tests/qapi-schema/args-int.json                    |   4 -
>  tests/qapi-schema/args-invalid.err                 |   2 +-
>  tests/qapi-schema/args-invalid.json                |   3 -
>  tests/qapi-schema/args-member-array-bad.err        |   2 +-
>  tests/qapi-schema/args-member-array-bad.json       |   4 -
>  tests/qapi-schema/args-member-case.err             |   2 +-
>  tests/qapi-schema/args-member-case.json            |   4 -
>  tests/qapi-schema/args-member-unknown.err          |   2 +-
>  tests/qapi-schema/args-member-unknown.json         |   4 -
>  tests/qapi-schema/args-name-clash.err              |   2 +-
>  tests/qapi-schema/args-name-clash.json             |   4 -
>  tests/qapi-schema/args-union.err                   |   2 +-
>  tests/qapi-schema/args-union.json                  |   7 -
>  tests/qapi-schema/args-unknown.err                 |   2 +-
>  tests/qapi-schema/args-unknown.json                |   4 -
>  tests/qapi-schema/bad-base.err                     |   2 +-
>  tests/qapi-schema/bad-base.json                    |   7 -
>  tests/qapi-schema/bad-data.err                     |   2 +-
>  tests/qapi-schema/bad-data.json                    |   4 -
>  tests/qapi-schema/bad-ident.err                    |   2 +-
>  tests/qapi-schema/bad-ident.json                   |   4 -
>  tests/qapi-schema/bad-type-bool.err                |   2 +-
>  tests/qapi-schema/bad-type-bool.json               |   4 -
>  tests/qapi-schema/bad-type-dict.err                |   2 +-
>  tests/qapi-schema/bad-type-dict.json               |   4 -
>  tests/qapi-schema/base-cycle-direct.err            |   2 +-
>  tests/qapi-schema/base-cycle-direct.json           |   4 -
>  tests/qapi-schema/base-cycle-indirect.err          |   2 +-
>  tests/qapi-schema/base-cycle-indirect.json         |   7 -
>  tests/qapi-schema/command-int.err                  |   2 +-
>  tests/qapi-schema/command-int.json                 |   4 -
>  tests/qapi-schema/comments.json                    |   4 -
>  tests/qapi-schema/comments.out                     |   1 -
>  tests/qapi-schema/doc-bad-alternate-member.err     |   1 +
>  ...optional.exit =3D> doc-bad-alternate-member.exit} |   0
>  tests/qapi-schema/doc-bad-alternate-member.json    |   9 +
>  ...c-optional.out =3D> doc-bad-alternate-member.out} |   0
>  tests/qapi-schema/doc-bad-args.err                 |   1 -
>  tests/qapi-schema/doc-bad-command-arg.err          |   1 +
>  ...{doc-bad-args.exit =3D> doc-bad-command-arg.exit} |   0
>  ...{doc-bad-args.json =3D> doc-bad-command-arg.json} |   0
>  .../{doc-bad-args.out =3D> doc-bad-command-arg.out}  |   0
>  tests/qapi-schema/doc-bad-expr.err                 |   1 +
>  tests/qapi-schema/doc-bad-expr.exit                |   1 +
>  tests/qapi-schema/doc-bad-expr.json                |   7 +
>  tests/qapi-schema/doc-bad-expr.out                 |   0
>  tests/qapi-schema/doc-bad-symbol.err               |   2 +-
>  tests/qapi-schema/doc-bad-union-member.err         |   1 +
>  tests/qapi-schema/doc-bad-union-member.exit        |   1 +
>  tests/qapi-schema/doc-bad-union-member.json        |  19 +
>  tests/qapi-schema/doc-bad-union-member.out         |   0
>  tests/qapi-schema/doc-empty-section.err            |   2 +-
>  tests/qapi-schema/doc-invalid-section.err          |   2 +-
>  tests/qapi-schema/doc-missing-expr.err             |   2 +-
>  tests/qapi-schema/doc-missing.err                  |   1 +
>  tests/qapi-schema/doc-missing.exit                 |   1 +
>  tests/qapi-schema/doc-missing.json                 |   5 +
>  tests/qapi-schema/doc-missing.out                  |   0
>  tests/qapi-schema/doc-no-symbol.err                |   1 +
>  tests/qapi-schema/doc-no-symbol.exit               |   1 +
>  tests/qapi-schema/doc-no-symbol.json               |   6 +
>  tests/qapi-schema/doc-no-symbol.out                |   0
>  tests/qapi-schema/doc-optional.err                 |   1 -
>  tests/qapi-schema/doc-optional.json                |   7 -
>  tests/qapi-schema/double-type.err                  |   2 +-
>  tests/qapi-schema/double-type.json                 |   4 -
>  tests/qapi-schema/enum-bad-name.err                |   2 +-
>  tests/qapi-schema/enum-bad-name.json               |   4 -
>  tests/qapi-schema/enum-bad-prefix.err              |   2 +-
>  tests/qapi-schema/enum-bad-prefix.json             |   4 -
>  tests/qapi-schema/enum-clash-member.err            |   2 +-
>  tests/qapi-schema/enum-clash-member.json           |   4 -
>  tests/qapi-schema/enum-dict-member.err             |   2 +-
>  tests/qapi-schema/enum-dict-member.json            |   4 -
>  tests/qapi-schema/enum-member-case.err             |   2 +-
>  tests/qapi-schema/enum-member-case.json            |   8 +-
>  tests/qapi-schema/enum-missing-data.err            |   2 +-
>  tests/qapi-schema/enum-missing-data.json           |   4 -
>  tests/qapi-schema/enum-wrong-data.err              |   2 +-
>  tests/qapi-schema/enum-wrong-data.json             |   4 -
>  tests/qapi-schema/event-boxed-empty.err            |   2 +-
>  tests/qapi-schema/event-boxed-empty.json           |   4 -
>  tests/qapi-schema/event-case.json                  |   4 -
>  tests/qapi-schema/event-case.out                   |   1 -
>  tests/qapi-schema/event-nest-struct.err            |   2 +-
>  tests/qapi-schema/event-nest-struct.json           |   4 -
>  tests/qapi-schema/flat-union-array-branch.err      |   2 +-
>  tests/qapi-schema/flat-union-array-branch.json     |  12 -
>  tests/qapi-schema/flat-union-bad-base.err          |   2 +-
>  tests/qapi-schema/flat-union-bad-base.json         |  13 -
>  tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
>  .../qapi-schema/flat-union-bad-discriminator.json  |  16 -
>  tests/qapi-schema/flat-union-base-any.err          |   2 +-
>  tests/qapi-schema/flat-union-base-any.json         |  13 -
>  tests/qapi-schema/flat-union-base-union.err        |   2 +-
>  tests/qapi-schema/flat-union-base-union.json       |  16 -
>  tests/qapi-schema/flat-union-clash-member.err      |   2 +-
>  tests/qapi-schema/flat-union-clash-member.json     |  16 -
>  tests/qapi-schema/flat-union-empty.err             |   2 +-
>  tests/qapi-schema/flat-union-empty.json            |  10 -
>  tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
>  .../qapi-schema/flat-union-incomplete-branch.json  |  10 -
>  tests/qapi-schema/flat-union-inline.err            |   2 +-
>  tests/qapi-schema/flat-union-inline.json           |  10 -
>  tests/qapi-schema/flat-union-int-branch.err        |   2 +-
>  tests/qapi-schema/flat-union-int-branch.json       |  13 -
>  .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
>  .../qapi-schema/flat-union-invalid-branch-key.json |  15 -
>  .../flat-union-invalid-discriminator.err           |   2 +-
>  .../flat-union-invalid-discriminator.json          |  15 -
>  tests/qapi-schema/flat-union-no-base.err           |   2 +-
>  tests/qapi-schema/flat-union-no-base.json          |  13 -
>  .../flat-union-optional-discriminator.err          |   2 +-
>  .../flat-union-optional-discriminator.json         |  13 -
>  .../flat-union-string-discriminator.err            |   2 +-
>  .../flat-union-string-discriminator.json           |  15 -
>  tests/qapi-schema/ident-with-escape.json           |   4 -
>  tests/qapi-schema/ident-with-escape.out            |   1 -
>  tests/qapi-schema/include-relpath-sub.json         |   3 -
>  tests/qapi-schema/include-relpath.out              |   1 -
>  tests/qapi-schema/include-repetition.out           |   1 -
>  tests/qapi-schema/include-simple-sub.json          |   3 -
>  tests/qapi-schema/include-simple.out               |   1 -
>  tests/qapi-schema/indented-expr.json               |   6 -
>  tests/qapi-schema/indented-expr.out                |   2 -
>  tests/qapi-schema/missing-type.err                 |   2 +-
>  tests/qapi-schema/missing-type.json                |   4 -
>  tests/qapi-schema/nested-struct-data.err           |   2 +-
>  tests/qapi-schema/nested-struct-data.json          |   4 -
>  tests/qapi-schema/qapi-schema-test.json            | 218 +------
>  tests/qapi-schema/qapi-schema-test.out             | 130 -----
>  tests/qapi-schema/redefined-builtin.err            |   2 +-
>  tests/qapi-schema/redefined-builtin.json           |   4 -
>  tests/qapi-schema/redefined-command.err            |   2 +-
>  tests/qapi-schema/redefined-command.json           |   7 -
>  tests/qapi-schema/redefined-event.err              |   2 +-
>  tests/qapi-schema/redefined-event.json             |   7 -
>  tests/qapi-schema/redefined-type.err               |   2 +-
>  tests/qapi-schema/redefined-type.json              |   7 -
>  tests/qapi-schema/reserved-command-q.err           |   2 +-
>  tests/qapi-schema/reserved-command-q.json          |   7 -
>  tests/qapi-schema/reserved-enum-q.err              |   2 +-
>  tests/qapi-schema/reserved-enum-q.json             |   4 -
>  tests/qapi-schema/reserved-member-has.err          |   2 +-
>  tests/qapi-schema/reserved-member-has.json         |   4 -
>  tests/qapi-schema/reserved-member-q.err            |   2 +-
>  tests/qapi-schema/reserved-member-q.json           |   4 -
>  tests/qapi-schema/reserved-member-u.err            |   2 +-
>  tests/qapi-schema/reserved-member-u.json           |   4 -
>  tests/qapi-schema/reserved-member-underscore.err   |   2 +-
>  tests/qapi-schema/reserved-member-underscore.json  |   4 -
>  tests/qapi-schema/reserved-type-kind.err           |   2 +-
>  tests/qapi-schema/reserved-type-kind.json          |   4 -
>  tests/qapi-schema/reserved-type-list.err           |   2 +-
>  tests/qapi-schema/reserved-type-list.json          |   4 -
>  tests/qapi-schema/returns-alternate.err            |   2 +-
>  tests/qapi-schema/returns-alternate.json           |   7 -
>  tests/qapi-schema/returns-array-bad.err            |   2 +-
>  tests/qapi-schema/returns-array-bad.json           |   4 -
>  tests/qapi-schema/returns-dict.err                 |   2 +-
>  tests/qapi-schema/returns-dict.json                |   4 -
>  tests/qapi-schema/returns-unknown.err              |   2 +-
>  tests/qapi-schema/returns-unknown.json             |   4 -
>  tests/qapi-schema/returns-whitelist.err            |   2 +-
>  tests/qapi-schema/returns-whitelist.json           |  18 +-
>  tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
>  tests/qapi-schema/struct-base-clash-deep.json      |  10 -
>  tests/qapi-schema/struct-base-clash.err            |   2 +-
>  tests/qapi-schema/struct-base-clash.json           |   7 -
>  tests/qapi-schema/struct-data-invalid.err          |   2 +-
>  tests/qapi-schema/struct-data-invalid.json         |   3 -
>  tests/qapi-schema/struct-member-invalid.err        |   2 +-
>  tests/qapi-schema/struct-member-invalid.json       |   3 -
>  tests/qapi-schema/test-qapi.py                     |  14 -
>  tests/qapi-schema/trailing-comma-list.err          |   2 +-
>  tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
>  tests/qapi-schema/type-bypass-bad-gen.json         |   4 -
>  tests/qapi-schema/unicode-str.err                  |   2 +-
>  tests/qapi-schema/unicode-str.json                 |   4 -
>  tests/qapi-schema/union-base-empty.err             |   1 +
>  tests/qapi-schema/union-base-empty.exit            |   1 +
>  tests/qapi-schema/union-base-empty.json            |   9 +
>  tests/qapi-schema/union-base-empty.out             |   0
>  tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
>  tests/qapi-schema/union-base-no-discriminator.json |  12 -
>  tests/qapi-schema/union-branch-case.err            |   2 +-
>  tests/qapi-schema/union-branch-case.json           |   4 -
>  tests/qapi-schema/union-clash-branches.err         |   2 +-
>  tests/qapi-schema/union-clash-branches.json        |   4 -
>  tests/qapi-schema/union-empty.err                  |   2 +-
>  tests/qapi-schema/union-empty.json                 |   4 -
>  tests/qapi-schema/union-invalid-base.err           |   2 +-
>  tests/qapi-schema/union-invalid-base.json          |  10 -
>  tests/qapi-schema/union-optional-branch.err        |   2 +-
>  tests/qapi-schema/union-optional-branch.json       |   4 -
>  tests/qapi-schema/union-unknown.err                |   2 +-
>  tests/qapi-schema/union-unknown.json               |   4 -
>  tests/qapi-schema/unknown-escape.err               |   2 +-
>  tests/qapi-schema/unknown-escape.json              |   4 -
>  tests/qapi-schema/unknown-expr-key.err             |   2 +-
>  tests/qapi-schema/unknown-expr-key.json            |   4 -
>  259 files changed, 1263 insertions(+), 2109 deletions(-)
>  create mode 100644 tests/qapi-schema/doc-bad-alternate-member.err
>  rename tests/qapi-schema/{doc-optional.exit =3D>
> doc-bad-alternate-member.exit} (100%)
>  create mode 100644 tests/qapi-schema/doc-bad-alternate-member.json
>  rename tests/qapi-schema/{doc-optional.out =3D>
> doc-bad-alternate-member.out} (100%)
>  delete mode 100644 tests/qapi-schema/doc-bad-args.err
>  create mode 100644 tests/qapi-schema/doc-bad-command-arg.err
>  rename tests/qapi-schema/{doc-bad-args.exit =3D> doc-bad-command-arg.exi=
t}
> (100%)
>  rename tests/qapi-schema/{doc-bad-args.json =3D> doc-bad-command-arg.jso=
n}
> (100%)
>  rename tests/qapi-schema/{doc-bad-args.out =3D> doc-bad-command-arg.out}
> (100%)
>  create mode 100644 tests/qapi-schema/doc-bad-expr.err
>  create mode 100644 tests/qapi-schema/doc-bad-expr.exit
>  create mode 100644 tests/qapi-schema/doc-bad-expr.json
>  create mode 100644 tests/qapi-schema/doc-bad-expr.out
>  create mode 100644 tests/qapi-schema/doc-bad-union-member.err
>  create mode 100644 tests/qapi-schema/doc-bad-union-member.exit
>  create mode 100644 tests/qapi-schema/doc-bad-union-member.json
>  create mode 100644 tests/qapi-schema/doc-bad-union-member.out
>  create mode 100644 tests/qapi-schema/doc-missing.err
>  create mode 100644 tests/qapi-schema/doc-missing.exit
>  create mode 100644 tests/qapi-schema/doc-missing.json
>  create mode 100644 tests/qapi-schema/doc-missing.out
>  create mode 100644 tests/qapi-schema/doc-no-symbol.err
>  create mode 100644 tests/qapi-schema/doc-no-symbol.exit
>  create mode 100644 tests/qapi-schema/doc-no-symbol.json
>  create mode 100644 tests/qapi-schema/doc-no-symbol.out
>  delete mode 100644 tests/qapi-schema/doc-optional.err
>  delete mode 100644 tests/qapi-schema/doc-optional.json
>  create mode 100644 tests/qapi-schema/union-base-empty.err
>  create mode 100644 tests/qapi-schema/union-base-empty.exit
>  create mode 100644 tests/qapi-schema/union-base-empty.json
>  create mode 100644 tests/qapi-schema/union-base-empty.out
>
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
