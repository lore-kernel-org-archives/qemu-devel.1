Received: from eggs.gnu.org ([2001:4830:134:3::10]:44444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGVV-0003cq-Ch
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGVT-00063A-BD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cEGVT-000631-28
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49ABB6198D
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 14:14:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  6 Dec 2016 17:13:31 +0300
Message-Id: <20161206141343.28044-6-marcandre.lureau@redhat.com>
In-Reply-To: <20161206141343.28044-1-marcandre.lureau@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 05/17] docs: add master qapi texi files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The qapi2texi script generates a file to be included in a texi file. Add
"QEMU QMP Reference Manual" and "QEMU Guest Agent Protocol Reference"
master texi files.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/qapi-syntax.texi  | 175 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 docs/qemu-ga-ref.texi  |  85 ++++++++++++++++++++++++
 docs/qemu-qmp-ref.texi |  85 ++++++++++++++++++++++++
 3 files changed, 345 insertions(+)
 create mode 100644 docs/qapi-syntax.texi
 create mode 100644 docs/qemu-ga-ref.texi
 create mode 100644 docs/qemu-qmp-ref.texi

diff --git a/docs/qapi-syntax.texi b/docs/qapi-syntax.texi
new file mode 100644
index 0000000000..117d6272d6
--- /dev/null
+++ b/docs/qapi-syntax.texi
@@ -0,0 +1,175 @@
+See QEMU @file{docs/qapi-code-gen.txt} for details about the ``Client
+JSON Protocol'' wire format. Many @b{Example} illustrate the usage of
+the various types.
+
+This reference document uses a simplified syntax for the different
+JSON expressions, of the following general form:
+
+@deftp {Type} TypeName @
+{@{ 'member': @t{type}, ['optional-member: @t{some-type}], ... @}}
+
+@table @asis
+@item @code{'member'}
+Member description
+@item @code{'optional-member'} *
+Optional member description
+@end table
+@quotation Since
+A tagged section
+@end quotation
+@quotation Example
+@example
+<- @{ "return": @{ "member": "foo", ... @} @}
+@end example
+@end quotation
+@end deftp
+
+The [] in the declaration and the * name prefix in the member
+description means the member is optional.
+
+A type name inside [] refers to a single-dimension array of that type.
+
+@section Enum documentation
+
+Enumerations are strings over the Client JSON Protocol.
+
+Example of an API documentation:
+
+@deftp Enum Enumeration
+
+@table @asis
+@item @code{'auto'}
+Description auto
+@item @code{'on'}
+Description on
+@item @code{'off'}
+Description off
+@end table
+An enumeration of three options: on, off, and auto
+@end deftp
+
+@section Struct documentation
+
+A struct is an Object in the Client JSON protocol, whose members are
+listed in the declaration. It may have a base structure: the members
+of the base structure are merged in the same top-level Object over the
+client protocol.
+
+The API documentation uses the following syntax for a struct:
+
+@deftp {Struct} Type @
+{@{ BaseStruct, 'foo': @t{type}, ... @}}
+
+@table @asis
+@item @code{'foo'}
+Member foo description
+@end table
+The type description.
+@end deftp
+
+@section Union documentation
+
+Union types are used to let the user choose between several different
+variants for an object.  There are two flavors: simple (no
+discriminator or base), and flat (both discriminator and base).
+
+In the Client JSON Protocol, a simple union is represented by a
+dictionary that contains the @t{'type'} member as a discriminator, and
+a @t{'data'} member that is of the specified data type corresponding
+to the discriminator value.
+
+The API documentation uses the following syntax for simple union:
+
+@deftp {Simple Union} SimpleUnionType @
+{@{ 'type': @t{str}, 'data': [ 'type' =3D 't1': @t{Type1}, 't2: @t{Type2=
}, ... ] @}}
+
+Simple union description
+@end deftp
+
+A flat union definition avoids nesting on the wire, and specifies a
+set of common members that occur in all variants of the union. The
+top-level members of the union dictionary on the wire will be
+combination of members from both the base type and the appropriate
+discriminated branch type.  The @t{'discriminator'} member is the name
+of a non-optional enum-typed member of the base struct.
+
+The documentation uses the following syntax for a flat union:
+
+@deftp {Flat Union} FlatUnionType @
+{@{ UnionBase, [ 'discriminator' =3D 'd1': @t{Type1}, 'd2': @t{Type2} ] =
@}}
+
+Flat union description
+@end deftp
+
+@section Alternate documentation
+
+An alternate type is one that allows a choice between two or more JSON
+data types (string, integer, number, or object, but currently not
+array) on the wire.
+
+@deftp {Alternate} AlternateType @
+{[ 't1': @t{Type1}, 't2': @t{Type2}, ... ]}
+
+@table @asis
+@item @code{'t1'}
+Either this type
+@item @code{'t2'}
+Or this type
+@end table
+AlternateType description
+@end deftp
+
+@section Command documentation
+
+In the Client JSON Protocol, a command is a dictionary with an
+@t{'execute'} member (the name of the command as value), and an
+@t{'arguments'} member for the arguments. The API documentation uses
+the following syntax for a command:
+
+@deftypefn Command {ReturnType} query-foo @
+{('arg': @t{type}, ...)}
+
+@table @asis
+@item @code{'arg'}
+If true, the command will query...
+@end table
+Query for all bar...
+@quotation Returns
+The @code{ReturnType} for...
+@end quotation
+@quotation Example
+@example
+-> @{ "execute": "query-foo", "arguments": @{ "arg": ... @} @}
+<- @{
+      "return": @{ "foo": ... @}
+   @}
+@end example
+@end quotation
+@end deftypefn
+
+@section Event documentation
+
+An event is a JSON object defined by its name, used as the @t{'event'}
+member value, and a @t{'data'} member for the event members.
+
+The API documentation uses the following syntax for an event:
+
+@deftypefn Event {} EVENT_NAME @
+{('foo': @t{type}, ...)}
+
+@table @asis
+@item @code{'foo'}
+An event member
+@end table
+Event emitted when ...
+@quotation Note
+This event is rate-limited.
+@end quotation
+@quotation Example
+@example
+<-   @{ "event": "EVENT_NAME",
+       "data": @{ "param": .. @},
+       "timestamp": @{ "seconds": 1267020223, "microseconds": 435656 @} =
@}
+@end example
+@end quotation
+@end deftypefn
diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
new file mode 100644
index 0000000000..2c8ad45d49
--- /dev/null
+++ b/docs/qemu-ga-ref.texi
@@ -0,0 +1,85 @@
+\input texinfo
+@setfilename qemu-ga-ref.info
+
+@exampleindent 0
+@paragraphindent 0
+
+@settitle QEMU Guest Agent Protocol Reference
+
+@copying
+This is the QEMU Guest Agent Protocol reference manual.
+
+Copyright @copyright{} 2016 The QEMU Project developers
+
+@quotation
+This manual is free documentation: you can redistribute it and/or
+modify it under the terms of the GNU General Public License as
+published by the Free Software Foundation, either version 2 of the
+License, or (at your option) any later version.
+
+This manual is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this manual.  If not, see http://www.gnu.org/licenses/.
+@end quotation
+@end copying
+
+@dircategory QEMU
+@direntry
+* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
+@end direntry
+
+@titlepage
+@title Guest Agent Protocol Reference Manual
+@subtitle QEMU version @value{VERSION}
+@page
+@vskip 0pt plus 1filll
+@insertcopying
+@end titlepage
+
+@contents
+
+@ifnottex
+@node Top
+@top QEMU Guest Agent protocol reference
+@end ifnottex
+
+@menu
+* API Reference::
+* Documentation syntax::
+* Commands and Events Index::
+* Data Types Index::
+@end menu
+
+@node API Reference
+@chapter API Reference
+
+@c for texi2pod:
+@c man begin DESCRIPTION
+
+@include qemu-ga-qapi.texi
+
+@c man end
+
+@node Documentation syntax
+@chapter Documentation syntax
+
+@c for texi2pod:
+@c man begin NOTES
+
+@include qapi-syntax.texi
+
+@c man end
+
+@node Commands and Events Index
+@unnumbered Commands and Events Index
+@printindex fn
+
+@node Data Types Index
+@unnumbered Data Types Index
+@printindex tp
+
+@bye
diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
new file mode 100644
index 0000000000..5fa354afa3
--- /dev/null
+++ b/docs/qemu-qmp-ref.texi
@@ -0,0 +1,85 @@
+\input texinfo
+@setfilename qemu-qmp-ref.info
+
+@exampleindent 0
+@paragraphindent 0
+
+@settitle QEMU QMP Reference Manual
+
+@copying
+This is the QEMU QMP reference manual.
+
+Copyright @copyright{} 2016 The QEMU Project developers
+
+@quotation
+This manual is free documentation: you can redistribute it and/or
+modify it under the terms of the GNU General Public License as
+published by the Free Software Foundation, either version 2 of the
+License, or (at your option) any later version.
+
+This manual is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this manual.  If not, see http://www.gnu.org/licenses/.
+@end quotation
+@end copying
+
+@dircategory QEMU
+@direntry
+* QEMU-QMP-Ref: (qemu-qmp-ref). QEMU QMP Reference Manual
+@end direntry
+
+@titlepage
+@title QMP Reference Manual
+@subtitle QEMU version @value{VERSION}
+@page
+@vskip 0pt plus 1filll
+@insertcopying
+@end titlepage
+
+@contents
+
+@ifnottex
+@node Top
+@top QEMU QMP reference
+@end ifnottex
+
+@menu
+* API Reference::
+* Documentation syntax::
+* Commands and Events Index::
+* Data Types Index::
+@end menu
+
+@node API Reference
+@chapter API Reference
+
+@c for texi2pod:
+@c man begin DESCRIPTION
+
+@include qemu-qapi.texi
+
+@c man end
+
+@node Documentation syntax
+@chapter Documentation syntax
+
+@c for texi2pod:
+@c man begin NOTES
+
+@include qapi-syntax.texi
+
+@c man end
+
+@node Commands and Events Index
+@unnumbered Commands and Events Index
+@printindex fn
+
+@node Data Types Index
+@unnumbered Data Types Index
+@printindex tp
+
+@bye
--=20
2.11.0
