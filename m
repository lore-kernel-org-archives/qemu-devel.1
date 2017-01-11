Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRJrG-0004Hd-OS
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRJrD-0004SD-En
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:26:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRJrD-0004Rq-39
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:26:31 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 138B8C0467E5
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 14:26:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-16-marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 15:26:27 +0100
In-Reply-To: <20170109143437.30554-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 9 Jan 2017
	15:34:31 +0100")
Message-ID: <87shopn04s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 15/21] qapi: add qapi2texi script
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
> Symbol description:
>
>   ##
>   # @symbol:
>   #
>   # Symbol body ditto ergo sum. Foo bar
>   # baz ding.
>   #
>   # @param1: the frob to frobnicate
>   # @param2: #optional how hard to frobnicate
>   #
>   # Returns: the frobnicated frob.
>   #          If frob isn't frobnicatable, GenericError.
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
> symbol_comment =3D "# @" name ":\n" { member | tag_section | freeform_com=
ment }
> member =3D "# @" name ':' [ text ] "\n" freeform_comment
> tag_section =3D "# " ( "Returns:", "Since:", "Note:", "Notes:", "Example:=
", "Examples:" ) [ text ]  "\n" freeform_comment
> text =3D free text with markup
>
> Note that the grammar is ambiguous: a line "# @foo:\n" can be parsed
> both as freeform_comment and as symbol_comment.  The actual parser
> recognizes symbol_comment.
>
> See docs/qapi-code-gen.txt for more details.
>
> Deficiencies:

Perhaps "Deficiencies and limitations".

> - the generated QMP documentation includes internal types
> - union-type support is lacking

"union type" (no dash).

> - type information is lacking in generated documentation
> - doc comment error message positions are imprecise, they point
>   to the beginning of the comment.
> - see other TODO/FIXME in this commit

Suggest: - a few minor issues, all marked TODO/FIXME in the code

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
[diffstat snipped...]
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 3d5f9e1eaf..a92a86f428 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -125,6 +125,122 @@ class QAPISemError(QAPIError):
>                             info['parent'], msg)
>=20=20
>=20=20
> +class QAPIDoc(object):
> +    class Section(object):
> +        def __init__(self, name=3DNone):
> +            # optional section name (argument/member or section name)
> +            self.name =3D name
> +            # the list of lines for this section
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
> +
> +    def __init__(self, parser, info):
> +        # self.parser is used to report errors with QAPIParseError.  The
> +        # resulting error position depends on the state of the parser.
> +        # It happens to be the beginning of the comment.  More or less
> +        # servicable, but action at a distance.
> +        self.parser =3D parser
> +        self.info =3D info
> +        self.symbol =3D None
> +        self.body =3D QAPIDoc.Section()
> +        # dict mapping parameter name to ArgSection
> +        self.args =3D OrderedDict()
> +        # a list of Section
> +        self.sections =3D []
> +        # the current section
> +        self.section =3D self.body
> +        # associated expression (to be set by expression parser)
> +        self.expr =3D None
> +
> +    def has_section(self, name):
> +        """Return True if we have a section with this name."""
> +        for i in self.sections:
> +            if i.name =3D=3D name:
> +                return True
> +        return False
> +
> +    def append(self, line):
> +        """Parse a comment line and add it to the documentation."""
> +        line =3D line[1:]
> +        if not line:
> +            self._append_freeform(line)
> +            return
> +
> +        if line[0] !=3D ' ':
> +            raise QAPIParseError(self.parser, "Missing space after #")
> +        line =3D line[1:]
> +
> +        # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
> +        # recognized, and get silently treated as ordinary text
> +        if self.symbol:
> +            self._append_symbol_line(line)
> +        elif not self.body.content and line.startswith("@"):
> +            if not line.endswith(":"):
> +                raise QAPIParseError(self.parser, "Line should end with =
:")
> +            self.symbol =3D line[1:-1]
> +            # FIXME invalid names other than the empty string aren't fla=
gged
> +            if not self.symbol:
> +                raise QAPIParseError(self.parser, "Invalid name")
> +        else:
> +            self._append_freeform(line)
> +
> +    def _append_symbol_line(self, line):
> +        name =3D line.split(' ', 1)[0]
> +
> +        if name.startswith("@") and name.endswith(":"):
> +            line =3D line[len(name)+1:]
> +            self._start_args_section(name[1:-1])
> +        elif name in ("Returns:", "Since:",
> +                      # those are often singular or plural
> +                      "Note:", "Notes:",
> +                      "Example:", "Examples:",
> +                      "TODO:"):
> +            line =3D line[len(name)+1:]
> +            self._start_section(name[:-1])
> +
> +        self._append_freeform(line)
> +
> +    def _start_args_section(self, name):
> +        # FIXME invalid names other than the empty string aren't flagged
> +        if not name:
> +            raise QAPIParseError(self.parser, "Invalid parameter name")
> +        if name in self.args:
> +            raise QAPIParseError(self.parser,
> +                                 "'%s' parameter name duplicated" % name)
> +        if self.sections:
> +            raise QAPIParseError(self.parser,
> +                                 "'%s' parameter documentation is interl=
eaved "
> +                                 "with other sections" % name)

This error message is rather confusing.  Ideally, we'd point to the the
source code that made us add to self.sections, but that's not in the
cards right now.  Here's my best try:

               raise QAPIParseError(self.parser,
                                    "'@%s:' can't follow '%s' section"
                                    % (name, self.sections[0].name))

> +        self.section =3D QAPIDoc.ArgSection(name)
> +        self.args[name] =3D self.section
> +
> +    def _start_section(self, name=3D""):

Note: @name changed to default to "" since v6 for the benefit of
_append_freeform() below.

> +        if name in ("Returns", "Since") and self.has_section(name):
> +            raise QAPIParseError(self.parser,
> +                                 "Duplicated '%s' section" % name)
> +        self.section =3D QAPIDoc.Section(name)
> +        self.sections.append(self.section)
> +
> +    def _append_freeform(self, line):
> +        in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
> +        if (in_arg and self.section.content and
> +                not self.section.content[-1] and
> +                line and not line[0].isspace()):

PEP8 recommends breaking lines before operators in new code.

> +            self._start_section()

Changed from v6's

               raise QAPIParseError(self.parser, "Invalid section indentati=
on")

May well be an improvement (I'm certainly no fan of this error myself),
but it throws my review off the fast track: now I have to figure out how
the new code works.  Can you give me a hint on what this change does?

Or should we take a shortcut and revert to v6 here?  We can always
improve on top.

> +        if (in_arg or not self.section.name or
> +                not self.section.name.startswith("Example")):

Again, break before the operator.

> +            line =3D line.strip()
> +        self.section.append(line)
> +
> +
>  class QAPISchemaParser(object):
>=20=20
>      def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
> @@ -140,11 +256,17 @@ class QAPISchemaParser(object):
>          self.line =3D 1
>          self.line_pos =3D 0
>          self.exprs =3D []
> +        self.docs =3D []
>          self.accept()
>=20=20
>          while self.tok is not None:
>              info =3D {'file': fname, 'line': self.line,
>                      'parent': self.incl_info}
> +            if self.tok =3D=3D '#':
> +                doc =3D self.get_doc(info)
> +                self.docs.append(doc)
> +                continue
> +
>              expr =3D self.get_expr(False)
>              if isinstance(expr, dict) and "include" in expr:
>                  if len(expr) !=3D 1:
> @@ -162,6 +284,7 @@ class QAPISchemaParser(object):
>                          raise QAPISemError(info, "Inclusion loop for %s"
>                                             % include)
>                      inf =3D inf['parent']
> +
>                  # skip multiple include of the same file
>                  if incl_abs_fname in previously_included:
>                      continue
> @@ -172,12 +295,19 @@ class QAPISchemaParser(object):
>                  exprs_include =3D QAPISchemaParser(fobj, previously_incl=
uded,
>                                                   info)
>                  self.exprs.extend(exprs_include.exprs)
> +                self.docs.extend(exprs_include.docs)
>              else:
>                  expr_elem =3D {'expr': expr,
>                               'info': info}
> +                if (self.docs and
> +                        self.docs[-1].info['file'] =3D=3D fname and
> +                        not self.docs[-1].expr):

Again, break before the operator.

> +                    self.docs[-1].expr =3D expr
> +                    expr_elem['doc'] =3D self.docs[-1]
> +
>                  self.exprs.append(expr_elem)
>=20=20
> -    def accept(self):
> +    def accept(self, skip_comment=3DTrue):
>          while True:
>              self.tok =3D self.src[self.cursor]
>              self.pos =3D self.cursor
> @@ -185,7 +315,13 @@ class QAPISchemaParser(object):
>              self.val =3D None
>=20=20
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

> @@ -319,6 +455,28 @@ class QAPISchemaParser(object):
>              raise QAPIParseError(self, 'Expected "{", "[" or string')
>          return expr
>=20=20
> +    def get_doc(self, info):
> +        if self.val !=3D '##':
> +            raise QAPIParseError(self, "Junk after '##' at start of "
> +                                 "documentation comment")
> +
> +        doc =3D QAPIDoc(self, info)
> +        self.accept(False)
> +        while self.tok =3D=3D '#':
> +            if self.val.startswith('##'):
> +                # End of doc comment
> +                if self.val !=3D '##':
> +                    raise QAPIParseError(self, "Junk after '##' at end o=
f "
> +                                         "documentation comment")
> +                self.accept()
> +                return doc
> +            else:
> +                doc.append(self.val)
> +            self.accept(False)
> +
> +        raise QAPIParseError(self, "Documentation comment must end with =
'##'")
> +
> +
>  #
>  # Semantic analysis of schema expressions
>  # TODO fold into QAPISchema
> @@ -703,6 +861,11 @@ def check_exprs(exprs):
>      for expr_elem in exprs:
>          expr =3D expr_elem['expr']
>          info =3D expr_elem['info']
> +
> +        if 'doc' not in expr_elem:
> +            raise QAPISemError(info,
> +                               "Expression missing documentation comment=
")
> +
>          if 'enum' in expr:
>              check_keys(expr_elem, 'enum', ['data'], ['prefix'])
>              add_enum(expr['enum'], info, expr['data'])
> @@ -761,6 +924,84 @@ def check_exprs(exprs):
>      return exprs
>=20=20
>=20=20
> +def check_freeform_doc(doc):
> +    if doc.symbol:
> +        raise QAPISemError(doc.info,
> +                           "Documention for '%s' is not followed"
> +                           " by the definition" % doc.symbol)
> +
> +    body =3D str(doc.body)
> +    if re.search(r'@\S+:', body, re.MULTILINE):
> +        raise QAPISemError(doc.info,
> +                           "Free-form documentation block must not conta=
in"
> +                           " @NAME: sections")
> +
> +
> +def check_definition_doc(doc, expr, info):

Lots of churn in this function.  It can certainly use improvement, as
pointed out in prior reviews, but it triggers still more review.  Based
on the tests, I guess it's for finding documented parameters that don't
actually exist, and to diagnose optional mismatch.  Anything else?

Or should we take a shortcut and revert to v6 here?  We can always
improve on top.  I think v6 would need a # TODO Should ensure #optional
matches the schema.

> +    for i in ('enum', 'union', 'alternate', 'struct', 'command', 'event'=
):
> +        if i in expr:
> +            meta =3D i
> +            break
> +
> +    name =3D expr[meta]
> +    if doc.symbol !=3D name:
> +        raise QAPISemError(info, "Definition of '%s' follows documentati=
on"
> +                           " for '%s'" % (name, doc.symbol))
> +    if doc.has_section('Returns') and 'command' not in expr:
> +        raise QAPISemError(info, "'Returns:' is only valid for commands")

Copied from review of v5, so I don't forget:

We accept 'Returns:' even when the command doesn't return anything,
because we currently use it to document errors, too.  Can't say I like
that, but it's out of scope here.

> +
> +    if meta =3D=3D 'union':
> +        args =3D expr.get('base', [])
> +    else:
> +        args =3D expr.get('data', [])
> +    if isinstance(args, dict):
> +        args =3D args.keys()
> +
> +    if meta =3D=3D 'alternate' or \
> +       (meta =3D=3D 'union' and not expr.get('discriminator')):
> +        args.append('type')
> +
> +    if isinstance(args, list):
> +        for arg in args:
> +            if arg[0] =3D=3D '*':
> +                opt =3D True
> +                desc =3D doc.args.get(arg[1:])
> +            else:
> +                opt =3D False
> +                desc =3D doc.args.get(arg)
> +            if not desc:
> +                continue
> +            desc_opt =3D "#optional" in str(desc)
> +            if desc_opt and not opt:
> +                raise QAPISemError(info, "Description has #optional, "
> +                                   "but the declaration doesn't")
> +            if not desc_opt and opt:
> +                # silently fix the doc
> +                desc.append("#optional")
> +
> +    doc_args =3D set(doc.args.keys())
> +    args =3D set([name.strip('*') for name in args])
> +    if not doc_args.issubset(args):
> +        raise QAPISemError(info, "The following documented members are n=
ot in "
> +                           "the declaration: %s" % ", ".join(doc_args - =
args))

Copied from review of v5, so I don't forget:

As explained in review of v3, this is only a subset of the real set of
members.  Computing the exact set is impractical when working with the
abstract syntax tree.  I believe we'll eventually have to rewrite this
code to work with the QAPISchemaEntity instead.

> +
> +
> +def check_docs(docs):
> +    for doc in docs:
> +        for section in doc.args.values() + doc.sections:
> +            content =3D str(section)
> +            if not content or content.isspace():
> +                raise QAPISemError(doc.info,
> +                                   "Empty doc section '%s'" % section.na=
me)
> +
> +        if not doc.expr:
> +            check_freeform_doc(doc)
> +        else:
> +            check_definition_doc(doc, doc.expr, doc.info)
> +
> +    return docs
> +
> +
>  #
>  # Schema compiler frontend
>  #
> @@ -1229,7 +1470,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
>  class QAPISchema(object):
>      def __init__(self, fname):
>          try:
> -            self.exprs =3D check_exprs(QAPISchemaParser(open(fname, "r")=
).exprs)
> +            parser =3D QAPISchemaParser(open(fname, "r"))
> +            self.exprs =3D check_exprs(parser.exprs)
> +            self.docs =3D check_docs(parser.docs)
>              self._entity_dict =3D {}
>              self._predefining =3D True
>              self._def_predefineds()
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> new file mode 100755
> index 0000000000..436749ec7b
> --- /dev/null
> +++ b/scripts/qapi2texi.py
> @@ -0,0 +1,266 @@
> +#!/usr/bin/env python
> +# QAPI texi generator
> +#
> +# This work is licensed under the terms of the GNU LGPL, version 2+.
> +# See the COPYING file in the top-level directory.
> +"""This script produces the documentation of a qapi schema in texinfo fo=
rmat"""
> +import re
> +import sys
> +
> +import qapi
> +
> +COMMAND_FMT =3D """
> +@deftypefn {type} {{}} {name}
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
> +@deftp {{{type}}} {name}
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
> +    return re.sub(r'\*([^*\n]+)\*', r'@emph{\1}', doc)
> +
> +
> +def subst_emph(doc):
> +    """Replaces _foo_ by @emph{foo}"""
> +    return re.sub(r'\b_([^_\n]+)_\b', r' @emph{\1} ', doc)
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
> +    # TODO: Neglects to escape @ characters.
> +    # We should probably escape them in subst_braces(), and rename the
> +    # function to subst_special() or subs_texi_special().  If we do that=
, we
> +    # need to delay it until after subst_vars() in texi_format().
> +    doc =3D subst_braces(doc).strip('\n')
> +    return EXAMPLE_FMT(code=3Ddoc)
> +
> +
> +def texi_format(doc):
> +    """
> +    Format documentation
> +
> +    Lines starting with:
> +    - |: generates an @example
> +    - =3D: generates @section
> +    - =3D=3D: generates @subsection
> +    - 1. or 1): generates an @enumerate @item
> +    - */-: generates an @itemize list
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
> +        # FIXME: Doing this in a single if / elif chain is
> +        # problematic.  For instance, a line without markup terminates
> +        # a list if it follows a blank line (reaches the final elif),
> +        # but a line with some *other* markup, such as a =3D title
> +        # doesn't.
> +        if line.startswith("| "):
> +            line =3D EXAMPLE_FMT(code=3Dline[2:])
> +        elif line.startswith("=3D "):
> +            line =3D "@section " + line[2:]
> +        elif line.startswith("=3D=3D "):
> +            line =3D "@subsection " + line[3:]
> +        elif re.match("^([0-9]*[.]) ", line):

[.] is an unusual way to say \.

Perhaps we should consistently use r"..." for strings used as regular
expressions.

> +            if not inlist:
> +                lines.append("@enumerate")
> +                inlist =3D "enumerate"
> +            line =3D line[line.find(" ")+1:]
> +            lines.append("@item")
> +        elif re.match("^[*-] ", line):
> +            if not inlist:
> +                lines.append("@itemize %s" % {'*': "@bullet",
> +                                              '-': "@minus"}[line[0]])
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
> +def texi_body(doc):
> +    """
> +    Format the body of a symbol documentation:
> +    - main body
> +    - table of arguments
> +    - followed by "Returns/Notes/Since/Example" sections
> +    """
> +    body =3D texi_format(str(doc.body)) + "\n"
> +    if doc.args:
> +        body +=3D "@table @asis\n"
> +        for arg, section in doc.args.iteritems():
> +            desc =3D str(section)
> +            opt =3D ''
> +            if "#optional" in desc:
> +                desc =3D desc.replace("#optional", "")
> +                opt =3D ' (optional)'
> +            body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
> +                                                   texi_format(desc))
> +        body +=3D "@end table\n"
> +
> +    for section in doc.sections:
> +        name, doc =3D (section.name, str(section))
> +        func =3D texi_format
> +        if name.startswith("Example"):
> +            func =3D texi_example
> +
> +        if name:

@quotation produces confusing .txt and .html output, as discussed in
review of v6.  Either drop it, or record the problem in a comment, e.g.

               # FIXME the indentation produced by @quotation in .txt and
               # .html output is confusing

> +            body +=3D "\n@quotation %s\n%s\n@end quotation" % \
> +                    (name, func(doc))
> +        else:
> +            body +=3D func(doc)
> +
> +    return body
> +
> +
> +def texi_alternate(expr, doc):
> +    """Format an alternate to texi"""
> +    body =3D texi_body(doc)
> +    return STRUCT_FMT(type=3D"Alternate",
> +                      name=3Ddoc.symbol,
> +                      body=3Dbody)
> +
> +
> +def texi_union(expr, doc):
> +    """Format a union to texi"""
> +    discriminator =3D expr.get("discriminator")
> +    if discriminator:
> +        union =3D "Flat Union"
> +    else:
> +        union =3D "Simple Union"

Not sure flat vs. simple matters for users of generated documentation,
but let's not worry about that now.

> +
> +    body =3D texi_body(doc)
> +    return STRUCT_FMT(type=3Dunion,
> +                      name=3Ddoc.symbol,
> +                      body=3Dbody)
> +
> +
> +def texi_enum(expr, doc):
> +    """Format an enum to texi"""
> +    for i in expr['data']:
> +        if i not in doc.args:
> +            doc.args[i] =3D ''
> +    body =3D texi_body(doc)
> +    return ENUM_FMT(name=3Ddoc.symbol,
> +                    body=3Dbody)
> +
> +
> +def texi_struct(expr, doc):
> +    """Format a struct to texi"""
> +    body =3D texi_body(doc)
> +    return STRUCT_FMT(type=3D"Struct",
> +                      name=3Ddoc.symbol,
> +                      body=3Dbody)
> +
> +
> +def texi_command(expr, doc):
> +    """Format a command to texi"""
> +    body =3D texi_body(doc)
> +    return COMMAND_FMT(type=3D"Command",
> +                       name=3Ddoc.symbol,
> +                       body=3Dbody)
> +
> +
> +def texi_event(expr, doc):
> +    """Format an event to texi"""
> +    body =3D texi_body(doc)
> +    return COMMAND_FMT(type=3D"Event",
> +                       name=3Ddoc.symbol,
> +                       body=3Dbody)
> +
> +
> +def texi_expr(expr, doc):
> +    """Format an expr to texi"""
> +    (kind, _) =3D expr.items()[0]
> +
> +    fmt =3D {"command": texi_command,
> +           "struct": texi_struct,
> +           "enum": texi_enum,
> +           "union": texi_union,
> +           "alternate": texi_alternate,
> +           "event": texi_event}[kind]
> +
> +    return fmt(expr, doc)
> +
> +
> +def texi(docs):
> +    """Convert QAPI schema expressions to texi documentation"""
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
> +    """Takes schema argument, prints result to stdout"""
> +    if len(argv) !=3D 2:
> +        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv=
[0]
> +        sys.exit(1)
> +
> +    schema =3D qapi.QAPISchema(argv[1])
> +    print texi(schema.docs)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main(sys.argv)
> diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
> index 2841c5144a..b29f996fdc 100644
> --- a/docs/qapi-code-gen.txt
> +++ b/docs/qapi-code-gen.txt
> @@ -44,40 +44,148 @@ Input must be ASCII (although QMP supports full Unic=
ode strings, the
>  QAPI parser does not).  At present, there is no place where a QAPI
>  schema requires the use of JSON numbers or null.
>=20=20
> +
> +=3D=3D=3D Comments =3D=3D=3D
> +
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
> -x.y.z)' comment.  For example:
> -
> -    ##
> -    # @BlockStats:
> -    #
> -    # Statistics of a virtual block device or a block backing device.
> -    #
> -    # @device: #optional If the stats are for a virtual block device, th=
e name
> -    #          corresponding to the virtual block device.
> -    #
> -    # @stats:  A @BlockDeviceStats for the device.
> -    #
> -    # @parent: #optional This describes the file block device if it has =
one.
> -    #
> -    # @backing: #optional This describes the backing block device if it =
has one.
> -    #           (Since 2.0)
> -    #
> -    # Since: 0.14.0
> -    ##
> -    { 'struct': 'BlockStats',
> -      'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
> -               '*parent': 'BlockStats',
> -               '*backing': 'BlockStats'} }
> +newline is ignored.
> +
> +A multi-line comment that starts and ends with a '##' line is a
> +documentation comment.  These are parsed by the documentation
> +generator, which recognizes certain markup detailed below.
> +
> +
> +=3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
> +
> +Comment text starting with '=3D' is a section title:
> +
> +    # =3D Section title
> +
> +Double the '=3D' for a subsection title:
> +
> +    # =3D=3D Subection title
> +
> +'|' denotes examples:
> +
> +    # | Text of the example, may span
> +    # | multiple lines
> +
> +'*' starts an itemized list:
> +
> +    # * First item, may span
> +    #   multiple lines
> +    # * Second item
> +
> +You can also use '-' instead of '*'.
> +
> +A decimal number followed by '.' starts a numbered list:
> +
> +    # 1. First item, may span
> +    # multiple lines
> +    # 2. Second item
> +
> +The actual number doesn't matter.  You could even use '*' instead of
> +'2.' for the second item.
> +
> +FIXME what exactly ends a list

Can you say offhand what ends a list?  If yes, can we resolve this FIXME
now rather than later?

> +
> +Additional whitespace between the initial '#' and the comment text is
> +permitted.
> +
> +*foo* and _foo_ are for strong and emphasis styles respectively (they
> +do not work over multiple lines). @foo is used to reference a name in
> +the schema.
> +
> +Example:
> +
> +##
> +# =3D Section
> +# =3D=3D Subsection
> +#
> +# Some text foo with *strong* and _emphasis_
> +# 1. with a list
> +# 2. like that
> +#
> +# And some code:
> +# | $ echo foo
> +# | -> do this
> +# | <- get that
> +#
> +##
> +
> +
> +=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
> +
> +Each expression that isn't an include directive must be preceded by a
> +documentation block.  Such blocks are called expression documentation
> +blocks.
> +
> +The first line of the documentation names the expression, then the
> +documentation body is provided, then individual documentation about
> +each member of 'data' is provided. Finally, several tagged sections
> +can be added.

In my review of v6, I wrote:

    I'm afraid this is more aspiration than specification: the parser
    accepts these things in almost any order.

    Could be filed under "deficiencies" for now.

To file under "deficiencies", we need to add a FIXME or TODO either
here, or in the parser.  Assuming you haven't tightened the parser
meanwhile (hope you haven't; we need to control the churn).

    Member of 'data' won't remain accurate.  Consider:

        { 'union': 'GlusterServer',
          'base': { 'type': 'GlusterTransport' },
          'discriminator': 'type',
          'data': { 'unix': 'UnixSocketAddress',
                    'tcp': 'InetSocketAddress' } }

    Its doc comment currently doesn't contain argument sections.  It should
    eventually contain @type:, @unix: and @tcp:.  Only the latter two are
    members of 'data'.

    I should propose something better, but I'm getting perilously close to
    the christmas break already.  Later.

Also: passive voice is meh (not your idea; you adapted the existing
text).

What about:

   The documentation block consists of a first line naming the
   expression, an optional overview, a description of each argument (for
   commands and events) or member (for structs, unions and alternates),
   and optional tagged sections.

I still don't like the use of "section" for both the =3D things and the
tagged sections, but it's not important enough to spend time on it now.

> +
> +Optional members are tagged with the phrase '#optional', often with

If we adopt my text, we should say "arguments / members" here.

> +their default value; and extensions added after the expression was
> +first released are also given a '(since x.y.z)' comment.
> +
> +A tagged section starts with one of the following words:
> +"Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".

What ends such a section?  The start of the next one / end of the
comment block?

I suspect we could avoid PATCH 03 by recognizing "TODO" in addition to
"TODO:".  Might also be more robust.  But let's ignore this now.

> +
> +A 'Since: x.y.z' tag lists the release that introduced the expression.

Nitpick: 'Since: x.y.z' is a tagged section, not a tag.

> +
> +For example:
> +
> +##
> +# @BlockStats:
> +#
> +# Statistics of a virtual block device or a block backing device.
> +#
> +# @device: #optional If the stats are for a virtual block device, the na=
me
> +#          corresponding to the virtual block device.
> +#
> +# @node-name: #optional The node name of the device. (since 2.3)
> +#
> +# ... more members ...
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'BlockStats',
> +  'data': {'*device': 'str', '*node-name': 'str',
> +           ... more members ... } }
> +
> +##
> +# @query-blockstats:
> +#
> +# Query the @BlockStats for all virtual block devices.
> +#
> +# @query-nodes: #optional If true, the command will query all the
> +#               block nodes ... explain, explain ...  (since 2.3)
> +#
> +# Returns: A list of @BlockStats for each virtual block devices.
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-blockstats" }
> +# <- {
> +#      ... lots of output ...
> +#    }
> +#
> +##
> +{ 'command': 'query-blockstats',
> +  'data': { '*query-nodes': 'bool' },
> +  'returns': ['BlockStats'] }
> +
> +=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
> +
> +A documentation block that isn't an expression documentation block is
> +a free-form documentation block.  These may be used to provide
> +additional text and structuring content.
> +
> +
> +=3D=3D=3D Schema overview =3D=3D=3D
>=20=20
>  The schema sets up a series of types, as well as commands and events
>  that will use those types.  Forward references are allowed: the parser
[Tests look okay, snipped...]
