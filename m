Received: from eggs.gnu.org ([2001:4830:134:3::10]:52428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dty6P-00021K-SD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dty6M-00024J-Ei
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:36:53 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:48742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dty6M-000249-1j
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:36:50 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 108so848648wra.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:36:49 -0700 (PDT)
Date: Mon, 18 Sep 2017 16:36:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918153644.GA12759@stefanha-x1.localdomain>
References: <87r2w6eq5n.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2w6eq5n.fsf@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, David Michael <fedora.dm0@gmail.com>

On Sat, Aug 19, 2017 at 10:58:44PM -0700, David Michael wrote:
> This allows building with "./configure --python=python3", where
> the python3 program is at least version 3.6.  It preserves
> compatibility with Python 2.  The changes include:
> 
>   - Avoiding "print" usage
>   - Using bytes with files opened in binary mode
>   - Switching .iteritems() to .items()
>   - Adding fallback imports for functions moved to other modules
> 
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
> 
> Hi,
> 
> I've been applying these changes when building on Fedora 26, which does
> not include any Python 2 packages by default.  It was tested with Python
> 2.7 and 3.6.
> 
> I just saw the list of scripts that need updating on the mailing list,
> and this doesn't cover all of them, but it is enough to build a binary
> for running virtual machines with KVM.  Maybe it is still useful as a
> starting point.
> 
> Thanks.


Markus,
You wanted to discuss the general direction of Python version support
before applying this.

Has consensus been reached?

Stefan

> 
> David
> 
>  configure            |  6 ++++--
>  scripts/qapi.py      | 31 ++++++++++++++++++++-----------
>  scripts/qapi2texi.py | 10 +++++-----
>  scripts/signrom.py   |  4 ++--
>  4 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/configure b/configure
> index dd73cce..09f4d68 100755
> --- a/configure
> +++ b/configure
> @@ -1548,9 +1548,11 @@ fi
>  
>  # Note that if the Python conditional here evaluates True we will exit
>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6) or sys.version_info >= (3,))'; then
> +if ! $python -c 'import sys; sys.exit(sys.version_info >= (3,) and sys.version_info < (3,6))'; then
> +  error_exit "Cannot use '$python', Python 3.6 or later is required." \
> +      "Use --python=/path/to/python3 to specify a supported Python 3."
> +elif ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then
>    error_exit "Cannot use '$python', Python 2.6 or later is required." \
> -      "Note that Python 3 or later is not yet supported." \
>        "Use --python=/path/to/python to specify a supported Python."
>  fi
>  
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 8aa2775..6450998 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -15,9 +15,11 @@ import errno
>  import getopt
>  import os
>  import re
> -import string
>  import sys
> -from ordereddict import OrderedDict
> +try:
> +    from collections import OrderedDict
> +except ImportError:
> +    from ordereddict import OrderedDict
>  
>  builtin_types = {
>      'null':     'QTYPE_QNULL',
> @@ -252,7 +254,7 @@ class QAPIDoc(object):
>                                 "'Returns:' is only valid for commands")
>  
>      def check(self):
> -        bogus = [name for name, section in self.args.iteritems()
> +        bogus = [name for name, section in self.args.items()
>                   if not section.member]
>          if bogus:
>              raise QAPISemError(
> @@ -308,7 +310,7 @@ class QAPISchemaParser(object):
>                  if not isinstance(pragma, dict):
>                      raise QAPISemError(
>                          info, "Value of 'pragma' must be a dictionary")
> -                for name, value in pragma.iteritems():
> +                for name, value in pragma.items():
>                      self._pragma(name, value, info)
>              else:
>                  expr_elem = {'expr': expr,
> @@ -1574,7 +1576,7 @@ class QAPISchema(object):
>  
>      def _make_members(self, data, info):
>          return [self._make_member(key, value, info)
> -                for (key, value) in data.iteritems()]
> +                for (key, value) in data.items()]
>  
>      def _def_struct_type(self, expr, info, doc):
>          name = expr['struct']
> @@ -1606,11 +1608,11 @@ class QAPISchema(object):
>                  name, info, doc, 'base', self._make_members(base, info)))
>          if tag_name:
>              variants = [self._make_variant(key, value)
> -                        for (key, value) in data.iteritems()]
> +                        for (key, value) in data.items()]
>              members = []
>          else:
>              variants = [self._make_simple_variant(key, value, info)
> -                        for (key, value) in data.iteritems()]
> +                        for (key, value) in data.items()]
>              typ = self._make_implicit_enum_type(name, info,
>                                                  [v.name for v in variants])
>              tag_member = QAPISchemaObjectTypeMember('type', typ, False)
> @@ -1625,7 +1627,7 @@ class QAPISchema(object):
>          name = expr['alternate']
>          data = expr['data']
>          variants = [self._make_variant(key, value)
> -                    for (key, value) in data.iteritems()]
> +                    for (key, value) in data.items()]
>          tag_member = QAPISchemaObjectTypeMember('type', 'QType', False)
>          self._def_entity(
>              QAPISchemaAlternateType(name, info, doc,
> @@ -1735,7 +1737,11 @@ def c_enum_const(type_name, const_name, prefix=None):
>          type_name = prefix
>      return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>  
> -c_name_trans = string.maketrans('.-', '__')
> +try:
> +    c_name_trans = str.maketrans('.-', '__')
> +except AttributeError:
> +    import string
> +    c_name_trans = string.maketrans('.-', '__')
>  
>  
>  # Map @name to a valid C identifier.
> @@ -1997,8 +2003,11 @@ def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
>          if really:
>              return open(name, opt)
>          else:
> -            import StringIO
> -            return StringIO.StringIO()
> +            try:
> +                from StringIO import StringIO
> +            except ImportError:
> +                from io import StringIO
> +            return StringIO()
>  
>      fdef = maybe_open(do_c, c_file, 'w')
>      fdecl = maybe_open(do_h, h_file, 'w')
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index a317526..9a6fed9 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -147,7 +147,7 @@ def texi_member(member, suffix=''):
>  def texi_members(doc, what, base, variants, member_func):
>      """Format the table of members"""
>      items = ''
> -    for section in doc.args.itervalues():
> +    for section in doc.args.values():
>          # TODO Drop fallbacks when undocumented members are outlawed
>          if section.content:
>              desc = texi_format(str(section))
> @@ -285,15 +285,15 @@ def texi_schema(schema):
>  def main(argv):
>      """Takes schema argument, prints result to stdout"""
>      if len(argv) != 2:
> -        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv[0]
> +        sys.stderr.write("%s: need exactly 1 argument: SCHEMA\n" % argv[0])
>          sys.exit(1)
>  
>      schema = qapi.QAPISchema(argv[1])
>      if not qapi.doc_required:
> -        print >>sys.stderr, ("%s: need pragma 'doc-required' "
> -                             "to generate documentation" % argv[0])
> +        sys.stderr.write("%s: need pragma 'doc-required' "
> +                         "to generate documentation\n" % argv[0])
>          sys.exit(1)
> -    print texi_schema(schema)
> +    sys.stdout.write(texi_schema(schema) + "\n")
>  
>  
>  if __name__ == '__main__':
> diff --git a/scripts/signrom.py b/scripts/signrom.py
> index d1dabe0..0497a1c 100644
> --- a/scripts/signrom.py
> +++ b/scripts/signrom.py
> @@ -18,7 +18,7 @@ fin = open(sys.argv[1], 'rb')
>  fout = open(sys.argv[2], 'wb')
>  
>  magic = fin.read(2)
> -if magic != '\x55\xaa':
> +if magic != b'\x55\xaa':
>      sys.exit("%s: option ROM does not begin with magic 55 aa" % sys.argv[1])
>  
>  size_byte = ord(fin.read(1))
> @@ -33,7 +33,7 @@ elif len(data) < size:
>      # Add padding if necessary, rounding the whole input to a multiple of
>      # 512 bytes according to the third byte of the input.
>      # size-1 because a final byte is added below to store the checksum.
> -    data = data.ljust(size-1, '\0')
> +    data = data.ljust(size-1, b'\0')
>  else:
>      if ord(data[-1:]) != 0:
>          sys.stderr.write('WARNING: ROM includes nonzero checksum\n')
> -- 
> 2.13.5
> 
> 
