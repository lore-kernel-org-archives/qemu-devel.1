Received: from eggs.gnu.org ([2001:4830:134:3::10]:37635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faJs2-0007OI-Fw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faJrx-0007Dk-K1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:53:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faJrx-0007DL-EI
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:53:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-8-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 13:53:15 +0200
In-Reply-To: <20180627163551.31610-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 27 Jun 2018 18:35:43 +0200")
Message-ID: <87sh50bkno.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/15] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add helpers to wrap generated code with #if/#endif lines.
>
> Add QAPIGenCSnippet class to write C snippet code, make QAPIGenC
> inherit from it, for full C files with copyright headers etc.

It's called QAPIGenCCode now.  Can touch up when I apply, along with
another instance below.

Leaves the reader wondering *why* you need to splice QAPIGenCCode
between QAPIGen and QAPIGenC.  Becomes clear only in PATCH 10.
Providing the class now reduces code churn, but you should explain why.
Perhaps:

  A later patch wants to use QAPIGen for generating C snippets rather
  than full C files with copyright headers etc.  Splice in class
  QAPIGenCCode between QAPIGen and QAPIGenC.

> Add a 'with' statement context manager that will be used to wrap
> generator visitor methods.  The manager will check if code was
> generated before adding #if/#endif lines on QAPIGenCSnippet
> objects. Used in the following patches.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 101 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 1b56065a80..44eaf25850 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -12,6 +12,7 @@
>  # See the COPYING file in the top-level directory.
>=20=20
>  from __future__ import print_function
> +from contextlib import contextmanager
>  import errno
>  import os
>  import re
> @@ -1974,6 +1975,40 @@ def guardend(name):
>                   name=3Dguardname(name))
>=20=20
>=20=20
> +def gen_if(ifcond):
> +    ret =3D ''
> +    for ifc in ifcond:
> +        ret +=3D mcgen('''
> +#if %(cond)s
> +''', cond=3Difc)
> +    return ret
> +
> +
> +def gen_endif(ifcond):
> +    ret =3D ''
> +    for ifc in reversed(ifcond):
> +        ret +=3D mcgen('''
> +#endif /* %(cond)s */
> +''', cond=3Difc)
> +    return ret
> +
> +
> +def wrap_ifcond(ifcond, before, after):

Looks like a helper method.  Name it _wrap_ifcond?

> +    if ifcond is None or before =3D=3D after:
> +        return after

The before =3D=3D after part suppresses empty conditionals.  Suggest

           return after            # suppress empty #if ... #endif

The ifcond is None part is suppresses "non-conditionals".  How can this
happen?  If it can't, let's drop this part.

Another non-conditional is [].  See below.

> +
> +    assert after.startswith(before)
> +    out =3D before
> +    added =3D after[len(before):]
> +    if added[0] =3D=3D '\n':
> +        out +=3D '\n'
> +        added =3D added[1:]

The conditional adjusts vertical space around #if.  This might need
tweaking, but let's not worry about that now.

> +    out +=3D gen_if(ifcond)
> +    out +=3D added
> +    out +=3D gen_endif(ifcond)

There's no similar adjustment for #endif.  Again, let's not worry about
that now.

> +    return out
> +
> +

Since gen_if([]) and gen_endif([]) return '', wrap_ifcond([], before,
after) returns after.  Okay.

>  def gen_enum_lookup(name, values, prefix=3DNone):
>      ret =3D mcgen('''
>=20=20
> @@ -2064,6 +2099,7 @@ class QAPIGen(object):
>      def __init__(self):
>          self._preamble =3D ''
>          self._body =3D ''
> +        self._start_if =3D None
>=20=20
>      def preamble_add(self, text):
>          self._preamble +=3D text
> @@ -2071,6 +2107,25 @@ class QAPIGen(object):
>      def add(self, text):
>          self._body +=3D text
>=20=20
> +    def start_if(self, ifcond):
> +        assert self._start_if is None
> +

Let's drop this blank line.

> +        self._start_if =3D (ifcond, self._body, self._preamble)

It's now obvious that you can't nest .start_if() ... .endif().  Good.

> +
> +    def _wrap_ifcond(self):
> +        pass
> +
> +    def end_if(self):
> +        assert self._start_if
> +

Let's drop this blank line.

> +        self._wrap_ifcond()
> +        self._start_if =3D None
> +
> +    def get_content(self, fname=3DNone):
> +        assert self._start_if is None
> +        return (self._top(fname) + self._preamble + self._body
> +                + self._bottom(fname))
> +
>      def _top(self, fname):
>          return ''
>=20=20

Note for later: all this code has no effect unless ._wrap_ifcond() is
overridden.

> @@ -2091,8 +2146,7 @@ class QAPIGen(object):
>              f =3D open(fd, 'r+', encoding=3D'utf-8')
>          else:
>              f =3D os.fdopen(fd, 'r+')
> -        text =3D (self._top(fname) + self._preamble + self._body
> -                + self._bottom(fname))
> +        text =3D self.get_content(fname)
>          oldtext =3D f.read(len(text) + 1)
>          if text !=3D oldtext:
>              f.seek(0)
> @@ -2101,10 +2155,49 @@ class QAPIGen(object):
>          f.close()
>=20=20
>=20=20
> -class QAPIGenC(QAPIGen):
> +@contextmanager
> +def ifcontext(ifcond, *args):
> +    """A 'with' statement context manager to wrap with start_if()/end_if=
()
>=20=20
> -    def __init__(self, blurb, pydoc):
> +    *args: variable length argument list of QAPIGen

Perhaps: any number of QAPIGen objects

> +
> +    Example::
> +
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            modify self._genh and self._genc ...
> +
> +    Is equivalent to calling::
> +
> +        self._genh.start_if(ifcond)
> +        self._genc.start_if(ifcond)
> +        modify self._genh and self._genc ...
> +        self._genh.end_if()
> +        self._genc.end_if()
> +

Can we drop this blank line?

> +    """
> +    for arg in args:
> +        arg.start_if(ifcond)
> +    yield
> +    for arg in args:
> +        arg.end_if()
> +
> +
> +class QAPIGenCCode(QAPIGen):
> +
> +    def __init__(self):
>          QAPIGen.__init__(self)
> +
> +    def _wrap_ifcond(self):
> +        self._body =3D wrap_ifcond(self._start_if[0],
> +                                 self._start_if[1], self._body)
> +        self._preamble =3D wrap_ifcond(self._start_if[0],
> +                                     self._start_if[2], self._preamble)

Can you explain why you put the machinery for conditionals in QAPIGen
and not QAPIGenCCode?

> +
> +
> +class QAPIGenC(QAPIGenCCode):
> +
> +    def __init__(self, blurb, pydoc):
> +        QAPIGenCCode.__init__(self)
>          self._blurb =3D blurb
>          self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
>                                                    re.MULTILINE))
