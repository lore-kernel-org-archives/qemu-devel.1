Received: from eggs.gnu.org ([2001:4830:134:3::10]:54802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cJk51-0007xw-6o
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cJk4y-00014O-1w
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:49:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cJk4x-00014G-Mo
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:49:23 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FE1661B85
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 16:49:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-6-marcandre.lureau@redhat.com>
Date: Wed, 21 Dec 2016 17:49:20 +0100
In-Reply-To: <20161206141343.28044-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 6 Dec 2016 17:13:31 +0300")
Message-ID: <87zijp8bxr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/17] docs: add master qapi texi files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The qapi2texi script generates a file to be included in a texi file. Add
> "QEMU QMP Reference Manual" and "QEMU Guest Agent Protocol Reference"
> master texi files.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This is v5 (which got my R-by) with a "Documentation syntax" section
added to both manuals, between "API Reference" and the indexes.

Since "Documentation syntax" explains how to read "API reference", it
should either come first, or a suitable forward reference should alert
novice readers to it.  Could be done on top.

> ---
>  docs/qapi-syntax.texi  | 175 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  docs/qemu-ga-ref.texi  |  85 ++++++++++++++++++++++++
>  docs/qemu-qmp-ref.texi |  85 ++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 docs/qapi-syntax.texi
>  create mode 100644 docs/qemu-ga-ref.texi
>  create mode 100644 docs/qemu-qmp-ref.texi
>
> diff --git a/docs/qapi-syntax.texi b/docs/qapi-syntax.texi
> new file mode 100644
> index 0000000000..117d6272d6
> --- /dev/null
> +++ b/docs/qapi-syntax.texi
> @@ -0,0 +1,175 @@

This file is new in v6.  I have quite a few remarks.  Some of them only
say "problem here", without proposing a solution.  That's because I'm
going to do fewer, more comprehensive proposals rather than scattering
lots of them all over the place.

Still, it's a lot of feedback for something on which we both want to
converge as quickly as possible.  Before you log off in disgust and
drink yourself to oblivion for the remainder of the year: I still hope
to end review of this series with a plan for committing the bulk of it
quickly.  This may involve cutting stuff, and adding FIXMEs.

> +See QEMU @file{docs/qapi-code-gen.txt} for details about the ``Client
> +JSON Protocol'' wire format. Many @b{Example} illustrate the usage of

Examples

> +the various types.

Jumping right into the wire format is rather abrupt.

> +
> +This reference document uses a simplified syntax for the different

Simplified from what?  I know what you mean (the QAPI schema), but I
have much more context than I'm willing to assume readers have.

> +JSON expressions, of the following general form:
> +
> +@deftp {Type} TypeName @
> +{@{ 'member': @t{type}, ['optional-member: @t{some-type}], ... @}}
> +
> +@table @asis
> +@item @code{'member'}
> +Member description
> +@item @code{'optional-member'} *
> +Optional member description
> +@end table
> +@quotation Since
> +A tagged section
> +@end quotation
> +@quotation Example
> +@example
> +<- @{ "return": @{ "member": "foo", ... @} @}
> +@end example
> +@end quotation
> +@end deftp
> +
> +The [] in the declaration and the * name prefix in the member
> +description means the member is optional.
> +
> +A type name inside [] refers to a single-dimension array of that type.

Recommend s/refers to/denotes/, and either scratch "single-dimension",
or say "one-dimensional".

The overloading of [] for optional and array is confusing.

This "general form" is incomplete: it has the type description derived
from the schema, then the argument sections.  Non-argument sections are
missing.

Let's go through the specific forms before I propose improvements for
this general form.

> +
> +@section Enum documentation
> +
> +Enumerations are strings over the Client JSON Protocol.

Suggest "Enumeration values are transmitted as JSON strings in the
Client JSON Protocol", or even just "are strings on the wire".

The authoritative resource on the wire protocol is qapi-code-gen.txt, as
you note above.  Explaining the wire protocol here once more is
technically redundant, but I guess readers will appreciate it anyway.

However, it's more than just "documentation syntax".  Retitle to "How to
read API documentation"?

Starting the section with explaining the wire protocol seems awkward.
I'd order as follows: introduction, documentation format, example, wire
format.

> +
> +Example of an API documentation:
> +
> +@deftp Enum Enumeration

Doesn't match the "general form" introduced in the previous section:
there is no list of members in curly braces.  Such a list would be
redundant here, however.

> +
> +@table @asis
> +@item @code{'auto'}
> +Description auto
> +@item @code{'on'}
> +Description on
> +@item @code{'off'}
> +Description off
> +@end table
> +An enumeration of three options: on, off, and auto
> +@end deftp

Results in the following plain text:

    2.1 Enum documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Enumerations are strings over the Client JSON Protocol.

    Example of an API documentation:

     -- Enum: Enumeration

         ''auto''
              Description auto
         ''on''
              Description on
         ''off''
              Description off
         An enumeration of three options: on, off, and auto

Why do we jump into explaining the enumeration values, and only then
explain what the whole enumeration is good for?  We do, because that's
what the doc generator introduced later in this series does.

Evidence: the example is cribbed from the docs generated for OnOffAuto

     -- Enum: OnOffAuto

         ''auto''
              QEMU selects the value between on and off
         ''on''
              Enabled
         ''off''
              Disabled
         An enumeration of three options: on, off, and auto
              Since: 2.2

which are generated from this schema definition

    ##
    # @OnOffAuto:
    #
    # An enumeration of three options: on, off, and auto
    #
    # @auto: QEMU selects the value between on and off
    #
    # @on: Enabled
    #
    # @off: Disabled
    #
    # Since: 2.2
    ##
    { 'enum': 'OnOffAuto',
      'data': [ 'auto', 'on', 'off' ] }

Even though the documentation author put "An enumeration of ..." at the
beginning (thoughtfully, I presume), the doc generator moves it to the
end.  This is *not* an improvement.  Hardly surprising; I don't expect a
computer's reordering of manually written text to improve things.

I want us to stick to the human author's order.  I'll come back to this
when I review the doc generator.

Here's my try:

    2.1 Enum API documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

    An enumeration type is a set of named values.  Its API documentation
    lists these values.  Looks like this:

     -- Enum: Enumeration

        An enumeration of three options: on, off, and auto

        The enumeration values are:

         ''auto''
              Description of auto
         ''on''
              Description of on
         ''off''
              Description of off

    Enumeration values are transmitted as JSON strings on the wire.

The "Enum: Enumeration" part can't quite decide whether to be a sketch
of the structure or an example.

Sketch of structure would be:

     -- Enum: EnumName

        Description of the enum type

        The enumeration values are:

         ''foo''
              Description of value foo
         ... more values ...

This is closer to what you do for other kinds of types.

Example would be the actual OnOffAuto type documentation, possibly
trimmed a bit.

If we want example, we could use a less anodyne one:

     -- Enum: Duckling

        One of Donald Duck's nephews

         ''Huey''
              The duckling wearing red
         ''Dewey''
              The duckling wearing blue
         ''Louie''
              The duckling wearing green

> +
> +@section Struct documentation
> +
> +A struct is an Object in the Client JSON protocol, whose members are
> +listed in the declaration. It may have a base structure: the members
> +of the base structure are merged in the same top-level Object over the
> +client protocol.
> +
> +The API documentation uses the following syntax for a struct:
> +
> +@deftp {Struct} Type @
> +{@{ BaseStruct, 'foo': @t{type}, ... @}}
> +
> +@table @asis
> +@item @code{'foo'}
> +Member foo description
> +@end table
> +The type description.
> +@end deftp

Plain text:

    2.2 Struct documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    A struct is an Object in the Client JSON protocol, whose members are
    listed in the declaration.  It may have a base structure: the members of
    the base structure are merged in the same top-level Object over the
    client protocol.

    The API documentation uses the following syntax for a struct:

     -- Struct: Type { BaseStruct, 'foo': type, ... }

         ''foo''
              Member foo description
         The type description.

The text in curly braces "BaseStruct, " doesn't match actual doc
generator output "BaseStruct + ".

Perhaps we should show an optional member here.

Here's my try:

    2.2 Struct API documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

    A struct type is a collection of named members.  Its API
    documentation lists these members.  Looks like this:

     -- Struct: StructName { BaseStruct + 'foo': FooType, ['bar': BarType],=
 ... }

         Description of the struct type

         The struct's members are the members of struct type BaseStruct, an=
d:

         ''foo''
              Description of member foo
         ''bar'' *
              Description of member bar
         ... more members ...

    Struct values are transmitted as JSON objects on the wire.  The JSON
    object's members correspond to the struct type members.

Note how I have the members list refer to the additional members without
explaining base types.  That part is omitted when there's no base type.

Perhaps we want an actual example in addition or instead of the format
sketch.  I guess not, as plenty of them can be found in the actual API
docs.

Note the redundancy between the text in curly braces and the list of
members: basically the only information the former adds is types.  Avoid
that:

     -- Struct: StructName

         Description of the struct type

         The struct's members are the members of struct type BaseStruct, an=
d:

         ''foo'' (of type FooType)
              Description of member foo
         ''bar'' (of type BarType, optional)
              Description of member bar
         ... more members ...

I believe this is a good deal easier to read.

I'm not attached to the (of type ...) format.  Better ideas for these
lines welcome.

> +
> +@section Union documentation
> +
> +Union types are used to let the user choose between several different
> +variants for an object.  There are two flavors: simple (no
> +discriminator or base), and flat (both discriminator and base).
> +
> +In the Client JSON Protocol, a simple union is represented by a
> +dictionary that contains the @t{'type'} member as a discriminator, and
> +a @t{'data'} member that is of the specified data type corresponding
> +to the discriminator value.
> +
> +The API documentation uses the following syntax for simple union:
> +
> +@deftp {Simple Union} SimpleUnionType @
> +{@{ 'type': @t{str}, 'data': [ 'type' =3D 't1': @t{Type1}, 't2: @t{Type2=
}, ... ] @}}
> +
> +Simple union description
> +@end deftp
> +
> +A flat union definition avoids nesting on the wire, and specifies a
> +set of common members that occur in all variants of the union. The
> +top-level members of the union dictionary on the wire will be
> +combination of members from both the base type and the appropriate
> +discriminated branch type.  The @t{'discriminator'} member is the name
> +of a non-optional enum-typed member of the base struct.
> +
> +The documentation uses the following syntax for a flat union:
> +
> +@deftp {Flat Union} FlatUnionType @
> +{@{ UnionBase, [ 'discriminator' =3D 'd1': @t{Type1}, 'd2': @t{Type2} ] =
@}}
> +
> +Flat union description
> +@end deftp

Plain text:

    2.3 Union documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Union types are used to let the user choose between several different
    variants for an object.  There are two flavors: simple (no discriminator
    or base), and flat (both discriminator and base).

    In the Client JSON Protocol, a simple union is represented by a
    dictionary that contains the 'type' member as a discriminator, and a
    'data' member that is of the specified data type corresponding to the
    discriminator value.

    The API documentation uses the following syntax for simple union:

     -- Simple Union: SimpleUnionType { 'type': str, 'data': [ 'type' =3D
              't1': Type1, 't2: Type2, ... ] }

         Simple union description

    A flat union definition avoids nesting on the wire, and specifies a set
    of common members that occur in all variants of the union.  The
    top-level members of the union dictionary on the wire will be
    combination of members from both the base type and the appropriate
    discriminated branch type.  The 'discriminator' member is the name of a
    non-optional enum-typed member of the base struct.

    The documentation uses the following syntax for a flat union:

     -- Flat Union: FlatUnionType { UnionBase, [ 'discriminator' =3D 'd1':
              Type1, 'd2': Type2 ] }

         Flat union description

I'd love to relegate flat vs. simple to implementation detail.

The documentation generated for unions is generally sub-par, just as the
pre-series doc comments are.

Here's where I want us to go:

    2.3 Union API documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

    A union type is a collection of named members, where one member is
    the discriminator, and some members are present only when the
    discriminator member has a certain value.  Its API documentation
    lists these members.  Looks like this:

     -- Union: UnionName

         Description of the union type

         The struct's members are the members of struct type BaseStruct, an=
d:

         ''type'' (of type Type)
         ... more common members ...

         Additionally when member ''type'' has value "ding", the members
         of struct type DingType

         ... Members for more values of ''type'' ...

    Union values are transmitted as JSON objects on the wire.  The JSON
    object's members correspond to the union type members.

Again, no need for the text in curly braces.

Base types defined inline are to be quietly spliced into the common
members.

If this turns out to be too verbose for simple unions, we can invent an
abbreviated format for them.

How close to this can we get in the first step?  Baby step in the right
direction would be fine.  Bigger steps in another direction not so much.

> +
> +@section Alternate documentation
> +
> +An alternate type is one that allows a choice between two or more JSON
> +data types (string, integer, number, or object, but currently not
> +array) on the wire.
> +
> +@deftp {Alternate} AlternateType @
> +{[ 't1': @t{Type1}, 't2': @t{Type2}, ... ]}
> +
> +@table @asis
> +@item @code{'t1'}
> +Either this type
> +@item @code{'t2'}
> +Or this type
> +@end table
> +AlternateType description
> +@end deftp

Plain text:

    2.4 Alternate documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

    An alternate type is one that allows a choice between two or more JSON
    data types (string, integer, number, or object, but currently not array)
    on the wire.

     -- Alternate: AlternateType [ 't1': Type1, 't2': Type2, ... ]

         ''t1''
              Either this type
         ''t2''
              Or this type
         AlternateType description

My try:

    2.4 Alternate API documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

    An alternate type is one that allows a choice between two or more
    sufficiently distinct types.  Its API documentation lists the
    possible types.  Looks like this:

     -- Alternate: AlternateType

         Description of the alternate type

         Its possible types are:

         ''Type1''
              Description of this alternative
         ''Type2''
              Description of this alternative
         ... more alternatives ...

    Alternate types are transmitted exactly like the selected
    alternative type on the wire.

If we care, we can add to the last paragraph: Their JSON types are all
distinct.

> +
> +@section Command documentation
> +
> +In the Client JSON Protocol, a command is a dictionary with an
> +@t{'execute'} member (the name of the command as value), and an
> +@t{'arguments'} member for the arguments. The API documentation uses
> +the following syntax for a command:
> +
> +@deftypefn Command {ReturnType} query-foo @
> +{('arg': @t{type}, ...)}
> +
> +@table @asis
> +@item @code{'arg'}
> +If true, the command will query...
> +@end table
> +Query for all bar...
> +@quotation Returns
> +The @code{ReturnType} for...
> +@end quotation
> +@quotation Example
> +@example
> +-> @{ "execute": "query-foo", "arguments": @{ "arg": ... @} @}
> +<- @{
> +      "return": @{ "foo": ... @}
> +   @}
> +@end example
> +@end quotation
> +@end deftypefn

Plain text:

    2.5 Command documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

    In the Client JSON Protocol, a command is a dictionary with an 'execute'
    member (the name of the command as value), and an 'arguments' member for
    the arguments.  The API documentation uses the following syntax for a
    command:

     -- Command: ReturnType query-foo ('arg': type, ...)

         ''arg''
              If true, the command will query...
         Query for all bar...
              Returns: The 'ReturnType' for...
              Example: -> { "execute": "query-foo", "arguments": { "arg": .=
.. } }
                   <- {
                         "return": { "foo": ... }
                      }

Doesn't match the "general form": there is no list of members in curly
braces.  We have different formal language instead.

Again, the formal language is redundant except for type information.

Again, the order of things is inferior to the doc comment's order.

The example formatting is a bit unfortunate.

My try:

    2.5 Command API documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

    A command is a message consisting of command name and arguments sent
    by the client to the server, which makes the server send a message
    in reply.  The reply is either a return value or an error.  The
    return value can be an arbitrary type.  The arguments taken together
    are commonly like a struct type, but union type is also possible.
    API documentation shows arguments and return value like this:

     -- Command: command-name

         Description of the command

         The arguments are:

         ''arg''
              Description of argument ''arg''
         ... more arguments ...

         Returns type ReturnType: Description of the return value

         Example:
            -> { "execute": "command-name", "arguments": { "arg": ... } }
            <- { "return": ... }

    See qmp-spec.txt for more detailed information on command message
    wire format.

Mostly glossed over: how exactly we show commands where 'data' is a type
name, such as blockdev-add.  Can't say offhand how we treat those in the
doc generator now.

> +
> +@section Event documentation
> +
> +An event is a JSON object defined by its name, used as the @t{'event'}
> +member value, and a @t{'data'} member for the event members.
> +
> +The API documentation uses the following syntax for an event:
> +
> +@deftypefn Event {} EVENT_NAME @
> +{('foo': @t{type}, ...)}
> +
> +@table @asis
> +@item @code{'foo'}
> +An event member
> +@end table
> +Event emitted when ...
> +@quotation Note
> +This event is rate-limited.
> +@end quotation
> +@quotation Example
> +@example
> +<-   @{ "event": "EVENT_NAME",
> +       "data": @{ "param": .. @},
> +       "timestamp": @{ "seconds": 1267020223, "microseconds": 435656 @} =
@}
> +@end example
> +@end quotation
> +@end deftypefn

Plain text:

    2.6 Event documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    An event is a JSON object defined by its name, used as the 'event'
    member value, and a 'data' member for the event members.

    The API documentation uses the following syntax for an event:

     -- Event: EVENT_NAME ('foo': type, ...)

         ''foo''
              An event member
         Event emitted when ...
              Note: This event is rate-limited.
              Example: <-   { "event": "EVENT_NAME",
                          "data": { "param": .. },
                          "timestamp": { "seconds": 1267020223, "microsecon=
ds": 435656 } }

Again, doesn't match the "general form": there is no list of members in
curly braces; we have different formal language instead.

Again, the formal language is redundant except for type information.

Again, the order of things is inferior to the doc comment's order.

Again, the example formatting is a bit unfortunate.

The example's data doesn't match the documented event members.

My try:

    2.6 Event API documentation
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

    An event is an asynchronous message sent by the server to the
    client, consisting of event name and event data.  Event data is like
    a struct type.  API documentation shows it like this:

     -- Event: EVENT_NAME

         Description of the event

         Event data members are:

         ''foo''
              Description of member foo
         ... more members ...

         Example:
             <- { "event": "EVENT_NAME",
                  "data": { "foo": ... },
                  "timestamp": { ... } }

    See qmp-spec.txt for more detailed information on command message
    wire format.

Now that I mangled^Wreviewed all the sections on specific forms: which
parts of the "general form" section do we actually need?

> diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
> new file mode 100644
> index 0000000000..2c8ad45d49
> --- /dev/null
> +++ b/docs/qemu-ga-ref.texi
> @@ -0,0 +1,85 @@
> +\input texinfo
> +@setfilename qemu-ga-ref.info
> +
> +@exampleindent 0
> +@paragraphindent 0
> +
> +@settitle QEMU Guest Agent Protocol Reference
> +
> +@copying
> +This is the QEMU Guest Agent Protocol reference manual.
> +
> +Copyright @copyright{} 2016 The QEMU Project developers
> +
> +@quotation
> +This manual is free documentation: you can redistribute it and/or
> +modify it under the terms of the GNU General Public License as
> +published by the Free Software Foundation, either version 2 of the
> +License, or (at your option) any later version.
> +
> +This manual is distributed in the hope that it will be useful, but
> +WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this manual.  If not, see http://www.gnu.org/licenses/.
> +@end quotation
> +@end copying
> +
> +@dircategory QEMU
> +@direntry
> +* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
> +@end direntry
> +
> +@titlepage
> +@title Guest Agent Protocol Reference Manual
> +@subtitle QEMU version @value{VERSION}
> +@page
> +@vskip 0pt plus 1filll
> +@insertcopying
> +@end titlepage
> +
> +@contents
> +
> +@ifnottex
> +@node Top
> +@top QEMU Guest Agent protocol reference
> +@end ifnottex
> +
> +@menu
> +* API Reference::
> +* Documentation syntax::
> +* Commands and Events Index::
> +* Data Types Index::
> +@end menu
> +
> +@node API Reference
> +@chapter API Reference
> +
> +@c for texi2pod:
> +@c man begin DESCRIPTION
> +
> +@include qemu-ga-qapi.texi
> +
> +@c man end
> +
> +@node Documentation syntax
> +@chapter Documentation syntax
> +
> +@c for texi2pod:
> +@c man begin NOTES
> +
> +@include qapi-syntax.texi
> +
> +@c man end
> +
> +@node Commands and Events Index
> +@unnumbered Commands and Events Index
> +@printindex fn
> +
> +@node Data Types Index
> +@unnumbered Data Types Index
> +@printindex tp
> +
> +@bye
> diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
> new file mode 100644
> index 0000000000..5fa354afa3
> --- /dev/null
> +++ b/docs/qemu-qmp-ref.texi
> @@ -0,0 +1,85 @@
> +\input texinfo
> +@setfilename qemu-qmp-ref.info
> +
> +@exampleindent 0
> +@paragraphindent 0
> +
> +@settitle QEMU QMP Reference Manual
> +
> +@copying
> +This is the QEMU QMP reference manual.
> +
> +Copyright @copyright{} 2016 The QEMU Project developers
> +
> +@quotation
> +This manual is free documentation: you can redistribute it and/or
> +modify it under the terms of the GNU General Public License as
> +published by the Free Software Foundation, either version 2 of the
> +License, or (at your option) any later version.
> +
> +This manual is distributed in the hope that it will be useful, but
> +WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this manual.  If not, see http://www.gnu.org/licenses/.
> +@end quotation
> +@end copying
> +
> +@dircategory QEMU
> +@direntry
> +* QEMU-QMP-Ref: (qemu-qmp-ref). QEMU QMP Reference Manual
> +@end direntry
> +
> +@titlepage
> +@title QMP Reference Manual
> +@subtitle QEMU version @value{VERSION}
> +@page
> +@vskip 0pt plus 1filll
> +@insertcopying
> +@end titlepage
> +
> +@contents
> +
> +@ifnottex
> +@node Top
> +@top QEMU QMP reference
> +@end ifnottex
> +
> +@menu
> +* API Reference::
> +* Documentation syntax::
> +* Commands and Events Index::
> +* Data Types Index::
> +@end menu
> +
> +@node API Reference
> +@chapter API Reference
> +
> +@c for texi2pod:
> +@c man begin DESCRIPTION
> +
> +@include qemu-qapi.texi
> +
> +@c man end
> +
> +@node Documentation syntax
> +@chapter Documentation syntax
> +
> +@c for texi2pod:
> +@c man begin NOTES
> +
> +@include qapi-syntax.texi
> +
> +@c man end
> +
> +@node Commands and Events Index
> +@unnumbered Commands and Events Index
> +@printindex fn
> +
> +@node Data Types Index
> +@unnumbered Data Types Index
> +@printindex tp
> +
> +@bye
