Received: from eggs.gnu.org ([2001:4830:134:3::10]:37777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWMlT-0004Rm-Os
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWMlO-0005Pn-Nt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWMlO-0005Od-I5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3001E8D76C
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 14:10:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-19-marcandre.lureau@redhat.com>
Date: Fri, 22 Jun 2018 16:10:08 +0200
In-Reply-To: <20180321115211.17937-19-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:40 +0100")
Message-ID: <87vaaac3pb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 18/49] tests: modify visit_enum_type()
 in test-qapi to print members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

The subject is misleading: visit_enum_type() prints members even before
this patch already.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Use a common self._print_members() to print enum members details.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qapi-schema/comments.out           | 14 ++++++-
>  tests/qapi-schema/doc-bad-section.out    | 13 ++++++-
>  tests/qapi-schema/doc-good.out           | 17 ++++++--
>  tests/qapi-schema/empty.out              |  9 ++++-
>  tests/qapi-schema/event-case.out         |  9 ++++-
>  tests/qapi-schema/ident-with-escape.out  |  9 ++++-
>  tests/qapi-schema/include-relpath.out    | 14 ++++++-
>  tests/qapi-schema/include-repetition.out | 14 ++++++-
>  tests/qapi-schema/include-simple.out     | 14 ++++++-
>  tests/qapi-schema/indented-expr.out      |  9 ++++-
>  tests/qapi-schema/qapi-schema-test.out   | 49 +++++++++++++++++++-----
>  tests/qapi-schema/test-qapi.py           | 18 ++++++---
>  12 files changed, 158 insertions(+), 31 deletions(-)
>
> diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
> index 8d2f1ce8a2..d1abc4b5a1 100644
> --- a/tests/qapi-schema/comments.out
> +++ b/tests/qapi-schema/comments.out
> @@ -1,5 +1,15 @@
>  object q_empty
> -enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
> +enum QType
>      prefix QTYPE
> +    member none
> +    member qnull
> +    member qnum
> +    member qstring
> +    member qdict
> +    member qlist
> +    member qbool
>  module comments.json
> -enum Status ['good', 'bad', 'ugly']
> +enum Status
> +    member good
> +    member bad
> +    member ugly
[More of the same...]
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 3623deae62..7e7b8f9f0f 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -12,7 +12,8 @@
>=20=20
>  from __future__ import print_function
>  import sys
> -from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
> +from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor, \
> +    QAPISchemaObjectTypeMember
>=20=20
>=20=20
>  class QAPISchemaTestVisitor(QAPISchemaVisitor):
> @@ -24,18 +25,17 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          print('include %s' % name)
>=20=20
>      def visit_enum_type(self, name, info, ifcond, members, prefix):
> -        print('enum %s %s' % (name, [m.name for m in members]))
> +        print('enum %s' % name)
>          if prefix:
>              print('    prefix %s' % prefix)
> +        self._print_members(members)
>          self._print_if(ifcond)
>=20=20
>      def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
>          print('object %s' % name)
>          if base:
>              print('    base %s' % base.name)
> -        for m in members:
> -            print('    member %s: %s optional=3D%s' % \
> -                  (m.name, m.type.name, m.optional))
> +        self._print_members(members)
>          self._print_variants(variants)
>          self._print_if(ifcond)
>=20=20
> @@ -57,6 +57,14 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          print('   boxed=3D%s' % boxed)
>          self._print_if(ifcond)
>=20=20
> +    @staticmethod
> +    def _print_members(members):
> +        for m in members:
> +            print('    member %s%s' % (
> +                m.name,
> +                ': %s optional=3D%s' % (m.type.name, m.optional)
> +                if isinstance(m, QAPISchemaObjectTypeMember) else ''))
> +
>      @staticmethod
>      def _print_variants(variants):
>          if variants:

I don't think the de-duplication is worth the isinstance() ugliness,
even with PATCH 21's additional line.

Compare the stupidest possible solution:

   diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qap=
i.py
   index 3623deae62..37547dc233 100644
   --- a/tests/qapi-schema/test-qapi.py
   +++ b/tests/qapi-schema/test-qapi.py
   @@ -24,9 +24,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
            print('include %s' % name)

        def visit_enum_type(self, name, info, ifcond, members, prefix):
   -        print('enum %s %s' % (name, [m.name for m in members]))
   +        print('enum %s' % name)
            if prefix:
                print('    prefix %s' % prefix)
   +        for m in members:
   +            print('    member %s' % m.name)
            self._print_if(ifcond)

        def visit_object_type(self, name, info, ifcond, base, members, vari=
ants):

PATCH 21 will then add two lines instead of one.  Still less code, and
simpler, too.

Revised commit message could be:

    tests: Print enum type members more like object type members

    Commit 93bda4dd461 changed the internal representation of enum type
    members from str to QAPISchemaMember, but we still print only a
    string.  Has been good enough, as the name is the member's only
    attribute of interest, but that's about to change.  To prepare,
    print them more like object type members.
