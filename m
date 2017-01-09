Received: from eggs.gnu.org ([2001:4830:134:3::10]:39661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQadW-0002yt-1T
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQadG-0003DF-Lb
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:09:22 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cQadF-0003Cl-N8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:09:06 -0500
Date: Mon, 9 Jan 2017 09:09:04 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1150624120.16922.1483970944576.JavaMail.zimbra@redhat.com>
In-Reply-To: <87pokju5id.fsf@dusky.pond.sub.org>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-9-marcandre.lureau@redhat.com>
	<87pokju5id.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > As the name suggests, the qapi2texi script converts JSON QAPI
> > description into a texi file suitable for different target
> > formats (info/man/txt/pdf/html...).
> >
> > It parses the following kind of blocks:
> >
> > Free-form:
> >
> >   ##
> >   # =3D Section
> >   # =3D=3D Subsection
> >   #
> >   # Some text foo with *emphasis*
> >   # 1. with a list
> >   # 2. like that
> >   #
> >   # And some code:
> >   # | $ echo foo
> >   # | -> do this
> >   # | <- get that
> >   #
> >   ##
> >
> > Symbol:
> >
> >   ##
> >   # @symbol:
> >   #
> >   # Symbol body ditto ergo sum. Foo bar
> >   # baz ding.
> >   #
> >   # @param1: the frob to frobnicate
> >   # @param2: #optional how hard to frobnicate
> >   #
> >   # Returns: the frobnicated frob.
> >   #          If frob isn't frobnicatable, GenericError.
> >   #
> >   # Since: version
> >   # Notes: notes, comments can have
> >   #        - itemized list
> >   #        - like this
> >   #
> >   # Example:
> >   #
> >   # -> { "execute": "quit" }
> >   # <- { "return": {} }
> >   #
> >   ##
> >
> > That's roughly following the following EBNF grammar:
> >
> > api_comment =3D "##\n" comment "##\n"
> > comment =3D freeform_comment | symbol_comment
> > freeform_comment =3D { "# " text "\n" | "#\n" }
> > symbol_comment =3D "# @" name ":\n" { member | meta | freeform_comment =
}
> > member =3D "# @" name ':' [ text ] "\n" freeform_comment
> > meta =3D "# " ( "Returns:", "Since:", "Note:", "Notes:", "Example:",
> > "Examples:" ) [ text ]  "\n" freeform_comment
> > text =3D free text with annotations
>=20
> Let's add:
>=20
>     Note that the grammar is ambiguous: a line "# @foo:\n" can be parsed
>     both as freeform_comment and as symbol_comment.  The actual parser
>     recognizes symbol_comment.
>=20

ok

> > See docs/qapi-code-gen.txt for more details.
> >
> > The documentation is enriched with information from the actual schema.
> >
> > Deficiencies:
> > - the generated QMP documentation includes internal types
> > - union support is lacking
> > - doc comment error message positions are imprecise, they point
> >   to the beginning of the comment.
>=20
> Acceptable.  We need matching FIXME or TODO comments; see below.
>=20
> Hope we're not missing anything noteworthy here.  I should double-check.
>=20
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> [diffstat snipped...]
>=20
> Recommend to jump forward to docs/qapi-code-gen.txt, then come back.
>=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index e98d3b6bb3..284329a4cd 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -350,6 +350,23 @@ qapi-schema +=3D base-cycle-direct.json
> >  qapi-schema +=3D base-cycle-indirect.json
> >  qapi-schema +=3D command-int.json
> >  qapi-schema +=3D comments.json
> > +qapi-schema +=3D doc-bad-args.json
> > +qapi-schema +=3D doc-bad-section.json
> > +qapi-schema +=3D doc-bad-symbol.json
> > +qapi-schema +=3D doc-duplicated-arg.json
> > +qapi-schema +=3D doc-duplicated-return.json
> > +qapi-schema +=3D doc-duplicated-since.json
> > +qapi-schema +=3D doc-empty-arg.json
> > +qapi-schema +=3D doc-empty-section.json
> > +qapi-schema +=3D doc-empty-symbol.json
> > +qapi-schema +=3D doc-invalid-end.json
> > +qapi-schema +=3D doc-invalid-end2.json
> > +qapi-schema +=3D doc-invalid-return.json
> > +qapi-schema +=3D doc-invalid-section.json
> > +qapi-schema +=3D doc-invalid-start.json
> > +qapi-schema +=3D doc-missing-colon.json
> > +qapi-schema +=3D doc-missing-expr.json
> > +qapi-schema +=3D doc-missing-space.json
> >  qapi-schema +=3D double-data.json
> >  qapi-schema +=3D double-type.json
> >  qapi-schema +=3D duplicate-key.json
> > @@ -443,6 +460,8 @@ qapi-schema +=3D union-optional-branch.json
> >  qapi-schema +=3D union-unknown.json
> >  qapi-schema +=3D unknown-escape.json
> >  qapi-schema +=3D unknown-expr-key.json
> > +
> > +
> >  check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schema=
))
> > =20
> >  GENERATED_HEADERS +=3D tests/test-qapi-types.h tests/test-qapi-visit.h=
 \
> > diff --git a/scripts/qapi.py b/scripts/qapi.py
> > index 5423b64b23..190530308e 100644
> > --- a/scripts/qapi.py
> > +++ b/scripts/qapi.py
> > @@ -125,6 +125,114 @@ class QAPISemError(QAPIError):
> >                             info['parent'], msg)
> > =20
> > =20
> > +class QAPIDoc(object):
> > +    class Section(object):
> > +        def __init__(self, name=3DNone):
> > +            # optional section name (argument/member or section name)
> > +            self.name =3D name
> > +            # the list of lines for this section
> > +            self.content =3D []
> > +
> > +        def append(self, line):
> > +            self.content.append(line)
> > +
> > +        def __repr__(self):
> > +            return "\n".join(self.content).strip()
> > +
> > +    class ArgSection(Section):
> > +        pass
> > +
> > +    def __init__(self, parser, info):
> > +        self.parser =3D parser
>=20
> Let's document the comment error message position deficiency mentioned
> in the commit message here:
>=20
>            # self.parser is used to report errors with QAPIParseError.  T=
he
>            # resulting error position depends on the state of the parser.
>            # It happens to be the beginning of the comment.  More or less
>            # servicable, but action at a distance.
>=20

ok

> > +        self.info =3D info
> > +        self.symbol =3D None
> > +        self.body =3D QAPIDoc.Section()
> > +        # dict mapping parameter name to ArgSection
> > +        self.args =3D OrderedDict()
> > +        # a list of Section
> > +        self.sections =3D []
> > +        # the current section
> > +        self.section =3D self.body
> > +        # associated expression (to be set by expression parser)
> > +        self.expr =3D None
> > +
> > +    def has_section(self, name):
> > +        """Return True if we have a meta section with this name."""
>=20
> Pretty much all other uses of "meta" are gone.  Can we simply drop it
> here?
>=20

ok

> Hmm, there's one more left in the commit message's grammar.  Can we come
> up with a better name there?

tag_section?

>=20
> > +        for i in self.sections:
> > +            if i.name =3D=3D name:
> > +                return True
> > +        return False
> > +
> > +    def append(self, line):
> > +        """Parse a comment line and add it to the documentation."""
> > +        line =3D line[1:]
> > +        if not line:
> > +            self._append_freeform(line)
> > +            return
> > +
> > +        if line[0] !=3D ' ':
> > +            raise QAPIParseError(self.parser, "Missing space after #")
> > +        line =3D line[1:]
> > +
> > +        # FIXME: currently recognizes only '# @foo:' with a single spa=
ce
> > +        # we may want to fail if there are other kind of whitespaces
>=20
> Actually, also fails when there's crap after ':', including invisible
> crap (trailing whitespace).  Suggest:
>=20
>            # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
>            # recognized, and get silently treated as ordinary text
>=20

ok

> Should this be added to the commit message's list of deficiencies?  I
> guess it's not necessary.

I'll add a generic deficiency note pointing to the FIXMEs :)

>=20
> > +        if self.symbol:
> > +            self._append_symbol_line(line)
> > +        elif not self.body.content and line.startswith("@"):
> > +            if not line.endswith(":"):
> > +                raise QAPIParseError(self.parser, "Line should end wit=
h
> > :")
> > +            self.symbol =3D line[1:-1]
> > +            if not self.symbol:
> > +                raise QAPIParseError(self.parser, "Invalid name")
>=20
> Let's add:
>=20
>                # FIXME invalid names other than the empty string aren't
>                flagged
>=20

ok

> > +        else:
> > +            self._append_freeform(line)
> > +
> > +    def _append_symbol_line(self, line):
> > +        name =3D line.split(' ', 1)[0]
> > +
> > +        if name.startswith("@") and name.endswith(":"):
> > +            line =3D line[len(name)+1:]
> > +            self._start_args_section(name[1:-1])
> > +        elif name in ("Returns:", "Since:",
> > +                      # those are often singular or plural
> > +                      "Note:", "Notes:",
> > +                      "Example:", "Examples:"):
> > +            line =3D line[len(name)+1:]
> > +            self._start_section(name[:-1])
> > +
> > +        self._append_freeform(line)
> > +
> > +    def _start_args_section(self, name):
> > +        if not name:
> > +            raise QAPIParseError(self.parser, "Invalid parameter name"=
)
>=20
> Let's add
>=20
>            # FIXME invalid names other than the empty string aren't flagg=
ed
>=20

ok

> > +        if name in self.args:
> > +            raise QAPIParseError(self.parser,
> > +                                 "'%s' parameter name duplicated" % na=
me)
> > +        self.section =3D QAPIDoc.ArgSection(name)
> > +        self.args[name] =3D self.section
> > +
> > +    def _start_section(self, name):
> > +        if name in ("Returns", "Since") and self.has_section(name):
> > +            raise QAPIParseError(self.parser,
> > +                                 "Duplicated '%s' section" % name)
> > +        self.section =3D QAPIDoc.Section(name)
> > +        self.sections.append(self.section)
> > +
> > +    def _append_freeform(self, line):
> > +        in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
> > +        if (in_arg and self.section.content and
> > +                not self.section.content[-1] and
> > +                line and not line[0].isspace()):
>=20
> PEP8 recommends breaking lines before operators in new code.  Can touch
> up on commit.

Hmm right, looks like pep8 (tested 1.6.2 and 1.7.0), doesn't follow the bes=
t convention.

https://www.python.org/dev/peps/pep-0008/#should-a-line-break-before-or-aft=
er-a-binary-operator

For now, I prefer to keep pep8 tool happy, makes it easier to spot new issu=
es... I'll add a patch that can eventually be dropped.

>=20
> > +            # an empty line followed by a non-indented
> > +            # comment is usually meant to ends the section
>=20
> to end
>=20
> > +            # but we prefer to reject this ambiguous case
>=20
> I'm afraid this comment confuses more than it helps.  Drop it?

ok

>=20
> > +            raise QAPIParseError(self.parser, "Invalid section
> > indentation")
> > +        if (in_arg or not self.section.name or
> > +                not self.section.name.startswith("Example")):
>=20
> Again, break before the operator.
>=20
> > +            line =3D line.strip()
> > +        self.section.append(line)
> > +
> > +
> >  class QAPISchemaParser(object):
> > =20
> >      def __init__(self, fp, previously_included=3D[], incl_info=3DNone)=
:
> > @@ -140,11 +248,17 @@ class QAPISchemaParser(object):
> >          self.line =3D 1
> >          self.line_pos =3D 0
> >          self.exprs =3D []
> > +        self.docs =3D []
> >          self.accept()
> > =20
> >          while self.tok is not None:
> >              info =3D {'file': fname, 'line': self.line,
> >                      'parent': self.incl_info}
> > +            if self.tok =3D=3D '#':
> > +                doc =3D self.get_doc(info)
> > +                self.docs.append(doc)
> > +                continue
> > +
> >              expr =3D self.get_expr(False)
> >              if isinstance(expr, dict) and "include" in expr:
> >                  if len(expr) !=3D 1:
> > @@ -162,6 +276,7 @@ class QAPISchemaParser(object):
> >                          raise QAPIParseError(self, "Inclusion loop for=
 %s"
> >                                               % include)
> >                      inf =3D inf['parent']
> > +
> >                  # skip multiple include of the same file
> >                  if incl_abs_fname in previously_included:
> >                      continue
> > @@ -173,12 +288,19 @@ class QAPISchemaParser(object):
> >                  exprs_include =3D QAPISchemaParser(fobj,
> >                  previously_included,
> >                                                   info)
> >                  self.exprs.extend(exprs_include.exprs)
> > +                self.docs.extend(exprs_include.docs)
> >              else:
> >                  expr_elem =3D {'expr': expr,
> >                               'info': info}
> > +                if (self.docs and
> > +                        self.docs[-1].info['file'] =3D=3D fname and
> > +                        not self.docs[-1].expr):
>=20
> Again, break before the operator.
>=20
> > +                    self.docs[-1].expr =3D expr
> > +                    expr_elem['doc'] =3D self.docs[-1]
> > +
> >                  self.exprs.append(expr_elem)
> > =20
> > -    def accept(self):
> > +    def accept(self, skip_comment=3DTrue):
> >          while True:
> >              self.tok =3D self.src[self.cursor]
> >              self.pos =3D self.cursor
> > @@ -186,7 +308,13 @@ class QAPISchemaParser(object):
> >              self.val =3D None
> > =20
> >              if self.tok =3D=3D '#':
> > +                if self.src[self.cursor] =3D=3D '#':
> > +                    # Start of doc comment
> > +                    skip_comment =3D False
> >                  self.cursor =3D self.src.find('\n', self.cursor)
> > +                if not skip_comment:
> > +                    self.val =3D self.src[self.pos:self.cursor]
> > +                    return
> >              elif self.tok in "{}:,[]":
> >                  return
> >              elif self.tok =3D=3D "'":
>=20
> Copied from review of v3, so I don't forget:
>=20
> Comment tokens are thrown away as before, except when the parser asks
> for them by passing skip_comment=3DFalse, or when the comment token start=
s
> with ##.  The parser asks while parsing a doc comment, in get_doc().
>=20
> This is a backchannel from the parser to the lexer.  I'd rather avoid
> such lexer hacks, but I guess we can address that on top.
>=20
> A comment starting with ## inside an expression is now a syntax error.
> For instance, input
>=20
>     {
>     ##
>=20
> yields
>=20
>     /dev/stdin:2:1: Expected string or "}"
>=20
> Rather unfriendly error message, but we can fix that on top.
>=20
> > @@ -320,6 +448,28 @@ class QAPISchemaParser(object):
> >              raise QAPIParseError(self, 'Expected "{", "[" or string')
> >          return expr
> > =20
> > +    def get_doc(self, info):
> > +        if self.val !=3D '##':
> > +            raise QAPIParseError(self, "Junk after '##' at start of "
> > +                                 "documentation comment")
> > +
> > +        doc =3D QAPIDoc(self, info)
> > +        self.accept(False)
> > +        while self.tok =3D=3D '#':
> > +            if self.val.startswith('##'):
> > +                # End of doc comment
> > +                if self.val !=3D '##':
> > +                    raise QAPIParseError(self, "Junk after '##' at end=
 of
> > "
> > +                                         "documentation comment")
> > +                self.accept()
> > +                return doc
> > +            else:
> > +                doc.append(self.val)
> > +            self.accept(False)
> > +
> > +        raise QAPIParseError(self, "Documentation comment must end wit=
h
> > '##'")
> > +
> > +
> >  #
> >  # Semantic analysis of schema expressions
> >  # TODO fold into QAPISchema
> > @@ -704,6 +854,11 @@ def check_exprs(exprs):
> >      for expr_elem in exprs:
> >          expr =3D expr_elem['expr']
> >          info =3D expr_elem['info']
> > +
> > +        if 'doc' not in expr_elem:
> > +            raise QAPISemError(info,
> > +                               "Expression missing documentation comme=
nt")
> > +
> >          if 'enum' in expr:
> >              check_keys(expr_elem, 'enum', ['data'], ['prefix'])
> >              add_enum(expr['enum'], info, expr['data'])
> > @@ -762,6 +917,66 @@ def check_exprs(exprs):
> >      return exprs
> > =20
> > =20
> > +def check_freeform_doc(doc):
> > +    if doc.symbol:
> > +        raise QAPISemError(doc.info,
> > +                           "Documention for '%s' is not followed"
> > +                           " by the definition" % doc.symbol)
> > +
> > +    body =3D str(doc.body)
> > +    if re.search(r'@\S+:', body, re.MULTILINE):
> > +        raise QAPISemError(doc.info,
> > +                           "Document body cannot contain @NAME: sectio=
ns")
>=20
> "Free-form documentation block must not contain ..."
>=20

ok

> > +
> > +
> > +def check_definition_doc(doc, expr, info):
> > +    for i in ('enum', 'union', 'alternate', 'struct', 'command', 'even=
t'):
> > +        if i in expr:
> > +            meta =3D i
> > +            break
> > +
> > +    name =3D expr[meta]
> > +    if doc.symbol !=3D name:
> > +        raise QAPISemError(info, "Definition of '%s' follows
> > documentation"
> > +                           " for '%s'" % (name, doc.symbol))
> > +    if doc.has_section('Returns') and 'command' not in expr:
> > +        raise QAPISemError(info, "'Returns:' is only valid for command=
s")
>=20
> Copied from review of v5, so I don't forget:
>=20
> We accept 'Returns:' even when the command doesn't return anything,
> because we currently use it to document errors, too.  Can't say I like
> that, but it's out of scope here.
>=20
> > +
> > +    doc_args =3D set(doc.args.keys())
> > +    if meta =3D=3D 'union':
> > +        data =3D expr.get('base', [])
> > +    else:
> > +        data =3D expr.get('data', [])
> > +    if isinstance(data, dict):
> > +        data =3D data.keys()
> > +    if isinstance(data, list):
> > +        args =3D set([name.strip('*') for name in data])
> > +    else:
> > +        args =3D set()
> > +    if meta =3D=3D 'alternate' or \
> > +       (meta =3D=3D 'union' and not expr.get('discriminator')):
> > +        args.add('type')
> > +    if not doc_args.issubset(args):
> > +        raise QAPISemError(info, "Members documentation is not a subse=
t
> > of"
> > +                           " API %r > %r" % (list(doc_args), list(args=
)))
>=20
> This error message is pretty horrid :)  Can be improved on top.

Improved in v7

>=20
> Copied from review of v5, so I don't forget:
>=20
> As explained in review of v3, this is only a subset of the real set of
> members.  Computing the exact set is impractical when working with the
> abstract syntax tree.  I believe we'll eventually have to rewrite this
> code to work with the QAPISchemaEntity instead.
>=20
> > +
> > +
> > +def check_docs(docs):
> > +    for doc in docs:
> > +        for section in doc.args.values() + doc.sections:
> > +            content =3D str(section)
> > +            if not content or content.isspace():
> > +                raise QAPISemError(doc.info,
> > +                                   "Empty doc section '%s'" %
> > section.name)
> > +
> > +        if not doc.expr:
> > +            check_freeform_doc(doc)
> > +        else:
> > +            check_definition_doc(doc, doc.expr, doc.info)
> > +
> > +    return docs
> > +
> > +
> >  #
> >  # Schema compiler frontend
> >  #
> > @@ -1230,7 +1445,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
> >  class QAPISchema(object):
> >      def __init__(self, fname):
> >          try:
> > -            self.exprs =3D check_exprs(QAPISchemaParser(open(fname,
> > "r")).exprs)
> > +            parser =3D QAPISchemaParser(open(fname, "r"))
> > +            self.exprs =3D check_exprs(parser.exprs)
> > +            self.docs =3D check_docs(parser.docs)
> >              self._entity_dict =3D {}
> >              self._predefining =3D True
> >              self._def_predefineds()
> > diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> > new file mode 100755
> > index 0000000000..99ad118b06
> > --- /dev/null
> > +++ b/scripts/qapi2texi.py
> > @@ -0,0 +1,339 @@
> > +#!/usr/bin/env python
> > +# QAPI texi generator
> > +#
> > +# This work is licensed under the terms of the GNU LGPL, version 2+.
> > +# See the COPYING file in the top-level directory.
> > +"""This script produces the documentation of a qapi schema in texinfo
> > format"""
> > +import re
> > +import sys
> > +
> > +import qapi
> > +
> > +COMMAND_FMT =3D """
>=20
> Got a particular reason for shouting?
>=20

constant name should be in capital

> > +@deftypefn {type} {{{ret}}} {name} @
> > +{{{args}}}
> > +
> > +{body}
> > +
> > +@end deftypefn
> > +
> > +""".format
>=20
> This .format business is perhaps a bit too clever.  But let's move on.
>=20

That or we call COMMAND_FMT.format() and such, I prefer the former. I don't=
 know what is the pythonic way. Converting it to a full function is even mo=
re verbose and ugly ;)

> > +
> > +ENUM_FMT =3D """
> > +@deftp Enum {name}
> > +
> > +{body}
> > +
> > +@end deftp
> > +
> > +""".format
> > +
> > +STRUCT_FMT =3D """
>=20
> This is used for unions and alternates in addition to structs.  But okay.
>=20
> > +@deftp {{{type}}} {name} @
> > +{{{attrs}}}
> > +
> > +{body}
> > +
> > +@end deftp
> > +
> > +""".format
> > +
> > +EXAMPLE_FMT =3D """@example
> > +{code}
> > +@end example
> > +""".format
> > +
> > +
> > +def subst_strong(doc):
> > +    """Replaces *foo* by @strong{foo}"""
> > +    return re.sub(r'\*([^_\n]+)\*', r'@emph{\1}', doc)
>=20
> Pasto: you want * instead of _ in the [^ ... ].

yep

>=20
> > +
> > +
> > +def subst_emph(doc):
> > +    """Replaces _foo_ by @emph{foo}"""
> > +    return re.sub(r'\s_([^_\n]+)_\s', r' @emph{\1} ', doc)
>=20
> This replaces adjacent whitespace characters by the space character.
> Would \b work here?

yes

>=20
> > +
> > +
> > +def subst_vars(doc):
> > +    """Replaces @var by @code{var}"""
> > +    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
>=20
> Note: any @ characters not followed by at least one word character are
> left alone.
>=20
> > +
> > +
> > +def subst_braces(doc):
> > +    """Replaces {} with @{ @}"""
> > +    return doc.replace("{", "@{").replace("}", "@}")
> > +
> > +
> > +def texi_example(doc):
> > +    """Format @example"""
> > +    doc =3D subst_braces(doc).strip('\n')
> > +    return EXAMPLE_FMT(code=3Ddoc)
>=20
> Neglects to escape @ characters.
>=20

Is there such use case yet?

> We should probably escape them in subst_braces(), and rename the
> function to subst_special() or subs_texi_special().  If we do that, we
> need to delay it until after subst_vars() in texi_format().
>=20

Added a TODO

> > +
> > +
> > +def texi_format(doc):
> > +    """
> > +    Format documentation
> > +
> > +    Lines starting with:
> > +    - |: generates an @example
> > +    - =3D: generates @section
> > +    - =3D=3D: generates @subsection
> > +    - 1. or 1): generates an @enumerate @item
>=20
> Any number works, but I guess this is close enough.
>=20
> > +    - o/*/-: generates an @itemize list
> > +    """
> > +    lines =3D []
> > +    doc =3D subst_braces(doc)
> > +    doc =3D subst_vars(doc)
> > +    doc =3D subst_emph(doc)
> > +    doc =3D subst_strong(doc)
> > +    inlist =3D ""
> > +    lastempty =3D False
> > +    for line in doc.split('\n'):
> > +        empty =3D line =3D=3D ""
> > +
> > +        if line.startswith("| "):
> > +            line =3D EXAMPLE_FMT(code=3Dline[2:])
> > +        elif line.startswith("=3D "):
> > +            line =3D "@section " + line[2:]
> > +        elif line.startswith("=3D=3D "):
> > +            line =3D "@subsection " + line[3:]
> > +        elif re.match("^([0-9]*[.)]) ", line):
>=20
> N) isn't actually used, and not covered by tests.  Dropping it is
> simpler than testing it, so let's do that.
>=20

ok

> > +            if not inlist:
> > +                lines.append("@enumerate")
> > +                inlist =3D "enumerate"
> > +            line =3D line[line.find(" ")+1:]
> > +            lines.append("@item")
> > +        elif re.match("^[o*-] ", line):
> > +            if not inlist:
> > +                lines.append("@itemize %s" % {'o': "@bullet",
> > +                                              '*': "@minus",
> > +                                              '-': ""}[line[0]])
>=20
> Both 'o' and '-' become @bullet, the former explicitly, the latter
> because @bullet is the default.  '*' becomes @minus.  This is odd.
>=20
> Since 'o' isn't actually used, let's drop it, and map '*' to @bullet (or
> nothing, doesn't matter), '-' to @minus'.

'o' is being used in @human-monitor-command. Let's change it then, added a =
preliminary patch.

>=20
> > +                inlist =3D "itemize"
> > +            lines.append("@item")
> > +            line =3D line[2:]
>=20
> Note that the choice of 'o' vs. '*' vs. '-' vs. [0-9]*[.)] matters only
> in the first item.
>=20
> > +        elif lastempty and inlist:
> > +            lines.append("@end %s\n" % inlist)
> > +            inlist =3D ""
>=20
> Doing this in a single if / elif chain is problematic.  For instance, a
> line without markup terminates a list if it follows a blank line
> (reaches the final elif), but a line with some *other* markup, such as a
> title doesn't.
>=20
> Example:
>=20
>     ##
>     # 1. one
>     # 2. two
>     #
>     # =3D title
>     #
>     # 1. eins
>     # 2. zwei
>     # * drei
>     ##
>=20
> happily produces
>=20
>     @enumerate
>     @item
>     one
>     @item
>     two
>=20
>     @section title
>=20
>     @item
>     eins
>     @item
>     zwei
>     @item
>     drei
>     @end enumerate
>=20
> Could be filed under deficiencies for now, with a FIXME comment here.
>=20

added a FIXME

> > +
> > +        lastempty =3D empty
> > +        lines.append(line)
> > +
> > +    if inlist:
> > +        lines.append("@end %s\n" % inlist)
> > +    return "\n".join(lines)
> > +
> > +
> > +def texi_args(expr, key=3D"data"):
> > +    """
> > +    Format the functions/structure/events.. arguments/members
> > +    """
>=20
> PEP257 wants one-liner doc strings in one line, including the """.

which version of pep8 or checker are you using? :)

>=20
> > +    if key not in expr:
> > +        return ""
> > +
> > +    args =3D expr[key]
> > +    arg_list =3D []
> > +    if isinstance(args, str):
> > +        arg_list.append(args)
> > +    else:
> > +        for name, typ in args.iteritems():
> > +            # optional arg
> > +            if name.startswith("*"):
> > +                name =3D name[1:]
> > +                arg_list.append("['%s': @t{%s}]" % (name, typ))
> > +            # regular arg
> > +            else:
> > +                arg_list.append("'%s': @t{%s}" % (name, typ))
> > +
> > +    return ", ".join(arg_list)
>=20
> Generates a formal description of something like struct members in a
> language you invent.  As I showed in review of PATCH 05, the information
> here is redundant except for types.  If we can add the type information
> elsewhere, and the formal description be dropped.  That's what I want us
> to try in the medium term.  For the short term, I propose to drop it,
> and add a FIXME.  This gets rid of code I haven't fully reviewed, yet.
> More importantly, it gets rid of documentation that is known to be
> inaccurate and incomplete (see review of PATCH 05), and threatens to
> delay this series further.
>=20

It's discouraging that you ask me to document and augment this syntax to en=
d up asking me to remove it.

More importantly, I believe it is convenient and quite natural for any prog=
rammer to read, and it was there since the first RFC of the series (~1.5y a=
go), we had time to discuss it.

Let's remove it for now, because to be pragmatic and avoid this yet another=
 delaying discussion. It's a big regression, I hope we can bring it back in=
 some form later.

> > +
> > +
> > +def texi_body(doc):
> > +    """
> > +    Format the body of a symbol documentation:
> > +    - a table of arguments
> > +    - followed by "Returns/Notes/Since/Example" sections
> > +    """
> > +    def _section_order(section):
> > +        return {"Returns": 0,
> > +                "Note": 1,
> > +                "Notes": 1,
> > +                "Since": 2,
> > +                "Example": 3,
> > +                "Examples": 3}[section]
> > +
> > +    body =3D ""
> > +    if doc.args:
> > +        body +=3D "@table @asis\n"
> > +        for arg, section in doc.args.iteritems():
> > +            desc =3D str(section)
> > +            opt =3D ''
> > +            if desc.startswith("#optional"):
> > +                desc =3D desc[10:]
> > +                opt =3D ' *'
> > +            elif desc.endswith("#optional"):
> > +                desc =3D desc[:-10]
> > +                opt =3D ' *'
>=20
> Add here:
>=20
>                # TODO Should ensure #optional matches the schema

fixed, new test case added

>=20
> > +            body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
> > +                                                   texi_format(desc))
> > +        body +=3D "@end table\n"
> > +    body +=3D texi_format(str(doc.body))
> > +
> > +    sections =3D sorted(doc.sections, key=3Dlambda i: _section_order(i=
.name))
>=20
> Reordering documentation written by humans is unlikely to improve
> things, so let's not do that.  If we want our documentation presented in
> a certain order, we should enforce that order at the source level.
>=20

That would bring consistency and avoid ambiguity. Imho it would make sense =
if sections can be reordered (think about IDE tooling and such).

Interleaving documentation body and arguments seems a bad idea and can be a=
mbiguous. I don't know an API documentation format that accepts that.

It feels backward to me, but I'll follow your advice for now and accept app=
ended doc (as anonymous sections) and keep original ordering.


> The doc parser splits doc comments into sections.  It should produce a
> list of sections in source order, for the generator to walk.
>=20
> If we decide doing that now would delay the series too much, I'm willing
> to accept it as is with a suitable FIXME comment here, noted in the
> commit message's list of deficiencies.
>=20
> > +    for section in sections:
> > +        name, doc =3D (section.name, str(section))
> > +        func =3D texi_format
> > +        if name.startswith("Example"):
> > +            func =3D texi_example
> > +
> > +        body +=3D "\n@quotation %s\n%s\n@end quotation" % \
> > +                (name, func(doc))
>=20
> Are you sure @quotation is a good idea?  The extra indentation looks
> ugly to me, both in .txt and .html.  But we can touch that up on top.

That's what quotation is for:
https://www.gnu.org/software/texinfo/manual/texinfo/html_node/_0040quotatio=
n.html

I'd rather look at fixing the txt/html generator.

>=20
> > +    return body
> > +
> > +
> > +def texi_alternate(expr, doc):
> > +    """
> > +    Format an alternate to texi
> > +    """
> > +    args =3D texi_args(expr)
> > +    body =3D texi_body(doc)
> > +    return STRUCT_FMT(type=3D"Alternate",
> > +                      name=3Ddoc.symbol,
> > +                      attrs=3D"[ " + args + " ]",
> > +                      body=3Dbody)
> > +
> > +
> > +def texi_union(expr, doc):
> > +    """
> > +    Format a union to texi
> > +    """
> > +    discriminator =3D expr.get("discriminator")
> > +    if discriminator:
> > +        is_flat =3D True
> > +        union =3D "Flat Union"
> > +    else:
> > +        is_flat =3D False
> > +        union =3D "Simple Union"
> > +        discriminator =3D "type"
> > +
> > +    attrs =3D "@{ "
> > +    if is_flat:
> > +        attrs +=3D texi_args(expr, "base") + ", "
> > +    else:
> > +        attrs +=3D "'type': @t{str}, 'data': "
> > +    attrs +=3D "[ '%s' =3D " % discriminator
> > +    attrs +=3D texi_args(expr, "data") + " ] @}"
> > +    body =3D texi_body(doc)
> > +    return STRUCT_FMT(type=3Dunion,
> > +                      name=3Ddoc.symbol,
> > +                      attrs=3Dattrs,
> > +                      body=3Dbody)
> > +
> > +
> > +def texi_enum(expr, doc):
> > +    """
> > +    Format an enum to texi
> > +    """
> > +    for i in expr['data']:
> > +        if i not in doc.args:
> > +            doc.args[i] =3D ''
> > +    body =3D texi_body(doc)
> > +    return ENUM_FMT(name=3Ddoc.symbol,
> > +                    body=3Dbody)
> > +
> > +
> > +def texi_struct(expr, doc):
> > +    """
> > +    Format a struct to texi
> > +    """
> > +    args =3D texi_args(expr)
> > +    body =3D texi_body(doc)
> > +    base =3D expr.get("base")
> > +    attrs =3D "@{ "
> > +    if base:
> > +        attrs +=3D "%s" % base
> > +        if args:
> > +            attrs +=3D " + "
> > +    attrs +=3D args + " @}"
> > +    return STRUCT_FMT(type=3D"Struct",
> > +                      name=3Ddoc.symbol,
> > +                      attrs=3Dattrs,
> > +                      body=3Dbody)
> > +
> > +
> > +def texi_command(expr, doc):
> > +    """
> > +    Format a command to texi
> > +    """
> > +    args =3D texi_args(expr)
> > +    ret =3D expr["returns"] if "returns" in expr else ""
> > +    body =3D texi_body(doc)
> > +    return COMMAND_FMT(type=3D"Command",
> > +                       name=3Ddoc.symbol,
> > +                       ret=3Dret,
> > +                       args=3D"(" + args + ")",
> > +                       body=3Dbody)
> > +
> > +
> > +def texi_event(expr, doc):
> > +    """
> > +    Format an event to texi
> > +    """
> > +    args =3D texi_args(expr)
> > +    body =3D texi_body(doc)
> > +    return COMMAND_FMT(type=3D"Event",
> > +                       name=3Ddoc.symbol,
> > +                       ret=3D"",
> > +                       args=3D"(" + args + ")",
> > +                       body=3Dbody)
> > +
> > +
> > +def texi_expr(expr, doc):
> > +    """
> > +    Format an expr to texi
> > +    """
> > +    (kind, _) =3D expr.items()[0]
> > +
> > +    fmt =3D {"command": texi_command,
> > +           "struct": texi_struct,
> > +           "enum": texi_enum,
> > +           "union": texi_union,
> > +           "alternate": texi_alternate,
> > +           "event": texi_event}[kind]
> > +
> > +    return fmt(expr, doc)
> > +
> > +
> > +def texi(docs):
> > +    """
> > +    Convert QAPI schema expressions to texi documentation
> > +    """
> > +    res =3D []
> > +    for doc in docs:
> > +        expr =3D doc.expr
> > +        if not expr:
> > +            res.append(texi_body(doc))
> > +            continue
> > +        try:
> > +            doc =3D texi_expr(expr, doc)
> > +            res.append(doc)
> > +        except:
> > +            print >>sys.stderr, "error at @%s" % doc.info
> > +            raise
> > +
> > +    return '\n'.join(res)
> > +
> > +
> > +def main(argv):
> > +    """
> > +    Takes schema argument, prints result to stdout
> > +    """
> > +    if len(argv) !=3D 2:
> > +        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" %
> > argv[0]
> > +        sys.exit(1)
> > +
> > +    schema =3D qapi.QAPISchema(argv[1])
> > +    print texi(schema.docs)
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main(sys.argv)
> > diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
> > index 2841c5144a..f93d3390c8 100644
> > --- a/docs/qapi-code-gen.txt
> > +++ b/docs/qapi-code-gen.txt
> > @@ -44,40 +44,110 @@ Input must be ASCII (although QMP supports full
> > Unicode strings, the
> >  QAPI parser does not).  At present, there is no place where a QAPI
> >  schema requires the use of JSON numbers or null.
> > =20
> > +
> > +=3D=3D=3D Comments =3D=3D=3D
> > +
> >  Comments are allowed; anything between an unquoted # and the following
> > -newline is ignored.  Although there is not yet a documentation
> > -generator, a form of stylized comments has developed for consistently
> > -documenting details about an expression and when it was added to the
> > -schema.  The documentation is delimited between two lines of ##, then
> > -the first line names the expression, an optional overview is provided,
> > -then individual documentation about each member of 'data' is provided,
> > -and finally, a 'Since: x.y.z' tag lists the release that introduced
> > -the expression.  Optional members are tagged with the phrase
> > -'#optional', often with their default value; and extensions added
> > -after the expression was first released are also given a '(since
> > -x.y.z)' comment.  For example:
> > -
> > -    ##
> > -    # @BlockStats:
> > -    #
> > -    # Statistics of a virtual block device or a block backing device.
> > -    #
> > -    # @device: #optional If the stats are for a virtual block device, =
the
> > name
> > -    #          corresponding to the virtual block device.
> > -    #
> > -    # @stats:  A @BlockDeviceStats for the device.
> > -    #
> > -    # @parent: #optional This describes the file block device if it ha=
s
> > one.
> > -    #
> > -    # @backing: #optional This describes the backing block device if i=
t
> > has one.
> > -    #           (Since 2.0)
> > -    #
> > -    # Since: 0.14.0
> > -    ##
> > -    { 'struct': 'BlockStats',
> > -      'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
> > -               '*parent': 'BlockStats',
> > -               '*backing': 'BlockStats'} }
> > +newline is ignored.
> > +
> > +A documentation block is delimited between two lines of ##, and can be
> > +formatted.
>=20
> Well, any comment can be "formatted".  Suggest:
>=20
>    A multi-line comment that starts and ends with a '##' line is a
>    documentation comment.  These are parsed by the documentation
>    generator, which recognizes certain markup detailed below.
>=20
> Note that I say "markup" instead of "annotations".  I think it's a more
> precise term.  If we go with it, the commit message's grammar needs an
> update, too.
>=20

sure (I thought you preferred annotations in an earlier discussion to avoid=
 confusion with proper markup/markdown languages)


> > +
> > +Example:
> > +
> > +##
> > +# =3D Section
> > +# =3D=3D Subsection
> > +#
> > +# Some text foo with *strong* and _emphasis_
> > +# 1. with a list
> > +# 2. like that
> > +#
> > +# And some code:
> > +# | $ echo foo
> > +# | -> do this
> > +# | <- get that
> > +#
> > +##
>=20
> I'd move this to the end of "Documentation annotations".

ok

>=20
> > +
> > +
> > +=3D=3D=3D=3D Documentation annotations =3D=3D=3D=3D
> > +
> > +Documentation lines starting with the following characters and a
> > +space:
>=20
> What exactly constitutes a "documentation line"?  It's actually whatever
> line the doc comment machinery gets out of the doc comment parsing &
> mangling, to be passed on to the doc formatting.
>=20
> The user doesn't want to know about all that crap.  We should talk to
> him in terms of doc comments, because that's what he writes and reads.
>=20
> > +- =3D are top section title
> > +- =3D=3D are subsection title
>=20
> Grammar demands "titles".

ok

>=20
> > +- | are examples
>=20
> Not spelled out, but perhaps obvious enough: a sequence of such lines is
> *one* example.  Peeking at the generator code... hmm, obvious enough or
> not, it's wrong: each such line is its own example.  Doesn't that suck?
> Could be filed under "deficiencies", for improvement on top.
>=20
> > +- X. or X) are enumerations (X is any number)
> > +- o/*/- are itemized list
>=20
> What exactly ends a list?  Particularly important for enumerations,
> because their counter gets reset there.  Peeking at the code... looks
> like blank lines followed by a line without markup does.  Not so good,
> see there.
>=20
> Can lists be nested?  Peeking at the code... no.

Another limitation, worth to add a TODO? only if needed probably.

>=20
> The forms "X)" and "o " appear not to be used.  Let's get rid of them.
>=20
> Here's my try:
>=20
>    =3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
>=20
>    Comment text starting with '=3D' is a section title:
>=20
>        # =3D Section title
>=20
>    Double the '=3D' for a subsection title:
>=20
>        # =3D=3D Subection title
>=20
>    '|' denotes examples:
>=20
>        # | Text of the example, may span
>        # | multiple lines
>=20
>    '*' starts an itemized list:
>=20
>        # * First item, may span
>        #   multiple lines
>        # * Second item
>=20
>    You can also use '-' instead of '*'.
>=20
>    A decimal number followed by '.' starts a numbered list:
>=20
>        # 1. First item, may span
>        # multiple lines
>        # 2. Second item
>=20
>    The actual number doesn't matter.  You could even use '*' instead of
>    '2.' for the second item.
>=20
>    FIXME what exactly ends a list
>=20
>    Additional whitespace between the initial '#' and the comment text is
>    permitted.
>=20
> > +
> > +*foo* and _foo_ are for strong and emphasis styles respectively (they
> > +do not work over multiple lines). @foo is used to reference a symbol.
>=20
> Only occurence of "symbol" in this file.  Let's say "to reference a name
> in the schema".
>=20

ok

> > +
> > +Note: the 'Example' section is processed verbatim (see 'Expression
> > +documentation' below).
>=20
> Peeking at the generator code... the section text is enclosed in an
> @example environment.  For true verbatim processing, we'd need a
> @verbatim environment.  The easy fix is to explain the formatting of
> Example sections by reduction to '# |' formatting instead.
>=20
> Unecessary forward reference: Example sections are not yet defined.
> Let's move the explanation how they're formatted to their definition.
> I'll propose something there.
>=20
> Taking a step back: there are two ways to mark up examples: as
> Example/Examples section, or as '# |' lines.  Feels like a bad language
> design idea, but it's probably a good "limit the QAPI schema churn in
> this series" idea.  We can get rid of it later.
>=20
> > +
> > +
> > +=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
> > +
> > +A free-form documentation isn't immediately followed by an expression,
> > +and is used to provide some additional text and structuring content.
>=20
> Suggest to move this below the next section, and say:
>=20
>    =3D=3D=3D=3D Free-form documentation blocks =3D=3D=3D=3D
>=20
>    A documentation block that isn't expression an documentation block is
>    a free-form documentation block.  These may be used to provide
>    additional ...
>=20

ok


> > +
> > +
> > +=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
> > +
> > +An expression must have a preceding comment block defining it.
>=20
> What about include expressions?
>=20
> Suggest:
>=20
>    =3D=3D=3D=3D Expression documentation blocks =3D=3D=3D=3D
>=20
>    Each expression that isn't an include directive must be preceded by a
>    documentation block.  Such blocks are called expression documentation
>    blocks.


ok


>=20
> > +
> > +The first line of the documentation names the expression, then the
> > +documentation body is provided, then individual documentation about
> > +each member of 'data' is provided. Finally, several tagged sections
> > +can be added.
>=20
> I'm afraid this is more aspiration than specification: the parser
> accepts these things in almost any order.
>=20
> Could be filed under "deficiencies" for now.
>=20
> Member of 'data' won't remain accurate.  Consider:
>=20
>     { 'union': 'GlusterServer',
>       'base': { 'type': 'GlusterTransport' },
>       'discriminator': 'type',
>       'data': { 'unix': 'UnixSocketAddress',
>                 'tcp': 'InetSocketAddress' } }
>=20
> Its doc comment currently doesn't contain argument sections.  It should
> eventually contain @type:, @unix: and @tcp:.  Only the latter two are
> members of 'data'.
>=20
> I should propose something better, but I'm getting perilously close to
> the christmas break already.  Later.
>=20

It falls under the union-type support is lacking?

> I don't like the reuse of "section".  We already burned that term on the
> things that start with # =3D lines.  But I don't have a better idea right
> now.
>=20
> > +
> > +Optional members are tagged with the phrase '#optional', often with
> > +their default value; and extensions added after the expression was
> > +first released are also given a '(since x.y.z)' comment.
> > +
> > +A tagged section starts with one of the following words:
> > +"Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:".
> > +
> > +A 'Since: x.y.z' tag lists the release that introduced the expression.
> > +
> > +For example:
> > +
> > +##
> > +# @BlockStats:
> > +#
> > +# Statistics of a virtual block device or a block backing device.
> > +#
> > +# @device: #optional If the stats are for a virtual block device, the =
name
> > +#          corresponding to the virtual block device.
> > +#
> > +# @stats:  A @BlockDeviceStats for the device.
> > +#
> > +# @parent: #optional This describes the file block device if it has on=
e.
> > +#
> > +# @backing: #optional This describes the backing block device if it ha=
s
> > one.
> > +#           (Since 2.0)
> > +#
> > +# Since: 0.14.0
> > +#
> > +# Notes: You can also make a list:
> > +#        - with items
> > +#        - like this
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": ... }
> > +# <- { "return": ... }
> > +#
> > +##
> > +{ 'struct': 'BlockStats',
> > +  'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
> > +           '*parent': 'BlockStats',
> > +           '*backing': 'BlockStats'} }
>=20
> I don't like this example.  It's a type cribbed from block-core.json,
> with Notes: and Example: thrown in just to show how they're used.
> Except you'd never use such an example with a type, only with a command.
>=20
> Instead of cramming this stuff into @BlockStats, why not add the command
> that uses it?
>=20
>    ##
>    # @BlockStats:
>    #
>    # Statistics of a virtual block device or a block backing device.
>    #
>    # @device: #optional If the stats are for a virtual block device, the =
name
>    #          corresponding to the virtual block device.
>    #
>    # @node-name: #optional The node name of the device. (Since 2.3)
>    #
>    # ... more members ...
>    #
>    # Since: 0.14.0
>    ##
>    { 'struct': 'BlockStats',
>      'data': {'*device': 'str', '*node-name': 'str',
>               ... more members ... } }
>=20
>    ##
>    # @query-blockstats:
>    #
>    # Query the @BlockStats for all virtual block devices.
>    #
>    # @query-nodes: #optional If true, the command will query all the bloc=
k
>    nodes
>    #               ... explain, explain ...
>    #               (Since 2.3)
>    #
>    # Returns: A list of @BlockStats for each virtual block devices.
>    #
>    # Since: 0.14.0
>    #
>    # Example:
>    #
>    # -> { "execute": "query-blockstats" }
>    # <- {
>    #      ... lots of output ...
>    #    }
>    #
>    ##
>    { 'command': 'query-blockstats',
>      'data': { '*query-nodes': 'bool' },
>      'returns': ['BlockStats'] }

ok

>=20
> > +
> > +
> > +=3D=3D=3D Schema overview =3D=3D=3D
> > =20
> >  The schema sets up a series of types, as well as commands and events
> >  that will use those types.  Forward references are allowed: the parser
> > @@ -193,7 +263,7 @@ struct in C or an Object in JSON. Each value of the
> > 'data' dictionary
> >  must be the name of a type, or a one-element array containing a type
> >  name.  An example of a struct is:
> > =20
> > - { 'struct': 'MyType',
> > +{ 'struct': 'MyType',
> >     'data': { 'member1': 'str', 'member2': 'int', '*member3': 'str' } }
> > =20
> >  The use of '*' as a prefix to the name means the member is optional in
>=20
> Spurious hunk.  Could be dropped on commit.

ok

>=20
> > diff --git a/tests/qapi-schema/alternate-any.err
> > b/tests/qapi-schema/alternate-any.err
> > index aaa0154731..395c8ab583 100644
> > --- a/tests/qapi-schema/alternate-any.err
> > +++ b/tests/qapi-schema/alternate-any.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one'
> > cannot use type 'any'
> > +tests/qapi-schema/alternate-any.json:6: Alternate 'Alt' member 'one'
> > cannot use type 'any'
> > diff --git a/tests/qapi-schema/alternate-any.json
> > b/tests/qapi-schema/alternate-any.json
> > index e47a73a116..c958776767 100644
> > --- a/tests/qapi-schema/alternate-any.json
> > +++ b/tests/qapi-schema/alternate-any.json
> > @@ -1,4 +1,8 @@
> >  # we do not allow the 'any' type as an alternate branch
> > +
> > +##
> > +# @Alt:
> > +##
>=20
> If you need to respin, please consider splitting these off into their
> own patch, to make this one a smaller bear to review.

That's not convenient, because doc output comes after this patch. So it wou=
ld have to be splitted in before and after doc parsing. Not convinced it's =
worth it.


I hope I didn't miss or skipped too much of your review, I'll send v7 with =
those changes.

thanks again

>=20
> >  { 'alternate': 'Alt',
> >    'data': { 'one': 'any',
> >              'two': 'int' } }
> > diff --git a/tests/qapi-schema/alternate-array.err
> > b/tests/qapi-schema/alternate-array.err
> > index 7b930c64ab..09628e9755 100644
> > --- a/tests/qapi-schema/alternate-array.err
> > +++ b/tests/qapi-schema/alternate-array.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'A=
lt'
> > cannot be an array
> > +tests/qapi-schema/alternate-array.json:12: Member 'two' of alternate '=
Alt'
> > cannot be an array
> > diff --git a/tests/qapi-schema/alternate-array.json
> > b/tests/qapi-schema/alternate-array.json
> > index f241aac122..c2f98ad608 100644
> > --- a/tests/qapi-schema/alternate-array.json
> > +++ b/tests/qapi-schema/alternate-array.json
> > @@ -1,7 +1,14 @@
> >  # we do not allow array branches in alternates
> > +
> > +##
> > +# @One:
> > +##
> >  # TODO: should we support this?
> >  { 'struct': 'One',
> >    'data': { 'name': 'str' } }
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt',
> >    'data': { 'one': 'One',
> >              'two': [ 'int' ] } }
> > diff --git a/tests/qapi-schema/alternate-base.err
> > b/tests/qapi-schema/alternate-base.err
> > index 30d8a34373..3b679140e0 100644
> > --- a/tests/qapi-schema/alternate-base.err
> > +++ b/tests/qapi-schema/alternate-base.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alterna=
te
> > 'Alt'
> > +tests/qapi-schema/alternate-base.json:11: Unknown key 'base' in altern=
ate
> > 'Alt'
> > diff --git a/tests/qapi-schema/alternate-base.json
> > b/tests/qapi-schema/alternate-base.json
> > index 529430ecf2..9612b7925d 100644
> > --- a/tests/qapi-schema/alternate-base.json
> > +++ b/tests/qapi-schema/alternate-base.json
> > @@ -1,6 +1,13 @@
> >  # we reject alternate with base type
> > +
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt',
> >    'base': 'Base',
> >    'data': { 'number': 'int' } }
> > diff --git a/tests/qapi-schema/alternate-clash.err
> > b/tests/qapi-schema/alternate-clash.err
> > index 604d8495eb..f07c3e8ad3 100644
> > --- a/tests/qapi-schema/alternate-clash.err
> > +++ b/tests/qapi-schema/alternate-clash.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) colli=
des
> > with 'a-b' (branch of Alt1)
> > +tests/qapi-schema/alternate-clash.json:11: 'a_b' (branch of Alt1) coll=
ides
> > with 'a-b' (branch of Alt1)
> > diff --git a/tests/qapi-schema/alternate-clash.json
> > b/tests/qapi-schema/alternate-clash.json
> > index 6d73bc527b..97ca7c80e7 100644
> > --- a/tests/qapi-schema/alternate-clash.json
> > +++ b/tests/qapi-schema/alternate-clash.json
> > @@ -4,5 +4,9 @@
> >  # TODO: In the future, if alternates are simplified to not generate
> >  # the implicit Alt1Kind enum, we would still have a collision with the
> >  # resulting C union trying to have two members named 'a_b'.
> > +
> > +##
> > +# @Alt1:
> > +##
> >  { 'alternate': 'Alt1',
> >    'data': { 'a-b': 'str', 'a_b': 'int' } }
> > diff --git a/tests/qapi-schema/alternate-conflict-dict.err
> > b/tests/qapi-schema/alternate-conflict-dict.err
> > index 0f411f4faf..7cb023fdd8 100644
> > --- a/tests/qapi-schema/alternate-conflict-dict.err
> > +++ b/tests/qapi-schema/alternate-conflict-dict.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' memb=
er
> > 'two' can't be distinguished from member 'one'
> > +tests/qapi-schema/alternate-conflict-dict.json:16: Alternate 'Alt' mem=
ber
> > 'two' can't be distinguished from member 'one'
> > diff --git a/tests/qapi-schema/alternate-conflict-dict.json
> > b/tests/qapi-schema/alternate-conflict-dict.json
> > index d566cca816..9f9d97fa2e 100644
> > --- a/tests/qapi-schema/alternate-conflict-dict.json
> > +++ b/tests/qapi-schema/alternate-conflict-dict.json
> > @@ -1,8 +1,18 @@
> >  # we reject alternates with multiple object branches
> > +
> > +##
> > +# @One:
> > +##
> >  { 'struct': 'One',
> >    'data': { 'name': 'str' } }
> > +##
> > +# @Two:
> > +##
> >  { 'struct': 'Two',
> >    'data': { 'value': 'int' } }
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt',
> >    'data': { 'one': 'One',
> >              'two': 'Two' } }
> > diff --git a/tests/qapi-schema/alternate-conflict-string.err
> > b/tests/qapi-schema/alternate-conflict-string.err
> > index fc523b0879..6dbbacd1d2 100644
> > --- a/tests/qapi-schema/alternate-conflict-string.err
> > +++ b/tests/qapi-schema/alternate-conflict-string.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-conflict-string.json:4: Alternate 'Alt' me=
mber
> > 'two' can't be distinguished from member 'one'
> > +tests/qapi-schema/alternate-conflict-string.json:11: Alternate 'Alt'
> > member 'two' can't be distinguished from member 'one'
> > diff --git a/tests/qapi-schema/alternate-conflict-string.json
> > b/tests/qapi-schema/alternate-conflict-string.json
> > index 72f04a820a..12aafab808 100644
> > --- a/tests/qapi-schema/alternate-conflict-string.json
> > +++ b/tests/qapi-schema/alternate-conflict-string.json
> > @@ -1,6 +1,13 @@
> >  # we reject alternates with multiple string-like branches
> > +
> > +##
> > +# @Enum:
> > +##
> >  { 'enum': 'Enum',
> >    'data': [ 'hello', 'world' ] }
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt',
> >    'data': { 'one': 'str',
> >              'two': 'Enum' } }
> > diff --git a/tests/qapi-schema/alternate-empty.err
> > b/tests/qapi-schema/alternate-empty.err
> > index bb06c5bfec..8245ce3103 100644
> > --- a/tests/qapi-schema/alternate-empty.err
> > +++ b/tests/qapi-schema/alternate-empty.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' should have =
at
> > least two branches in 'data'
> > +tests/qapi-schema/alternate-empty.json:6: Alternate 'Alt' should have =
at
> > least two branches in 'data'
> > diff --git a/tests/qapi-schema/alternate-empty.json
> > b/tests/qapi-schema/alternate-empty.json
> > index fff15baf16..db54405240 100644
> > --- a/tests/qapi-schema/alternate-empty.json
> > +++ b/tests/qapi-schema/alternate-empty.json
> > @@ -1,2 +1,6 @@
> >  # alternates must list at least two types to be useful
> > +
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt', 'data': { 'i': 'int' } }
> > diff --git a/tests/qapi-schema/alternate-nested.err
> > b/tests/qapi-schema/alternate-nested.err
> > index 4d1187e60e..1804ffbf47 100644
> > --- a/tests/qapi-schema/alternate-nested.err
> > +++ b/tests/qapi-schema/alternate-nested.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternat=
e
> > 'Alt2' cannot use alternate type 'Alt1'
> > +tests/qapi-schema/alternate-nested.json:11: Member 'nested' of alterna=
te
> > 'Alt2' cannot use alternate type 'Alt1'
> > diff --git a/tests/qapi-schema/alternate-nested.json
> > b/tests/qapi-schema/alternate-nested.json
> > index 8e22186491..9f83ebe2e0 100644
> > --- a/tests/qapi-schema/alternate-nested.json
> > +++ b/tests/qapi-schema/alternate-nested.json
> > @@ -1,5 +1,12 @@
> >  # we reject a nested alternate branch
> > +
> > +##
> > +# @Alt1:
> > +##
> >  { 'alternate': 'Alt1',
> >    'data': { 'name': 'str', 'value': 'int' } }
> > +##
> > +# @Alt2:
> > +##
> >  { 'alternate': 'Alt2',
> >    'data': { 'nested': 'Alt1', 'b': 'bool' } }
> > diff --git a/tests/qapi-schema/alternate-unknown.err
> > b/tests/qapi-schema/alternate-unknown.err
> > index dea45dc730..cf5b9b6830 100644
> > --- a/tests/qapi-schema/alternate-unknown.err
> > +++ b/tests/qapi-schema/alternate-unknown.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of altern=
ate
> > 'Alt' uses unknown type 'MissingType'
> > +tests/qapi-schema/alternate-unknown.json:6: Member 'unknown' of altern=
ate
> > 'Alt' uses unknown type 'MissingType'
> > diff --git a/tests/qapi-schema/alternate-unknown.json
> > b/tests/qapi-schema/alternate-unknown.json
> > index 08c80dced0..941ba1fac4 100644
> > --- a/tests/qapi-schema/alternate-unknown.json
> > +++ b/tests/qapi-schema/alternate-unknown.json
> > @@ -1,3 +1,7 @@
> >  # we reject an alternate with unknown type in branch
> > +
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt',
> >    'data': { 'unknown': 'MissingType', 'i': 'int' } }
> > diff --git a/tests/qapi-schema/args-alternate.err
> > b/tests/qapi-schema/args-alternate.err
> > index 3086eae56b..2e6bf54245 100644
> > --- a/tests/qapi-schema/args-alternate.err
> > +++ b/tests/qapi-schema/args-alternate.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' can=
not
> > use alternate type 'Alt'
> > +tests/qapi-schema/args-alternate.json:11: 'data' for command 'oops' ca=
nnot
> > use alternate type 'Alt'
> > diff --git a/tests/qapi-schema/args-alternate.json
> > b/tests/qapi-schema/args-alternate.json
> > index 69e94d4819..49d0211a03 100644
> > --- a/tests/qapi-schema/args-alternate.json
> > +++ b/tests/qapi-schema/args-alternate.json
> > @@ -1,3 +1,11 @@
> >  # we do not allow alternate arguments
> > +
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt', 'data': { 'case1': 'int', 'case2': 'str' } }
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': 'Alt' }
> > diff --git a/tests/qapi-schema/args-any.err
> > b/tests/qapi-schema/args-any.err
> > index bf9b5e0730..955504b10f 100644
> > --- a/tests/qapi-schema/args-any.err
> > +++ b/tests/qapi-schema/args-any.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot us=
e
> > built-in type 'any'
> > +tests/qapi-schema/args-any.json:6: 'data' for command 'oops' cannot us=
e
> > built-in type 'any'
> > diff --git a/tests/qapi-schema/args-any.json
> > b/tests/qapi-schema/args-any.json
> > index 58fe5e470e..f494479cc9 100644
> > --- a/tests/qapi-schema/args-any.json
> > +++ b/tests/qapi-schema/args-any.json
> > @@ -1,2 +1,6 @@
> >  # we do not allow an 'any' argument
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': 'any' }
> > diff --git a/tests/qapi-schema/args-array-empty.err
> > b/tests/qapi-schema/args-array-empty.err
> > index cb7ed33b3f..e85f7918ab 100644
> > --- a/tests/qapi-schema/args-array-empty.err
> > +++ b/tests/qapi-schema/args-array-empty.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' fo=
r
> > command 'oops': array type must contain single type name
> > +tests/qapi-schema/args-array-empty.json:6: Member 'empty' of 'data' fo=
r
> > command 'oops': array type must contain single type name
> > diff --git a/tests/qapi-schema/args-array-empty.json
> > b/tests/qapi-schema/args-array-empty.json
> > index 652dcfb24a..78a0b88221 100644
> > --- a/tests/qapi-schema/args-array-empty.json
> > +++ b/tests/qapi-schema/args-array-empty.json
> > @@ -1,2 +1,6 @@
> >  # we reject an array for data if it does not contain a known type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': { 'empty': [ ] } }
> > diff --git a/tests/qapi-schema/args-array-unknown.err
> > b/tests/qapi-schema/args-array-unknown.err
> > index cd7a0f98d7..77788de099 100644
> > --- a/tests/qapi-schema/args-array-unknown.err
> > +++ b/tests/qapi-schema/args-array-unknown.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' =
for
> > command 'oops' uses unknown type 'NoSuchType'
> > +tests/qapi-schema/args-array-unknown.json:6: Member 'array' of 'data' =
for
> > command 'oops' uses unknown type 'NoSuchType'
> > diff --git a/tests/qapi-schema/args-array-unknown.json
> > b/tests/qapi-schema/args-array-unknown.json
> > index 6f3e883315..f680fc10d3 100644
> > --- a/tests/qapi-schema/args-array-unknown.json
> > +++ b/tests/qapi-schema/args-array-unknown.json
> > @@ -1,2 +1,6 @@
> >  # we reject an array for data if it does not contain a known type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': { 'array': [ 'NoSuchType' ] } }
> > diff --git a/tests/qapi-schema/args-bad-boxed.err
> > b/tests/qapi-schema/args-bad-boxed.err
> > index ad0d417321..87a906137a 100644
> > --- a/tests/qapi-schema/args-bad-boxed.err
> > +++ b/tests/qapi-schema/args-bad-boxed.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-bad-boxed.json:2: 'boxed' of command 'foo' shou=
ld
> > only use true value
> > +tests/qapi-schema/args-bad-boxed.json:6: 'boxed' of command 'foo' shou=
ld
> > only use true value
> > diff --git a/tests/qapi-schema/args-bad-boxed.json
> > b/tests/qapi-schema/args-bad-boxed.json
> > index dea0cd0aa5..4c0b28f291 100644
> > --- a/tests/qapi-schema/args-bad-boxed.json
> > +++ b/tests/qapi-schema/args-bad-boxed.json
> > @@ -1,2 +1,6 @@
> >  # 'boxed' should only appear with value true
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'boxed': false }
> > diff --git a/tests/qapi-schema/args-boxed-anon.err
> > b/tests/qapi-schema/args-boxed-anon.err
> > index f24f345218..3cfac0b923 100644
> > --- a/tests/qapi-schema/args-boxed-anon.err
> > +++ b/tests/qapi-schema/args-boxed-anon.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' sho=
uld
> > be a type name
> > +tests/qapi-schema/args-boxed-anon.json:6: 'data' for command 'foo' sho=
uld
> > be a type name
> > diff --git a/tests/qapi-schema/args-boxed-anon.json
> > b/tests/qapi-schema/args-boxed-anon.json
> > index 95f60da2ed..2358e6abb1 100644
> > --- a/tests/qapi-schema/args-boxed-anon.json
> > +++ b/tests/qapi-schema/args-boxed-anon.json
> > @@ -1,2 +1,6 @@
> >  # 'boxed' can only be used with named types
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'boxed': true, 'data': { 'string': 'str' } }
> > diff --git a/tests/qapi-schema/args-boxed-empty.err
> > b/tests/qapi-schema/args-boxed-empty.err
> > index 039603e85c..963f495a9d 100644
> > --- a/tests/qapi-schema/args-boxed-empty.err
> > +++ b/tests/qapi-schema/args-boxed-empty.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-boxed-empty.json:3: Cannot use 'boxed' with emp=
ty
> > type
> > +tests/qapi-schema/args-boxed-empty.json:11: Cannot use 'boxed' with em=
pty
> > type
> > diff --git a/tests/qapi-schema/args-boxed-empty.json
> > b/tests/qapi-schema/args-boxed-empty.json
> > index 52717e065f..8e8cc26525 100644
> > --- a/tests/qapi-schema/args-boxed-empty.json
> > +++ b/tests/qapi-schema/args-boxed-empty.json
> > @@ -1,3 +1,11 @@
> >  # 'boxed' requires a non-empty type
> > +
> > +##
> > +# @Empty:
> > +##
> >  { 'struct': 'Empty', 'data': {} }
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'boxed': true, 'data': 'Empty' }
> > diff --git a/tests/qapi-schema/args-boxed-string.err
> > b/tests/qapi-schema/args-boxed-string.err
> > index d326b48aef..7623755208 100644
> > --- a/tests/qapi-schema/args-boxed-string.err
> > +++ b/tests/qapi-schema/args-boxed-string.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo'
> > cannot use built-in type 'str'
> > +tests/qapi-schema/args-boxed-string.json:6: 'data' for command 'foo'
> > cannot use built-in type 'str'
> > diff --git a/tests/qapi-schema/args-boxed-string.json
> > b/tests/qapi-schema/args-boxed-string.json
> > index f91a1502e7..aecdf97ce9 100644
> > --- a/tests/qapi-schema/args-boxed-string.json
> > +++ b/tests/qapi-schema/args-boxed-string.json
> > @@ -1,2 +1,6 @@
> >  # 'boxed' requires a complex (not built-in) type
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'boxed': true, 'data': 'str' }
> > diff --git a/tests/qapi-schema/args-int.err
> > b/tests/qapi-schema/args-int.err
> > index dc1d2504ff..38b3202b09 100644
> > --- a/tests/qapi-schema/args-int.err
> > +++ b/tests/qapi-schema/args-int.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot us=
e
> > built-in type 'int'
> > +tests/qapi-schema/args-int.json:6: 'data' for command 'oops' cannot us=
e
> > built-in type 'int'
> > diff --git a/tests/qapi-schema/args-int.json
> > b/tests/qapi-schema/args-int.json
> > index a334d92e8c..7f4e1b7aa6 100644
> > --- a/tests/qapi-schema/args-int.json
> > +++ b/tests/qapi-schema/args-int.json
> > @@ -1,2 +1,6 @@
> >  # we reject commands where data is not an array or complex type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': 'int' }
> > diff --git a/tests/qapi-schema/args-invalid.err
> > b/tests/qapi-schema/args-invalid.err
> > index fe1e94975b..5d3568d7c3 100644
> > --- a/tests/qapi-schema/args-invalid.err
> > +++ b/tests/qapi-schema/args-invalid.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should=
 be
> > a dictionary or type name
> > +tests/qapi-schema/args-invalid.json:4: 'data' for command 'foo' should=
 be
> > a dictionary or type name
> > diff --git a/tests/qapi-schema/args-invalid.json
> > b/tests/qapi-schema/args-invalid.json
> > index db0981341b..1a7e63bb23 100644
> > --- a/tests/qapi-schema/args-invalid.json
> > +++ b/tests/qapi-schema/args-invalid.json
> > @@ -1,2 +1,5 @@
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo',
> >    'data': false }
> > diff --git a/tests/qapi-schema/args-member-array-bad.err
> > b/tests/qapi-schema/args-member-array-bad.err
> > index 881b4d954f..825ffca9bf 100644
> > --- a/tests/qapi-schema/args-member-array-bad.err
> > +++ b/tests/qapi-schema/args-member-array-bad.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'da=
ta'
> > for command 'oops': array type must contain single type name
> > +tests/qapi-schema/args-member-array-bad.json:6: Member 'member' of 'da=
ta'
> > for command 'oops': array type must contain single type name
> > diff --git a/tests/qapi-schema/args-member-array-bad.json
> > b/tests/qapi-schema/args-member-array-bad.json
> > index b2ff144ec6..e934f5c457 100644
> > --- a/tests/qapi-schema/args-member-array-bad.json
> > +++ b/tests/qapi-schema/args-member-array-bad.json
> > @@ -1,2 +1,6 @@
> >  # we reject data if it does not contain a valid array type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': { 'member': [ { 'nested': 'str' } ] } }
> > diff --git a/tests/qapi-schema/args-member-case.err
> > b/tests/qapi-schema/args-member-case.err
> > index 19c4426601..a3fb2bdd60 100644
> > --- a/tests/qapi-schema/args-member-case.err
> > +++ b/tests/qapi-schema/args-member-case.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-member-case.json:2: 'Arg' (parameter of
> > no-way-this-will-get-whitelisted) should not use uppercase
> > +tests/qapi-schema/args-member-case.json:6: 'Arg' (parameter of
> > no-way-this-will-get-whitelisted) should not use uppercase
> > diff --git a/tests/qapi-schema/args-member-case.json
> > b/tests/qapi-schema/args-member-case.json
> > index 93439bee8b..811e658d66 100644
> > --- a/tests/qapi-schema/args-member-case.json
> > +++ b/tests/qapi-schema/args-member-case.json
> > @@ -1,2 +1,6 @@
> >  # Member names should be 'lower-case' unless the struct/command is
> >  whitelisted
> > +
> > +##
> > +# @no-way-this-will-get-whitelisted:
> > +##
> >  { 'command': 'no-way-this-will-get-whitelisted', 'data': { 'Arg': 'int=
' }
> >  }
> > diff --git a/tests/qapi-schema/args-member-unknown.err
> > b/tests/qapi-schema/args-member-unknown.err
> > index f6f82828ce..3db452b95a 100644
> > --- a/tests/qapi-schema/args-member-unknown.err
> > +++ b/tests/qapi-schema/args-member-unknown.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data=
'
> > for command 'oops' uses unknown type 'NoSuchType'
> > +tests/qapi-schema/args-member-unknown.json:6: Member 'member' of 'data=
'
> > for command 'oops' uses unknown type 'NoSuchType'
> > diff --git a/tests/qapi-schema/args-member-unknown.json
> > b/tests/qapi-schema/args-member-unknown.json
> > index 342a41ec90..e2fef9c46f 100644
> > --- a/tests/qapi-schema/args-member-unknown.json
> > +++ b/tests/qapi-schema/args-member-unknown.json
> > @@ -1,2 +1,6 @@
> >  # we reject data if it does not contain a known type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': { 'member': 'NoSuchType' } }
> > diff --git a/tests/qapi-schema/args-name-clash.err
> > b/tests/qapi-schema/args-name-clash.err
> > index d953e8d241..23988cb5ca 100644
> > --- a/tests/qapi-schema/args-name-clash.err
> > +++ b/tests/qapi-schema/args-name-clash.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops)
> > collides with 'a-b' (parameter of oops)
> > +tests/qapi-schema/args-name-clash.json:8: 'a_b' (parameter of oops)
> > collides with 'a-b' (parameter of oops)
> > diff --git a/tests/qapi-schema/args-name-clash.json
> > b/tests/qapi-schema/args-name-clash.json
> > index 61423cb893..991323b78d 100644
> > --- a/tests/qapi-schema/args-name-clash.json
> > +++ b/tests/qapi-schema/args-name-clash.json
> > @@ -1,4 +1,8 @@
> >  # C member name collision
> >  # Reject members that clash when mapped to C names (we would have two
> >  'a_b'
> >  # members).
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': { 'a-b': 'str', 'a_b': 'str' } }
> > diff --git a/tests/qapi-schema/args-union.err
> > b/tests/qapi-schema/args-union.err
> > index f8ad223dde..ce0a34e16c 100644
> > --- a/tests/qapi-schema/args-union.err
> > +++ b/tests/qapi-schema/args-union.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot =
use
> > union type 'Uni'
> > +tests/qapi-schema/args-union.json:10: 'data' for command 'oops' cannot=
 use
> > union type 'Uni'
> > diff --git a/tests/qapi-schema/args-union.json
> > b/tests/qapi-schema/args-union.json
> > index 2fcaeaae16..57284b43c5 100644
> > --- a/tests/qapi-schema/args-union.json
> > +++ b/tests/qapi-schema/args-union.json
> > @@ -1,3 +1,10 @@
> >  # use of union arguments requires 'boxed':true
> > +
> > +##
> > +# @Uni:
> > +##
> >  { 'union': 'Uni', 'data': { 'case1': 'int', 'case2': 'str' } }
> > +##
> > +# oops:
> > +##
> >  { 'command': 'oops', 'data': 'Uni' }
> > diff --git a/tests/qapi-schema/args-unknown.err
> > b/tests/qapi-schema/args-unknown.err
> > index 4d91ec869f..ba6c6cf326 100644
> > --- a/tests/qapi-schema/args-unknown.err
> > +++ b/tests/qapi-schema/args-unknown.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses
> > unknown type 'NoSuchType'
> > +tests/qapi-schema/args-unknown.json:6: 'data' for command 'oops' uses
> > unknown type 'NoSuchType'
> > diff --git a/tests/qapi-schema/args-unknown.json
> > b/tests/qapi-schema/args-unknown.json
> > index 32aba43b3f..12666dc020 100644
> > --- a/tests/qapi-schema/args-unknown.json
> > +++ b/tests/qapi-schema/args-unknown.json
> > @@ -1,2 +1,6 @@
> >  # we reject data if it does not contain a known type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': 'NoSuchType' }
> > diff --git a/tests/qapi-schema/bad-base.err
> > b/tests/qapi-schema/bad-base.err
> > index 154274bdd3..e668761c65 100644
> > --- a/tests/qapi-schema/bad-base.err
> > +++ b/tests/qapi-schema/bad-base.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot u=
se
> > union type 'Union'
> > +tests/qapi-schema/bad-base.json:10: 'base' for struct 'MyType' cannot =
use
> > union type 'Union'
> > diff --git a/tests/qapi-schema/bad-base.json
> > b/tests/qapi-schema/bad-base.json
> > index a634331cdd..c3faa8242b 100644
> > --- a/tests/qapi-schema/bad-base.json
> > +++ b/tests/qapi-schema/bad-base.json
> > @@ -1,3 +1,10 @@
> >  # we reject a base that is not a struct
> > +
> > +##
> > +# @Union:
> > +##
> >  { 'union': 'Union', 'data': { 'a': 'int', 'b': 'str' } }
> > +##
> > +# @MyType:
> > +##
> >  { 'struct': 'MyType', 'base': 'Union', 'data': { 'c': 'int' } }
> > diff --git a/tests/qapi-schema/bad-data.err
> > b/tests/qapi-schema/bad-data.err
> > index 8523ac4f46..c1b9e35313 100644
> > --- a/tests/qapi-schema/bad-data.err
> > +++ b/tests/qapi-schema/bad-data.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be=
 an
> > array
> > +tests/qapi-schema/bad-data.json:6: 'data' for command 'oops' cannot be=
 an
> > array
> > diff --git a/tests/qapi-schema/bad-data.json
> > b/tests/qapi-schema/bad-data.json
> > index 832eeb76f4..51c444f4f8 100644
> > --- a/tests/qapi-schema/bad-data.json
> > +++ b/tests/qapi-schema/bad-data.json
> > @@ -1,2 +1,6 @@
> >  # we ensure 'data' is a dictionary for all but enums
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': [ ] }
> > diff --git a/tests/qapi-schema/bad-ident.err
> > b/tests/qapi-schema/bad-ident.err
> > index c4190602b5..b757aa21e7 100644
> > --- a/tests/qapi-schema/bad-ident.err
> > +++ b/tests/qapi-schema/bad-ident.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional n=
ame
> > '*oops'
> > +tests/qapi-schema/bad-ident.json:6: 'struct' does not allow optional n=
ame
> > '*oops'
> > diff --git a/tests/qapi-schema/bad-ident.json
> > b/tests/qapi-schema/bad-ident.json
> > index 763627ad23..b43df7a3e0 100644
> > --- a/tests/qapi-schema/bad-ident.json
> > +++ b/tests/qapi-schema/bad-ident.json
> > @@ -1,2 +1,6 @@
> >  # we reject creating a type name with bad name
> > +
> > +##
> > +# @*oops:
> > +##
> >  { 'struct': '*oops', 'data': { 'i': 'int' } }
> > diff --git a/tests/qapi-schema/bad-type-bool.err
> > b/tests/qapi-schema/bad-type-bool.err
> > index 62fd70baaf..72e026b46c 100644
> > --- a/tests/qapi-schema/bad-type-bool.err
> > +++ b/tests/qapi-schema/bad-type-bool.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/bad-type-bool.json:2: 'struct' key must have a strin=
g
> > value
> > +tests/qapi-schema/bad-type-bool.json:6: 'struct' key must have a strin=
g
> > value
> > diff --git a/tests/qapi-schema/bad-type-bool.json
> > b/tests/qapi-schema/bad-type-bool.json
> > index bde17b56c4..1f9eddf938 100644
> > --- a/tests/qapi-schema/bad-type-bool.json
> > +++ b/tests/qapi-schema/bad-type-bool.json
> > @@ -1,2 +1,6 @@
> >  # we reject an expression with a metatype that is not a string
> > +
> > +##
> > +# @true:
> > +##
> >  { 'struct': true, 'data': { } }
> > diff --git a/tests/qapi-schema/bad-type-dict.err
> > b/tests/qapi-schema/bad-type-dict.err
> > index 0b2a2aeac4..d0d1f607e5 100644
> > --- a/tests/qapi-schema/bad-type-dict.err
> > +++ b/tests/qapi-schema/bad-type-dict.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/bad-type-dict.json:2: 'command' key must have a stri=
ng
> > value
> > +tests/qapi-schema/bad-type-dict.json:6: 'command' key must have a stri=
ng
> > value
> > diff --git a/tests/qapi-schema/bad-type-dict.json
> > b/tests/qapi-schema/bad-type-dict.json
> > index 2a91b241f8..5952caab28 100644
> > --- a/tests/qapi-schema/bad-type-dict.json
> > +++ b/tests/qapi-schema/bad-type-dict.json
> > @@ -1,2 +1,6 @@
> >  # we reject an expression with a metatype that is not a string
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': { } }
> > diff --git a/tests/qapi-schema/base-cycle-direct.err
> > b/tests/qapi-schema/base-cycle-direct.err
> > index 9c68f6543d..dd7f5aace6 100644
> > --- a/tests/qapi-schema/base-cycle-direct.err
> > +++ b/tests/qapi-schema/base-cycle-direct.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itse=
lf
> > +tests/qapi-schema/base-cycle-direct.json:6: Object Loopy contains itse=
lf
> > diff --git a/tests/qapi-schema/base-cycle-direct.json
> > b/tests/qapi-schema/base-cycle-direct.json
> > index 4fc66d0516..9780f7e2ca 100644
> > --- a/tests/qapi-schema/base-cycle-direct.json
> > +++ b/tests/qapi-schema/base-cycle-direct.json
> > @@ -1,2 +1,6 @@
> >  # we reject a loop in base classes
> > +
> > +##
> > +# @Loopy:
> > +##
> >  { 'struct': 'Loopy', 'base': 'Loopy', 'data': {} }
> > diff --git a/tests/qapi-schema/base-cycle-indirect.err
> > b/tests/qapi-schema/base-cycle-indirect.err
> > index fc92fe47f8..f4198e4a40 100644
> > --- a/tests/qapi-schema/base-cycle-indirect.err
> > +++ b/tests/qapi-schema/base-cycle-indirect.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains it=
self
> > +tests/qapi-schema/base-cycle-indirect.json:6: Object Base1 contains it=
self
> > diff --git a/tests/qapi-schema/base-cycle-indirect.json
> > b/tests/qapi-schema/base-cycle-indirect.json
> > index 28667721a3..99926c4609 100644
> > --- a/tests/qapi-schema/base-cycle-indirect.json
> > +++ b/tests/qapi-schema/base-cycle-indirect.json
> > @@ -1,3 +1,10 @@
> >  # we reject a loop in base classes
> > +
> > +##
> > +# @Base1:
> > +##
> >  { 'struct': 'Base1', 'base': 'Base2', 'data': {} }
> > +##
> > +# @Base2:
> > +##
> >  { 'struct': 'Base2', 'base': 'Base1', 'data': {} }
> > diff --git a/tests/qapi-schema/command-int.err
> > b/tests/qapi-schema/command-int.err
> > index 0f9300679b..3c834a97ab 100644
> > --- a/tests/qapi-schema/command-int.err
> > +++ b/tests/qapi-schema/command-int.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/command-int.json:2: built-in 'int' is already define=
d
> > +tests/qapi-schema/command-int.json:6: built-in 'int' is already define=
d
> > diff --git a/tests/qapi-schema/command-int.json
> > b/tests/qapi-schema/command-int.json
> > index 9a62554fc6..5b51bf148b 100644
> > --- a/tests/qapi-schema/command-int.json
> > +++ b/tests/qapi-schema/command-int.json
> > @@ -1,2 +1,6 @@
> >  # we reject collisions between commands and types
> > +
> > +##
> > +# @int:
> > +##
> >  { 'command': 'int', 'data': { 'character': 'str' } }
> > diff --git a/tests/qapi-schema/comments.json
> > b/tests/qapi-schema/comments.json
> > index e643f3a74c..d31ef0d90a 100644
> > --- a/tests/qapi-schema/comments.json
> > +++ b/tests/qapi-schema/comments.json
> > @@ -1,4 +1,8 @@
> >  # Unindented comment
> > +
> > +##
> > +# @Status:
> > +##
> >  { 'enum': 'Status',             # Comment to the right of code
> >    # Indented comment
> >    'data': [ 'good', 'bad', 'ugly' ] }
> > diff --git a/tests/qapi-schema/comments.out
> > b/tests/qapi-schema/comments.out
> > index 5d7c13cad1..ab3d74f49f 100644
> > --- a/tests/qapi-schema/comments.out
> > +++ b/tests/qapi-schema/comments.out
> > @@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict'=
,
> > 'qlist', 'qfloat', 'qbo
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > +doc symbol=3DStatus expr=3D('enum', 'Status')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/doc-bad-args.err
> > b/tests/qapi-schema/doc-bad-args.err
> > new file mode 100644
> > index 0000000000..13e67597ed
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-args.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-bad-args.json:3: Members documentation is not a
> > subset of API ['a', 'b'] > ['a']
> > diff --git a/tests/qapi-schema/doc-bad-args.exit
> > b/tests/qapi-schema/doc-bad-args.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-args.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-bad-args.json
> > b/tests/qapi-schema/doc-bad-args.json
> > new file mode 100644
> > index 0000000000..048e0fc5ef
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-args.json
> > @@ -0,0 +1,8 @@
> > +# Arguments listed in the doc comment must exist in the actual schema
> > +
> > +##
> > +# @foo:
> > +# @a: a
> > +# @b: b
> > +##
> > +{ 'command': 'foo', 'data': {'a': 'int'} }
> > diff --git a/tests/qapi-schema/doc-bad-args.out
> > b/tests/qapi-schema/doc-bad-args.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-bad-section.err
> > b/tests/qapi-schema/doc-bad-section.err
> > new file mode 100644
> > index 0000000000..24104dd3be
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-section.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-bad-section.json:13:1: Invalid section indentati=
on
> > diff --git a/tests/qapi-schema/doc-bad-section.exit
> > b/tests/qapi-schema/doc-bad-section.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-section.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-bad-section.json
> > b/tests/qapi-schema/doc-bad-section.json
> > new file mode 100644
> > index 0000000000..87a6e02ae9
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-section.json
> > @@ -0,0 +1,19 @@
> > +# Comment body must be only at the top of the section
> > +
> > +##
> > +# @TestStruct:
> > +#
> > +# body with @var
> > +#
> > +# @integer: foo
> > +#           blah
> > +#
> > +#           bao
> > +#
> > +# Let's catch this bad comment.
> > +#
> > +# Since: 2.3
> > +#
> > +##
> > +{ 'struct': 'TestStruct',
> > +  'data': { 'integer': 'int' } }
> > diff --git a/tests/qapi-schema/doc-bad-section.out
> > b/tests/qapi-schema/doc-bad-section.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-bad-symbol.err
> > b/tests/qapi-schema/doc-bad-symbol.err
> > new file mode 100644
> > index 0000000000..ac4e5667cb
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-symbol.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-bad-symbol.json:3: Definition of 'foo' follows
> > documentation for 'food'
> > diff --git a/tests/qapi-schema/doc-bad-symbol.exit
> > b/tests/qapi-schema/doc-bad-symbol.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-symbol.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-bad-symbol.json
> > b/tests/qapi-schema/doc-bad-symbol.json
> > new file mode 100644
> > index 0000000000..a7c15b3b8f
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-bad-symbol.json
> > @@ -0,0 +1,6 @@
> > +# Documentation symbol mismatch with expression
> > +
> > +##
> > +# @food:
> > +##
> > +{ 'command': 'foo', 'data': {'a': 'int'} }
> > diff --git a/tests/qapi-schema/doc-bad-symbol.out
> > b/tests/qapi-schema/doc-bad-symbol.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-duplicated-arg.err
> > b/tests/qapi-schema/doc-duplicated-arg.err
> > new file mode 100644
> > index 0000000000..1c3f8e0a54
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-arg.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-duplicated-arg.json:6:1: 'a' parameter name
> > duplicated
> > diff --git a/tests/qapi-schema/doc-duplicated-arg.exit
> > b/tests/qapi-schema/doc-duplicated-arg.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-arg.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-duplicated-arg.json
> > b/tests/qapi-schema/doc-duplicated-arg.json
> > new file mode 100644
> > index 0000000000..035cae9745
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-arg.json
> > @@ -0,0 +1,7 @@
> > +# Do not allow duplicated argument
> > +
> > +##
> > +# @foo:
> > +# @a:
> > +# @a:
> > +##
> > diff --git a/tests/qapi-schema/doc-duplicated-arg.out
> > b/tests/qapi-schema/doc-duplicated-arg.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-duplicated-return.err
> > b/tests/qapi-schema/doc-duplicated-return.err
> > new file mode 100644
> > index 0000000000..e48039f8e5
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-return.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-duplicated-return.json:7:1: Duplicated 'Returns'
> > section
> > diff --git a/tests/qapi-schema/doc-duplicated-return.exit
> > b/tests/qapi-schema/doc-duplicated-return.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-return.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-duplicated-return.json
> > b/tests/qapi-schema/doc-duplicated-return.json
> > new file mode 100644
> > index 0000000000..b44b5ae979
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-return.json
> > @@ -0,0 +1,8 @@
> > +# Do not allow duplicated Returns section
> > +
> > +##
> > +# @foo:
> > +#
> > +# Returns: 0
> > +# Returns: 1
> > +##
> > diff --git a/tests/qapi-schema/doc-duplicated-return.out
> > b/tests/qapi-schema/doc-duplicated-return.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-duplicated-since.err
> > b/tests/qapi-schema/doc-duplicated-since.err
> > new file mode 100644
> > index 0000000000..3fb890744a
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-since.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-duplicated-since.json:7:1: Duplicated 'Since'
> > section
> > diff --git a/tests/qapi-schema/doc-duplicated-since.exit
> > b/tests/qapi-schema/doc-duplicated-since.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-since.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-duplicated-since.json
> > b/tests/qapi-schema/doc-duplicated-since.json
> > new file mode 100644
> > index 0000000000..343cd872cb
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-duplicated-since.json
> > @@ -0,0 +1,8 @@
> > +# Do not allow duplicated Since section
> > +
> > +##
> > +# @foo:
> > +#
> > +# Since: 0
> > +# Since: 1
> > +##
> > diff --git a/tests/qapi-schema/doc-duplicated-since.out
> > b/tests/qapi-schema/doc-duplicated-since.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-empty-arg.err
> > b/tests/qapi-schema/doc-empty-arg.err
> > new file mode 100644
> > index 0000000000..2895518fa7
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-arg.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-empty-arg.json:5:1: Invalid parameter name
> > diff --git a/tests/qapi-schema/doc-empty-arg.exit
> > b/tests/qapi-schema/doc-empty-arg.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-arg.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-empty-arg.json
> > b/tests/qapi-schema/doc-empty-arg.json
> > new file mode 100644
> > index 0000000000..8f76ede8f3
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-arg.json
> > @@ -0,0 +1,6 @@
> > +# An invalid empty argument name
> > +
> > +##
> > +# @foo:
> > +# @:
> > +##
> > diff --git a/tests/qapi-schema/doc-empty-arg.out
> > b/tests/qapi-schema/doc-empty-arg.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-empty-section.err
> > b/tests/qapi-schema/doc-empty-section.err
> > new file mode 100644
> > index 0000000000..00ad625e17
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-section.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-empty-section.json:3: Empty doc section 'Note'
> > diff --git a/tests/qapi-schema/doc-empty-section.exit
> > b/tests/qapi-schema/doc-empty-section.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-section.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-empty-section.json
> > b/tests/qapi-schema/doc-empty-section.json
> > new file mode 100644
> > index 0000000000..f3384e9a3b
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-section.json
> > @@ -0,0 +1,8 @@
> > +# Tagged-section must not be empty
> > +
> > +##
> > +# @foo:
> > +#
> > +# Note:
> > +##
> > +{ 'command': 'foo', 'data': {'a': 'int'} }
> > diff --git a/tests/qapi-schema/doc-empty-section.out
> > b/tests/qapi-schema/doc-empty-section.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-empty-symbol.err
> > b/tests/qapi-schema/doc-empty-symbol.err
> > new file mode 100644
> > index 0000000000..1936ad094f
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-symbol.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-empty-symbol.json:4:1: Invalid name
> > diff --git a/tests/qapi-schema/doc-empty-symbol.exit
> > b/tests/qapi-schema/doc-empty-symbol.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-symbol.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-empty-symbol.json
> > b/tests/qapi-schema/doc-empty-symbol.json
> > new file mode 100644
> > index 0000000000..fb8fddc4ae
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-empty-symbol.json
> > @@ -0,0 +1,5 @@
> > +# Invalid documentation symbol
> > +
> > +##
> > +# @:
> > +##
> > diff --git a/tests/qapi-schema/doc-empty-symbol.out
> > b/tests/qapi-schema/doc-empty-symbol.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-invalid-end.err
> > b/tests/qapi-schema/doc-invalid-end.err
> > new file mode 100644
> > index 0000000000..2bda28cb54
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-end.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-invalid-end.json:5:2: Documentation comment must=
 end
> > with '##'
> > diff --git a/tests/qapi-schema/doc-invalid-end.exit
> > b/tests/qapi-schema/doc-invalid-end.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-end.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-invalid-end.json
> > b/tests/qapi-schema/doc-invalid-end.json
> > new file mode 100644
> > index 0000000000..3583b23b18
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-end.json
> > @@ -0,0 +1,5 @@
> > +# Documentation must end with '##'
> > +
> > +##
> > +# An invalid comment
> > +#
> > diff --git a/tests/qapi-schema/doc-invalid-end.out
> > b/tests/qapi-schema/doc-invalid-end.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-invalid-end2.err
> > b/tests/qapi-schema/doc-invalid-end2.err
> > new file mode 100644
> > index 0000000000..6fad9c789e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-end2.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-invalid-end2.json:5:1: Junk after '##' at end of
> > documentation comment
> > diff --git a/tests/qapi-schema/doc-invalid-end2.exit
> > b/tests/qapi-schema/doc-invalid-end2.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-end2.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-invalid-end2.json
> > b/tests/qapi-schema/doc-invalid-end2.json
> > new file mode 100644
> > index 0000000000..fa2d39d7c2
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-end2.json
> > @@ -0,0 +1,5 @@
> > +# Documentation must end with '##'
> > +
> > +##
> > +#
> > +## invalid
> > diff --git a/tests/qapi-schema/doc-invalid-end2.out
> > b/tests/qapi-schema/doc-invalid-end2.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-invalid-return.err
> > b/tests/qapi-schema/doc-invalid-return.err
> > new file mode 100644
> > index 0000000000..5aaba33bb4
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-return.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-invalid-return.json:3: 'Returns:' is only valid =
for
> > commands
> > diff --git a/tests/qapi-schema/doc-invalid-return.exit
> > b/tests/qapi-schema/doc-invalid-return.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-return.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-invalid-return.json
> > b/tests/qapi-schema/doc-invalid-return.json
> > new file mode 100644
> > index 0000000000..1ba45de414
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-return.json
> > @@ -0,0 +1,7 @@
> > +# Events can't have 'Returns' section
> > +
> > +##
> > +# @foo:
> > +# Returns: blah
> > +##
> > +{ 'event': 'foo' }
> > diff --git a/tests/qapi-schema/doc-invalid-return.out
> > b/tests/qapi-schema/doc-invalid-return.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-invalid-section.err
> > b/tests/qapi-schema/doc-invalid-section.err
> > new file mode 100644
> > index 0000000000..bd0505761f
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-section.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-invalid-section.json:3: Document body cannot con=
tain
> > @NAME: sections
> > diff --git a/tests/qapi-schema/doc-invalid-section.exit
> > b/tests/qapi-schema/doc-invalid-section.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-section.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-invalid-section.json
> > b/tests/qapi-schema/doc-invalid-section.json
> > new file mode 100644
> > index 0000000000..0578b8ae25
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-section.json
> > @@ -0,0 +1,6 @@
> > +# Free-form documentation doesn't have tagged-sections
> > +
> > +##
> > +# freeform
> > +# @note: foo
> > +##
> > diff --git a/tests/qapi-schema/doc-invalid-section.out
> > b/tests/qapi-schema/doc-invalid-section.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-invalid-start.err
> > b/tests/qapi-schema/doc-invalid-start.err
> > new file mode 100644
> > index 0000000000..149af2bfac
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-start.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-invalid-start.json:3:1: Junk after '##' at start=
 of
> > documentation comment
> > diff --git a/tests/qapi-schema/doc-invalid-start.exit
> > b/tests/qapi-schema/doc-invalid-start.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-start.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-invalid-start.json
> > b/tests/qapi-schema/doc-invalid-start.json
> > new file mode 100644
> > index 0000000000..4f6c15a38c
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-invalid-start.json
> > @@ -0,0 +1,5 @@
> > +# Documentation must start with '##'
> > +
> > +## invalid
> > +#
> > +##
> > diff --git a/tests/qapi-schema/doc-invalid-start.out
> > b/tests/qapi-schema/doc-invalid-start.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-missing-colon.err
> > b/tests/qapi-schema/doc-missing-colon.err
> > new file mode 100644
> > index 0000000000..817398b8e4
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-colon.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-missing-colon.json:4:1: Line should end with :
> > diff --git a/tests/qapi-schema/doc-missing-colon.exit
> > b/tests/qapi-schema/doc-missing-colon.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-colon.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-missing-colon.json
> > b/tests/qapi-schema/doc-missing-colon.json
> > new file mode 100644
> > index 0000000000..d88c06c6dd
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-colon.json
> > @@ -0,0 +1,5 @@
> > +# The symbol section must end with ':'
> > +
> > +##
> > +# @missing-colon
> > +##
> > diff --git a/tests/qapi-schema/doc-missing-colon.out
> > b/tests/qapi-schema/doc-missing-colon.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-missing-expr.err
> > b/tests/qapi-schema/doc-missing-expr.err
> > new file mode 100644
> > index 0000000000..c0e687cadd
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-expr.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-missing-expr.json:3: Documention for 'bar' is no=
t
> > followed by the definition
> > diff --git a/tests/qapi-schema/doc-missing-expr.exit
> > b/tests/qapi-schema/doc-missing-expr.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-expr.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-missing-expr.json
> > b/tests/qapi-schema/doc-missing-expr.json
> > new file mode 100644
> > index 0000000000..06ad7df8d6
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-expr.json
> > @@ -0,0 +1,5 @@
> > +# Expression documentation must be followed by the actual expression
> > +
> > +##
> > +# @bar:
> > +##
> > diff --git a/tests/qapi-schema/doc-missing-expr.out
> > b/tests/qapi-schema/doc-missing-expr.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/doc-missing-space.err
> > b/tests/qapi-schema/doc-missing-space.err
> > new file mode 100644
> > index 0000000000..d6b46ffd77
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-space.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/doc-missing-space.json:5:1: Missing space after #
> > diff --git a/tests/qapi-schema/doc-missing-space.exit
> > b/tests/qapi-schema/doc-missing-space.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-space.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/doc-missing-space.json
> > b/tests/qapi-schema/doc-missing-space.json
> > new file mode 100644
> > index 0000000000..beb276bc64
> > --- /dev/null
> > +++ b/tests/qapi-schema/doc-missing-space.json
> > @@ -0,0 +1,6 @@
> > +# Documentation line must have a leading space
> > +
> > +##
> > +# missing space:
> > +#wef
> > +##
> > diff --git a/tests/qapi-schema/doc-missing-space.out
> > b/tests/qapi-schema/doc-missing-space.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/double-type.err
> > b/tests/qapi-schema/double-type.err
> > index f9613c6d6b..424df9bedd 100644
> > --- a/tests/qapi-schema/double-type.err
> > +++ b/tests/qapi-schema/double-type.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct
> > 'bar'
> > +tests/qapi-schema/double-type.json:6: Unknown key 'command' in struct
> > 'bar'
> > diff --git a/tests/qapi-schema/double-type.json
> > b/tests/qapi-schema/double-type.json
> > index 911fa7af50..ab59523ff7 100644
> > --- a/tests/qapi-schema/double-type.json
> > +++ b/tests/qapi-schema/double-type.json
> > @@ -1,2 +1,6 @@
> >  # we reject an expression with ambiguous metatype
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'struct': 'bar', 'data': { } }
> > diff --git a/tests/qapi-schema/enum-bad-name.err
> > b/tests/qapi-schema/enum-bad-name.err
> > index 9c3c1002b7..157d1b0d69 100644
> > --- a/tests/qapi-schema/enum-bad-name.err
> > +++ b/tests/qapi-schema/enum-bad-name.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-bad-name.json:2: Member of enum 'MyEnum' uses
> > invalid name 'not^possible'
> > +tests/qapi-schema/enum-bad-name.json:6: Member of enum 'MyEnum' uses
> > invalid name 'not^possible'
> > diff --git a/tests/qapi-schema/enum-bad-name.json
> > b/tests/qapi-schema/enum-bad-name.json
> > index 8506562b31..978cb88994 100644
> > --- a/tests/qapi-schema/enum-bad-name.json
> > +++ b/tests/qapi-schema/enum-bad-name.json
> > @@ -1,2 +1,6 @@
> >  # we ensure all enum names can map to C
> > +
> > +##
> > +# @MyEnum:
> > +##
> >  { 'enum': 'MyEnum', 'data': [ 'not^possible' ] }
> > diff --git a/tests/qapi-schema/enum-bad-prefix.err
> > b/tests/qapi-schema/enum-bad-prefix.err
> > index 399f5f7af5..918915f7ab 100644
> > --- a/tests/qapi-schema/enum-bad-prefix.err
> > +++ b/tests/qapi-schema/enum-bad-prefix.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a str=
ing
> > for 'prefix'
> > +tests/qapi-schema/enum-bad-prefix.json:6: Enum 'MyEnum' requires a str=
ing
> > for 'prefix'
> > diff --git a/tests/qapi-schema/enum-bad-prefix.json
> > b/tests/qapi-schema/enum-bad-prefix.json
> > index 996f628f6d..25f17a7b08 100644
> > --- a/tests/qapi-schema/enum-bad-prefix.json
> > +++ b/tests/qapi-schema/enum-bad-prefix.json
> > @@ -1,2 +1,6 @@
> >  # The prefix must be a string type
> > +
> > +##
> > +# @MyEnum:
> > +##
> >  { 'enum': 'MyEnum', 'data': [ 'one' ], 'prefix': [ 'fish' ] }
> > diff --git a/tests/qapi-schema/enum-clash-member.err
> > b/tests/qapi-schema/enum-clash-member.err
> > index 5403c78507..25249b63c4 100644
> > --- a/tests/qapi-schema/enum-clash-member.err
> > +++ b/tests/qapi-schema/enum-clash-member.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-clash-member.json:2: 'one_two' (member of MyEnu=
m)
> > collides with 'one-two' (member of MyEnum)
> > +tests/qapi-schema/enum-clash-member.json:6: 'one_two' (member of MyEnu=
m)
> > collides with 'one-two' (member of MyEnum)
> > diff --git a/tests/qapi-schema/enum-clash-member.json
> > b/tests/qapi-schema/enum-clash-member.json
> > index b6928b8bfd..fd52751941 100644
> > --- a/tests/qapi-schema/enum-clash-member.json
> > +++ b/tests/qapi-schema/enum-clash-member.json
> > @@ -1,2 +1,6 @@
> >  # we reject enums where members will clash when mapped to C enum
> > +
> > +##
> > +# @MyEnum:
> > +##
> >  { 'enum': 'MyEnum', 'data': [ 'one-two', 'one_two' ] }
> > diff --git a/tests/qapi-schema/enum-dict-member.err
> > b/tests/qapi-schema/enum-dict-member.err
> > index 8ca146ea59..9b7d2f111d 100644
> > --- a/tests/qapi-schema/enum-dict-member.err
> > +++ b/tests/qapi-schema/enum-dict-member.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum'
> > requires a string name
> > +tests/qapi-schema/enum-dict-member.json:6: Member of enum 'MyEnum'
> > requires a string name
> > diff --git a/tests/qapi-schema/enum-dict-member.json
> > b/tests/qapi-schema/enum-dict-member.json
> > index 79672e0f09..69d30f0c1e 100644
> > --- a/tests/qapi-schema/enum-dict-member.json
> > +++ b/tests/qapi-schema/enum-dict-member.json
> > @@ -1,2 +1,6 @@
> >  # we reject any enum member that is not a string
> > +
> > +##
> > +# @MyEnum:
> > +##
> >  { 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
> > diff --git a/tests/qapi-schema/enum-member-case.err
> > b/tests/qapi-schema/enum-member-case.err
> > index b652e9aacc..df96e2205a 100644
> > --- a/tests/qapi-schema/enum-member-case.err
> > +++ b/tests/qapi-schema/enum-member-case.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-member-case.json:3: 'Value' (member of
> > NoWayThisWillGetWhitelisted) should not use uppercase
> > +tests/qapi-schema/enum-member-case.json:10: 'Value' (member of
> > NoWayThisWillGetWhitelisted) should not use uppercase
> > diff --git a/tests/qapi-schema/enum-member-case.json
> > b/tests/qapi-schema/enum-member-case.json
> > index 2096b350ca..d2e4aba39d 100644
> > --- a/tests/qapi-schema/enum-member-case.json
> > +++ b/tests/qapi-schema/enum-member-case.json
> > @@ -1,3 +1,10 @@
> >  # Member names should be 'lower-case' unless the enum is whitelisted
> > +
> > +##
> > +# @UuidInfo:
> > +##
> >  { 'enum': 'UuidInfo', 'data': [ 'Value' ] } # UuidInfo is whitelisted
> > +##
> > +# @NoWayThisWillGetWhitelisted:
> > +##
> >  { 'enum': 'NoWayThisWillGetWhitelisted', 'data': [ 'Value' ] }
> > diff --git a/tests/qapi-schema/enum-missing-data.err
> > b/tests/qapi-schema/enum-missing-data.err
> > index ba4873ae69..de4b9e8281 100644
> > --- a/tests/qapi-schema/enum-missing-data.err
> > +++ b/tests/qapi-schema/enum-missing-data.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from
> > enum 'MyEnum'
> > +tests/qapi-schema/enum-missing-data.json:6: Key 'data' is missing from
> > enum 'MyEnum'
> > diff --git a/tests/qapi-schema/enum-missing-data.json
> > b/tests/qapi-schema/enum-missing-data.json
> > index 558fd35e93..d7601f91fb 100644
> > --- a/tests/qapi-schema/enum-missing-data.json
> > +++ b/tests/qapi-schema/enum-missing-data.json
> > @@ -1,2 +1,6 @@
> >  # we require that all QAPI enums have a data array
> > +
> > +##
> > +# @MyEnum:
> > +##
> >  { 'enum': 'MyEnum' }
> > diff --git a/tests/qapi-schema/enum-wrong-data.err
> > b/tests/qapi-schema/enum-wrong-data.err
> > index 11b43471cf..c44e9b59dc 100644
> > --- a/tests/qapi-schema/enum-wrong-data.err
> > +++ b/tests/qapi-schema/enum-wrong-data.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an ar=
ray
> > for 'data'
> > +tests/qapi-schema/enum-wrong-data.json:6: Enum 'MyEnum' requires an ar=
ray
> > for 'data'
> > diff --git a/tests/qapi-schema/enum-wrong-data.json
> > b/tests/qapi-schema/enum-wrong-data.json
> > index 7b3e255c14..4b9e97878b 100644
> > --- a/tests/qapi-schema/enum-wrong-data.json
> > +++ b/tests/qapi-schema/enum-wrong-data.json
> > @@ -1,2 +1,6 @@
> >  # we require that all qapi enums have an array for data
> > +
> > +##
> > +# @MyEnum:
> > +##
> >  { 'enum': 'MyEnum', 'data': { 'value': 'str' } }
> > diff --git a/tests/qapi-schema/event-boxed-empty.err
> > b/tests/qapi-schema/event-boxed-empty.err
> > index 68ec6f2d2b..defe656e32 100644
> > --- a/tests/qapi-schema/event-boxed-empty.err
> > +++ b/tests/qapi-schema/event-boxed-empty.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'd=
ata'
> > +tests/qapi-schema/event-boxed-empty.json:6: Use of 'boxed' requires 'd=
ata'
> > diff --git a/tests/qapi-schema/event-boxed-empty.json
> > b/tests/qapi-schema/event-boxed-empty.json
> > index cb145f1433..63b870b31b 100644
> > --- a/tests/qapi-schema/event-boxed-empty.json
> > +++ b/tests/qapi-schema/event-boxed-empty.json
> > @@ -1,2 +1,6 @@
> >  # 'boxed' requires a non-empty type
> > +
> > +##
> > +# @FOO:
> > +##
> >  { 'event': 'FOO', 'boxed': true }
> > diff --git a/tests/qapi-schema/event-case.json
> > b/tests/qapi-schema/event-case.json
> > index 3a92d8b610..6b05c5d247 100644
> > --- a/tests/qapi-schema/event-case.json
> > +++ b/tests/qapi-schema/event-case.json
> > @@ -1,3 +1,7 @@
> >  # TODO: might be nice to enforce naming conventions; but until then th=
is
> >  works
> >  # even though events should usually be ALL_CAPS
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'event': 'oops' }
> > diff --git a/tests/qapi-schema/event-case.out
> > b/tests/qapi-schema/event-case.out
> > index 5a0f2bf805..5a36293c8f 100644
> > --- a/tests/qapi-schema/event-case.out
> > +++ b/tests/qapi-schema/event-case.out
> > @@ -3,3 +3,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict'=
,
> > 'qlist', 'qfloat', 'qbo
> >  event oops None
> >     boxed=3DFalse
> >  object q_empty
> > +doc symbol=3Doops expr=3D('event', 'oops')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/event-nest-struct.err
> > b/tests/qapi-schema/event-nest-struct.err
> > index 5a42701b8f..17a6c3c7b9 100644
> > --- a/tests/qapi-schema/event-nest-struct.err
> > +++ b/tests/qapi-schema/event-nest-struct.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for e=
vent
> > 'EVENT_A' should be a type name
> > +tests/qapi-schema/event-nest-struct.json:5: Member 'a' of 'data' for e=
vent
> > 'EVENT_A' should be a type name
> > diff --git a/tests/qapi-schema/event-nest-struct.json
> > b/tests/qapi-schema/event-nest-struct.json
> > index ee6f3ecb6f..328e0a64d3 100644
> > --- a/tests/qapi-schema/event-nest-struct.json
> > +++ b/tests/qapi-schema/event-nest-struct.json
> > @@ -1,2 +1,6 @@
> > +##
> > +# @EVENT_A:
> > +# event-nest-struct
> > +##
> >  { 'event': 'EVENT_A',
> >    'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' =
} }
> > diff --git a/tests/qapi-schema/flat-union-array-branch.err
> > b/tests/qapi-schema/flat-union-array-branch.err
> > index 8ea91eadb2..e456094993 100644
> > --- a/tests/qapi-schema/flat-union-array-branch.err
> > +++ b/tests/qapi-schema/flat-union-array-branch.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of u=
nion
> > 'TestUnion' cannot be an array
> > +tests/qapi-schema/flat-union-array-branch.json:20: Member 'value1' of
> > union 'TestUnion' cannot be an array
> > diff --git a/tests/qapi-schema/flat-union-array-branch.json
> > b/tests/qapi-schema/flat-union-array-branch.json
> > index 0b98820a8f..51dde10392 100644
> > --- a/tests/qapi-schema/flat-union-array-branch.json
> > +++ b/tests/qapi-schema/flat-union-array-branch.json
> > @@ -1,10 +1,22 @@
> > +##
> > +# @TestEnum:
> > +##
> >  # we require flat union branches to be a struct
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'enum1': 'TestEnum' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'Base',
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-bad-base.err
> > b/tests/qapi-schema/flat-union-bad-base.err
> > index bee24a217a..072ffbaadd 100644
> > --- a/tests/qapi-schema/flat-union-bad-base.err
> > +++ b/tests/qapi-schema/flat-union-bad-base.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of
> > TestTypeA) collides with 'string' (base of TestUnion)
> > +tests/qapi-schema/flat-union-bad-base.json:21: 'string' (member of
> > TestTypeA) collides with 'string' (base of TestUnion)
> > diff --git a/tests/qapi-schema/flat-union-bad-base.json
> > b/tests/qapi-schema/flat-union-bad-base.json
> > index 74dd421708..7713e7f0ad 100644
> > --- a/tests/qapi-schema/flat-union-bad-base.json
> > +++ b/tests/qapi-schema/flat-union-bad-base.json
> > @@ -1,10 +1,23 @@
> >  # we allow anonymous base, but enforce no duplicate keys
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': { 'enum1': 'TestEnum', 'string': 'str' },
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err
> > b/tests/qapi-schema/flat-union-bad-discriminator.err
> > index c38cc8e4df..1be4e7b23a 100644
> > --- a/tests/qapi-schema/flat-union-bad-discriminator.err
> > +++ b/tests/qapi-schema/flat-union-bad-discriminator.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator =
of
> > flat union 'TestUnion' requires a string name
> > +tests/qapi-schema/flat-union-bad-discriminator.json:27: Discriminator =
of
> > flat union 'TestUnion' requires a string name
> > diff --git a/tests/qapi-schema/flat-union-bad-discriminator.json
> > b/tests/qapi-schema/flat-union-bad-discriminator.json
> > index cd10b9d901..ef92f9b583 100644
> > --- a/tests/qapi-schema/flat-union-bad-discriminator.json
> > +++ b/tests/qapi-schema/flat-union-bad-discriminator.json
> > @@ -1,13 +1,29 @@
> >  # we require the discriminator to be a string naming a base-type membe=
r
> >  # this tests the old syntax for anonymous unions before we added
> >  alternates
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @TestBase:
> > +##
> >  { 'struct': 'TestBase',
> >    'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'TestBase',
> >    'discriminator': {},
> > diff --git a/tests/qapi-schema/flat-union-base-any.err
> > b/tests/qapi-schema/flat-union-base-any.err
> > index 646f1c9cd1..c1ea2d76b3 100644
> > --- a/tests/qapi-schema/flat-union-base-any.err
> > +++ b/tests/qapi-schema/flat-union-base-any.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-base-any.json:8: 'base' for union 'TestUn=
ion'
> > cannot use built-in type 'any'
> > +tests/qapi-schema/flat-union-base-any.json:21: 'base' for union
> > 'TestUnion' cannot use built-in type 'any'
> > diff --git a/tests/qapi-schema/flat-union-base-any.json
> > b/tests/qapi-schema/flat-union-base-any.json
> > index fe66b713ef..3dfb02fa30 100644
> > --- a/tests/qapi-schema/flat-union-base-any.json
> > +++ b/tests/qapi-schema/flat-union-base-any.json
> > @@ -1,10 +1,23 @@
> >  # we require the base to be an existing struct
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'any',
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-base-union.err
> > b/tests/qapi-schema/flat-union-base-union.err
> > index f138395e45..ccc5e85876 100644
> > --- a/tests/qapi-schema/flat-union-base-union.err
> > +++ b/tests/qapi-schema/flat-union-base-union.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-base-union.json:14: 'base' for union
> > 'TestUnion' cannot use union type 'UnionBase'
> > +tests/qapi-schema/flat-union-base-union.json:30: 'base' for union
> > 'TestUnion' cannot use union type 'UnionBase'
> > diff --git a/tests/qapi-schema/flat-union-base-union.json
> > b/tests/qapi-schema/flat-union-base-union.json
> > index 98b4eba181..c63c6130b8 100644
> > --- a/tests/qapi-schema/flat-union-base-union.json
> > +++ b/tests/qapi-schema/flat-union-base-union.json
> > @@ -2,15 +2,31 @@
> >  # TODO: It would be possible to allow a union as a base, as long as al=
l
> >  # permutations of QMP names exposed by base do not clash with any QMP
> >  # member names added by local variants.
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @UnionBase:
> > +##
> >  { 'union': 'UnionBase',
> >    'data': { 'kind1': 'TestTypeA',
> >              'kind2': 'TestTypeB' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'UnionBase',
> >    'discriminator': 'type',
> > diff --git a/tests/qapi-schema/flat-union-clash-member.err
> > b/tests/qapi-schema/flat-union-clash-member.err
> > index 2adf69755a..fe12a07e2d 100644
> > --- a/tests/qapi-schema/flat-union-clash-member.err
> > +++ b/tests/qapi-schema/flat-union-clash-member.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of
> > Branch1) collides with 'name' (member of Base)
> > +tests/qapi-schema/flat-union-clash-member.json:27: 'name' (member of
> > Branch1) collides with 'name' (member of Base)
> > diff --git a/tests/qapi-schema/flat-union-clash-member.json
> > b/tests/qapi-schema/flat-union-clash-member.json
> > index 9efc7719b8..9000b94f16 100644
> > --- a/tests/qapi-schema/flat-union-clash-member.json
> > +++ b/tests/qapi-schema/flat-union-clash-member.json
> > @@ -1,13 +1,29 @@
> >  # We check for no duplicate keys between branch members and base
> >  # base's member 'name' clashes with Branch1's
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'enum1': 'TestEnum', '*name': 'str' } }
> > +##
> > +# @Branch1:
> > +##
> >  { 'struct': 'Branch1',
> >    'data': { 'name': 'str' } }
> > +##
> > +# @Branch2:
> > +##
> >  { 'struct': 'Branch2',
> >    'data': { 'value': 'int' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'Base',
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-empty.err
> > b/tests/qapi-schema/flat-union-empty.err
> > index 15754f54eb..ead7bd4fcb 100644
> > --- a/tests/qapi-schema/flat-union-empty.err
> > +++ b/tests/qapi-schema/flat-union-empty.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-empty.json:4: Union 'Union' cannot have e=
mpty
> > 'data'
> > +tests/qapi-schema/flat-union-empty.json:14: Union 'Union' cannot have
> > empty 'data'
> > diff --git a/tests/qapi-schema/flat-union-empty.json
> > b/tests/qapi-schema/flat-union-empty.json
> > index 77f1d9abfb..afa8988205 100644
> > --- a/tests/qapi-schema/flat-union-empty.json
> > +++ b/tests/qapi-schema/flat-union-empty.json
> > @@ -1,4 +1,14 @@
> >  # flat unions cannot be empty
> > +
> > +##
> > +# @Empty:
> > +##
> >  { 'enum': 'Empty', 'data': [ ] }
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base', 'data': { 'type': 'Empty' } }
> > +##
> > +# @Union:
> > +##
> >  { 'union': 'Union', 'base': 'Base', 'discriminator': 'type', 'data': {=
 } }
> > diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err
> > b/tests/qapi-schema/flat-union-incomplete-branch.err
> > index e826bf0789..c655bbfb4a 100644
> > --- a/tests/qapi-schema/flat-union-incomplete-branch.err
> > +++ b/tests/qapi-schema/flat-union-incomplete-branch.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnio=
n'
> > data missing 'value2' branch
> > +tests/qapi-schema/flat-union-incomplete-branch.json:16: Union 'TestUni=
on'
> > data missing 'value2' branch
> > diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json
> > b/tests/qapi-schema/flat-union-incomplete-branch.json
> > index 25a411bc83..dea03775c7 100644
> > --- a/tests/qapi-schema/flat-union-incomplete-branch.json
> > +++ b/tests/qapi-schema/flat-union-incomplete-branch.json
> > @@ -1,8 +1,18 @@
> >  # we require all branches of the union to be covered
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': { 'type': 'TestEnum' },
> >    'discriminator': 'type',
> > diff --git a/tests/qapi-schema/flat-union-inline.err
> > b/tests/qapi-schema/flat-union-inline.err
> > index 2333358d28..c2c3f7604b 100644
> > --- a/tests/qapi-schema/flat-union-inline.err
> > +++ b/tests/qapi-schema/flat-union-inline.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union
> > 'TestUnion' should be a type name
> > +tests/qapi-schema/flat-union-inline.json:17: Member 'value1' of union
> > 'TestUnion' should be a type name
> > diff --git a/tests/qapi-schema/flat-union-inline.json
> > b/tests/qapi-schema/flat-union-inline.json
> > index 62c7cda617..400f0817a1 100644
> > --- a/tests/qapi-schema/flat-union-inline.json
> > +++ b/tests/qapi-schema/flat-union-inline.json
> > @@ -1,9 +1,19 @@
> >  # we require branches to be a struct name
> >  # TODO: should we allow anonymous inline branch types?
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'Base',
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-int-branch.err
> > b/tests/qapi-schema/flat-union-int-branch.err
> > index faf01573b7..299cbb24b2 100644
> > --- a/tests/qapi-schema/flat-union-int-branch.err
> > +++ b/tests/qapi-schema/flat-union-int-branch.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of uni=
on
> > 'TestUnion' cannot use built-in type 'int'
> > +tests/qapi-schema/flat-union-int-branch.json:21: Member 'value1' of un=
ion
> > 'TestUnion' cannot use built-in type 'int'
> > diff --git a/tests/qapi-schema/flat-union-int-branch.json
> > b/tests/qapi-schema/flat-union-int-branch.json
> > index 9370c349e8..9603e172f8 100644
> > --- a/tests/qapi-schema/flat-union-int-branch.json
> > +++ b/tests/qapi-schema/flat-union-int-branch.json
> > @@ -1,10 +1,23 @@
> >  # we require flat union branches to be a struct
> > +
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'enum1': 'TestEnum' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'Base',
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err
> > b/tests/qapi-schema/flat-union-invalid-branch-key.err
> > index ccf72d2dfe..455f2dc083 100644
> > --- a/tests/qapi-schema/flat-union-invalid-branch-key.err
> > +++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator
> > value 'value_wrong' is not found in enum 'TestEnum'
> > +tests/qapi-schema/flat-union-invalid-branch-key.json:28: Discriminator
> > value 'value_wrong' is not found in enum 'TestEnum'
> > diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.json
> > b/tests/qapi-schema/flat-union-invalid-branch-key.json
> > index 95ff7746bf..00f28966ff 100644
> > --- a/tests/qapi-schema/flat-union-invalid-branch-key.json
> > +++ b/tests/qapi-schema/flat-union-invalid-branch-key.json
> > @@ -1,15 +1,30 @@
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > =20
> > +##
> > +# @TestBase:
> > +##
> >  { 'struct': 'TestBase',
> >    'data': { 'enum1': 'TestEnum' } }
> > =20
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > =20
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > =20
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'TestBase',
> >    'discriminator': 'enum1',
> > diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err
> > b/tests/qapi-schema/flat-union-invalid-discriminator.err
> > index 5f4055614e..f0e427b0a7 100644
> > --- a/tests/qapi-schema/flat-union-invalid-discriminator.err
> > +++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-invalid-discriminator.json:13: Discrimina=
tor
> > 'enum_wrong' is not a member of base struct 'TestBase'
> > +tests/qapi-schema/flat-union-invalid-discriminator.json:28: Discrimina=
tor
> > 'enum_wrong' is not a member of base struct 'TestBase'
> > diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json
> > b/tests/qapi-schema/flat-union-invalid-discriminator.json
> > index 48b94c3a4d..c8700c7d71 100644
> > --- a/tests/qapi-schema/flat-union-invalid-discriminator.json
> > +++ b/tests/qapi-schema/flat-union-invalid-discriminator.json
> > @@ -1,15 +1,30 @@
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > =20
> > +##
> > +# @TestBase:
> > +##
> >  { 'struct': 'TestBase',
> >    'data': { 'enum1': 'TestEnum' } }
> > =20
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > =20
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > =20
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'TestBase',
> >    'discriminator': 'enum_wrong',
> > diff --git a/tests/qapi-schema/flat-union-no-base.err
> > b/tests/qapi-schema/flat-union-no-base.err
> > index 841c93b554..a2d0a81aa0 100644
> > --- a/tests/qapi-schema/flat-union-no-base.err
> > +++ b/tests/qapi-schema/flat-union-no-base.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' mu=
st
> > have a base
> > +tests/qapi-schema/flat-union-no-base.json:22: Flat union 'TestUnion' m=
ust
> > have a base
> > diff --git a/tests/qapi-schema/flat-union-no-base.json
> > b/tests/qapi-schema/flat-union-no-base.json
> > index ffc4c6f0e6..641f68aea4 100644
> > --- a/tests/qapi-schema/flat-union-no-base.json
> > +++ b/tests/qapi-schema/flat-union-no-base.json
> > @@ -1,11 +1,24 @@
> >  # flat unions require a base
> >  # TODO: simple unions should be able to use an enum discriminator
> > +
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > +##
> > +# @Enum:
> > +##
> >  { 'enum': 'Enum',
> >    'data': [ 'value1', 'value2' ] }
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'discriminator': 'Enum',
> >    'data': { 'value1': 'TestTypeA',
> > diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err
> > b/tests/qapi-schema/flat-union-optional-discriminator.err
> > index aaabedb3bd..e15f8564dd 100644
> > --- a/tests/qapi-schema/flat-union-optional-discriminator.err
> > +++ b/tests/qapi-schema/flat-union-optional-discriminator.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-optional-discriminator.json:6: Discrimina=
tor
> > of flat union 'MyUnion' does not allow optional name '*switch'
> > +tests/qapi-schema/flat-union-optional-discriminator.json:19: Discrimin=
ator
> > of flat union 'MyUnion' does not allow optional name '*switch'
> > diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json
> > b/tests/qapi-schema/flat-union-optional-discriminator.json
> > index 08a8f7ef8b..9f19af5789 100644
> > --- a/tests/qapi-schema/flat-union-optional-discriminator.json
> > +++ b/tests/qapi-schema/flat-union-optional-discriminator.json
> > @@ -1,8 +1,21 @@
> >  # we require the discriminator to be non-optional
> > +
> > +##
> > +# @Enum:
> > +##
> >  { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { '*switch': 'Enum' } }
> > +##
> > +# @Branch:
> > +##
> >  { 'struct': 'Branch', 'data': { 'name': 'str' } }
> > +##
> > +# @MyUnion:
> > +##
> >  { 'union': 'MyUnion',
> >    'base': 'Base',
> >    'discriminator': '*switch',
> > diff --git a/tests/qapi-schema/flat-union-string-discriminator.err
> > b/tests/qapi-schema/flat-union-string-discriminator.err
> > index 200016bd5c..bc0c133aa9 100644
> > --- a/tests/qapi-schema/flat-union-string-discriminator.err
> > +++ b/tests/qapi-schema/flat-union-string-discriminator.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminat=
or
> > 'kind' must be of enumeration type
> > +tests/qapi-schema/flat-union-string-discriminator.json:28: Discriminat=
or
> > 'kind' must be of enumeration type
> > diff --git a/tests/qapi-schema/flat-union-string-discriminator.json
> > b/tests/qapi-schema/flat-union-string-discriminator.json
> > index 8af60333b6..47a17d2e4a 100644
> > --- a/tests/qapi-schema/flat-union-string-discriminator.json
> > +++ b/tests/qapi-schema/flat-union-string-discriminator.json
> > @@ -1,15 +1,30 @@
> > +##
> > +# @TestEnum:
> > +##
> >  { 'enum': 'TestEnum',
> >    'data': [ 'value1', 'value2' ] }
> > =20
> > +##
> > +# @TestBase:
> > +##
> >  { 'struct': 'TestBase',
> >    'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
> > =20
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > =20
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > =20
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'TestBase',
> >    'discriminator': 'kind',
> > diff --git a/tests/qapi-schema/ident-with-escape.json
> > b/tests/qapi-schema/ident-with-escape.json
> > index 56617501e7..c03404bee3 100644
> > --- a/tests/qapi-schema/ident-with-escape.json
> > +++ b/tests/qapi-schema/ident-with-escape.json
> > @@ -1,4 +1,8 @@
> >  # we allow escape sequences in strings, if they map back to ASCII
> >  # { 'command': 'fooA', 'data': { 'bar1': 'str' } }
> > +
> > +##
> > +# @fooA:
> > +##
> >  { 'c\u006fmmand': '\u0066\u006f\u006FA',
> >    'd\u0061ta': { '\u0062\u0061\u00721': '\u0073\u0074\u0072' } }
> > diff --git a/tests/qapi-schema/ident-with-escape.out
> > b/tests/qapi-schema/ident-with-escape.out
> > index 1d2722c02e..4a98933b28 100644
> > --- a/tests/qapi-schema/ident-with-escape.out
> > +++ b/tests/qapi-schema/ident-with-escape.out
> > @@ -5,3 +5,6 @@ command fooA q_obj_fooA-arg -> None
> >  object q_empty
> >  object q_obj_fooA-arg
> >      member bar1: str optional=3DFalse
> > +doc symbol=3DfooA expr=3D('command', 'fooA')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/include-relpath-sub.json
> > b/tests/qapi-schema/include-relpath-sub.json
> > index 4bd4af4162..b4bd8a23d7 100644
> > --- a/tests/qapi-schema/include-relpath-sub.json
> > +++ b/tests/qapi-schema/include-relpath-sub.json
> > @@ -1,2 +1,5 @@
> > +##
> > +# @Status:
> > +##
> >  { 'enum': 'Status',
> >    'data': [ 'good', 'bad', 'ugly' ] }
> > diff --git a/tests/qapi-schema/include-relpath.out
> > b/tests/qapi-schema/include-relpath.out
> > index 5d7c13cad1..ab3d74f49f 100644
> > --- a/tests/qapi-schema/include-relpath.out
> > +++ b/tests/qapi-schema/include-relpath.out
> > @@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict'=
,
> > 'qlist', 'qfloat', 'qbo
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > +doc symbol=3DStatus expr=3D('enum', 'Status')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/include-repetition.out
> > b/tests/qapi-schema/include-repetition.out
> > index 5d7c13cad1..ab3d74f49f 100644
> > --- a/tests/qapi-schema/include-repetition.out
> > +++ b/tests/qapi-schema/include-repetition.out
> > @@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict'=
,
> > 'qlist', 'qfloat', 'qbo
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > +doc symbol=3DStatus expr=3D('enum', 'Status')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/include-simple-sub.json
> > b/tests/qapi-schema/include-simple-sub.json
> > index 4bd4af4162..b4bd8a23d7 100644
> > --- a/tests/qapi-schema/include-simple-sub.json
> > +++ b/tests/qapi-schema/include-simple-sub.json
> > @@ -1,2 +1,5 @@
> > +##
> > +# @Status:
> > +##
> >  { 'enum': 'Status',
> >    'data': [ 'good', 'bad', 'ugly' ] }
> > diff --git a/tests/qapi-schema/include-simple.out
> > b/tests/qapi-schema/include-simple.out
> > index 5d7c13cad1..ab3d74f49f 100644
> > --- a/tests/qapi-schema/include-simple.out
> > +++ b/tests/qapi-schema/include-simple.out
> > @@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict'=
,
> > 'qlist', 'qfloat', 'qbo
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > +doc symbol=3DStatus expr=3D('enum', 'Status')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/indented-expr.json
> > b/tests/qapi-schema/indented-expr.json
> > index 7115d3131e..d759be1877 100644
> > --- a/tests/qapi-schema/indented-expr.json
> > +++ b/tests/qapi-schema/indented-expr.json
> > @@ -1,2 +1,8 @@
> > +##
> > +# @eins:
> > +##
> >  { 'command' : 'eins' }
> > +##
> > +# @zwei:
> > +##
> >   { 'command' : 'zwei' }
> > diff --git a/tests/qapi-schema/indented-expr.out
> > b/tests/qapi-schema/indented-expr.out
> > index e8171c935f..4ef4d7f48d 100644
> > --- a/tests/qapi-schema/indented-expr.out
> > +++ b/tests/qapi-schema/indented-expr.out
> > @@ -5,3 +5,9 @@ command eins None -> None
> >  object q_empty
> >  command zwei None -> None
> >     gen=3DTrue success_response=3DTrue boxed=3DFalse
> > +doc symbol=3Deins expr=3D('command', 'eins')
> > +    body=3D
> > +
> > +doc symbol=3Dzwei expr=3D('command', 'zwei')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/missing-type.err
> > b/tests/qapi-schema/missing-type.err
> > index b3e7b14e42..74c4ef7324 100644
> > --- a/tests/qapi-schema/missing-type.err
> > +++ b/tests/qapi-schema/missing-type.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/missing-type.json:2: Expression is missing metatype
> > +tests/qapi-schema/missing-type.json:6: Expression is missing metatype
> > diff --git a/tests/qapi-schema/missing-type.json
> > b/tests/qapi-schema/missing-type.json
> > index ff5349d3fe..c2fc62d0af 100644
> > --- a/tests/qapi-schema/missing-type.json
> > +++ b/tests/qapi-schema/missing-type.json
> > @@ -1,2 +1,6 @@
> >  # we reject an expression with missing metatype
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'data': { } }
> > diff --git a/tests/qapi-schema/nested-struct-data.err
> > b/tests/qapi-schema/nested-struct-data.err
> > index da767bade2..379bd1d3f4 100644
> > --- a/tests/qapi-schema/nested-struct-data.err
> > +++ b/tests/qapi-schema/nested-struct-data.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for
> > command 'foo' should be a type name
> > +tests/qapi-schema/nested-struct-data.json:6: Member 'a' of 'data' for
> > command 'foo' should be a type name
> > diff --git a/tests/qapi-schema/nested-struct-data.json
> > b/tests/qapi-schema/nested-struct-data.json
> > index efbe773ded..6106e15e86 100644
> > --- a/tests/qapi-schema/nested-struct-data.json
> > +++ b/tests/qapi-schema/nested-struct-data.json
> > @@ -1,3 +1,7 @@
> >  # inline subtypes collide with our desired future use of defaults
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo',
> >    'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' =
} }
> > diff --git a/tests/qapi-schema/qapi-schema-test.json
> > b/tests/qapi-schema/qapi-schema-test.json
> > index 17194637ba..f4d8cc4230 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -3,67 +3,153 @@
> >  # This file is a stress test of supported qapi constructs that must
> >  # parse and compile correctly.
> > =20
> > +##
> > +# =3D Section
> > +# =3D=3D subsection
> > +#
> > +# Some text foo with *strong* and _emphasis_
> > +# 1. with a list
> > +# 2. like that @foo
> > +#
> > +# And some code:
> > +# | $ echo foo
> > +# | -> do this
> > +# | <- get that
> > +#
> > +# Note: is not a meta
> > +##
> > +
> > +##
> > +# @TestStruct:
> > +#
> > +# body with @var
> > +#
> > +# @integer: foo
> > +#           blah
> > +#
> > +#           bao
> > +#
> > +# @boolean: bar
> > +# @string: baz
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": ... }
> > +# <- { "return": ... }
> > +#
> > +# Since: 2.3
> > +# Note: a note
> > +#
> > +##
> >  { 'struct': 'TestStruct',
> >    'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
> > =20
> > +##
> > +# @NestedEnumsOne:
> >  # for testing enums
> > +##
> >  { 'struct': 'NestedEnumsOne',
> >    'data': { 'enum1': 'EnumOne',   # Intentional forward reference
> >              '*enum2': 'EnumOne', 'enum3': 'EnumOne', '*enum4': 'EnumOn=
e' }
> >              }
> > =20
> > +##
> > +# @MyEnum:
> >  # An empty enum, although unusual, is currently acceptable
> > +##
> >  { 'enum': 'MyEnum', 'data': [ ] }
> > =20
> > +##
> > +# @Empty1:
> >  # Likewise for an empty struct, including an empty base
> > +##
> >  { 'struct': 'Empty1', 'data': { } }
> > +##
> > +# @Empty2:
> > +##
> >  { 'struct': 'Empty2', 'base': 'Empty1', 'data': { } }
> > =20
> > +##
> > +# @user_def_cmd0:
> > +##
> >  { 'command': 'user_def_cmd0', 'data': 'Empty2', 'returns': 'Empty2' }
> > =20
> > +##
> > +# @QEnumTwo:
> >  # for testing override of default naming heuristic
> > +##
> >  { 'enum': 'QEnumTwo',
> >    'prefix': 'QENUM_TWO',
> >    'data': [ 'value1', 'value2' ] }
> > =20
> > +##
> > +# @UserDefOne:
> >  # for testing nested structs
> > +##
> >  { 'struct': 'UserDefOne',
> >    'base': 'UserDefZero',        # intentional forward reference
> >    'data': { 'string': 'str',
> >              '*enum1': 'EnumOne' } }   # intentional forward reference
> > =20
> > +##
> > +# @EnumOne:
> > +##
> >  { 'enum': 'EnumOne',
> >    'data': [ 'value1', 'value2', 'value3' ] }
> > =20
> > +##
> > +# @UserDefZero:
> > +##
> >  { 'struct': 'UserDefZero',
> >    'data': { 'integer': 'int' } }
> > =20
> > +##
> > +# @UserDefTwoDictDict:
> > +##
> >  { 'struct': 'UserDefTwoDictDict',
> >    'data': { 'userdef': 'UserDefOne', 'string': 'str' } }
> > =20
> > +##
> > +# @UserDefTwoDict:
> > +##
> >  { 'struct': 'UserDefTwoDict',
> >    'data': { 'string1': 'str',
> >              'dict2': 'UserDefTwoDictDict',
> >              '*dict3': 'UserDefTwoDictDict' } }
> > =20
> > +##
> > +# @UserDefTwo:
> > +##
> >  { 'struct': 'UserDefTwo',
> >    'data': { 'string0': 'str',
> >              'dict1': 'UserDefTwoDict' } }
> > =20
> > +##
> > +# @ForceArrays:
> >  # dummy struct to force generation of array types not otherwise mentio=
ned
> > +##
> >  { 'struct': 'ForceArrays',
> >    'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
> >              'unused3':['TestStruct'] } }
> > =20
> > +##
> > +# @UserDefA:
> >  # for testing unions
> >  # Among other things, test that a name collision between branches does
> >  # not cause any problems (since only one branch can be in use at a tim=
e),
> >  # by intentionally using two branches that both have a C member 'a_b'
> > +##
> >  { 'struct': 'UserDefA',
> >    'data': { 'boolean': 'bool', '*a_b': 'int' } }
> > =20
> > +##
> > +# @UserDefB:
> > +##
> >  { 'struct': 'UserDefB',
> >    'data': { 'intb': 'int', '*a-b': 'bool' } }
> > =20
> > +##
> > +# @UserDefFlatUnion:
> > +##
> >  { 'union': 'UserDefFlatUnion',
> >    'base': 'UserDefUnionBase',   # intentional forward reference
> >    'discriminator': 'enum1',
> > @@ -71,35 +157,71 @@
> >              'value2' : 'UserDefB',
> >              'value3' : 'UserDefB' } }
> > =20
> > +##
> > +# @UserDefUnionBase:
> > +##
> >  { 'struct': 'UserDefUnionBase',
> >    'base': 'UserDefZero',
> >    'data': { 'string': 'str', 'enum1': 'EnumOne' } }
> > =20
> > +##
> > +# @UserDefFlatUnion2:
> >  # this variant of UserDefFlatUnion defaults to a union that uses membe=
rs
> >  with
> >  # allocated types to test corner cases in the cleanup/dealloc visitor
> > +##
> >  { 'union': 'UserDefFlatUnion2',
> >    'base': { '*integer': 'int', 'string': 'str', 'enum1': 'QEnumTwo' },
> >    'discriminator': 'enum1',
> >    'data': { 'value1' : 'UserDefC', # intentional forward reference
> >              'value2' : 'UserDefB' } }
> > =20
> > +##
> > +# @WrapAlternate:
> > +##
> >  { 'struct': 'WrapAlternate',
> >    'data': { 'alt': 'UserDefAlternate' } }
> > +##
> > +# @UserDefAlternate:
> > +##
> >  { 'alternate': 'UserDefAlternate',
> >    'data': { 'udfu': 'UserDefFlatUnion', 's': 'str', 'i': 'int' } }
> > =20
> > +##
> > +# @UserDefC:
> > +##
> >  { 'struct': 'UserDefC',
> >    'data': { 'string1': 'str', 'string2': 'str' } }
> > =20
> >  # for testing use of 'number' within alternates
> > +##
> > +# @AltStrBool:
> > +##
> >  { 'alternate': 'AltStrBool', 'data': { 's': 'str', 'b': 'bool' } }
> > +##
> > +# @AltStrNum:
> > +##
> >  { 'alternate': 'AltStrNum', 'data': { 's': 'str', 'n': 'number' } }
> > +##
> > +# @AltNumStr:
> > +##
> >  { 'alternate': 'AltNumStr', 'data': { 'n': 'number', 's': 'str' } }
> > +##
> > +# @AltStrInt:
> > +##
> >  { 'alternate': 'AltStrInt', 'data': { 's': 'str', 'i': 'int' } }
> > +##
> > +# @AltIntNum:
> > +##
> >  { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
> > +##
> > +# @AltNumInt:
> > +##
> >  { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
> > =20
> > +##
> > +# @UserDefNativeListUnion:
> >  # for testing native lists
> > +##
> >  { 'union': 'UserDefNativeListUnion',
> >    'data': { 'integer': ['int'],
> >              's8': ['int8'],
> > @@ -117,19 +239,61 @@
> >              'any': ['any'] } }
> > =20
> >  # testing commands
> > +##
> > +# @user_def_cmd:
> > +##
> >  { 'command': 'user_def_cmd', 'data': {} }
> > +##
> > +# @user_def_cmd1:
> > +##
> >  { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
> > +##
> > +# @user_def_cmd2:
> > +##
> >  { 'command': 'user_def_cmd2',
> >    'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
> >    'returns': 'UserDefTwo' }
> > =20
> > +##
> > +# Another comment
> > +##
> > +
> > +##
> > +# @guest-get-time:
> > +#
> > +# @guest-get-time body
> > +#
> > +# @a: an integer
> > +# @b: #optional integer
> > +#
> > +# Returns: returns something
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "guest-get-time", ... }
> > +# <- { "return": "42" }
> > +#
> > +##
> > +
> >  # Returning a non-dictionary requires a name from the whitelist
> >  { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
> >    'returns': 'int' }
> > +##
> > +# @guest-sync:
> > +##
> >  { 'command': 'guest-sync', 'data': { 'arg': 'any' }, 'returns': 'any' =
}
> > +##
> > +# @boxed-struct:
> > +##
> >  { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
> > +##
> > +# @boxed-union:
> > +##
> >  { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed':
> >  true }
> > =20
> > +##
> > +# @UserDefOptions:
> > +#
> >  # For testing integer range flattening in opts-visitor. The following
> >  schema
> >  # corresponds to the option format:
> >  #
> > @@ -137,6 +301,7 @@
> >  #
> >  # For simplicity, this example doesn't use [type=3D]discriminator nor
> >  optargs
> >  # specific to discriminator values.
> > +##
> >  { 'struct': 'UserDefOptions',
> >    'data': {
> >      '*i64' : [ 'int'    ],
> > @@ -146,35 +311,83 @@
> >      '*u64x':   'uint64'  } }
> > =20
> >  # testing event
> > +##
> > +# @EventStructOne:
> > +##
> >  { 'struct': 'EventStructOne',
> >    'data': { 'struct1': 'UserDefOne', 'string': 'str', '*enum2': 'EnumO=
ne'
> >    } }
> > =20
> > +##
> > +# @EVENT_A:
> > +##
> >  { 'event': 'EVENT_A' }
> > +##
> > +# @EVENT_B:
> > +##
> >  { 'event': 'EVENT_B',
> >    'data': { } }
> > +##
> > +# @EVENT_C:
> > +##
> >  { 'event': 'EVENT_C',
> >    'data': { '*a': 'int', '*b': 'UserDefOne', 'c': 'str' } }
> > +##
> > +# @EVENT_D:
> > +##
> >  { 'event': 'EVENT_D',
> >    'data': { 'a' : 'EventStructOne', 'b' : 'str', '*c': 'str', '*enum3'=
:
> >    'EnumOne' } }
> > +##
> > +# @EVENT_E:
> > +##
> >  { 'event': 'EVENT_E', 'boxed': true, 'data': 'UserDefZero' }
> > +##
> > +# @EVENT_F:
> > +##
> >  { 'event': 'EVENT_F', 'boxed': true, 'data': 'UserDefAlternate' }
> > =20
> >  # test that we correctly compile downstream extensions, as well as mun=
ge
> >  # ticklish names
> > +##
> > +# @__org.qemu_x-Enum:
> > +##
> >  { 'enum': '__org.qemu_x-Enum', 'data': [ '__org.qemu_x-value' ] }
> > +##
> > +# @__org.qemu_x-Base:
> > +##
> >  { 'struct': '__org.qemu_x-Base',
> >    'data': { '__org.qemu_x-member1': '__org.qemu_x-Enum' } }
> > +##
> > +# @__org.qemu_x-Struct:
> > +##
> >  { 'struct': '__org.qemu_x-Struct', 'base': '__org.qemu_x-Base',
> >    'data': { '__org.qemu_x-member2': 'str', '*wchar-t': 'int' } }
> > +##
> > +# @__org.qemu_x-Union1:
> > +##
> >  { 'union': '__org.qemu_x-Union1', 'data': { '__org.qemu_x-branch': 'st=
r' }
> >  }
> > +##
> > +# @__org.qemu_x-Struct2:
> > +##
> >  { 'struct': '__org.qemu_x-Struct2',
> >    'data': { 'array': ['__org.qemu_x-Union1'] } }
> > +##
> > +# @__org.qemu_x-Union2:
> > +##
> >  { 'union': '__org.qemu_x-Union2', 'base': '__org.qemu_x-Base',
> >    'discriminator': '__org.qemu_x-member1',
> >    'data': { '__org.qemu_x-value': '__org.qemu_x-Struct2' } }
> > +##
> > +# @__org.qemu_x-Alt:
> > +##
> >  { 'alternate': '__org.qemu_x-Alt',
> >    'data': { '__org.qemu_x-branch': 'str', 'b': '__org.qemu_x-Base' } }
> > +##
> > +# @__ORG.QEMU_X-EVENT:
> > +##
> >  { 'event': '__ORG.QEMU_X-EVENT', 'data': '__org.qemu_x-Struct' }
> > +##
> > +# @__org.qemu_x-command:
> > +##
> >  { 'command': '__org.qemu_x-command',
> >    'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
> >              'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
> > diff --git a/tests/qapi-schema/qapi-schema-test.out
> > b/tests/qapi-schema/qapi-schema-test.out
> > index 9d99c4eebb..1b44be8045 100644
> > --- a/tests/qapi-schema/qapi-schema-test.out
> > +++ b/tests/qapi-schema/qapi-schema-test.out
> > @@ -232,3 +232,215 @@ command user_def_cmd1 q_obj_user_def_cmd1-arg -> =
None
> >     gen=3DTrue success_response=3DTrue boxed=3DFalse
> >  command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
> >     gen=3DTrue success_response=3DTrue boxed=3DFalse
> > +doc freeform
> > +    body=3D
> > +=3D Section
> > +=3D=3D subsection
> > +
> > +Some text foo with *strong* and _emphasis_
> > +1. with a list
> > +2. like that @foo
> > +
> > +And some code:
> > +| $ echo foo
> > +| -> do this
> > +| <- get that
> > +
> > +Note: is not a meta
> > +doc symbol=3DTestStruct expr=3D('struct', 'TestStruct')
> > +    arg=3Dinteger
> > +foo
> > +blah
> > +
> > +bao
> > +    arg=3Dboolean
> > +bar
> > +    arg=3Dstring
> > +baz
> > +    section=3DExample
> > +-> { "execute": ... }
> > +<- { "return": ... }
> > +    section=3DSince
> > +2.3
> > +    section=3DNote
> > +a note
> > +    body=3D
> > +body with @var
> > +doc symbol=3DNestedEnumsOne expr=3D('struct', 'NestedEnumsOne')
> > +    body=3D
> > +for testing enums
> > +doc symbol=3DMyEnum expr=3D('enum', 'MyEnum')
> > +    body=3D
> > +An empty enum, although unusual, is currently acceptable
> > +doc symbol=3DEmpty1 expr=3D('struct', 'Empty1')
> > +    body=3D
> > +Likewise for an empty struct, including an empty base
> > +doc symbol=3DEmpty2 expr=3D('struct', 'Empty2')
> > +    body=3D
> > +
> > +doc symbol=3Duser_def_cmd0 expr=3D('command', 'user_def_cmd0')
> > +    body=3D
> > +
> > +doc symbol=3DQEnumTwo expr=3D('enum', 'QEnumTwo')
> > +    body=3D
> > +for testing override of default naming heuristic
> > +doc symbol=3DUserDefOne expr=3D('struct', 'UserDefOne')
> > +    body=3D
> > +for testing nested structs
> > +doc symbol=3DEnumOne expr=3D('enum', 'EnumOne')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefZero expr=3D('struct', 'UserDefZero')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefTwoDictDict expr=3D('struct', 'UserDefTwoDictDict'=
)
> > +    body=3D
> > +
> > +doc symbol=3DUserDefTwoDict expr=3D('struct', 'UserDefTwoDict')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefTwo expr=3D('struct', 'UserDefTwo')
> > +    body=3D
> > +
> > +doc symbol=3DForceArrays expr=3D('struct', 'ForceArrays')
> > +    body=3D
> > +dummy struct to force generation of array types not otherwise mentione=
d
> > +doc symbol=3DUserDefA expr=3D('struct', 'UserDefA')
> > +    body=3D
> > +for testing unions
> > +Among other things, test that a name collision between branches does
> > +not cause any problems (since only one branch can be in use at a time)=
,
> > +by intentionally using two branches that both have a C member 'a_b'
> > +doc symbol=3DUserDefB expr=3D('struct', 'UserDefB')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefFlatUnion expr=3D('union', 'UserDefFlatUnion')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefUnionBase expr=3D('struct', 'UserDefUnionBase')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefFlatUnion2 expr=3D('union', 'UserDefFlatUnion2')
> > +    body=3D
> > +this variant of UserDefFlatUnion defaults to a union that uses members
> > with
> > +allocated types to test corner cases in the cleanup/dealloc visitor
> > +doc symbol=3DWrapAlternate expr=3D('struct', 'WrapAlternate')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefAlternate expr=3D('alternate', 'UserDefAlternate')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefC expr=3D('struct', 'UserDefC')
> > +    body=3D
> > +
> > +doc symbol=3DAltStrBool expr=3D('alternate', 'AltStrBool')
> > +    body=3D
> > +
> > +doc symbol=3DAltStrNum expr=3D('alternate', 'AltStrNum')
> > +    body=3D
> > +
> > +doc symbol=3DAltNumStr expr=3D('alternate', 'AltNumStr')
> > +    body=3D
> > +
> > +doc symbol=3DAltStrInt expr=3D('alternate', 'AltStrInt')
> > +    body=3D
> > +
> > +doc symbol=3DAltIntNum expr=3D('alternate', 'AltIntNum')
> > +    body=3D
> > +
> > +doc symbol=3DAltNumInt expr=3D('alternate', 'AltNumInt')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefNativeListUnion expr=3D('union', 'UserDefNativeLis=
tUnion')
> > +    body=3D
> > +for testing native lists
> > +doc symbol=3Duser_def_cmd expr=3D('command', 'user_def_cmd')
> > +    body=3D
> > +
> > +doc symbol=3Duser_def_cmd1 expr=3D('command', 'user_def_cmd1')
> > +    body=3D
> > +
> > +doc symbol=3Duser_def_cmd2 expr=3D('command', 'user_def_cmd2')
> > +    body=3D
> > +
> > +doc freeform
> > +    body=3D
> > +Another comment
> > +doc symbol=3Dguest-get-time expr=3D('command', 'guest-get-time')
> > +    arg=3Da
> > +an integer
> > +    arg=3Db
> > +#optional integer
> > +    section=3DReturns
> > +returns something
> > +    section=3DExample
> > +-> { "execute": "guest-get-time", ... }
> > +<- { "return": "42" }
> > +    body=3D
> > +@guest-get-time body
> > +doc symbol=3Dguest-sync expr=3D('command', 'guest-sync')
> > +    body=3D
> > +
> > +doc symbol=3Dboxed-struct expr=3D('command', 'boxed-struct')
> > +    body=3D
> > +
> > +doc symbol=3Dboxed-union expr=3D('command', 'boxed-union')
> > +    body=3D
> > +
> > +doc symbol=3DUserDefOptions expr=3D('struct', 'UserDefOptions')
> > +    body=3D
> > +For testing integer range flattening in opts-visitor. The following sc=
hema
> > +corresponds to the option format:
> > +
> > +-userdef i64=3D3-6,i64=3D-5--1,u64=3D2,u16=3D1,u16=3D7-12
> > +
> > +For simplicity, this example doesn't use [type=3D]discriminator nor op=
targs
> > +specific to discriminator values.
> > +doc symbol=3DEventStructOne expr=3D('struct', 'EventStructOne')
> > +    body=3D
> > +
> > +doc symbol=3DEVENT_A expr=3D('event', 'EVENT_A')
> > +    body=3D
> > +
> > +doc symbol=3DEVENT_B expr=3D('event', 'EVENT_B')
> > +    body=3D
> > +
> > +doc symbol=3DEVENT_C expr=3D('event', 'EVENT_C')
> > +    body=3D
> > +
> > +doc symbol=3DEVENT_D expr=3D('event', 'EVENT_D')
> > +    body=3D
> > +
> > +doc symbol=3DEVENT_E expr=3D('event', 'EVENT_E')
> > +    body=3D
> > +
> > +doc symbol=3DEVENT_F expr=3D('event', 'EVENT_F')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Enum expr=3D('enum', '__org.qemu_x-Enum')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Base expr=3D('struct', '__org.qemu_x-Base')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Struct expr=3D('struct', '__org.qemu_x-Struc=
t')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Union1 expr=3D('union', '__org.qemu_x-Union1=
')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Struct2 expr=3D('struct', '__org.qemu_x-Stru=
ct2')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Union2 expr=3D('union', '__org.qemu_x-Union2=
')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-Alt expr=3D('alternate', '__org.qemu_x-Alt')
> > +    body=3D
> > +
> > +doc symbol=3D__ORG.QEMU_X-EVENT expr=3D('event', '__ORG.QEMU_X-EVENT')
> > +    body=3D
> > +
> > +doc symbol=3D__org.qemu_x-command expr=3D('command', '__org.qemu_x-com=
mand')
> > +    body=3D
> > +
> > diff --git a/tests/qapi-schema/redefined-builtin.err
> > b/tests/qapi-schema/redefined-builtin.err
> > index b2757225c4..ee0a2adf0b 100644
> > --- a/tests/qapi-schema/redefined-builtin.err
> > +++ b/tests/qapi-schema/redefined-builtin.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/redefined-builtin.json:2: built-in 'size' is already
> > defined
> > +tests/qapi-schema/redefined-builtin.json:6: built-in 'size' is already
> > defined
> > diff --git a/tests/qapi-schema/redefined-builtin.json
> > b/tests/qapi-schema/redefined-builtin.json
> > index 45b8a550ad..6d3a940d5e 100644
> > --- a/tests/qapi-schema/redefined-builtin.json
> > +++ b/tests/qapi-schema/redefined-builtin.json
> > @@ -1,2 +1,6 @@
> >  # we reject types that duplicate builtin names
> > +
> > +##
> > +# @size:
> > +##
> >  { 'struct': 'size', 'data': { 'myint': 'size' } }
> > diff --git a/tests/qapi-schema/redefined-command.err
> > b/tests/qapi-schema/redefined-command.err
> > index 82ae256e63..1e297c43ba 100644
> > --- a/tests/qapi-schema/redefined-command.err
> > +++ b/tests/qapi-schema/redefined-command.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/redefined-command.json:3: command 'foo' is already
> > defined
> > +tests/qapi-schema/redefined-command.json:10: command 'foo' is already
> > defined
> > diff --git a/tests/qapi-schema/redefined-command.json
> > b/tests/qapi-schema/redefined-command.json
> > index 247e401948..3a8cb9024c 100644
> > --- a/tests/qapi-schema/redefined-command.json
> > +++ b/tests/qapi-schema/redefined-command.json
> > @@ -1,3 +1,10 @@
> >  # we reject commands defined more than once
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'data': { 'one': 'str' } }
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'data': { '*two': 'str' } }
> > diff --git a/tests/qapi-schema/redefined-event.err
> > b/tests/qapi-schema/redefined-event.err
> > index 35429cb481..912c785119 100644
> > --- a/tests/qapi-schema/redefined-event.err
> > +++ b/tests/qapi-schema/redefined-event.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/redefined-event.json:3: event 'EVENT_A' is already
> > defined
> > +tests/qapi-schema/redefined-event.json:10: event 'EVENT_A' is already
> > defined
> > diff --git a/tests/qapi-schema/redefined-event.json
> > b/tests/qapi-schema/redefined-event.json
> > index 7717e91c18..ec7aeea0f0 100644
> > --- a/tests/qapi-schema/redefined-event.json
> > +++ b/tests/qapi-schema/redefined-event.json
> > @@ -1,3 +1,10 @@
> >  # we reject duplicate events
> > +
> > +##
> > +# @EVENT_A:
> > +##
> >  { 'event': 'EVENT_A', 'data': { 'myint': 'int' } }
> > +##
> > +# @EVENT_A:
> > +##
> >  { 'event': 'EVENT_A', 'data': { 'myint': 'int' } }
> > diff --git a/tests/qapi-schema/redefined-type.err
> > b/tests/qapi-schema/redefined-type.err
> > index 06ea78c478..28d87c098c 100644
> > --- a/tests/qapi-schema/redefined-type.err
> > +++ b/tests/qapi-schema/redefined-type.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/redefined-type.json:3: struct 'foo' is already defin=
ed
> > +tests/qapi-schema/redefined-type.json:10: struct 'foo' is already defi=
ned
> > diff --git a/tests/qapi-schema/redefined-type.json
> > b/tests/qapi-schema/redefined-type.json
> > index a09e768bae..7a8f3e1ec8 100644
> > --- a/tests/qapi-schema/redefined-type.json
> > +++ b/tests/qapi-schema/redefined-type.json
> > @@ -1,3 +1,10 @@
> >  # we reject types defined more than once
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'struct': 'foo', 'data': { 'one': 'str' } }
> > +##
> > +# @foo:
> > +##
> >  { 'enum': 'foo', 'data': [ 'two' ] }
> > diff --git a/tests/qapi-schema/reserved-command-q.err
> > b/tests/qapi-schema/reserved-command-q.err
> > index f939e044eb..5e17f3169b 100644
> > --- a/tests/qapi-schema/reserved-command-q.err
> > +++ b/tests/qapi-schema/reserved-command-q.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-command-q.json:5: 'command' uses invalid na=
me
> > 'q-unix'
> > +tests/qapi-schema/reserved-command-q.json:12: 'command' uses invalid n=
ame
> > 'q-unix'
> > diff --git a/tests/qapi-schema/reserved-command-q.json
> > b/tests/qapi-schema/reserved-command-q.json
> > index 99f8aae314..bba0860c99 100644
> > --- a/tests/qapi-schema/reserved-command-q.json
> > +++ b/tests/qapi-schema/reserved-command-q.json
> > @@ -1,5 +1,12 @@
> >  # C entity name collision
> >  # We reject names like 'q-unix', because they can collide with the man=
gled
> >  # name for 'unix' in generated C.
> > +
> > +##
> > +# @unix:
> > +##
> >  { 'command': 'unix' }
> > +##
> > +# @q-unix:
> > +##
> >  { 'command': 'q-unix' }
> > diff --git a/tests/qapi-schema/reserved-enum-q.err
> > b/tests/qapi-schema/reserved-enum-q.err
> > index e1c3480ee2..acb2df811d 100644
> > --- a/tests/qapi-schema/reserved-enum-q.err
> > +++ b/tests/qapi-schema/reserved-enum-q.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-enum-q.json:4: Member of enum 'Foo' uses
> > invalid name 'q-Unix'
> > +tests/qapi-schema/reserved-enum-q.json:8: Member of enum 'Foo' uses
> > invalid name 'q-Unix'
> > diff --git a/tests/qapi-schema/reserved-enum-q.json
> > b/tests/qapi-schema/reserved-enum-q.json
> > index 3593a765ea..6c7e7177c3 100644
> > --- a/tests/qapi-schema/reserved-enum-q.json
> > +++ b/tests/qapi-schema/reserved-enum-q.json
> > @@ -1,4 +1,8 @@
> >  # C entity name collision
> >  # We reject names like 'q-unix', because they can collide with the man=
gled
> >  # name for 'unix' in generated C.
> > +
> > +##
> > +# @Foo:
> > +##
> >  { 'enum': 'Foo', 'data': [ 'unix', 'q-Unix' ] }
> > diff --git a/tests/qapi-schema/reserved-member-has.err
> > b/tests/qapi-schema/reserved-member-has.err
> > index e755771446..9ace796055 100644
> > --- a/tests/qapi-schema/reserved-member-has.err
> > +++ b/tests/qapi-schema/reserved-member-has.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-member-has.json:5: Member of 'data' for com=
mand
> > 'oops' uses reserved name 'has-a'
> > +tests/qapi-schema/reserved-member-has.json:9: Member of 'data' for com=
mand
> > 'oops' uses reserved name 'has-a'
> > diff --git a/tests/qapi-schema/reserved-member-has.json
> > b/tests/qapi-schema/reserved-member-has.json
> > index 45b9109bdc..f0d8905ca2 100644
> > --- a/tests/qapi-schema/reserved-member-has.json
> > +++ b/tests/qapi-schema/reserved-member-has.json
> > @@ -2,4 +2,8 @@
> >  # We reject names like 'has-a', because they can collide with the flag
> >  # for an optional 'a' in generated C.
> >  # TODO we could munge the optional flag name to avoid the collision.
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'data': { '*a': 'str', 'has-a': 'str' } }
> > diff --git a/tests/qapi-schema/reserved-member-q.err
> > b/tests/qapi-schema/reserved-member-q.err
> > index f3d5dd7818..1709a88462 100644
> > --- a/tests/qapi-schema/reserved-member-q.err
> > +++ b/tests/qapi-schema/reserved-member-q.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-member-q.json:4: Member of 'data' for struc=
t
> > 'Foo' uses invalid name 'q-unix'
> > +tests/qapi-schema/reserved-member-q.json:8: Member of 'data' for struc=
t
> > 'Foo' uses invalid name 'q-unix'
> > diff --git a/tests/qapi-schema/reserved-member-q.json
> > b/tests/qapi-schema/reserved-member-q.json
> > index 62fed8fddf..f51e312917 100644
> > --- a/tests/qapi-schema/reserved-member-q.json
> > +++ b/tests/qapi-schema/reserved-member-q.json
> > @@ -1,4 +1,8 @@
> >  # C member name collision
> >  # We reject names like 'q-unix', because they can collide with the man=
gled
> >  # name for 'unix' in generated C.
> > +
> > +##
> > +# @Foo:
> > +##
> >  { 'struct': 'Foo', 'data': { 'unix':'int', 'q-unix':'bool' } }
> > diff --git a/tests/qapi-schema/reserved-member-u.err
> > b/tests/qapi-schema/reserved-member-u.err
> > index 87d42296cc..6ec69a712a 100644
> > --- a/tests/qapi-schema/reserved-member-u.err
> > +++ b/tests/qapi-schema/reserved-member-u.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-member-u.json:7: Member of 'data' for struc=
t
> > 'Oops' uses reserved name 'u'
> > +tests/qapi-schema/reserved-member-u.json:11: Member of 'data' for stru=
ct
> > 'Oops' uses reserved name 'u'
> > diff --git a/tests/qapi-schema/reserved-member-u.json
> > b/tests/qapi-schema/reserved-member-u.json
> > index 1eaf0f301c..3a578e5b56 100644
> > --- a/tests/qapi-schema/reserved-member-u.json
> > +++ b/tests/qapi-schema/reserved-member-u.json
> > @@ -4,4 +4,8 @@
> >  # This is true even for non-unions, because it is possible to convert =
a
> >  # struct to flat union while remaining backwards compatible in QMP.
> >  # TODO - we could munge the member name to 'q_u' to avoid the collisio=
n
> > +
> > +##
> > +# @Oops:
> > +##
> >  { 'struct': 'Oops', 'data': { 'u': 'str' } }
> > diff --git a/tests/qapi-schema/reserved-member-underscore.err
> > b/tests/qapi-schema/reserved-member-underscore.err
> > index 65ff0da8ce..c9aefee3a8 100644
> > --- a/tests/qapi-schema/reserved-member-underscore.err
> > +++ b/tests/qapi-schema/reserved-member-underscore.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-member-underscore.json:4: Member of 'data' =
for
> > struct 'Oops' uses invalid name '_oops'
> > +tests/qapi-schema/reserved-member-underscore.json:8: Member of 'data' =
for
> > struct 'Oops' uses invalid name '_oops'
> > diff --git a/tests/qapi-schema/reserved-member-underscore.json
> > b/tests/qapi-schema/reserved-member-underscore.json
> > index 4a3a017638..cc34b54b02 100644
> > --- a/tests/qapi-schema/reserved-member-underscore.json
> > +++ b/tests/qapi-schema/reserved-member-underscore.json
> > @@ -1,4 +1,8 @@
> >  # C member name collision
> >  # We reject use of a single leading underscore in all names (names mus=
t
> >  # begin with a letter or a downstream extension double-underscore pref=
ix).
> > +
> > +##
> > +# @Oops:
> > +##
> >  { 'struct': 'Oops', 'data': { '_oops': 'str' } }
> > diff --git a/tests/qapi-schema/reserved-type-kind.err
> > b/tests/qapi-schema/reserved-type-kind.err
> > index 0a38efaad8..8698073062 100644
> > --- a/tests/qapi-schema/reserved-type-kind.err
> > +++ b/tests/qapi-schema/reserved-type-kind.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-type-kind.json:2: enum 'UnionKind' should n=
ot
> > end in 'Kind'
> > +tests/qapi-schema/reserved-type-kind.json:6: enum 'UnionKind' should n=
ot
> > end in 'Kind'
> > diff --git a/tests/qapi-schema/reserved-type-kind.json
> > b/tests/qapi-schema/reserved-type-kind.json
> > index 9ecaba12bc..a094941561 100644
> > --- a/tests/qapi-schema/reserved-type-kind.json
> > +++ b/tests/qapi-schema/reserved-type-kind.json
> > @@ -1,2 +1,6 @@
> >  # we reject types that would conflict with implicit union enum
> > +
> > +##
> > +# @UnionKind:
> > +##
> >  { 'enum': 'UnionKind', 'data': [ 'oops' ] }
> > diff --git a/tests/qapi-schema/reserved-type-list.err
> > b/tests/qapi-schema/reserved-type-list.err
> > index 4510fa6d90..ec0531c4b9 100644
> > --- a/tests/qapi-schema/reserved-type-list.err
> > +++ b/tests/qapi-schema/reserved-type-list.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/reserved-type-list.json:5: struct 'FooList' should n=
ot
> > end in 'List'
> > +tests/qapi-schema/reserved-type-list.json:9: struct 'FooList' should n=
ot
> > end in 'List'
> > diff --git a/tests/qapi-schema/reserved-type-list.json
> > b/tests/qapi-schema/reserved-type-list.json
> > index 98d53bf808..6effb78e7f 100644
> > --- a/tests/qapi-schema/reserved-type-list.json
> > +++ b/tests/qapi-schema/reserved-type-list.json
> > @@ -2,4 +2,8 @@
> >  # We reserve names ending in 'List' for use by array types.
> >  # TODO - we could choose array names to avoid collision with user type=
s,
> >  # in order to let this compile
> > +
> > +##
> > +# @FooList:
> > +##
> >  { 'struct': 'FooList', 'data': { 's': 'str' } }
> > diff --git a/tests/qapi-schema/returns-alternate.err
> > b/tests/qapi-schema/returns-alternate.err
> > index dfbb419cac..2b81623ca3 100644
> > --- a/tests/qapi-schema/returns-alternate.err
> > +++ b/tests/qapi-schema/returns-alternate.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/returns-alternate.json:3: 'returns' for command 'oop=
s'
> > cannot use alternate type 'Alt'
> > +tests/qapi-schema/returns-alternate.json:10: 'returns' for command 'oo=
ps'
> > cannot use alternate type 'Alt'
> > diff --git a/tests/qapi-schema/returns-alternate.json
> > b/tests/qapi-schema/returns-alternate.json
> > index 972390c06b..005bf2d148 100644
> > --- a/tests/qapi-schema/returns-alternate.json
> > +++ b/tests/qapi-schema/returns-alternate.json
> > @@ -1,3 +1,10 @@
> >  # we reject returns if it is an alternate type
> > +
> > +##
> > +# @Alt:
> > +##
> >  { 'alternate': 'Alt', 'data': { 'a': 'int', 'b': 'str' } }
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'returns': 'Alt' }
> > diff --git a/tests/qapi-schema/returns-array-bad.err
> > b/tests/qapi-schema/returns-array-bad.err
> > index 138095ccde..b53bdb0ade 100644
> > --- a/tests/qapi-schema/returns-array-bad.err
> > +++ b/tests/qapi-schema/returns-array-bad.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/returns-array-bad.json:2: 'returns' for command 'oop=
s':
> > array type must contain single type name
> > +tests/qapi-schema/returns-array-bad.json:6: 'returns' for command 'oop=
s':
> > array type must contain single type name
> > diff --git a/tests/qapi-schema/returns-array-bad.json
> > b/tests/qapi-schema/returns-array-bad.json
> > index 09b0b1f182..30528fed29 100644
> > --- a/tests/qapi-schema/returns-array-bad.json
> > +++ b/tests/qapi-schema/returns-array-bad.json
> > @@ -1,2 +1,6 @@
> >  # we reject an array return that is not a single type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'returns': [ 'str', 'str' ] }
> > diff --git a/tests/qapi-schema/returns-dict.err
> > b/tests/qapi-schema/returns-dict.err
> > index eb2d0c4661..1570a35d49 100644
> > --- a/tests/qapi-schema/returns-dict.err
> > +++ b/tests/qapi-schema/returns-dict.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/returns-dict.json:2: 'returns' for command 'oops' sh=
ould
> > be a type name
> > +tests/qapi-schema/returns-dict.json:6: 'returns' for command 'oops' sh=
ould
> > be a type name
> > diff --git a/tests/qapi-schema/returns-dict.json
> > b/tests/qapi-schema/returns-dict.json
> > index 1cfef3ede7..6a3ed0f34d 100644
> > --- a/tests/qapi-schema/returns-dict.json
> > +++ b/tests/qapi-schema/returns-dict.json
> > @@ -1,2 +1,6 @@
> >  # we reject inline struct return type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'returns': { 'a': 'str' } }
> > diff --git a/tests/qapi-schema/returns-unknown.err
> > b/tests/qapi-schema/returns-unknown.err
> > index 1f43e3ac9f..d76bcfe455 100644
> > --- a/tests/qapi-schema/returns-unknown.err
> > +++ b/tests/qapi-schema/returns-unknown.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/returns-unknown.json:2: 'returns' for command 'oops'
> > uses unknown type 'NoSuchType'
> > +tests/qapi-schema/returns-unknown.json:6: 'returns' for command 'oops'
> > uses unknown type 'NoSuchType'
> > diff --git a/tests/qapi-schema/returns-unknown.json
> > b/tests/qapi-schema/returns-unknown.json
> > index 25bd498bff..3837f0e607 100644
> > --- a/tests/qapi-schema/returns-unknown.json
> > +++ b/tests/qapi-schema/returns-unknown.json
> > @@ -1,2 +1,6 @@
> >  # we reject returns if it does not contain a known type
> > +
> > +##
> > +# @oops:
> > +##
> >  { 'command': 'oops', 'returns': 'NoSuchType' }
> > diff --git a/tests/qapi-schema/returns-whitelist.err
> > b/tests/qapi-schema/returns-whitelist.err
> > index f47c1ee7ca..e77ea2da3f 100644
> > --- a/tests/qapi-schema/returns-whitelist.err
> > +++ b/tests/qapi-schema/returns-whitelist.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/returns-whitelist.json:10: 'returns' for command
> > 'no-way-this-will-get-whitelisted' cannot use built-in type 'int'
> > +tests/qapi-schema/returns-whitelist.json:26: 'returns' for command
> > 'no-way-this-will-get-whitelisted' cannot use built-in type 'int'
> > diff --git a/tests/qapi-schema/returns-whitelist.json
> > b/tests/qapi-schema/returns-whitelist.json
> > index e8b3cea396..0bc952db87 100644
> > --- a/tests/qapi-schema/returns-whitelist.json
> > +++ b/tests/qapi-schema/returns-whitelist.json
> > @@ -1,11 +1,27 @@
> >  # we enforce that 'returns' be a dict or array of dict unless whitelis=
ted
> > +
> > +##
> > +# @human-monitor-command:
> > +##
> >  { 'command': 'human-monitor-command',
> >    'data': {'command-line': 'str', '*cpu-index': 'int'},
> >    'returns': 'str' }
> > +##
> > +# @TpmModel:
> > +##
> >  { 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
> > +##
> > +# @query-tpm-models:
> > +##
> >  { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
> > +##
> > +# @guest-get-time:
> > +##
> >  { 'command': 'guest-get-time',
> >    'returns': 'int' }
> > =20
> > +##
> > +# @no-way-this-will-get-whitelisted:
> > +##
> >  { 'command': 'no-way-this-will-get-whitelisted',
> >    'returns': [ 'int' ] }
> > diff --git a/tests/qapi-schema/struct-base-clash-deep.err
> > b/tests/qapi-schema/struct-base-clash-deep.err
> > index e2d7943f21..1b7c0e9d12 100644
> > --- a/tests/qapi-schema/struct-base-clash-deep.err
> > +++ b/tests/qapi-schema/struct-base-clash-deep.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/struct-base-clash-deep.json:10: 'name' (member of Su=
b)
> > collides with 'name' (member of Base)
> > +tests/qapi-schema/struct-base-clash-deep.json:20: 'name' (member of Su=
b)
> > collides with 'name' (member of Base)
> > diff --git a/tests/qapi-schema/struct-base-clash-deep.json
> > b/tests/qapi-schema/struct-base-clash-deep.json
> > index fa873ab5d4..646d680ad6 100644
> > --- a/tests/qapi-schema/struct-base-clash-deep.json
> > +++ b/tests/qapi-schema/struct-base-clash-deep.json
> > @@ -2,11 +2,21 @@
> >  # Here, 'name' would have to appear twice on the wire, locally and
> >  # indirectly for the grandparent base; the collision doesn't care that
> >  # one instance is optional.
> > +
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'name': 'str' } }
> > +##
> > +# @Mid:
> > +##
> >  { 'struct': 'Mid',
> >    'base': 'Base',
> >    'data': { 'value': 'int' } }
> > +##
> > +# @Sub:
> > +##
> >  { 'struct': 'Sub',
> >    'base': 'Mid',
> >    'data': { '*name': 'str' } }
> > diff --git a/tests/qapi-schema/struct-base-clash.err
> > b/tests/qapi-schema/struct-base-clash.err
> > index c52f33d27b..5fe6393efa 100644
> > --- a/tests/qapi-schema/struct-base-clash.err
> > +++ b/tests/qapi-schema/struct-base-clash.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/struct-base-clash.json:5: 'name' (member of Sub)
> > collides with 'name' (member of Base)
> > +tests/qapi-schema/struct-base-clash.json:12: 'name' (member of Sub)
> > collides with 'name' (member of Base)
> > diff --git a/tests/qapi-schema/struct-base-clash.json
> > b/tests/qapi-schema/struct-base-clash.json
> > index 11aec80fe5..a8539958b5 100644
> > --- a/tests/qapi-schema/struct-base-clash.json
> > +++ b/tests/qapi-schema/struct-base-clash.json
> > @@ -1,7 +1,14 @@
> >  # Reject attempts to duplicate QMP members
> >  # Here, 'name' would have to appear twice on the wire, locally and for
> >  base.
> > +
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'name': 'str' } }
> > +##
> > +# @Sub:
> > +##
> >  { 'struct': 'Sub',
> >    'base': 'Base',
> >    'data': { 'name': 'str' } }
> > diff --git a/tests/qapi-schema/struct-data-invalid.err
> > b/tests/qapi-schema/struct-data-invalid.err
> > index 6644f4c2ad..27163355bd 100644
> > --- a/tests/qapi-schema/struct-data-invalid.err
> > +++ b/tests/qapi-schema/struct-data-invalid.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo'
> > should be a dictionary or type name
> > +tests/qapi-schema/struct-data-invalid.json:4: 'data' for struct 'foo'
> > should be a dictionary or type name
> > diff --git a/tests/qapi-schema/struct-data-invalid.json
> > b/tests/qapi-schema/struct-data-invalid.json
> > index 9adbc3bb6b..aa817bda34 100644
> > --- a/tests/qapi-schema/struct-data-invalid.json
> > +++ b/tests/qapi-schema/struct-data-invalid.json
> > @@ -1,2 +1,5 @@
> > +##
> > +# @foo:
> > +##
> >  { 'struct': 'foo',
> >    'data': false }
> > diff --git a/tests/qapi-schema/struct-member-invalid.err
> > b/tests/qapi-schema/struct-member-invalid.err
> > index 69a326d450..f2b105ba88 100644
> > --- a/tests/qapi-schema/struct-member-invalid.err
> > +++ b/tests/qapi-schema/struct-member-invalid.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/struct-member-invalid.json:1: Member 'a' of 'data' f=
or
> > struct 'foo' should be a type name
> > +tests/qapi-schema/struct-member-invalid.json:4: Member 'a' of 'data' f=
or
> > struct 'foo' should be a type name
> > diff --git a/tests/qapi-schema/struct-member-invalid.json
> > b/tests/qapi-schema/struct-member-invalid.json
> > index 8f172f7a87..10c74262d3 100644
> > --- a/tests/qapi-schema/struct-member-invalid.json
> > +++ b/tests/qapi-schema/struct-member-invalid.json
> > @@ -1,2 +1,5 @@
> > +##
> > +# @foo:
> > +##
> >  { 'struct': 'foo',
> >    'data': { 'a': false } }
> > diff --git a/tests/qapi-schema/test-qapi.py
> > b/tests/qapi-schema/test-qapi.py
> > index ef74e2c4c8..39b55b994a 100644
> > --- a/tests/qapi-schema/test-qapi.py
> > +++ b/tests/qapi-schema/test-qapi.py
> > @@ -55,3 +55,15 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
> > =20
> >  schema =3D QAPISchema(sys.argv[1])
> >  schema.visit(QAPISchemaTestVisitor())
> > +
> > +for doc in schema.docs:
> > +    if doc.symbol:
> > +        print 'doc symbol=3D%s expr=3D%s' % \
> > +            (doc.symbol, doc.expr.items()[0])
> > +    else:
> > +        print 'doc freeform'
> > +    for arg, section in doc.args.iteritems():
> > +        print '    arg=3D%s\n%s' % (arg, section)
> > +    for section in doc.sections:
> > +        print '    section=3D%s\n%s' % (section.name, section)
> > +    print '    body=3D\n%s' % doc.body
>=20
> This line seems to responsible for trailing blank lines in .out:
>=20
>     Applying: qapi: add qapi2texi script
>     /home/armbru/work/qemu/.git/rebase-apply/patch:1869: new blank line a=
t
>     EOF.
>     +
>     /home/armbru/work/qemu/.git/rebase-apply/patch:2568: new blank line a=
t
>     EOF.
>     +
>     /home/armbru/work/qemu/.git/rebase-apply/patch:3156: new blank line a=
t
>     EOF.
>     +
>     /home/armbru/work/qemu/.git/rebase-apply/patch:3177: new blank line a=
t
>     EOF.
>     +
>     /home/armbru/work/qemu/.git/rebase-apply/patch:3188: new blank line a=
t
>     EOF.
>     +
>     warning: squelched 3 whitespace errors
>     warning: 8 lines add whitespace errors.
>=20
> > diff --git a/tests/qapi-schema/type-bypass-bad-gen.err
> > b/tests/qapi-schema/type-bypass-bad-gen.err
> > index a83c3c655d..bd5431f60b 100644
> > --- a/tests/qapi-schema/type-bypass-bad-gen.err
> > +++ b/tests/qapi-schema/type-bypass-bad-gen.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/type-bypass-bad-gen.json:2: 'gen' of command 'foo'
> > should only use false value
> > +tests/qapi-schema/type-bypass-bad-gen.json:6: 'gen' of command 'foo'
> > should only use false value
> > diff --git a/tests/qapi-schema/type-bypass-bad-gen.json
> > b/tests/qapi-schema/type-bypass-bad-gen.json
> > index e8dec34249..7162c1a0ca 100644
> > --- a/tests/qapi-schema/type-bypass-bad-gen.json
> > +++ b/tests/qapi-schema/type-bypass-bad-gen.json
> > @@ -1,2 +1,6 @@
> >  # 'gen' should only appear with value false
> > +
> > +##
> > +# @foo:
> > +##
> >  { 'command': 'foo', 'gen': 'whatever' }
> > diff --git a/tests/qapi-schema/unicode-str.err
> > b/tests/qapi-schema/unicode-str.err
> > index f621cd6448..92ee277370 100644
> > --- a/tests/qapi-schema/unicode-str.err
> > +++ b/tests/qapi-schema/unicode-str.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=
=A9'
> > +tests/qapi-schema/unicode-str.json:6: 'command' uses invalid name '=C3=
=A9'
> > diff --git a/tests/qapi-schema/unicode-str.json
> > b/tests/qapi-schema/unicode-str.json
> > index 5253a1b9f3..75a08b3d93 100644
> > --- a/tests/qapi-schema/unicode-str.json
> > +++ b/tests/qapi-schema/unicode-str.json
> > @@ -1,2 +1,6 @@
> >  # we don't support full Unicode strings, yet
> > +
> > +##
> > +# @e:
> > +##
> >  { 'command': '=C3=A9' }
> > diff --git a/tests/qapi-schema/union-base-no-discriminator.err
> > b/tests/qapi-schema/union-base-no-discriminator.err
> > index 8b7a24260f..ca6ee92357 100644
> > --- a/tests/qapi-schema/union-base-no-discriminator.err
> > +++ b/tests/qapi-schema/union-base-no-discriminator.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-base-no-discriminator.json:11: Simple union
> > 'TestUnion' must not have a base
> > +tests/qapi-schema/union-base-no-discriminator.json:23: Simple union
> > 'TestUnion' must not have a base
> > diff --git a/tests/qapi-schema/union-base-no-discriminator.json
> > b/tests/qapi-schema/union-base-no-discriminator.json
> > index 1409cf5c9e..cc6bac1424 100644
> > --- a/tests/qapi-schema/union-base-no-discriminator.json
> > +++ b/tests/qapi-schema/union-base-no-discriminator.json
> > @@ -1,13 +1,25 @@
> > +##
> > +# @TestTypeA:
> > +##
> >  # we reject simple unions with a base (or flat unions without
> >  discriminator)
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > =20
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > =20
> > +##
> > +# @Base:
> > +##
> >  { 'struct': 'Base',
> >    'data': { 'string': 'str' } }
> > =20
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'Base',
> >    'data': { 'value1': 'TestTypeA',
> > diff --git a/tests/qapi-schema/union-branch-case.err
> > b/tests/qapi-schema/union-branch-case.err
> > index 11521901d8..9095bae565 100644
> > --- a/tests/qapi-schema/union-branch-case.err
> > +++ b/tests/qapi-schema/union-branch-case.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-branch-case.json:2: 'Branch' (branch of
> > NoWayThisWillGetWhitelisted) should not use uppercase
> > +tests/qapi-schema/union-branch-case.json:6: 'Branch' (branch of
> > NoWayThisWillGetWhitelisted) should not use uppercase
> > diff --git a/tests/qapi-schema/union-branch-case.json
> > b/tests/qapi-schema/union-branch-case.json
> > index e6565dc3b3..6de131548c 100644
> > --- a/tests/qapi-schema/union-branch-case.json
> > +++ b/tests/qapi-schema/union-branch-case.json
> > @@ -1,2 +1,6 @@
> >  # Branch names should be 'lower-case' unless the union is whitelisted
> > +
> > +##
> > +# @NoWayThisWillGetWhitelisted:
> > +##
> >  { 'union': 'NoWayThisWillGetWhitelisted', 'data': { 'Branch': 'int' } =
}
> > diff --git a/tests/qapi-schema/union-clash-branches.err
> > b/tests/qapi-schema/union-clash-branches.err
> > index e5b21135bb..640caeab8c 100644
> > --- a/tests/qapi-schema/union-clash-branches.err
> > +++ b/tests/qapi-schema/union-clash-branches.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-clash-branches.json:4: 'a_b' (branch of TestUn=
ion)
> > collides with 'a-b' (branch of TestUnion)
> > +tests/qapi-schema/union-clash-branches.json:8: 'a_b' (branch of TestUn=
ion)
> > collides with 'a-b' (branch of TestUnion)
> > diff --git a/tests/qapi-schema/union-clash-branches.json
> > b/tests/qapi-schema/union-clash-branches.json
> > index 3bece8c948..6615665dfe 100644
> > --- a/tests/qapi-schema/union-clash-branches.json
> > +++ b/tests/qapi-schema/union-clash-branches.json
> > @@ -1,5 +1,9 @@
> >  # Union branch name collision
> >  # Reject a union that would result in a collision in generated C names
> >  (this
> >  # would try to generate two members 'a_b').
> > +
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'data': { 'a-b': 'int', 'a_b': 'str' } }
> > diff --git a/tests/qapi-schema/union-empty.err
> > b/tests/qapi-schema/union-empty.err
> > index 12c20221bd..749bc76fc5 100644
> > --- a/tests/qapi-schema/union-empty.err
> > +++ b/tests/qapi-schema/union-empty.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-empty.json:2: Union 'Union' cannot have empty
> > 'data'
> > +tests/qapi-schema/union-empty.json:6: Union 'Union' cannot have empty
> > 'data'
> > diff --git a/tests/qapi-schema/union-empty.json
> > b/tests/qapi-schema/union-empty.json
> > index 1f0b13ca21..c9b0a1ef33 100644
> > --- a/tests/qapi-schema/union-empty.json
> > +++ b/tests/qapi-schema/union-empty.json
> > @@ -1,2 +1,6 @@
> >  # unions cannot be empty
> > +
> > +##
> > +# @Union:
> > +##
> >  { 'union': 'Union', 'data': { } }
> > diff --git a/tests/qapi-schema/union-invalid-base.err
> > b/tests/qapi-schema/union-invalid-base.err
> > index 03d7b97a93..41e238f453 100644
> > --- a/tests/qapi-schema/union-invalid-base.err
> > +++ b/tests/qapi-schema/union-invalid-base.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-invalid-base.json:8: 'base' for union 'TestUni=
on'
> > cannot use built-in type 'int'
> > +tests/qapi-schema/union-invalid-base.json:18: 'base' for union 'TestUn=
ion'
> > cannot use built-in type 'int'
> > diff --git a/tests/qapi-schema/union-invalid-base.json
> > b/tests/qapi-schema/union-invalid-base.json
> > index 92be39df69..fd837cb80b 100644
> > --- a/tests/qapi-schema/union-invalid-base.json
> > +++ b/tests/qapi-schema/union-invalid-base.json
> > @@ -1,10 +1,20 @@
> >  # a union base type must be a struct
> > +
> > +##
> > +# @TestTypeA:
> > +##
> >  { 'struct': 'TestTypeA',
> >    'data': { 'string': 'str' } }
> > =20
> > +##
> > +# @TestTypeB:
> > +##
> >  { 'struct': 'TestTypeB',
> >    'data': { 'integer': 'int' } }
> > =20
> > +##
> > +# @TestUnion:
> > +##
> >  { 'union': 'TestUnion',
> >    'base': 'int',
> >    'discriminator': 'int',
> > diff --git a/tests/qapi-schema/union-optional-branch.err
> > b/tests/qapi-schema/union-optional-branch.err
> > index 3ada1334dc..60523c07e4 100644
> > --- a/tests/qapi-schema/union-optional-branch.err
> > +++ b/tests/qapi-schema/union-optional-branch.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-optional-branch.json:2: Member of union 'Union=
'
> > does not allow optional name '*a'
> > +tests/qapi-schema/union-optional-branch.json:6: Member of union 'Union=
'
> > does not allow optional name '*a'
> > diff --git a/tests/qapi-schema/union-optional-branch.json
> > b/tests/qapi-schema/union-optional-branch.json
> > index 591615fc68..7d2ee4c730 100644
> > --- a/tests/qapi-schema/union-optional-branch.json
> > +++ b/tests/qapi-schema/union-optional-branch.json
> > @@ -1,2 +1,6 @@
> >  # union branches cannot be optional
> > +
> > +##
> > +# @Union:
> > +##
> >  { 'union': 'Union', 'data': { '*a': 'int', 'b': 'str' } }
> > diff --git a/tests/qapi-schema/union-unknown.err
> > b/tests/qapi-schema/union-unknown.err
> > index 54fe456f9c..5568302205 100644
> > --- a/tests/qapi-schema/union-unknown.err
> > +++ b/tests/qapi-schema/union-unknown.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/union-unknown.json:2: Member 'unknown' of union 'Uni=
on'
> > uses unknown type 'MissingType'
> > +tests/qapi-schema/union-unknown.json:6: Member 'unknown' of union 'Uni=
on'
> > uses unknown type 'MissingType'
> > diff --git a/tests/qapi-schema/union-unknown.json
> > b/tests/qapi-schema/union-unknown.json
> > index aa7e8143d8..5042b23197 100644
> > --- a/tests/qapi-schema/union-unknown.json
> > +++ b/tests/qapi-schema/union-unknown.json
> > @@ -1,3 +1,7 @@
> >  # we reject a union with unknown type in branch
> > +
> > +##
> > +# @Union:
> > +##
> >  { 'union': 'Union',
> >    'data': { 'unknown': 'MissingType' } }
> > diff --git a/tests/qapi-schema/unknown-escape.err
> > b/tests/qapi-schema/unknown-escape.err
> > index 000e30ddf3..1a4ead632b 100644
> > --- a/tests/qapi-schema/unknown-escape.err
> > +++ b/tests/qapi-schema/unknown-escape.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/unknown-escape.json:3:21: Unknown escape \x
> > +tests/qapi-schema/unknown-escape.json:7:21: Unknown escape \x
> > diff --git a/tests/qapi-schema/unknown-escape.json
> > b/tests/qapi-schema/unknown-escape.json
> > index 8e6891e52a..e3ae6793f2 100644
> > --- a/tests/qapi-schema/unknown-escape.json
> > +++ b/tests/qapi-schema/unknown-escape.json
> > @@ -1,3 +1,7 @@
> >  # we only recognize JSON escape sequences, plus our \' extension (no \=
x)
> > +
> > +##
> > +# @foo:
> > +##
> >  # { 'command': 'foo', 'data': {} }
> >  { 'command': 'foo', 'dat\x61':{} }
> > diff --git a/tests/qapi-schema/unknown-expr-key.err
> > b/tests/qapi-schema/unknown-expr-key.err
> > index 12f5ed5b43..b19a668bd6 100644
> > --- a/tests/qapi-schema/unknown-expr-key.err
> > +++ b/tests/qapi-schema/unknown-expr-key.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in stru=
ct
> > 'bar'
> > +tests/qapi-schema/unknown-expr-key.json:6: Unknown key 'bogus' in stru=
ct
> > 'bar'
> > diff --git a/tests/qapi-schema/unknown-expr-key.json
> > b/tests/qapi-schema/unknown-expr-key.json
> > index 3b2be00cc4..1b764c7b9d 100644
> > --- a/tests/qapi-schema/unknown-expr-key.json
> > +++ b/tests/qapi-schema/unknown-expr-key.json
> > @@ -1,2 +1,6 @@
> >  # we reject an expression with unknown top-level keys
> > +
> > +##
> > +# @bar:
> > +##
> >  { 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { } }
>=20
