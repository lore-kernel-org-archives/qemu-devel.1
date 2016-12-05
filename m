Received: from eggs.gnu.org ([2001:4830:134:3::10]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cDxBI-0008Oo-G8
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cDxB7-0000t5-Jz
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:36:00 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cDxB6-0000sb-GE
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:35:49 -0500
Received: by mail-lf0-x243.google.com with SMTP id o141so26519736lff.1
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 09:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20161117155504.21843-1-marcandre.lureau@redhat.com>
	<20161117155504.21843-14-marcandre.lureau@redhat.com>
	<87twapdkb5.fsf@dusky.pond.sub.org>
In-Reply-To: <87twapdkb5.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 05 Dec 2016 17:35:34 +0000
Message-ID: <CAJ+F1CLjozGuqXARb-W8CjmJY64JFAgWogAL_HnnyhUgJwf5VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/17] qapi: add qapi2texi script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Wed, Nov 30, 2016 at 8:07 PM Markus Armbruster <armbru@redhat.com> wrote=
:

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> As the name suggests, the qapi2texi script converts JSON QAPI
> description into a texi file suitable for different target
> formats (info/man/txt/pdf/html...).
>
> It parses the following kind of blocks:
>
> Free-form:
>
>   ##
>   # =3D Section
>   # =3D=3D Subsection
>   #
>   # Some text foo with *emphasis*
>   # 1. with a list
>   # 2. like that
>   #
>   # And some code:
>   # | $ echo foo
>   # | -> do this
>   # | <- get that
>   #
>   ##
>
> Symbol:
>
>   ##
>   # @symbol:
>   #
>   # Symbol body ditto ergo sum. Foo bar
>   # baz ding.
>   #
>   # @arg: foo
>   # @arg: #optional foo

Let's not use @arg twice.

Terminology: I prefer to use "parameter" for formal parameters, and
"argument" for actual arguments.  This matches how The Python Language
Reference uses the terms.

What about

    # @param1: the frob to frobnicate
    # @param2: #optional how hard to frobnicate


ok


>   #
>   # Returns: returns bla bla
>   #          Or bla blah

Repeating "returns" is awkward, and we don't do that in our schemas.

We need a period before "Or", or spell it "or".

What about

    # Returns: the frobnicated frob.
    #          If frob isn't frobnicatable, GenericError.


ok


>   #
>   # Since: version
>   # Notes: notes, comments can have
>   #        - itemized list
>   #        - like this
>   #
>   # Example:
>   #
>   # -> { "execute": "quit" }
>   # <- { "return": {} }
>   #
>   ##
>
> That's roughly following the following EBNF grammar:
>
> api_comment =3D "##\n" comment "##\n"
> comment =3D freeform_comment | symbol_comment
> freeform_comment =3D { "# " text "\n" | "#\n" }
> symbol_comment =3D "# @" name ":\n" { member | meta | freeform_comment }

Rejects non-empty comments where "#" is not followed by space.  Such
usage is accepted outside doc comments.  Hmm.

> member =3D "# @" name ':' [ text ] freeform_comment

Are you missing a "\n" before freeform_comment?


yes

> meta =3D "# " ( "Returns:", "Since:", "Note:", "Notes:", "Example:",
"Examples:" ) [ text ] freeform_comment

Likewise.


ok


> text =3D free-text markdown-like, "#optional" for members

The grammar is ambiguous: a line "# @foo:\n" can be parsed both as
freeform_comment and as symbol_comment.  Since your intent is obvious
enough, it can still serve as documentation.  It's not a suitable
foundation for parsing, though.  Okay for a commit message.

> Thanks to the following json expressions, the documentation is enhanced
> with extra information about the type of arguments and return value
> expected.

I guess you want to say that we enrich the documentation we extract from
comments with information from the actual schema.  Correct?


yes


Missing: a brief discussion of deficiencies.  These include:

* The generated QMP documentation includes internal types

  We use qapi-schema.json both for defining the external QMP interface
  and for defining internal types.  qmp-introspect.py carefully
  separates the two, to not expose internal types.  qapi2texi.py happily
  exposes everything.

  Currently, about a fifth of the types in the generated docs are
  internal:

      AcpiTableOptions
      BiosAtaTranslation
      BlockDeviceMapEntry
      COLOMessage
      COLOMode
      DummyForceArrays
      FailoverStatus
      FloppyDriveType
      ImageCheck
      LostTickPolicy
      MapEntry
      MigrationParameter
      NetClientDriver
      NetFilterDirection
      NetLegacy
      NetLegacyNicOptions
      NetLegacyOptions
      NetLegacyOptionsKind
      Netdev
      NetdevBridgeOptions
      NetdevDumpOptions
      NetdevHubPortOptions
      NetdevL2TPv3Options
      NetdevNetmapOptions
      NetdevNoneOptions
      NetdevSocketOptions
      NetdevTapOptions
      NetdevUserOptions
      NetdevVdeOptions
      NetdevVhostUserOptions
      NumaNodeOptions
      NumaOptions
      NumaOptionsKind
      OnOffAuto
      OnOffSplit
      PreallocMode
      QCryptoBlockCreateOptions
      QCryptoBlockCreateOptionsLUKS
      QCryptoBlockFormat
      QCryptoBlockInfo
      QCryptoBlockInfoBase
      QCryptoBlockInfoQCow
      QCryptoBlockOpenOptions
      QCryptoBlockOptionsBase
      QCryptoBlockOptionsLUKS
      QCryptoBlockOptionsQCow
      QCryptoSecretFormat
      QCryptoTLSCredsEndpoint
      QapiErrorClass
      ReplayMode
      X86CPUFeatureWordInfo
      X86CPURegister32

  Generating documentation for internal types might be useful, but
  letting them pollute QMP interface documentation isn't.  Needs fixing
  before we release.  Until then, needs a FIXME comment in qapi2texi.py.

* Union support is lacking

  The doc string language is adequate for documenting commands, events,
  and non-union types.  It doesn't really handle union variants.  Hardly
  surprising, as you fitted the language do existing practice, and
  existing (mal-)practice is neglecting to document union variant
  members.

* Documentation is lacking

  See review of qapi-code-gen.txt below.

* Doc comment error message positions are imprecise

  They always point to the beginning of the comment.

* Probably more

  We should update this with noteworthy findings during review.  I
  tried, but I suspect I missed some.


ok



> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[Lengthy diffstat snipped...]
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e98d3b6..f16764c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -350,6 +350,21 @@ qapi-schema +=3D base-cycle-direct.json
>  qapi-schema +=3D base-cycle-indirect.json
>  qapi-schema +=3D command-int.json
>  qapi-schema +=3D comments.json
> +qapi-schema +=3D doc-bad-args.json
> +qapi-schema +=3D doc-bad-symbol.json
> +qapi-schema +=3D doc-duplicated-arg.json
> +qapi-schema +=3D doc-duplicated-return.json
> +qapi-schema +=3D doc-duplicated-since.json
> +qapi-schema +=3D doc-empty-arg.json
> +qapi-schema +=3D doc-empty-section.json
> +qapi-schema +=3D doc-empty-symbol.json
> +qapi-schema +=3D doc-invalid-end.json
> +qapi-schema +=3D doc-invalid-end2.json
> +qapi-schema +=3D doc-invalid-return.json
> +qapi-schema +=3D doc-invalid-section.json
> +qapi-schema +=3D doc-invalid-start.json
> +qapi-schema +=3D doc-missing-expr.json
> +qapi-schema +=3D doc-missing-space.json
>  qapi-schema +=3D double-data.json
>  qapi-schema +=3D double-type.json
>  qapi-schema +=3D duplicate-key.json
> @@ -443,6 +458,8 @@ qapi-schema +=3D union-optional-branch.json
>  qapi-schema +=3D union-unknown.json
>  qapi-schema +=3D unknown-escape.json
>  qapi-schema +=3D unknown-expr-key.json
> +
> +
>  check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schema))
>
>  GENERATED_HEADERS +=3D tests/test-qapi-types.h tests/test-qapi-visit.h \
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 4d1b0e4..1b456b4 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -122,6 +122,109 @@ class QAPILineError(Exception):
>              "%s:%d: %s" % (self.info['file'], self.info['line'],
self.msg)
>
>
> +class QAPIDoc(object):
> +    class Section(object):
> +        def __init__(self, name=3D""):

name=3DNone feels more natural than "" for an absent optional name.


ok



> +            # optional section name (argument/member or section name)
> +            self.name =3D name
> +            # the list of strings for this section

Would "list of lines" be more accurate, or less?


more accurate, ok



> +            self.content =3D []
> +
> +        def append(self, line):
> +            self.content.append(line)
> +
> +        def __repr__(self):
> +            return "\n".join(self.content).strip()
> +
> +    class ArgSection(Section):
> +        pass

Begs the question what makes ArgSection differ from Section.  I think
it's the semantics of self.name: an ArgSection's name is the parameter
name, a non-ArgSection can either be a "meta" section (name is one of
"Returns"", "Since", "Note", "Notes", "Example", "Examples") or an
anonymous section (name is "").


yes, and the section type is checked in  _append_freeform()

> +
> +    def __init__(self, parser):
> +        self.parser =3D parser
> +        self.symbol =3D None
> +        self.body =3D QAPIDoc.Section()
> +        # a dict {'arg': ArgSection, ...}

Works.  Alternatevely:

           # dict mapping parameter name to ArgSection


ok


> +        self.args =3D OrderedDict()
> +        # a list of Section
> +        self.meta =3D []
> +        # the current section
> +        self.section =3D self.body
> +        # associated expression and info (set by expression parser)

"will be set by expression parser", or "to be set by expression parser"?


ok


> +        self.expr =3D None
> +        self.info =3D None

Clearer now.  The one remark I still have is on the use of "meta" isn't
obvious here.  I think a comment further up explaining the different
kinds of sections would help.

To be honest, I don't get what's "meta" about the "meta" sections :)


 Let's drop that distinction, it isn't necessary anymore


> +
> +    def has_meta(self, name):
> +        """Returns True if the doc has a meta section 'name'"""

PEP257[1] demands imperative mood, and punctuation:

           """Return True if the doc has a meta section 'name'."""

Unfortunately, there seems to be no established convention for marking
parameter names.  You put this one in single quotes, which works here,
but could be confusing in other cases.  I'd sidestep it:

           """Return True if we have a meta section with this name."""

or

           """Does a meta section with this name exist?"""


ok



> +        for i in self.meta:
> +            if i.name =3D=3D name:
> +                return True
> +        return False
> +
> +    def append(self, line):
> +        """Adds a # comment line, to be parsed and added to current
section"""

Imperative mood:

    """Add a comment line, to be parsed and added to the current section.""=
"

However, we're not always adding to the current section, we can also
start a new one.  The following avoids suggesting anything about the
current section:

    """Parse a comment line and add it to the documentation."""

When the function name is a verb, and its doc string starts with a
different verb, the name might be suboptimal.  Use your judgement.

If this one-liner is too terse, we can try a multi-line doc string:

    """Parse a comment line and add it to the documentation.

    TODO should we tell more about how we parse?

    Args:
        line: the comment starting with '#', with the newline stripped.

    Raises:
        QAPISchemaError: TODO explain error conditions
    """

Format stolen from the Google Python Style Guide[2], because PEP257 is
of not much help there.

Once you start with such elaborate doc strings, pressure will likely
mount to do the same elsewhere.  Could be a distraction right now.  Use
your judgement.


ok, thanks


> +        line =3D line[1:]
> +        if not line:
> +            self._append_freeform(line)
> +            return
> +
> +        if line[0] !=3D ' ':
> +            raise QAPISchemaError(self.parser, "missing space after #")
> +        line =3D line[1:]

QAPISchemaError takes the error position from its QAPISchemaParser
argument.  In other words, the error position depends on the state of
the parser when it calls this function.  Turns out the position is the
beginning of the comment.  Servicable here.  Action at a distance,
though.

Less strict:

           # strip leading # and space
           line =3D line[1:]
           if line[0] =3D=3D ' ':
               line =3D line[1:]

Also avoids special-casing empty comments.


That would raise "IndexError: string index out of range" on empty comment
lines ("#")

Also I'd like to keep the error in case a space is missing (it caught some
already).


Perhaps we should treat all leading whitespace the same (I'm not sure):

           # strip leading # and whitespace
           line =3D line[1:]
           line =3D line.lstrip()


That would break indentation in Example sections



> +
> +        if self.symbol:
> +            self._append_symbol_line(line)
> +        elif (not self.body.content and
> +              line.startswith("@") and line.endswith(":")):
> +            self.symbol =3D line[1:-1]
> +            if not self.symbol:
> +                raise QAPISchemaError(self.parser, "Invalid symbol")

Doesn't recognize the symbol when there's anything other than a single
space between # and @.  Pathological case: '#\t@foo:' starting in column
6 looks exactly like '# @foo:', but doesn't work.  Fortunately, your
code rejects the tab there.  Assigning meaning to (leading) whitespace
may make sense, but it must be documented clearly.


I think it's simpler to only accept a simple space (# + space + @ + symbol
+ :), it will also lead to more uniform doc.


Doesn't recognize the symbol when there's crap after ":".  Confusing
when it's invisible crap, i.e. trailing whitespace.  In general, it's
best to parse left to right, like this:

           elif not self.body.content and line.startswith('@'):
               match =3D valid_name.match(line[1:]);
               if not match:
                   raise QAPISchemaError(self.parser, 'Invalid name')
               if line.startswith(':', match.end(0)):
                   raise QAPISchemaError(self.parser, 'Expected ":")


Easier is simply to check :
if not line.endswith(":"):
                raise QAPIParseError(self.parser, "Line should end with :")

test added

Here, the error position is clearly suboptimal: it's the beginning of
the comment instead of where the actual error is, namely the beginning /
the end of the name.  More of the same below.  The root cause is
stacking parsers.  I'm not asking you to do anything about it at this
time.

Note my use of "name" rather than "symbol" in the error message.
qapi-code-gen.txt talks about names, not symbols.  Consistent use of
terminology matters.


Agree, isn't "symbol" more appropriate for documentation though?


> +        else:
> +            self._append_freeform(line)
> +
> +    def _append_symbol_line(self, line):
> +        name =3D line.split(' ', 1)[0]
> +
> +        if name.startswith("@") and name.endswith(":"):
> +            line =3D line[len(name)+1:]
> +            self._start_args_section(name[1:-1])

Similar issue.  Left to right:

           if re.match(r'\s*@', line):
               match =3D valid_name.match(line[1:]);
               if not match:
                   raise QAPISchemaError(self.parser, 'Invalid parameter
name')
               line =3D line[match.end(0):]
               if line.startswith(':'):
                   raise QAPISchemaError(self.parser, 'Expected ":")
               line =3D line[1:]
               self._start_args_section(match.group(0))

Even better would be factoring out the common code to parse '@foo:'.


It's a valid case to have a section freeform comment starting with @foo, ex=
:

@param: do this and than if
               @param2 is True

 I don't think it's worth to factor out the code to parse @foo vs @foo:, ye=
t



> +        elif name in ("Returns:", "Since:",
> +                      # those are often singular or plural
> +                      "Note:", "Notes:",
> +                      "Example:", "Examples:"):
> +            line =3D line[len(name)+1:]
> +            self._start_meta_section(name[:-1])

Since we're re.match()ing already, here's how do to it that way:


I don't follow your suggestion for the reason above,so I still have the
first word 'name'


           else
               match =3D re.match(r'\s*(Returns|Since|Notes?|Examples?):',
line)
               if match:
                   line =3D line[match.end(0):]
                   self._start_meta_section(match.group(1))


not really much nicer to me (especially because no match yet), I'll keep
the current code for now



> +
> +        self._append_freeform(line)
> +
> +    def _start_args_section(self, name):
> +        if not name:
> +            raise QAPISchemaError(self.parser, "Invalid argument name")

parameter name


ok



> +        if name in self.args:
> +            raise QAPISchemaError(self.parser, "'%s' arg duplicated" %
name)

Duplicate parameter name


ok


> +        self.section =3D QAPIDoc.ArgSection(name)
> +        self.args[name] =3D self.section
> +
> +    def _start_meta_section(self, name):
> +        if name in ("Returns", "Since") and self.has_meta(name):
> +            raise QAPISchemaError(self.parser,
> +                                  "Duplicated '%s' section" % name)
> +        self.section =3D QAPIDoc.Section(name)
> +        self.meta.append(self.section)
> +
> +    def _append_freeform(self, line):
> +        in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
> +        if in_arg and self.section.content and not
self.section.content[-1] \
> +           and line and not line[0].isspace():

PEP8[3] prefers parenthesises over backslash:

           if (in_arg and self.section.content and not
self.section.content[-1]
               and line and not line[0].isspace()):


yes, thanks


> +            # an empty line followed by a non-indented
> +            # comment ends the argument section
> +            self.section =3D self.body
> +            self._append_freeform(line)
> +            return

Switching back to the self.body section like this reorders the
documentation text.  I still think this is a terrible idea.  A dumb
script is exceedingly unlikely to improve human-written doc comment text
by reordering.  In the rare case it does, the doc comment source should
be reordered.

Here's an example where the doc generator happily creates unintelligible
garbage if I format CpuDefinitionInfo's doc comment in a slightly off
way:

    ##
    # @CpuDefinitionInfo:
    #
    # Virtual CPU definition.
    #
    # @name: the name of the CPU definition
    #
    # @migration-safe: #optional whether a CPU definition can be safely
    # used for migration in combination with a QEMU compatibility
    # machine when migrating between different QMU versions and between
    # hosts with different sets of (hardware or software)
    # capabilities.
    #
    # If not provided, information is not available and callers should
    # not assume the CPU definition to be migration-safe. (since 2.8)
    #
    # @static: whether a CPU definition is static and will not change
    # depending on QEMU version, machine type, machine options and
    # accelerator options.  A static model is always
    # migration-safe. (since 2.8)
    #
    # @unavailable-features: #optional List of properties that prevent
    # the CPU model from running in the current host. (since 2.8)
    #
    # @unavailable-features is a list of QOM property names that
    # represent CPU model attributes that prevent the CPU from running.
    # If the QOM property is read-only, that means there's no known
    # way to make the CPU model run in the current host. Implementations
    # that choose not to provide specific information return the
    # property name "type".
    #
    # If the property is read-write, it means that it MAY be possible
    # to run the CPU model in the current host if that property is
    # changed. Management software can use it as hints to suggest or
    # choose an alternative for the user, or just to generate meaningful
    # error messages explaining why the CPU model can't be used.
    # If @unavailable-features is an empty list, the CPU model is
    # runnable using the current host and machine-type.
    # If @unavailable-features is not present, runnability
    # information for the CPU is not available.
    #
    # Since: 1.2.0
    ##
    { 'struct': 'CpuDefinitionInfo',
      'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
                '*unavailable-features': [ 'str' ] } }

To detect the problem, you have to read the generated docs attentively.
You know my opinion on our chances for that to happen during
development.

My point is not that we should support this doc comment format.  My
point is that people could conceivably write something like it, and not
get caught in patch review.

I can see three ways out of this swamp:

1. Let sections continue until another one begins.


but we have interleaved  sections, and no explicit "body" section tag, ex:

##
# @input-send-event:
#
# Send input event(s) to guest.
#
# @device: #optional display device to send event(s) to.
# @head: #optional head to send event(s) to, in case the
#        display device supports multiple scanouts.
# @events: List of InputEvent union.
#
# Returns: Nothing on success.
#
# The @device and @head parameters can be used to send the input event
# to specific input devices in case (a) multiple input devices of the
# same kind are added to the virtual machine and (b) you have
# configured input routing (see docs/multiseat.txt) for those input
# ....

3. When a section ends, start a new anonymous section.


It's not clear how to recognize when a section ends and append to comment
body.



2. Make text between sections an error.


Sound like the best option to me. I'll fix the doc and add a check & test
for this common pattern though:

##
# @TestStruct:
#
# body with @var
#
# @integer: foo
#           blah
#
#           bao
#
# Let's catch this bad comment.
##




Can't say offhand which one will work best.


> +        if in_arg or not self.section.name.startswith("Example"):
> +            line =3D line.strip()

Stripping whitespace is not "Markdown-like", because intendation carries
meaning in Markdown.  Example:

* First item in itemized list
* Second item
    * Sub-item of second item
    * Another sub-item
* Third item

Stripping whitespace destroys the list structure.  If that's what you
want, you get to document where your "Markdown-like" markup is unlike
Markdown :)


let's use "comment annotations" instead



Is there a technical reason for stripping whitespace?

See also discussion of space after # above.

> +        self.section.append(line)
> +
> +
>  class QAPISchemaParser(object):
>
>      def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
> @@ -137,11 +240,18 @@ class QAPISchemaParser(object):
>          self.line =3D 1
>          self.line_pos =3D 0
>          self.exprs =3D []
> +        self.docs =3D []
>          self.accept()
>
>          while self.tok is not None:
>              info =3D {'file': fname, 'line': self.line,
>                      'parent': self.incl_info}
> +            if self.tok =3D=3D '#' and self.val.startswith('##'):

How can self.val *not* start with '##' here?


 you are right, unnecessary condition since we break get_expr() only in
this case now


> +                doc =3D self.get_doc()
> +                doc.info =3D info

Let's pass info as argument to get_doc(), so we don't have to dot into
doc here.  get_doc() can avoid dotting into doc by passing info to the
constructor.


ok


> +                self.docs.append(doc)
> +                continue
> +
>              expr =3D self.get_expr(False)
>              if isinstance(expr, dict) and "include" in expr:
>                  if len(expr) !=3D 1:
> @@ -160,6 +270,7 @@ class QAPISchemaParser(object):
>                          raise QAPILineError(info, "Inclusion loop for %s=
"
>                                              % include)
>                      inf =3D inf['parent']
> +
>                  # skip multiple include of the same file
>                  if incl_abs_fname in previously_included:
>                      continue
> @@ -171,12 +282,38 @@ class QAPISchemaParser(object):
>                  exprs_include =3D QAPISchemaParser(fobj,
previously_included,
>                                                   info)
>                  self.exprs.extend(exprs_include.exprs)
> +                self.docs.extend(exprs_include.docs)
>              else:
>                  expr_elem =3D {'expr': expr,
>                               'info': info}
> +                if self.docs and not self.docs[-1].expr:
> +                    self.docs[-1].expr =3D expr
> +                    expr_elem['doc'] =3D self.docs[-1]
> +

Attaches the expression to the last doc comment that doesn't already
have one.  A bit sloppy, because there could be non-doc comments in
between, or the doc comment could be in another file.  It'll do, at
least for now.


I extended the condition to check it attaches the doc from the same file



>                  self.exprs.append(expr_elem)
>
> -    def accept(self):
> +    def get_doc(self):
> +        if self.val !=3D '##':
> +            raise QAPISchemaError(self, "Junk after '##' at start of "
> +                                  "documentation comment")
> +
> +        doc =3D QAPIDoc(self)
> +        self.accept(False)
> +        while self.tok =3D=3D '#':
> +            if self.val.startswith('##'):
> +                # End of doc comment
> +                if self.val !=3D '##':
> +                    raise QAPISchemaError(self, "Junk after '##' at end
of "
> +                                          "documentation comment")
> +                self.accept()
> +                return doc
> +            else:
> +                doc.append(self.val)
> +            self.accept(False)
> +
> +        raise QAPISchemaError(self, "Documentation comment must end with
'##'")

Let's put this after accept, next to the other get_FOO().


ok



> +
> +    def accept(self, skip_comment=3DTrue):
>          while True:
>              self.tok =3D self.src[self.cursor]
>              self.pos =3D self.cursor
> @@ -184,7 +321,13 @@ class QAPISchemaParser(object):
>              self.val =3D None
>
>              if self.tok =3D=3D '#':
> +                if self.src[self.cursor] =3D=3D '#':
> +                    # Start of doc comment
> +                    skip_comment =3D False
>                  self.cursor =3D self.src.find('\n', self.cursor)
> +                if not skip_comment:
> +                    self.val =3D self.src[self.pos:self.cursor]
> +                    return
>              elif self.tok in "{}:,[]":
>                  return
>              elif self.tok =3D=3D "'":

Copied from review of v3, so I don't forget:

Comment tokens are thrown away as before, except when the parser asks
for them by passing skip_comment=3DFalse, or when the comment token starts
with ##.  The parser asks while parsing a doc comment, in get_doc().

This is a backchannel from the parser to the lexer.  I'd rather avoid
such lexer hacks, but I guess we can address that on top.

A comment starting with ## inside an expression is now a syntax error.
For instance, input

    {
    ##

yields

    /dev/stdin:2:1: Expected string or "}"

Rather unfriendly error message, but we can fix that on top.


I don't have a good solution to that


> @@ -713,7 +856,7 @@ def check_keys(expr_elem, meta, required,
optional=3D[]):
>                                  % (key, meta, name))
>
>
> -def check_exprs(exprs):
> +def check_exprs(exprs, strict_doc):

Note: strict_doc=3DFalse unless this is qapi2texi.py.


For tests reasons: we may want to fix the test instead, or have a flag
QAPI_CHECK/NOSTRICT_DOC=3D1 or an option.


>      global all_names
>
>      # Learn the types and check for valid expression keys
> @@ -722,6 +865,11 @@ def check_exprs(exprs):
>      for expr_elem in exprs:
>          expr =3D expr_elem['expr']
>          info =3D expr_elem['info']
> +
> +        if strict_doc and 'doc' not in expr_elem:
> +            raise QAPILineError(info,
> +                                "Expression missing documentation
comment")
> +

Why should we supress this error in programs other than qapi2texi.py?


because the tests don't have comments


Can't see a test for this one.


because tests aren't strict :)

I guess you'll tell me to fix the tests instead, so I did that in the next
series.


>          if 'enum' in expr:
>              check_keys(expr_elem, 'enum', ['data'], ['prefix'])
>              add_enum(expr['enum'], info, expr['data'])
> @@ -780,6 +928,63 @@ def check_exprs(exprs):
>      return exprs
>
>
> +def check_simple_doc(doc):

You call this "free-form" elsewhere.  Pick one name and stick to it.
I think free-form is more descriptive than simple.

ok


> +    if doc.symbol:
> +        raise QAPILineError(doc.info,
> +                            "'%s' documention is not followed by the
definition"
> +                            % doc.symbol)

"Documentation for %s is not ..."


ok


> +
> +    body =3D str(doc.body)
> +    if re.search(r'@\S+:', body, re.MULTILINE):
> +        raise QAPILineError(doc.info,
> +                            "Document body cannot contain @NAME:
sections")
> +
> +
> +def check_expr_doc(doc, expr, info):

You call this "symbol" elsewhere.  I think "definition" would be better
than either.


 ok


> +    for i in ('enum', 'union', 'alternate', 'struct', 'command',
'event'):
> +        if i in expr:
> +            meta =3D i
> +            break
> +
> +    name =3D expr[meta]
> +    if doc.symbol !=3D name:
> +        raise QAPILineError(info, "Definition of '%s' follows
documentation"
> +                            " for '%s'" % (name, doc.symbol))
> +    if doc.has_meta('Returns') and 'command' not in expr:
> +        raise QAPILineError(info, "Invalid return documentation")

Suggest something like "'Returns:' is only valid for commands".

We accept 'Returns:' even when the command doesn't return anything,
because we currently use it to document errors, too.  Can't say I like
that, but it's out of scope here.


ok



> +
> +    doc_args =3D set(doc.args.keys())
> +    if meta =3D=3D 'union':
> +        data =3D expr.get('base', [])
> +    else:
> +        data =3D expr.get('data', [])
> +    if isinstance(data, dict):
> +        data =3D data.keys()
> +    args =3D set([name.strip('*') for name in data])

Not fixed since v3:

* Flat union where 'base' is a string, e.g. union UserDefFlatUnion in
  qapi-schema-test.json has base 'UserDefUnionBase', args is set(['a',
  'B', 'e', 'D', 'f', 'i', 'o', 'n', 's', 'r', 'U'])

* Command where 'data' is a string, e.g. user_def_cmd0 in
  qapi-schema-test.json has data 'Empty2', args is set(['E', 'm', 'p',
  '2', 't', 'y'])


* Event where 'data' is a string, no test case handy (hole in test
  coverage)


ok, I changed it that way, that fixes it:
+    if isinstance(data, list):
+        args =3D set([name.strip('*') for name in data])
+    else:
+        args =3D set()



> +    if meta =3D=3D 'alternate' or \
> +       (meta =3D=3D 'union' and not expr.get('discriminator')):
> +        args.add('type')

As explained in review of v3, this is only a subset of the real set of
members.  Computing the exact set is impractical when working with the
abstract syntax tree.  I believe we'll eventually have to rewrite this
code to work with the QAPISchemaEntity instead.


I don't think we want to list all the members as this would lead to
duplicated documentation. Instead it should document only the members of
the expr being defined. In which case, it looks like this check is good
enough, no?



> +    if not doc_args.issubset(args):
> +        raise QAPILineError(info, "Members documentation is not a subset
of"
> +                            " API %r > %r" % (list(doc_args),
list(args)))
> +
> +
> +def check_docs(docs):
> +    for doc in docs:
> +        for section in doc.args.values() + doc.meta:
> +            content =3D str(section)
> +            if not content or content.isspace():
> +                raise QAPILineError(doc.info,
> +                                    "Empty doc section '%s'" %
section.name)
> +
> +        if not doc.expr:
> +            check_simple_doc(doc)
> +        else:
> +            check_expr_doc(doc, doc.expr, doc.info)
> +
> +    return docs
> +
> +
>  #
>  # Schema compiler frontend
>  #
> @@ -1249,9 +1454,11 @@ class QAPISchemaEvent(QAPISchemaEntity):
>
>
>  class QAPISchema(object):
> -    def __init__(self, fname):
> +    def __init__(self, fname, strict_doc=3DFalse):
>          try:
> -            self.exprs =3D check_exprs(QAPISchemaParser(open(fname,
"r")).exprs)
> +            parser =3D QAPISchemaParser(open(fname, "r"))
> +            self.exprs =3D check_exprs(parser.exprs, strict_doc)
> +            self.docs =3D check_docs(parser.docs)
>              self._entity_dict =3D {}
>              self._predefining =3D True
>              self._def_predefineds()
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> new file mode 100755
> index 0000000..0cec43a
> --- /dev/null
> +++ b/scripts/qapi2texi.py

Still only skimming this one.

> @@ -0,0 +1,331 @@
> +#!/usr/bin/env python
> +# QAPI texi generator
> +#
> +# This work is licensed under the terms of the GNU LGPL, version 2+.
> +# See the COPYING file in the top-level directory.
> +"""This script produces the documentation of a qapi schema in texinfo
format"""
> +import re
> +import sys
> +
> +import qapi
> +
> +COMMAND_FMT =3D """
> +@deftypefn {type} {{{ret}}} {name} @
> +{{{args}}}
> +
> +{body}
> +
> +@end deftypefn
> +
> +""".format
> +
> +ENUM_FMT =3D """
> +@deftp Enum {name}
> +
> +{body}
> +
> +@end deftp
> +
> +""".format
> +
> +STRUCT_FMT =3D """
> +@deftp {{{type}}} {name} @
> +{{{attrs}}}
> +
> +{body}
> +
> +@end deftp
> +
> +""".format
> +
> +EXAMPLE_FMT =3D """@example
> +{code}
> +@end example
> +""".format
> +
> +
> +def subst_strong(doc):
> +    """Replaces *foo* by @strong{foo}"""
> +    return re.sub(r'\*([^_\n]+)\*', r'@emph{\1}', doc)
> +
> +
> +def subst_emph(doc):
> +    """Replaces _foo_ by @emph{foo}"""
> +    return re.sub(r'\s_([^_\n]+)_\s', r' @emph{\1} ', doc)
> +
> +
> +def subst_vars(doc):
> +    """Replaces @var by @code{var}"""
> +    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
> +
> +
> +def subst_braces(doc):
> +    """Replaces {} with @{ @}"""
> +    return doc.replace("{", "@{").replace("}", "@}")
> +
> +
> +def texi_example(doc):
> +    """Format @example"""
> +    doc =3D subst_braces(doc).strip('\n')
> +    return EXAMPLE_FMT(code=3Ddoc)
> +
> +
> +def texi_comment(doc):
> +    """
> +    Format a comment
> +
> +    Lines starting with:
> +    - |: generates an @example
> +    - =3D: generates @section
> +    - =3D=3D: generates @subsection
> +    - 1. or 1): generates an @enumerate @item
> +    - o/*/-: generates an @itemize list
> +    """
> +    lines =3D []
> +    doc =3D subst_braces(doc)
> +    doc =3D subst_vars(doc)
> +    doc =3D subst_emph(doc)
> +    doc =3D subst_strong(doc)
> +    inlist =3D ""
> +    lastempty =3D False
> +    for line in doc.split('\n'):
> +        empty =3D line =3D=3D ""
> +
> +        if line.startswith("| "):
> +            line =3D EXAMPLE_FMT(code=3Dline[2:])
> +        elif line.startswith("=3D "):
> +            line =3D "@section " + line[2:]
> +        elif line.startswith("=3D=3D "):
> +            line =3D "@subsection " + line[3:]
> +        elif re.match("^([0-9]*[.)]) ", line):
> +            if not inlist:
> +                lines.append("@enumerate")
> +                inlist =3D "enumerate"
> +            line =3D line[line.find(" ")+1:]
> +            lines.append("@item")
> +        elif re.match("^[o*-] ", line):
> +            if not inlist:
> +                lines.append("@itemize %s" % {'o': "@bullet",
> +                                              '*': "@minus",
> +                                              '-': ""}[line[0]])
> +                inlist =3D "itemize"
> +            lines.append("@item")
> +            line =3D line[2:]
> +        elif lastempty and inlist:
> +            lines.append("@end %s\n" % inlist)
> +            inlist =3D ""
> +
> +        lastempty =3D empty
> +        lines.append(line)
> +
> +    if inlist:
> +        lines.append("@end %s\n" % inlist)
> +    return "\n".join(lines)
> +
> +
> +def texi_args(expr, key=3D"data"):
> +    """
> +    Format the functions/structure/events.. arguments/members
> +    """
> +    if key not in expr:
> +        return ""
> +
> +    args =3D expr[key]
> +    arg_list =3D []
> +    if isinstance(args, str):
> +        arg_list.append(args)
> +    else:
> +        for name, typ in args.iteritems():
> +            # optional arg
> +            if name.startswith("*"):
> +                name =3D name[1:]
> +                arg_list.append("['%s': @var{%s}]" % (name, typ))
> +            # regular arg
> +            else:
> +                arg_list.append("'%s': @var{%s}" % (name, typ))

Inappropriate use of @var.  @var is for metasyntactic variables,
i.e. something that stands for another piece of text.  typ isn't, it's
the name of a specific QAPI type.  I think you should use @code.


yes


This is the reason why the type names in qemu-qmp-ref.txt are often
mangled, e.g.

 -- Struct: VersionInfo { 'qemu': VERSIONTRIPLE, 'package': STR }


Right, we have format issue here. If we change it for @code, we get
additional quotes in the text format. The simpler is to use no format or
@t{}



> +
> +    return ", ".join(arg_list)
> +
> +
> +def texi_body(doc):
> +    """
> +    Format the body of a symbol documentation:
> +    - a table of arguments
> +    - followed by "Returns/Notes/Since/Example" sections
> +    """
> +    def _section_order(section):
> +        return {"Returns": 0,
> +                "Note": 1,
> +                "Notes": 1,
> +                "Since": 2,
> +                "Example": 3,
> +                "Examples": 3}[section]
> +
> +    body =3D "@table @asis\n"
> +    for arg, section in doc.args.iteritems():
> +        desc =3D str(section)
> +        opt =3D ''
> +        if desc.startswith("#optional"):
> +            desc =3D desc[10:]
> +            opt =3D ' *'
> +        elif desc.endswith("#optional"):
> +            desc =3D desc[:-10]
> +            opt =3D ' *'
> +        body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
texi_comment(desc))
> +    body +=3D "@end table\n"
> +    body +=3D texi_comment(str(doc.body))
> +
> +    meta =3D sorted(doc.meta, key=3Dlambda i: _section_order(i.name))
> +    for section in meta:
> +        name, doc =3D (section.name, str(section))
> +        func =3D texi_comment
> +        if name.startswith("Example"):
> +            func =3D texi_example
> +
> +        body +=3D "\n@quotation %s\n%s\n@end quotation" % \
> +                (name, func(doc))
> +    return body
> +
> +
> +def texi_alternate(expr, doc):
> +    """
> +    Format an alternate to texi
> +    """
> +    args =3D texi_args(expr)
> +    body =3D texi_body(doc)
> +    return STRUCT_FMT(type=3D"Alternate",
> +                      name=3Ddoc.symbol,
> +                      attrs=3D"[ " + args + " ]",
> +                      body=3Dbody)
> +
> +
> +def texi_union(expr, doc):
> +    """
> +    Format an union to texi

I think it's "a union".

ok


> +    """
> +    attrs =3D "@{ " + texi_args(expr, "base") + " @}"
> +    discriminator =3D expr.get("discriminator")
> +    if not discriminator:
> +        union =3D "Flat Union"
> +        discriminator =3D "type"
> +    else:
> +        union =3D "Union"

Condition is backwards.


fixed


> +    attrs +=3D " + '%s' =3D [ " % discriminator
> +    attrs +=3D texi_args(expr, "data") + " ]"
> +    body =3D texi_body(doc)
> +
> +    return STRUCT_FMT(type=3Dunion,
> +                      name=3Ddoc.symbol,
> +                      attrs=3Dattrs,
> +                      body=3Dbody)

You're inventing syntax here.  Example output:

 -- Union: QCryptoBlockOpenOptions { QCryptoBlockOptionsBase } +
          'format' =3D [ 'qcow': QCRYPTOBLOCKOPTIONSQCOW, 'luks':
          QCRYPTOBLOCKOPTIONSLUKS ]

     The options that are available for all encryption formats when
     opening an existing volume
          Since: 2.6

 -- Flat Union: ImageInfoSpecific { } + 'type' =3D [ 'qcow2':
          IMAGEINFOSPECIFICQCOW2, 'vmdk': IMAGEINFOSPECIFICVMDK, 'luks':
          QCRYPTOBLOCKINFOLUKS ]

     A discriminated record of image format specific information
     structures.
          Since: 1.7

Note that QCryptoBlockOpenOptions is actually a flat union, and
ImageInfoSpecific a simple union.  As I said, the condition is
backwards.

The meaning of the attrs part is unobvious.  Familiarity with schema
syntax doesn't really help.

Could we simply use schema syntax here?


Union: QCryptoBlockOpenOptions {
'base': QCryptoBlockOptionsBase,
'discriminator': 'format',
'data':  { 'qcow': QCryptoBlockOptionsQCow, 'luks':
QCryptoBlockCreateOptionsLUKS }

}

Doesn't look obvious either and pollute the documentation with
schema-specific parameters.

If not: whatever format you use, you first need to explain it.


I am not sure my solution is the best and will remain, but ok let's try to
document it for now.



> +
> +
> +def texi_enum(expr, doc):
> +    """
> +    Format an enum to texi
> +    """
> +    for i in expr['data']:
> +        if i not in doc.args:
> +            doc.args[i] =3D ''
> +    body =3D texi_body(doc)
> +    return ENUM_FMT(name=3Ddoc.symbol,
> +                    body=3Dbody)
> +
> +
> +def texi_struct(expr, doc):
> +    """
> +    Format a struct to texi
> +    """
> +    args =3D texi_args(expr)
> +    body =3D texi_body(doc)
> +    attrs =3D "@{ " + args + " @}"
> +    base =3D expr.get("base")
> +    if base:
> +        attrs +=3D " + %s" % base
> +    return STRUCT_FMT(type=3D"Struct",
> +                      name=3Ddoc.symbol,
> +                      attrs=3Dattrs,
> +                      body=3Dbody)

More syntax invention.  Example output:

 -- Struct: BlockdevOptionsReplication { 'mode': REPLICATIONMODE,
          ['top-id': STR] } + BlockdevOptionsGenericFormat

     ''mode''
          the replication mode
     ''top-id'' *
          In secondary mode, node name or device ID of the root node who
          owns the replication node chain.  Must not be given in primary
          mode.
     Driver specific block device options for replication
          Since: 2.8

Meaning of the attrs part is perhaps more guessable here, but it's still
guesswork.

The meaning of * after ''top-id'' is also unobvious.

Note the redundancy between the attrs part and the body: both state
member names and optionalness.  The body doesn't state member types and
base type.  If we fixed that, we could drop the attrs part and save us
the trouble of defining and explaining a syntax for it.

Let me take a step back.  This document is about the QMP wire format.
There are no such things as simple and flat unions on the wire, only
JSON objects.  QMP introspection duly describes a type's JSON objects,
not how it's defined in QAPI.  I think QMP documentation should ideally
do the same.

QMP introspection uses a common structure for struct, simple and flat
union: common members, variants, and if variants, then the common member
that serves as tag.  See introspect.json for details.

Base types are flattened away.  Appropriate for introspection, but
documentation shouldn't do that.

I wrote "ideally" because it's probably too big a step.  I'm willing to
settle for something less than ideal.


I don't have clear idea what to do here, so if we can leave that for later,
that would be nice for me (I am already spending more time than I imagined
I would on doc stuff)



> +
> +
> +def texi_command(expr, doc):
> +    """
> +    Format a command to texi
> +    """
> +    args =3D texi_args(expr)
> +    ret =3D expr["returns"] if "returns" in expr else ""
> +    body =3D texi_body(doc)
> +    return COMMAND_FMT(type=3D"Command",
> +                       name=3Ddoc.symbol,
> +                       ret=3Dret,
> +                       args=3D"(" + args + ")",
> +                       body=3Dbody)
> +
> +
> +def texi_event(expr, doc):
> +    """
> +    Format an event to texi
> +    """
> +    args =3D texi_args(expr)
> +    body =3D texi_body(doc)
> +    return COMMAND_FMT(type=3D"Event",
> +                       name=3Ddoc.symbol,
> +                       ret=3D"",
> +                       args=3D"(" + args + ")",
> +                       body=3Dbody)
> +
> +
> +def texi_expr(expr, doc):
> +    """
> +    Format an expr to texi
> +    """
> +    (kind, _) =3D expr.items()[0]
> +
> +    fmt =3D {"command": texi_command,
> +           "struct": texi_struct,
> +           "enum": texi_enum,
> +           "union": texi_union,
> +           "alternate": texi_alternate,
> +           "event": texi_event}
> +    try:
> +        fmt =3D fmt[kind]
> +    except KeyError:
> +        raise ValueError("Unknown expression kind '%s'" % kind)

The try / except converts one kind of error into another.  What does
that buy us?  As far as I can tell, this shouldn't ever happen.


dropped


> +
> +    return fmt(expr, doc)
> +
> +
> +def texi(docs):
> +    """
> +    Convert QAPI schema expressions to texi documentation
> +    """
> +    res =3D []
> +    for doc in docs:
> +        expr =3D doc.expr
> +        if not expr:
> +            res.append(texi_body(doc))
> +            continue
> +        try:
> +            doc =3D texi_expr(expr, doc)
> +            res.append(doc)
> +        except:
> +            print >>sys.stderr, "error at @%s" % doc.info
> +            raise
> +
> +    return '\n'.join(res)
> +
> +
> +def main(argv):
> +    """
> +    Takes schema argument, prints result to stdout
> +    """
> +    if len(argv) !=3D 2:
> +        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" %
argv[0]
> +        sys.exit(1)
> +
> +    schema =3D qapi.QAPISchema(argv[1], strict_doc=3DTrue)
> +    print texi(schema.docs)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main(sys.argv)
> diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
> index 2841c51..8bc963e 100644
> --- a/docs/qapi-code-gen.txt
> +++ b/docs/qapi-code-gen.txt
> @@ -45,16 +45,13 @@ QAPI parser does not).  At present, there is no place
where a QAPI
>  schema requires the use of JSON numbers or null.
>
>  Comments are allowed; anything between an unquoted # and the following
> -newline is ignored.  Although there is not yet a documentation
> -generator, a form of stylized comments has developed for consistently
> -documenting details about an expression and when it was added to the
> -schema.  The documentation is delimited between two lines of ##, then
> -the first line names the expression, an optional overview is provided,
> -then individual documentation about each member of 'data' is provided,
> -and finally, a 'Since: x.y.z' tag lists the release that introduced
> -the expression.  Optional members are tagged with the phrase
> -'#optional', often with their default value; and extensions added
> -after the expression was first released are also given a '(since
> +newline is ignored.  The documentation is delimited between two lines
> +of ##, then the first line names the expression, an optional overview
> +is provided, then individual documentation about each member of 'data'
> +is provided, and finally, a 'Since: x.y.z' tag lists the release that
> +introduced the expression.  Optional members are tagged with the
> +phrase '#optional', often with their default value; and extensions
> +added after the expression was first released are also given a '(since
>  x.y.z)' comment.  For example:
>
>      ##
> @@ -73,12 +70,49 @@ x.y.z)' comment.  For example:
>      #           (Since 2.0)
>      #
>      # Since: 0.14.0
> +    #
> +    # Notes: You can also make a list:
> +    #        - with items
> +    #        - like this
> +    #
> +    # Example:
> +    #
> +    # -> { "execute": ... }
> +    # <- { "return": ... }
> +    #
>      ##
>      { 'struct': 'BlockStats',
>        'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
>                 '*parent': 'BlockStats',
>                 '*backing': 'BlockStats'} }

This example gives an idea of how to document struct types.  But the
reader is left guessing how to document other kinds of definitions.  In
particular, there's no mention of "Returns", "Note" and "Examples"
sections anywhere in this file.  As is, this could do for a tutorial,
but this file is a *reference*, not a tutorial.

For a reference, we need to be more thorough.  A doc comments section on
its own seems advisable.

I guess doc comment examples are best added to the schema code examples
in sections =3D=3D=3D Struct types =3D=3D=3D, ..., =3D=3D=3D Events =3D=3D=
=3D.

Careful review for completeness is advised.


So far we did quite fine with the generic example. I am not convinced we
need to have doc comments for all kinds of types, it looks redundant to me.



> +It's also possible to create documentation sections, such as:
> +
> +    ##
> +    # =3D Section
> +    # =3D=3D Subsection
> +    #
> +    # Some text foo with *strong* and _emphasis_
> +    # 1. with a list
> +    # 2. like that
> +    #
> +    # And some code:
> +    # | $ echo foo
> +    # | -> do this
> +    # | <- get that
> +    #
> +    ##
> +
> +Text *foo* and _foo_ are for "strong" and "emphasis" styles (they do
> +not work over multiple lines). @foo is used to reference a symbol.
> +
> +Lines starting with the following characters and a space:
> +- | are examples
> +- =3D are top section
> +- =3D=3D are subsection
> +- X. or X) are enumerations (X is any number)
> +- o/*/- are itemized list
> +

Is this doc markup documentation complete?


I think so


Is it related to any existing text markup language?  Hmm, the commit
message calls it "Markdown-like".  Should we mention that here?


I'll use "annotations" instead in the doc



Is all markup valid in all contexts?  For instance, is =3D Section valid
in symbol blocks?  What does | (or any markup for that matter) do within
an Example section?


Example is verbatim

I improved a bit the doc based on your feedback. I'd suggest we iterate
with additional patches later, I could use help.


>  The schema sets up a series of types, as well as commands and events
>  that will use those types.  Forward references are allowed: the parser
>  scans in two passes, where the first pass learns all type names, and
> diff --git a/tests/qapi-schema/doc-bad-args.err
b/tests/qapi-schema/doc-bad-args.err
> new file mode 100644
> index 0000000..a55e003
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-args.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/doc-bad-args.json:1: Members documentation is not a
subset of API ['a', 'b'] > ['a']
> diff --git a/tests/qapi-schema/doc-bad-args.exit
b/tests/qapi-schema/doc-bad-args.exit
> new file mode 100644
> index 0000000..d00491f
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-args.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/doc-bad-args.json
b/tests/qapi-schema/doc-bad-args.json
> new file mode 100644
> index 0000000..26992ea
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-args.json
> @@ -0,0 +1,6 @@
> +##
> +# @foo:
> +# @a: a
> +# @b: b
> +##
> +{ 'command': 'foo', 'data': {'a': 'int'} }

The existing tests/qapi-schema/*.json explain what is being tested in a
comment.  Perhaps like this:

    # Arguments listed in the doc comment must exist in the actual schema

    ##
    # @foo:
    ...

Likewise for other tests.


ok



> diff --git a/tests/qapi-schema/doc-bad-args.out
b/tests/qapi-schema/doc-bad-args.out
> new file mode 100644
> index 0000000..e69de29
> diff --git a/tests/qapi-schema/doc-bad-symbol.err
b/tests/qapi-schema/doc-bad-symbol.err
> new file mode 100644
> index 0000000..9c969d1
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-symbol.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/doc-bad-symbol.json:1: Definition of 'foo' follows
documentation for 'food'
> diff --git a/tests/qapi-schema/doc-bad-symbol.exit
b/tests/qapi-schema/doc-bad-symbol.exit
> new file mode 100644
> index 0000000..d00491f
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-symbol.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/doc-bad-symbol.json
b/tests/qapi-schema/doc-bad-symbol.json
> new file mode 100644
> index 0000000..7255152
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-symbol.json
> @@ -0,0 +1,4 @@
> +##
> +# @food:
> +##
> +{ 'command': 'foo', 'data': {'a': 'int'} }
> diff --git a/tests/qapi-schema/doc-bad-symbol.out
b/tests/qapi-schema/doc-bad-symbol.out
> new file mode 100644
> index 0000000..e69de29
> diff --git a/tests/qapi-schema/doc-duplicated-arg.err
b/tests/qapi-schema/doc-duplicated-arg.err
> new file mode 100644
> index 0000000..88a272b
> --- /dev/null
> +++ b/tests/qapi-schema/doc-duplicated-arg.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/doc-duplicated-arg.json:4:1: 'a' arg duplicated
> diff --git a/tests/qapi-schema/doc-duplicated-arg.exit
b/tests/qapi-schema/doc-duplicated-arg.exit
> new file mode 100644
> index 0000000..d00491f
> --- /dev/null
> +++ b/tests/qapi-schema/doc-duplicated-arg.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/doc-duplicated-arg.json
b/tests/qapi-schema/doc-duplicated-arg.json
> new file mode 100644
> index 0000000..f7804c2
> --- /dev/null
> +++ b/tests/qapi-schema/doc-duplicated-arg.json
> @@ -0,0 +1,5 @@
> +##
> +# @foo:
> +# @a:
> +# @a:
> +##
> diff --git a/tests/qapi-schema/doc-duplicated-arg.out
b/tests/qapi-schema/doc-duplicated-arg.out
> new file mode 100644
> index 0000000..e69de29
> diff --git a/tests/qapi-schema/doc-duplicated-return.err
b/tests/qapi-schema/doc-duplicated-return.err
> new file mode 100644
> index 0000000..1b02880
> --- /dev/null
> +++ b/tests/qapi-schema/doc-duplicated-return.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/doc-duplicated-return.json:5:1: Duplicated 'Returns'
section

> diff --git a/tests/qapi-schema/doc-duplicated-return.exit
b/tests/qapi-schema/doc-duplicated-return.exit<br class=3D"gmail_msg

--=20
Marc-Andr=C3=A9 Lureau
