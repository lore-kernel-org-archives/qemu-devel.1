Received: from eggs.gnu.org ([2001:4830:134:3::10]:40589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRI2C-0006Qa-2m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRI26-0004J8-Qv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:29:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRI26-0004Io-EP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:29:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCCE22172A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:29:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-9-marcandre.lureau@redhat.com>
	<87pokju5id.fsf@dusky.pond.sub.org>
	<1150624120.16922.1483970944576.JavaMail.zimbra@redhat.com>
Date: Wed, 11 Jan 2017 13:29:34 +0100
In-Reply-To: <1150624120.16922.1483970944576.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 9 Jan 2017
	09:09:04 -0500 (EST)")
Message-ID: <87tw95pyoh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/17] qapi: add qapi2texi script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > As the name suggests, the qapi2texi script converts JSON QAPI
>> > description into a texi file suitable for different target
>> > formats (info/man/txt/pdf/html...).
>> >
>> > It parses the following kind of blocks:
>> >
>> > Free-form:
>> >
>> >   ##
>> >   # =3D Section
>> >   # =3D=3D Subsection
>> >   #
>> >   # Some text foo with *emphasis*
>> >   # 1. with a list
>> >   # 2. like that
>> >   #
>> >   # And some code:
>> >   # | $ echo foo
>> >   # | -> do this
>> >   # | <- get that
>> >   #
>> >   ##
>> >
>> > Symbol:
>> >
>> >   ##
>> >   # @symbol:
>> >   #
>> >   # Symbol body ditto ergo sum. Foo bar
>> >   # baz ding.
>> >   #
>> >   # @param1: the frob to frobnicate
>> >   # @param2: #optional how hard to frobnicate
>> >   #
>> >   # Returns: the frobnicated frob.
>> >   #          If frob isn't frobnicatable, GenericError.
>> >   #
>> >   # Since: version
>> >   # Notes: notes, comments can have
>> >   #        - itemized list
>> >   #        - like this
>> >   #
>> >   # Example:
>> >   #
>> >   # -> { "execute": "quit" }
>> >   # <- { "return": {} }
>> >   #
>> >   ##
>> >
>> > That's roughly following the following EBNF grammar:
>> >
>> > api_comment =3D "##\n" comment "##\n"
>> > comment =3D freeform_comment | symbol_comment
>> > freeform_comment =3D { "# " text "\n" | "#\n" }
>> > symbol_comment =3D "# @" name ":\n" { member | meta | freeform_comment=
 }
>> > member =3D "# @" name ':' [ text ] "\n" freeform_comment
>> > meta =3D "# " ( "Returns:", "Since:", "Note:", "Notes:", "Example:",
>> > "Examples:" ) [ text ]  "\n" freeform_comment
>> > text =3D free text with annotations
>>=20
>> Let's add:
>>=20
>>     Note that the grammar is ambiguous: a line "# @foo:\n" can be parsed
>>     both as freeform_comment and as symbol_comment.  The actual parser
>>     recognizes symbol_comment.
>>=20
>
> ok
>
>> > See docs/qapi-code-gen.txt for more details.
>> >
>> > The documentation is enriched with information from the actual schema.
>> >
>> > Deficiencies:
>> > - the generated QMP documentation includes internal types
>> > - union support is lacking
>> > - doc comment error message positions are imprecise, they point
>> >   to the beginning of the comment.
>>=20
>> Acceptable.  We need matching FIXME or TODO comments; see below.
>>=20
>> Hope we're not missing anything noteworthy here.  I should double-check.
>>=20
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> [diffstat snipped...]
>>=20
>> Recommend to jump forward to docs/qapi-code-gen.txt, then come back.
>>=20
>> > diff --git a/tests/Makefile.include b/tests/Makefile.include
>> > index e98d3b6bb3..284329a4cd 100644
>> > --- a/tests/Makefile.include
>> > +++ b/tests/Makefile.include
>> > @@ -350,6 +350,23 @@ qapi-schema +=3D base-cycle-direct.json
>> >  qapi-schema +=3D base-cycle-indirect.json
>> >  qapi-schema +=3D command-int.json
>> >  qapi-schema +=3D comments.json
>> > +qapi-schema +=3D doc-bad-args.json
>> > +qapi-schema +=3D doc-bad-section.json
>> > +qapi-schema +=3D doc-bad-symbol.json
>> > +qapi-schema +=3D doc-duplicated-arg.json
>> > +qapi-schema +=3D doc-duplicated-return.json
>> > +qapi-schema +=3D doc-duplicated-since.json
>> > +qapi-schema +=3D doc-empty-arg.json
>> > +qapi-schema +=3D doc-empty-section.json
>> > +qapi-schema +=3D doc-empty-symbol.json
>> > +qapi-schema +=3D doc-invalid-end.json
>> > +qapi-schema +=3D doc-invalid-end2.json
>> > +qapi-schema +=3D doc-invalid-return.json
>> > +qapi-schema +=3D doc-invalid-section.json
>> > +qapi-schema +=3D doc-invalid-start.json
>> > +qapi-schema +=3D doc-missing-colon.json
>> > +qapi-schema +=3D doc-missing-expr.json
>> > +qapi-schema +=3D doc-missing-space.json
>> >  qapi-schema +=3D double-data.json
>> >  qapi-schema +=3D double-type.json
>> >  qapi-schema +=3D duplicate-key.json
>> > @@ -443,6 +460,8 @@ qapi-schema +=3D union-optional-branch.json
>> >  qapi-schema +=3D union-unknown.json
>> >  qapi-schema +=3D unknown-escape.json
>> >  qapi-schema +=3D unknown-expr-key.json
>> > +
>> > +
>> >  check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schem=
a))
>> >=20=20
>> >  GENERATED_HEADERS +=3D tests/test-qapi-types.h tests/test-qapi-visit.=
h \
>> > diff --git a/scripts/qapi.py b/scripts/qapi.py
>> > index 5423b64b23..190530308e 100644
>> > --- a/scripts/qapi.py
>> > +++ b/scripts/qapi.py
>> > @@ -125,6 +125,114 @@ class QAPISemError(QAPIError):
>> >                             info['parent'], msg)
>> >=20=20
>> >=20=20
>> > +class QAPIDoc(object):
>> > +    class Section(object):
>> > +        def __init__(self, name=3DNone):
>> > +            # optional section name (argument/member or section name)
>> > +            self.name =3D name
>> > +            # the list of lines for this section
>> > +            self.content =3D []
>> > +
>> > +        def append(self, line):
>> > +            self.content.append(line)
>> > +
>> > +        def __repr__(self):
>> > +            return "\n".join(self.content).strip()
>> > +
>> > +    class ArgSection(Section):
>> > +        pass
>> > +
>> > +    def __init__(self, parser, info):
>> > +        self.parser =3D parser
>>=20
>> Let's document the comment error message position deficiency mentioned
>> in the commit message here:
>>=20
>>            # self.parser is used to report errors with QAPIParseError.  =
The
>>            # resulting error position depends on the state of the parser.
>>            # It happens to be the beginning of the comment.  More or less
>>            # servicable, but action at a distance.
>>=20
>
> ok
>
>> > +        self.info =3D info
>> > +        self.symbol =3D None
>> > +        self.body =3D QAPIDoc.Section()
>> > +        # dict mapping parameter name to ArgSection
>> > +        self.args =3D OrderedDict()
>> > +        # a list of Section
>> > +        self.sections =3D []
>> > +        # the current section
>> > +        self.section =3D self.body
>> > +        # associated expression (to be set by expression parser)
>> > +        self.expr =3D None
>> > +
>> > +    def has_section(self, name):
>> > +        """Return True if we have a meta section with this name."""
>>=20
>> Pretty much all other uses of "meta" are gone.  Can we simply drop it
>> here?
>>=20
>
> ok
>
>> Hmm, there's one more left in the commit message's grammar.  Can we come
>> up with a better name there?
>
> tag_section?

It'll do.

I'm not fond of our use of section for both tagged sections and =3D
sections, but cleaning that up would be too much churn now.

>> > +        for i in self.sections:
>> > +            if i.name =3D=3D name:
>> > +                return True
>> > +        return False
>> > +
>> > +    def append(self, line):
>> > +        """Parse a comment line and add it to the documentation."""
>> > +        line =3D line[1:]
>> > +        if not line:
>> > +            self._append_freeform(line)
>> > +            return
>> > +
>> > +        if line[0] !=3D ' ':
>> > +            raise QAPIParseError(self.parser, "Missing space after #")
>> > +        line =3D line[1:]
>> > +
>> > +        # FIXME: currently recognizes only '# @foo:' with a single sp=
ace
>> > +        # we may want to fail if there are other kind of whitespaces
>>=20
>> Actually, also fails when there's crap after ':', including invisible
>> crap (trailing whitespace).  Suggest:
>>=20
>>            # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
>>            # recognized, and get silently treated as ordinary text
>>=20
>
> ok
>
>> Should this be added to the commit message's list of deficiencies?  I
>> guess it's not necessary.
>
> I'll add a generic deficiency note pointing to the FIXMEs :)

Good idea.

>>=20
>> > +        if self.symbol:
>> > +            self._append_symbol_line(line)
>> > +        elif not self.body.content and line.startswith("@"):
>> > +            if not line.endswith(":"):
>> > +                raise QAPIParseError(self.parser, "Line should end wi=
th
>> > :")
>> > +            self.symbol =3D line[1:-1]
>> > +            if not self.symbol:
>> > +                raise QAPIParseError(self.parser, "Invalid name")
>>=20
>> Let's add:
>>=20
>>                # FIXME invalid names other than the empty string aren't
>>                flagged
>>=20
>
> ok
>
>> > +        else:
>> > +            self._append_freeform(line)
>> > +
>> > +    def _append_symbol_line(self, line):
>> > +        name =3D line.split(' ', 1)[0]
>> > +
>> > +        if name.startswith("@") and name.endswith(":"):
>> > +            line =3D line[len(name)+1:]
>> > +            self._start_args_section(name[1:-1])
>> > +        elif name in ("Returns:", "Since:",
>> > +                      # those are often singular or plural
>> > +                      "Note:", "Notes:",
>> > +                      "Example:", "Examples:"):
>> > +            line =3D line[len(name)+1:]
>> > +            self._start_section(name[:-1])
>> > +
>> > +        self._append_freeform(line)
>> > +
>> > +    def _start_args_section(self, name):
>> > +        if not name:
>> > +            raise QAPIParseError(self.parser, "Invalid parameter name=
")
>>=20
>> Let's add
>>=20
>>            # FIXME invalid names other than the empty string aren't flag=
ged
>>=20
>
> ok
>
>> > +        if name in self.args:
>> > +            raise QAPIParseError(self.parser,
>> > +                                 "'%s' parameter name duplicated" % n=
ame)
>> > +        self.section =3D QAPIDoc.ArgSection(name)
>> > +        self.args[name] =3D self.section
>> > +
>> > +    def _start_section(self, name):
>> > +        if name in ("Returns", "Since") and self.has_section(name):
>> > +            raise QAPIParseError(self.parser,
>> > +                                 "Duplicated '%s' section" % name)
>> > +        self.section =3D QAPIDoc.Section(name)
>> > +        self.sections.append(self.section)
>> > +
>> > +    def _append_freeform(self, line):
>> > +        in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
>> > +        if (in_arg and self.section.content and
>> > +                not self.section.content[-1] and
>> > +                line and not line[0].isspace()):
>>=20
>> PEP8 recommends breaking lines before operators in new code.  Can touch
>> up on commit.
>
> Hmm right, looks like pep8 (tested 1.6.2 and 1.7.0), doesn't follow the b=
est convention.
>
> https://www.python.org/dev/peps/pep-0008/#should-a-line-break-before-or-a=
fter-a-binary-operator
>
> For now, I prefer to keep pep8 tool happy, makes it easier to spot new is=
sues... I'll add a patch that can eventually be dropped.

Discussed elsewhere since.

>>=20
>> > +            # an empty line followed by a non-indented
>> > +            # comment is usually meant to ends the section
>>=20
>> to end
>>=20
>> > +            # but we prefer to reject this ambiguous case
>>=20
>> I'm afraid this comment confuses more than it helps.  Drop it?
>
> ok
>
>>=20
>> > +            raise QAPIParseError(self.parser, "Invalid section
>> > indentation")
>> > +        if (in_arg or not self.section.name or
>> > +                not self.section.name.startswith("Example")):
>>=20
>> Again, break before the operator.
>>=20
>> > +            line =3D line.strip()
>> > +        self.section.append(line)
>> > +
>> > +
>> >  class QAPISchemaParser(object):
>> >=20=20
>> >      def __init__(self, fp, previously_included=3D[], incl_info=3DNone=
):
>> > @@ -140,11 +248,17 @@ class QAPISchemaParser(object):
>> >          self.line =3D 1
>> >          self.line_pos =3D 0
>> >          self.exprs =3D []
>> > +        self.docs =3D []
>> >          self.accept()
>> >=20=20
>> >          while self.tok is not None:
>> >              info =3D {'file': fname, 'line': self.line,
>> >                      'parent': self.incl_info}
>> > +            if self.tok =3D=3D '#':
>> > +                doc =3D self.get_doc(info)
>> > +                self.docs.append(doc)
>> > +                continue
>> > +
>> >              expr =3D self.get_expr(False)
>> >              if isinstance(expr, dict) and "include" in expr:
>> >                  if len(expr) !=3D 1:
>> > @@ -162,6 +276,7 @@ class QAPISchemaParser(object):
>> >                          raise QAPIParseError(self, "Inclusion loop fo=
r %s"
>> >                                               % include)
>> >                      inf =3D inf['parent']
>> > +
>> >                  # skip multiple include of the same file
>> >                  if incl_abs_fname in previously_included:
>> >                      continue
>> > @@ -173,12 +288,19 @@ class QAPISchemaParser(object):
>> >                  exprs_include =3D QAPISchemaParser(fobj,
>> >                  previously_included,
>> >                                                   info)
>> >                  self.exprs.extend(exprs_include.exprs)
>> > +                self.docs.extend(exprs_include.docs)
>> >              else:
>> >                  expr_elem =3D {'expr': expr,
>> >                               'info': info}
>> > +                if (self.docs and
>> > +                        self.docs[-1].info['file'] =3D=3D fname and
>> > +                        not self.docs[-1].expr):
>>=20
>> Again, break before the operator.
>>=20
>> > +                    self.docs[-1].expr =3D expr
>> > +                    expr_elem['doc'] =3D self.docs[-1]
>> > +
>> >                  self.exprs.append(expr_elem)
>> >=20=20
>> > -    def accept(self):
>> > +    def accept(self, skip_comment=3DTrue):
>> >          while True:
>> >              self.tok =3D self.src[self.cursor]
>> >              self.pos =3D self.cursor
>> > @@ -186,7 +308,13 @@ class QAPISchemaParser(object):
>> >              self.val =3D None
>> >=20=20
>> >              if self.tok =3D=3D '#':
>> > +                if self.src[self.cursor] =3D=3D '#':
>> > +                    # Start of doc comment
>> > +                    skip_comment =3D False
>> >                  self.cursor =3D self.src.find('\n', self.cursor)
>> > +                if not skip_comment:
>> > +                    self.val =3D self.src[self.pos:self.cursor]
>> > +                    return
>> >              elif self.tok in "{}:,[]":
>> >                  return
>> >              elif self.tok =3D=3D "'":
>>=20
>> Copied from review of v3, so I don't forget:
>>=20
>> Comment tokens are thrown away as before, except when the parser asks
>> for them by passing skip_comment=3DFalse, or when the comment token star=
ts
>> with ##.  The parser asks while parsing a doc comment, in get_doc().
>>=20
>> This is a backchannel from the parser to the lexer.  I'd rather avoid
>> such lexer hacks, but I guess we can address that on top.
>>=20
>> A comment starting with ## inside an expression is now a syntax error.
>> For instance, input
>>=20
>>     {
>>     ##
>>=20
>> yields
>>=20
>>     /dev/stdin:2:1: Expected string or "}"
>>=20
>> Rather unfriendly error message, but we can fix that on top.
>>=20
>> > @@ -320,6 +448,28 @@ class QAPISchemaParser(object):
>> >              raise QAPIParseError(self, 'Expected "{", "[" or string')
>> >          return expr
>> >=20=20
>> > +    def get_doc(self, info):
>> > +        if self.val !=3D '##':
>> > +            raise QAPIParseError(self, "Junk after '##' at start of "
>> > +                                 "documentation comment")
>> > +
>> > +        doc =3D QAPIDoc(self, info)
>> > +        self.accept(False)
>> > +        while self.tok =3D=3D '#':
>> > +            if self.val.startswith('##'):
>> > +                # End of doc comment
>> > +                if self.val !=3D '##':
>> > +                    raise QAPIParseError(self, "Junk after '##' at en=
d of
>> > "
>> > +                                         "documentation comment")
>> > +                self.accept()
>> > +                return doc
>> > +            else:
>> > +                doc.append(self.val)
>> > +            self.accept(False)
>> > +
>> > +        raise QAPIParseError(self, "Documentation comment must end wi=
th
>> > '##'")
>> > +
>> > +
>> >  #
>> >  # Semantic analysis of schema expressions
>> >  # TODO fold into QAPISchema
>> > @@ -704,6 +854,11 @@ def check_exprs(exprs):
>> >      for expr_elem in exprs:
>> >          expr =3D expr_elem['expr']
>> >          info =3D expr_elem['info']
>> > +
>> > +        if 'doc' not in expr_elem:
>> > +            raise QAPISemError(info,
>> > +                               "Expression missing documentation comm=
ent")
>> > +
>> >          if 'enum' in expr:
>> >              check_keys(expr_elem, 'enum', ['data'], ['prefix'])
>> >              add_enum(expr['enum'], info, expr['data'])
>> > @@ -762,6 +917,66 @@ def check_exprs(exprs):
>> >      return exprs
>> >=20=20
>> >=20=20
>> > +def check_freeform_doc(doc):
>> > +    if doc.symbol:
>> > +        raise QAPISemError(doc.info,
>> > +                           "Documention for '%s' is not followed"
>> > +                           " by the definition" % doc.symbol)
>> > +
>> > +    body =3D str(doc.body)
>> > +    if re.search(r'@\S+:', body, re.MULTILINE):
>> > +        raise QAPISemError(doc.info,
>> > +                           "Document body cannot contain @NAME: secti=
ons")
>>=20
>> "Free-form documentation block must not contain ..."
>>=20
>
> ok
>
>> > +
>> > +
>> > +def check_definition_doc(doc, expr, info):
>> > +    for i in ('enum', 'union', 'alternate', 'struct', 'command', 'eve=
nt'):
>> > +        if i in expr:
>> > +            meta =3D i
>> > +            break
>> > +
>> > +    name =3D expr[meta]
>> > +    if doc.symbol !=3D name:
>> > +        raise QAPISemError(info, "Definition of '%s' follows
>> > documentation"
>> > +                           " for '%s'" % (name, doc.symbol))
>> > +    if doc.has_section('Returns') and 'command' not in expr:
>> > +        raise QAPISemError(info, "'Returns:' is only valid for comman=
ds")
>>=20
>> Copied from review of v5, so I don't forget:
>>=20
>> We accept 'Returns:' even when the command doesn't return anything,
>> because we currently use it to document errors, too.  Can't say I like
>> that, but it's out of scope here.
>>=20
>> > +
>> > +    doc_args =3D set(doc.args.keys())
>> > +    if meta =3D=3D 'union':
>> > +        data =3D expr.get('base', [])
>> > +    else:
>> > +        data =3D expr.get('data', [])
>> > +    if isinstance(data, dict):
>> > +        data =3D data.keys()
>> > +    if isinstance(data, list):
>> > +        args =3D set([name.strip('*') for name in data])
>> > +    else:
>> > +        args =3D set()
>> > +    if meta =3D=3D 'alternate' or \
>> > +       (meta =3D=3D 'union' and not expr.get('discriminator')):
>> > +        args.add('type')
>> > +    if not doc_args.issubset(args):
>> > +        raise QAPISemError(info, "Members documentation is not a subs=
et
>> > of"
>> > +                           " API %r > %r" % (list(doc_args), list(arg=
s)))
>>=20
>> This error message is pretty horrid :)  Can be improved on top.
>
> Improved in v7
>
>>=20
>> Copied from review of v5, so I don't forget:
>>=20
>> As explained in review of v3, this is only a subset of the real set of
>> members.  Computing the exact set is impractical when working with the
>> abstract syntax tree.  I believe we'll eventually have to rewrite this
>> code to work with the QAPISchemaEntity instead.
>>=20
>> > +
>> > +
>> > +def check_docs(docs):
>> > +    for doc in docs:
>> > +        for section in doc.args.values() + doc.sections:
>> > +            content =3D str(section)
>> > +            if not content or content.isspace():
>> > +                raise QAPISemError(doc.info,
>> > +                                   "Empty doc section '%s'" %
>> > section.name)
>> > +
>> > +        if not doc.expr:
>> > +            check_freeform_doc(doc)
>> > +        else:
>> > +            check_definition_doc(doc, doc.expr, doc.info)
>> > +
>> > +    return docs
>> > +
>> > +
>> >  #
>> >  # Schema compiler frontend
>> >  #
>> > @@ -1230,7 +1445,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
>> >  class QAPISchema(object):
>> >      def __init__(self, fname):
>> >          try:
>> > -            self.exprs =3D check_exprs(QAPISchemaParser(open(fname,
>> > "r")).exprs)
>> > +            parser =3D QAPISchemaParser(open(fname, "r"))
>> > +            self.exprs =3D check_exprs(parser.exprs)
>> > +            self.docs =3D check_docs(parser.docs)
>> >              self._entity_dict =3D {}
>> >              self._predefining =3D True
>> >              self._def_predefineds()
>> > diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
>> > new file mode 100755
>> > index 0000000000..99ad118b06
>> > --- /dev/null
>> > +++ b/scripts/qapi2texi.py
>> > @@ -0,0 +1,339 @@
>> > +#!/usr/bin/env python
>> > +# QAPI texi generator
>> > +#
>> > +# This work is licensed under the terms of the GNU LGPL, version 2+.
>> > +# See the COPYING file in the top-level directory.
>> > +"""This script produces the documentation of a qapi schema in texinfo
>> > format"""
>> > +import re
>> > +import sys
>> > +
>> > +import qapi
>> > +
>> > +COMMAND_FMT =3D """
>>=20
>> Got a particular reason for shouting?
>>=20
>
> constant name should be in capital

You're right.

>> > +@deftypefn {type} {{{ret}}} {name} @
>> > +{{{args}}}
>> > +
>> > +{body}
>> > +
>> > +@end deftypefn
>> > +
>> > +""".format
>>=20
>> This .format business is perhaps a bit too clever.  But let's move on.
>>=20
>
> That or we call COMMAND_FMT.format() and such, I prefer the former. I don=
't know what is the pythonic way. Converting it to a full function is even =
more verbose and ugly ;)

Let's not worry about it now.

>> > +
>> > +ENUM_FMT =3D """
>> > +@deftp Enum {name}
>> > +
>> > +{body}
>> > +
>> > +@end deftp
>> > +
>> > +""".format
>> > +
>> > +STRUCT_FMT =3D """
>>=20
>> This is used for unions and alternates in addition to structs.  But okay.
>>=20
>> > +@deftp {{{type}}} {name} @
>> > +{{{attrs}}}
>> > +
>> > +{body}
>> > +
>> > +@end deftp
>> > +
>> > +""".format
>> > +
>> > +EXAMPLE_FMT =3D """@example
>> > +{code}
>> > +@end example
>> > +""".format
>> > +
>> > +
>> > +def subst_strong(doc):
>> > +    """Replaces *foo* by @strong{foo}"""
>> > +    return re.sub(r'\*([^_\n]+)\*', r'@emph{\1}', doc)
>>=20
>> Pasto: you want * instead of _ in the [^ ... ].
>
> yep
>
>>=20
>> > +
>> > +
>> > +def subst_emph(doc):
>> > +    """Replaces _foo_ by @emph{foo}"""
>> > +    return re.sub(r'\s_([^_\n]+)_\s', r' @emph{\1} ', doc)
>>=20
>> This replaces adjacent whitespace characters by the space character.
>> Would \b work here?
>
> yes
>
>>=20
>> > +
>> > +
>> > +def subst_vars(doc):
>> > +    """Replaces @var by @code{var}"""
>> > +    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
>>=20
>> Note: any @ characters not followed by at least one word character are
>> left alone.
>>=20
>> > +
>> > +
>> > +def subst_braces(doc):
>> > +    """Replaces {} with @{ @}"""
>> > +    return doc.replace("{", "@{").replace("}", "@}")
>> > +
>> > +
>> > +def texi_example(doc):
>> > +    """Format @example"""
>> > +    doc =3D subst_braces(doc).strip('\n')
>> > +    return EXAMPLE_FMT(code=3Ddoc)
>>=20
>> Neglects to escape @ characters.
>>=20
>
> Is there such use case yet?

I'm not aware of one.

>> We should probably escape them in subst_braces(), and rename the
>> function to subst_special() or subs_texi_special().  If we do that, we
>> need to delay it until after subst_vars() in texi_format().
>>=20
>
> Added a TODO

Thanks!

>> > +
>> > +
>> > +def texi_format(doc):
>> > +    """
>> > +    Format documentation
>> > +
>> > +    Lines starting with:
>> > +    - |: generates an @example
>> > +    - =3D: generates @section
>> > +    - =3D=3D: generates @subsection
>> > +    - 1. or 1): generates an @enumerate @item
>>=20
>> Any number works, but I guess this is close enough.
>>=20
>> > +    - o/*/-: generates an @itemize list
>> > +    """
>> > +    lines =3D []
>> > +    doc =3D subst_braces(doc)
>> > +    doc =3D subst_vars(doc)
>> > +    doc =3D subst_emph(doc)
>> > +    doc =3D subst_strong(doc)
>> > +    inlist =3D ""
>> > +    lastempty =3D False
>> > +    for line in doc.split('\n'):
>> > +        empty =3D line =3D=3D ""
>> > +
>> > +        if line.startswith("| "):
>> > +            line =3D EXAMPLE_FMT(code=3Dline[2:])
>> > +        elif line.startswith("=3D "):
>> > +            line =3D "@section " + line[2:]
>> > +        elif line.startswith("=3D=3D "):
>> > +            line =3D "@subsection " + line[3:]
>> > +        elif re.match("^([0-9]*[.)]) ", line):
>>=20
>> N) isn't actually used, and not covered by tests.  Dropping it is
>> simpler than testing it, so let's do that.
>>=20
>
> ok
>
>> > +            if not inlist:
>> > +                lines.append("@enumerate")
>> > +                inlist =3D "enumerate"
>> > +            line =3D line[line.find(" ")+1:]
>> > +            lines.append("@item")
>> > +        elif re.match("^[o*-] ", line):
>> > +            if not inlist:
>> > +                lines.append("@itemize %s" % {'o': "@bullet",
>> > +                                              '*': "@minus",
>> > +                                              '-': ""}[line[0]])
>>=20
>> Both 'o' and '-' become @bullet, the former explicitly, the latter
>> because @bullet is the default.  '*' becomes @minus.  This is odd.
>>=20
>> Since 'o' isn't actually used, let's drop it, and map '*' to @bullet (or
>> nothing, doesn't matter), '-' to @minus'.
>
> 'o' is being used in @human-monitor-command. Let's change it then, added =
a preliminary patch.

Okay.

>> > +                inlist =3D "itemize"
>> > +            lines.append("@item")
>> > +            line =3D line[2:]
>>=20
>> Note that the choice of 'o' vs. '*' vs. '-' vs. [0-9]*[.)] matters only
>> in the first item.
>>=20
>> > +        elif lastempty and inlist:
>> > +            lines.append("@end %s\n" % inlist)
>> > +            inlist =3D ""
>>=20
>> Doing this in a single if / elif chain is problematic.  For instance, a
>> line without markup terminates a list if it follows a blank line
>> (reaches the final elif), but a line with some *other* markup, such as a
>> title doesn't.
>>=20
>> Example:
>>=20
>>     ##
>>     # 1. one
>>     # 2. two
>>     #
>>     # =3D title
>>     #
>>     # 1. eins
>>     # 2. zwei
>>     # * drei
>>     ##
>>=20
>> happily produces
>>=20
>>     @enumerate
>>     @item
>>     one
>>     @item
>>     two
>>=20
>>     @section title
>>=20
>>     @item
>>     eins
>>     @item
>>     zwei
>>     @item
>>     drei
>>     @end enumerate
>>=20
>> Could be filed under deficiencies for now, with a FIXME comment here.
>>=20
>
> added a FIXME

Thanks.

>> > +
>> > +        lastempty =3D empty
>> > +        lines.append(line)
>> > +
>> > +    if inlist:
>> > +        lines.append("@end %s\n" % inlist)
>> > +    return "\n".join(lines)
>> > +
>> > +
>> > +def texi_args(expr, key=3D"data"):
>> > +    """
>> > +    Format the functions/structure/events.. arguments/members
>> > +    """
>>=20
>> PEP257 wants one-liner doc strings in one line, including the """.
>
> which version of pep8 or checker are you using? :)

For this one, Mk.1 eyeballs :)

>> > +    if key not in expr:
>> > +        return ""
>> > +
>> > +    args =3D expr[key]
>> > +    arg_list =3D []
>> > +    if isinstance(args, str):
>> > +        arg_list.append(args)
>> > +    else:
>> > +        for name, typ in args.iteritems():
>> > +            # optional arg
>> > +            if name.startswith("*"):
>> > +                name =3D name[1:]
>> > +                arg_list.append("['%s': @t{%s}]" % (name, typ))
>> > +            # regular arg
>> > +            else:
>> > +                arg_list.append("'%s': @t{%s}" % (name, typ))
>> > +
>> > +    return ", ".join(arg_list)
>>=20
>> Generates a formal description of something like struct members in a
>> language you invent.  As I showed in review of PATCH 05, the information
>> here is redundant except for types.  If we can add the type information
>> elsewhere, and the formal description be dropped.  That's what I want us
>> to try in the medium term.  For the short term, I propose to drop it,
>> and add a FIXME.  This gets rid of code I haven't fully reviewed, yet.
>> More importantly, it gets rid of documentation that is known to be
>> inaccurate and incomplete (see review of PATCH 05), and threatens to
>> delay this series further.
>>=20
>
> It's discouraging that you ask me to document and augment this syntax to =
end up asking me to remove it.

I'm sorry about that.

> More importantly, I believe it is convenient and quite natural for any pr=
ogrammer to read, and it was there since the first RFC of the series (~1.5y=
 ago), we had time to discuss it.

I never liked it, and I hope I expressed doubts about it from the start.
Sadly, it took us a long time to reach "start".  Even more sadly, it was
just doubts for several rounds of review, and doubts !=3D rejection.  You
tried to overcome my doubts with additional work, which is natural.
Only in v6 the rest of the series had become simple enough to review to
leave me the mental capacity to analyze this feature properly, with the
help of the new docs you provided, and then my doubts solidified into
tentative rejection.  Wasted some of your work, which is unfortunate.

> Let's remove it for now, because to be pragmatic and avoid this yet anoth=
er delaying discussion. It's a big regression, I hope we can bring it back =
in some form later.

I agree the loss of type information is a regression we need to fix.

>> > +
>> > +
>> > +def texi_body(doc):
>> > +    """
>> > +    Format the body of a symbol documentation:
>> > +    - a table of arguments
>> > +    - followed by "Returns/Notes/Since/Example" sections
>> > +    """
>> > +    def _section_order(section):
>> > +        return {"Returns": 0,
>> > +                "Note": 1,
>> > +                "Notes": 1,
>> > +                "Since": 2,
>> > +                "Example": 3,
>> > +                "Examples": 3}[section]
>> > +
>> > +    body =3D ""
>> > +    if doc.args:
>> > +        body +=3D "@table @asis\n"
>> > +        for arg, section in doc.args.iteritems():
>> > +            desc =3D str(section)
>> > +            opt =3D ''
>> > +            if desc.startswith("#optional"):
>> > +                desc =3D desc[10:]
>> > +                opt =3D ' *'
>> > +            elif desc.endswith("#optional"):
>> > +                desc =3D desc[:-10]
>> > +                opt =3D ' *'
>>=20
>> Add here:
>>=20
>>                # TODO Should ensure #optional matches the schema
>
> fixed, new test case added

At this stage, be careful what you fix.  Reviewing a new TODO comment is
fast, especially when it's one I asked for myself.  Reviewing an actual
solution can be slow.

>> > +            body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
>> > +                                                   texi_format(desc))
>> > +        body +=3D "@end table\n"
>> > +    body +=3D texi_format(str(doc.body))
>> > +
>> > +    sections =3D sorted(doc.sections, key=3Dlambda i: _section_order(=
i.name))
>>=20
>> Reordering documentation written by humans is unlikely to improve
>> things, so let's not do that.  If we want our documentation presented in
>> a certain order, we should enforce that order at the source level.
>>=20
>
> That would bring consistency and avoid ambiguity. Imho it would make sens=
e if sections can be reordered (think about IDE tooling and such).
>
> Interleaving documentation body and arguments seems a bad idea and can be=
 ambiguous. I don't know an API documentation format that accepts that.

The place to fix up badly ordered / ambiguously structured documentation
is the documentation source code, not the doc generation machinery.

> It feels backward to me, but I'll follow your advice for now and accept a=
ppended doc (as anonymous sections) and keep original ordering.

Sticking to source order for now simplifies review: we know the
generated docs will match the doc comments, and the comments have been
reviewed already.

If you want to try reordering later, its effect can be checked by
diffing generated documentation before and after.

>> The doc parser splits doc comments into sections.  It should produce a
>> list of sections in source order, for the generator to walk.
>>=20
>> If we decide doing that now would delay the series too much, I'm willing
>> to accept it as is with a suitable FIXME comment here, noted in the
>> commit message's list of deficiencies.
>>=20
>> > +    for section in sections:
>> > +        name, doc =3D (section.name, str(section))
>> > +        func =3D texi_format
>> > +        if name.startswith("Example"):
>> > +            func =3D texi_example
>> > +
>> > +        body +=3D "\n@quotation %s\n%s\n@end quotation" % \
>> > +                (name, func(doc))
>>=20
>> Are you sure @quotation is a good idea?  The extra indentation looks
>> ugly to me, both in .txt and .html.  But we can touch that up on top.
>
> That's what quotation is for:
> https://www.gnu.org/software/texinfo/manual/texinfo/html_node/_0040quotat=
ion.html
>
> I'd rather look at fixing the txt/html generator.

I don't really care whether we use @quotation in the intermediate
.texinfo, I do care about the end user documents' look.  Here's
qemu-qmp-ref.txt:

 -- Command: block_resize

     Resize a block image while a guest is running.

     Either 'device' or 'node-name' must be set but not both.
     ''device'' (optional)
          the name of the device to get the image resized
     ''node-name'' (optional)
          graph node name to get the image resized (Since 2.0)
     ''size''
          new image size in bytes

          Returns: nothing on success If 'device' is not a valid block
          device, DeviceNotFound
          Since: 0.14.0
          Example: -> { "execute": "block_resize",
                    "arguments": { "device": "scratch", "size": 1073741824 =
} }
               <- { "return": {} }

The indentation of Returns, Since and Example is ugly and confusing: it
suggests Returns etc. are structurally below @size.  Better:

 -- Command: block_resize

     Resize a block image while a guest is running.

     Either 'device' or 'node-name' must be set but not both.
     ''device'' (optional)
          the name of the device to get the image resized
     ''node-name'' (optional)
          graph node name to get the image resized (Since 2.0)
     ''size''
          new image size in bytes

     Returns: nothing on success If 'device' is not a valid block
     device, DeviceNotFound

     Since: 0.14.0

     Example: -> { "execute": "block_resize",
               "arguments": { "device": "scratch", "size": 1073741824 } }
          <- { "return": {} }

Same argument applies to .html, at least in my browser.

Can be corrected on top, of course.

>>=20
>> > +    return body
>> > +
>> > +
>> > +def texi_alternate(expr, doc):
>> > +    """
>> > +    Format an alternate to texi
>> > +    """
>> > +    args =3D texi_args(expr)
>> > +    body =3D texi_body(doc)
>> > +    return STRUCT_FMT(type=3D"Alternate",
>> > +                      name=3Ddoc.symbol,
>> > +                      attrs=3D"[ " + args + " ]",
>> > +                      body=3Dbody)
>> > +
>> > +
>> > +def texi_union(expr, doc):
>> > +    """
>> > +    Format a union to texi
>> > +    """
>> > +    discriminator =3D expr.get("discriminator")
>> > +    if discriminator:
>> > +        is_flat =3D True
>> > +        union =3D "Flat Union"
>> > +    else:
>> > +        is_flat =3D False
>> > +        union =3D "Simple Union"
>> > +        discriminator =3D "type"
>> > +
>> > +    attrs =3D "@{ "
>> > +    if is_flat:
>> > +        attrs +=3D texi_args(expr, "base") + ", "
>> > +    else:
>> > +        attrs +=3D "'type': @t{str}, 'data': "
>> > +    attrs +=3D "[ '%s' =3D " % discriminator
>> > +    attrs +=3D texi_args(expr, "data") + " ] @}"
>> > +    body =3D texi_body(doc)
>> > +    return STRUCT_FMT(type=3Dunion,
>> > +                      name=3Ddoc.symbol,
>> > +                      attrs=3Dattrs,
>> > +                      body=3Dbody)
>> > +
>> > +
>> > +def texi_enum(expr, doc):
>> > +    """
>> > +    Format an enum to texi
>> > +    """
>> > +    for i in expr['data']:
>> > +        if i not in doc.args:
>> > +            doc.args[i] =3D ''
>> > +    body =3D texi_body(doc)
>> > +    return ENUM_FMT(name=3Ddoc.symbol,
>> > +                    body=3Dbody)
>> > +
>> > +
>> > +def texi_struct(expr, doc):
>> > +    """
>> > +    Format a struct to texi
>> > +    """
>> > +    args =3D texi_args(expr)
>> > +    body =3D texi_body(doc)
>> > +    base =3D expr.get("base")
>> > +    attrs =3D "@{ "
>> > +    if base:
>> > +        attrs +=3D "%s" % base
>> > +        if args:
>> > +            attrs +=3D " + "
>> > +    attrs +=3D args + " @}"
>> > +    return STRUCT_FMT(type=3D"Struct",
>> > +                      name=3Ddoc.symbol,
>> > +                      attrs=3Dattrs,
>> > +                      body=3Dbody)
>> > +
>> > +
>> > +def texi_command(expr, doc):
>> > +    """
>> > +    Format a command to texi
>> > +    """
>> > +    args =3D texi_args(expr)
>> > +    ret =3D expr["returns"] if "returns" in expr else ""
>> > +    body =3D texi_body(doc)
>> > +    return COMMAND_FMT(type=3D"Command",
>> > +                       name=3Ddoc.symbol,
>> > +                       ret=3Dret,
>> > +                       args=3D"(" + args + ")",
>> > +                       body=3Dbody)
>> > +
>> > +
>> > +def texi_event(expr, doc):
>> > +    """
>> > +    Format an event to texi
>> > +    """
>> > +    args =3D texi_args(expr)
>> > +    body =3D texi_body(doc)
>> > +    return COMMAND_FMT(type=3D"Event",
>> > +                       name=3Ddoc.symbol,
>> > +                       ret=3D"",
>> > +                       args=3D"(" + args + ")",
>> > +                       body=3Dbody)
>> > +
>> > +
>> > +def texi_expr(expr, doc):
>> > +    """
>> > +    Format an expr to texi
>> > +    """
>> > +    (kind, _) =3D expr.items()[0]
>> > +
>> > +    fmt =3D {"command": texi_command,
>> > +           "struct": texi_struct,
>> > +           "enum": texi_enum,
>> > +           "union": texi_union,
>> > +           "alternate": texi_alternate,
>> > +           "event": texi_event}[kind]
>> > +
>> > +    return fmt(expr, doc)
>> > +
>> > +
>> > +def texi(docs):
>> > +    """
>> > +    Convert QAPI schema expressions to texi documentation
>> > +    """
>> > +    res =3D []
>> > +    for doc in docs:
>> > +        expr =3D doc.expr
>> > +        if not expr:
>> > +            res.append(texi_body(doc))
>> > +            continue
>> > +        try:
>> > +            doc =3D texi_expr(expr, doc)
>> > +            res.append(doc)
>> > +        except:
>> > +            print >>sys.stderr, "error at @%s" % doc.info
>> > +            raise
>> > +
>> > +    return '\n'.join(res)
>> > +
>> > +
>> > +def main(argv):
>> > +    """
>> > +    Takes schema argument, prints result to stdout
>> > +    """
>> > +    if len(argv) !=3D 2:
>> > +        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" %
>> > argv[0]
>> > +        sys.exit(1)
>> > +
>> > +    schema =3D qapi.QAPISchema(argv[1])
>> > +    print texi(schema.docs)
>> > +
>> > +
>> > +if __name__ =3D=3D "__main__":
>> > +    main(sys.argv)
>> > diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
>> > index 2841c5144a..f93d3390c8 100644
>> > --- a/docs/qapi-code-gen.txt
>> > +++ b/docs/qapi-code-gen.txt
>> > @@ -44,40 +44,110 @@ Input must be ASCII (although QMP supports full
>> > Unicode strings, the
>> >  QAPI parser does not).  At present, there is no place where a QAPI
>> >  schema requires the use of JSON numbers or null.
>> >=20=20
>> > +
>> > +=3D=3D=3D Comments =3D=3D=3D
>> > +
>> >  Comments are allowed; anything between an unquoted # and the following
>> > -newline is ignored.  Although there is not yet a documentation
>> > -generator, a form of stylized comments has developed for consistently
>> > -documenting details about an expression and when it was added to the
>> > -schema.  The documentation is delimited between two lines of ##, then
>> > -the first line names the expression, an optional overview is provided,
>> > -then individual documentation about each member of 'data' is provided,
>> > -and finally, a 'Since: x.y.z' tag lists the release that introduced
>> > -the expression.  Optional members are tagged with the phrase
>> > -'#optional', often with their default value; and extensions added
>> > -after the expression was first released are also given a '(since
>> > -x.y.z)' comment.  For example:
>> > -
>> > -    ##
>> > -    # @BlockStats:
>> > -    #
>> > -    # Statistics of a virtual block device or a block backing device.
>> > -    #
>> > -    # @device: #optional If the stats are for a virtual block device,=
 the
>> > name
>> > -    #          corresponding to the virtual block device.
>> > -    #
>> > -    # @stats:  A @BlockDeviceStats for the device.
>> > -    #
>> > -    # @parent: #optional This describes the file block device if it h=
as
>> > one.
>> > -    #
>> > -    # @backing: #optional This describes the backing block device if =
it
>> > has one.
>> > -    #           (Since 2.0)
>> > -    #
>> > -    # Since: 0.14.0
>> > -    ##
>> > -    { 'struct': 'BlockStats',
>> > -      'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
>> > -               '*parent': 'BlockStats',
>> > -               '*backing': 'BlockStats'} }
>> > +newline is ignored.
>> > +
>> > +A documentation block is delimited between two lines of ##, and can be
>> > +formatted.
>>=20
>> Well, any comment can be "formatted".  Suggest:
>>=20
>>    A multi-line comment that starts and ends with a '##' line is a
>>    documentation comment.  These are parsed by the documentation
>>    generator, which recognizes certain markup detailed below.
>>=20
>> Note that I say "markup" instead of "annotations".  I think it's a more
>> precise term.  If we go with it, the commit message's grammar needs an
>> update, too.
>>=20
>
> sure (I thought you preferred annotations in an earlier discussion to avo=
id confusion with proper markup/markdown languages)

I suggested not to say "Markdown-like", because if we do, we get to
explain how we differ from genuine Markdown.  You then suggested
"annotations", which sounded good to me, but when I read the actual
changed text, I realized I prefer "markup".

>> > +
>> > +Example:
>> > +
>> > +##
>> > +# =3D Section
>> > +# =3D=3D Subsection
>> > +#
>> > +# Some text foo with *strong* and _emphasis_
>> > +# 1. with a list
>> > +# 2. like that
>> > +#
>> > +# And some code:
>> > +# | $ echo foo
>> > +# | -> do this
>> > +# | <- get that
>> > +#
>> > +##
>>=20
>> I'd move this to the end of "Documentation annotations".
>
> ok
>
>>=20
>> > +
>> > +
>> > +=3D=3D=3D=3D Documentation annotations =3D=3D=3D=3D
>> > +
>> > +Documentation lines starting with the following characters and a
>> > +space:
>>=20
>> What exactly constitutes a "documentation line"?  It's actually whatever
>> line the doc comment machinery gets out of the doc comment parsing &
>> mangling, to be passed on to the doc formatting.
>>=20
>> The user doesn't want to know about all that crap.  We should talk to
>> him in terms of doc comments, because that's what he writes and reads.
>>=20
>> > +- =3D are top section title
>> > +- =3D=3D are subsection title
>>=20
>> Grammar demands "titles".
>
> ok
>
>>=20
>> > +- | are examples
>>=20
>> Not spelled out, but perhaps obvious enough: a sequence of such lines is
>> *one* example.  Peeking at the generator code... hmm, obvious enough or
>> not, it's wrong: each such line is its own example.  Doesn't that suck?
>> Could be filed under "deficiencies", for improvement on top.
>>=20
>> > +- X. or X) are enumerations (X is any number)
>> > +- o/*/- are itemized list
>>=20
>> What exactly ends a list?  Particularly important for enumerations,
>> because their counter gets reset there.  Peeking at the code... looks
>> like blank lines followed by a line without markup does.  Not so good,
>> see there.
>>=20
>> Can lists be nested?  Peeking at the code... no.
>
> Another limitation, worth to add a TODO? only if needed probably.

Worth a mention in the docs, I think.  Perhaps ...

>> The forms "X)" and "o " appear not to be used.  Let's get rid of them.
>>=20
>> Here's my try:
>>=20
>>    =3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
>>=20
>>    Comment text starting with '=3D' is a section title:
>>=20
>>        # =3D Section title
>>=20
>>    Double the '=3D' for a subsection title:
>>=20
>>        # =3D=3D Subection title
>>=20
>>    '|' denotes examples:
>>=20
>>        # | Text of the example, may span
>>        # | multiple lines
>>=20
>>    '*' starts an itemized list:
>>=20
>>        # * First item, may span
>>        #   multiple lines
>>        # * Second item
>>=20
>>    You can also use '-' instead of '*'.
>>=20
>>    A decimal number followed by '.' starts a numbered list:
>>=20
>>        # 1. First item, may span
>>        # multiple lines
>>        # 2. Second item
>>=20
>>    The actual number doesn't matter.  You could even use '*' instead of
>>    '2.' for the second item.
>>=20
>>    FIXME what exactly ends a list

... insert here "Nested lists aren't supported.".

>>=20
>>    Additional whitespace between the initial '#' and the comment text is
>>    permitted.
>>=20
>> > +
>> > +*foo* and _foo_ are for strong and emphasis styles respectively (they
>> > +do not work over multiple lines). @foo is used to reference a symbol.
>>=20
>> Only occurence of "symbol" in this file.  Let's say "to reference a name
>> in the schema".
>>=20
>
> ok
>
>> > +
>> > +Note: the 'Example' section is processed verbatim (see 'Expression
>> > +documentation' below).
>>=20
>> Peeking at the generator code... the section text is enclosed in an
>> @example environment.  For true verbatim processing, we'd need a
>> @verbatim environment.  The easy fix is to explain the formatting of
>> Example sections by reduction to '# |' formatting instead.
>>=20
>> Unecessary forward reference: Example sections are not yet defined.
>> Let's move the explanation how they're formatted to their definition.
>> I'll propose something there.
>>=20
>> Taking a step back: there are two ways to mark up examples: as
>> Example/Examples section, or as '# |' lines.  Feels like a bad language
>> design idea, but it's probably a good "limit the QAPI schema churn in
>> this series" idea.  We can get rid of it later.
>>=20
>> > +
>> > +
>> > +=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
>> > +
>> > +A free-form documentation isn't immediately followed by an expression,
>> > +and is used to provide some additional text and structuring content.
>>=20
>> Suggest to move this below the next section, and say:
>>=20
>>    =3D=3D=3D=3D Free-form documentation blocks =3D=3D=3D=3D
>>=20
>>    A documentation block that isn't expression an documentation block is
>>    a free-form documentation block.  These may be used to provide
>>    additional ...
>>=20
>
> ok
>
>
>> > +
>> > +
>> > +=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
>> > +
>> > +An expression must have a preceding comment block defining it.
>>=20
>> What about include expressions?
>>=20
>> Suggest:
>>=20
>>    =3D=3D=3D=3D Expression documentation blocks =3D=3D=3D=3D
>>=20
>>    Each expression that isn't an include directive must be preceded by a
>>    documentation block.  Such blocks are called expression documentation
>>    blocks.
>
>
> ok
>
>
>>=20
>> > +
>> > +The first line of the documentation names the expression, then the
>> > +documentation body is provided, then individual documentation about
>> > +each member of 'data' is provided. Finally, several tagged sections
>> > +can be added.
>>=20
>> I'm afraid this is more aspiration than specification: the parser
>> accepts these things in almost any order.
>>=20
>> Could be filed under "deficiencies" for now.
>>=20
>> Member of 'data' won't remain accurate.  Consider:
>>=20
>>     { 'union': 'GlusterServer',
>>       'base': { 'type': 'GlusterTransport' },
>>       'discriminator': 'type',
>>       'data': { 'unix': 'UnixSocketAddress',
>>                 'tcp': 'InetSocketAddress' } }
>>=20
>> Its doc comment currently doesn't contain argument sections.  It should
>> eventually contain @type:, @unix: and @tcp:.  Only the latter two are
>> members of 'data'.
>>=20
>> I should propose something better, but I'm getting perilously close to
>> the christmas break already.  Later.
>>=20
>
> It falls under the union-type support is lacking?

Kind of.  I'll try to propose something in my review of v7.

>> I don't like the reuse of "section".  We already burned that term on the
>> things that start with # =3D lines.  But I don't have a better idea right
>> now.
>>=20
>> > +
>> > +Optional members are tagged with the phrase '#optional', often with
>> > +their default value; and extensions added after the expression was
>> > +first released are also given a '(since x.y.z)' comment.
>> > +
>> > +A tagged section starts with one of the following words:
>> > +"Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:".
>> > +
>> > +A 'Since: x.y.z' tag lists the release that introduced the expression.
>> > +
>> > +For example:
>> > +
>> > +##
>> > +# @BlockStats:
>> > +#
>> > +# Statistics of a virtual block device or a block backing device.
>> > +#
>> > +# @device: #optional If the stats are for a virtual block device, the=
 name
>> > +#          corresponding to the virtual block device.
>> > +#
>> > +# @stats:  A @BlockDeviceStats for the device.
>> > +#
>> > +# @parent: #optional This describes the file block device if it has o=
ne.
>> > +#
>> > +# @backing: #optional This describes the backing block device if it h=
as
>> > one.
>> > +#           (Since 2.0)
>> > +#
>> > +# Since: 0.14.0
>> > +#
>> > +# Notes: You can also make a list:
>> > +#        - with items
>> > +#        - like this
>> > +#
>> > +# Example:
>> > +#
>> > +# -> { "execute": ... }
>> > +# <- { "return": ... }
>> > +#
>> > +##
>> > +{ 'struct': 'BlockStats',
>> > +  'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
>> > +           '*parent': 'BlockStats',
>> > +           '*backing': 'BlockStats'} }
>>=20
>> I don't like this example.  It's a type cribbed from block-core.json,
>> with Notes: and Example: thrown in just to show how they're used.
>> Except you'd never use such an example with a type, only with a command.
>>=20
>> Instead of cramming this stuff into @BlockStats, why not add the command
>> that uses it?
>>=20
>>    ##
>>    # @BlockStats:
>>    #
>>    # Statistics of a virtual block device or a block backing device.
>>    #
>>    # @device: #optional If the stats are for a virtual block device, the=
 name
>>    #          corresponding to the virtual block device.
>>    #
>>    # @node-name: #optional The node name of the device. (Since 2.3)
>>    #
>>    # ... more members ...
>>    #
>>    # Since: 0.14.0
>>    ##
>>    { 'struct': 'BlockStats',
>>      'data': {'*device': 'str', '*node-name': 'str',
>>               ... more members ... } }
>>=20
>>    ##
>>    # @query-blockstats:
>>    #
>>    # Query the @BlockStats for all virtual block devices.
>>    #
>>    # @query-nodes: #optional If true, the command will query all the blo=
ck
>>    nodes
>>    #               ... explain, explain ...
>>    #               (Since 2.3)
>>    #
>>    # Returns: A list of @BlockStats for each virtual block devices.
>>    #
>>    # Since: 0.14.0
>>    #
>>    # Example:
>>    #
>>    # -> { "execute": "query-blockstats" }
>>    # <- {
>>    #      ... lots of output ...
>>    #    }
>>    #
>>    ##
>>    { 'command': 'query-blockstats',
>>      'data': { '*query-nodes': 'bool' },
>>      'returns': ['BlockStats'] }
>
> ok
>
>>=20
>> > +
>> > +
>> > +=3D=3D=3D Schema overview =3D=3D=3D
>> >=20=20
>> >  The schema sets up a series of types, as well as commands and events
>> >  that will use those types.  Forward references are allowed: the parser
>> > @@ -193,7 +263,7 @@ struct in C or an Object in JSON. Each value of the
>> > 'data' dictionary
>> >  must be the name of a type, or a one-element array containing a type
>> >  name.  An example of a struct is:
>> >=20=20
>> > - { 'struct': 'MyType',
>> > +{ 'struct': 'MyType',
>> >     'data': { 'member1': 'str', 'member2': 'int', '*member3': 'str' } }
>> >=20=20
>> >  The use of '*' as a prefix to the name means the member is optional in
>>=20
>> Spurious hunk.  Could be dropped on commit.
>
> ok
>
>>=20
>> > diff --git a/tests/qapi-schema/alternate-any.err
>> > b/tests/qapi-schema/alternate-any.err
>> > index aaa0154731..395c8ab583 100644
>> > --- a/tests/qapi-schema/alternate-any.err
>> > +++ b/tests/qapi-schema/alternate-any.err
>> > @@ -1 +1 @@
>> > -tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one'
>> > cannot use type 'any'
>> > +tests/qapi-schema/alternate-any.json:6: Alternate 'Alt' member 'one'
>> > cannot use type 'any'
>> > diff --git a/tests/qapi-schema/alternate-any.json
>> > b/tests/qapi-schema/alternate-any.json
>> > index e47a73a116..c958776767 100644
>> > --- a/tests/qapi-schema/alternate-any.json
>> > +++ b/tests/qapi-schema/alternate-any.json
>> > @@ -1,4 +1,8 @@
>> >  # we do not allow the 'any' type as an alternate branch
>> > +
>> > +##
>> > +# @Alt:
>> > +##
>>=20
>> If you need to respin, please consider splitting these off into their
>> own patch, to make this one a smaller bear to review.
>
> That's not convenient, because doc output comes after this patch. So it w=
ould have to be splitted in before and after doc parsing. Not convinced it'=
s worth it.
>
> I hope I didn't miss or skipped too much of your review, I'll send v7 wit=
h those changes.

I'm reviewing it now.

> thanks again

Thanks for your patience!
