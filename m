Received: from eggs.gnu.org ([2001:4830:134:3::10]:47675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpADe-0001cP-A3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpADZ-0000qu-KU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpADZ-0000qL-CS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:32:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-20-marcandre.lureau@redhat.com>
Date: Tue, 05 Sep 2017 11:32:20 +0200
In-Reply-To: <20170822132255.23945-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:20 +0200")
Message-ID: <87o9qp1oez.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/54] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add helpers to generate #if/#endif and wrap visitor methods generating
> code. Used in the following patches.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 86845a28f9..52099332f1 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1892,6 +1892,57 @@ def guardend(name):
>                   name=3Dguardname(name))
>=20=20
>=20=20
> +def gen_if(ifcond):
> +    if not ifcond:
> +        return ''
> +    if isinstance(ifcond, str):
> +        ifcond =3D [ifcond]
> +    # Not using mcgen() because we don't want indent or \n stipped

s/stipped/stripped/ I guess.

Which newline exactly don't you want to strip?

Here's what mcgen() currently does:

* Strip one leading newline, so that this works:

      mcgen('''
  line 1
  line 2
  ''')

* Interpolate keywords

* Indent by @indent_level spaces

* Strip @eatspace.

> +    ret =3D '\n'
> +    for ifc in ifcond:
> +        ret +=3D '#if %s\n' % ifc
> +    ret +=3D '\n'
> +    return ret
> +
> +
> +def gen_endif(ifcond):
> +    if not ifcond:
> +        return ''
> +    if isinstance(ifcond, str):
> +        ifcond =3D [ifcond]
> +    # Not using mcgen() because we don't want indent or \n stipped

Likewise.

> +    ret =3D '\n'
> +    for ifc in reversed(ifcond):
> +        ret +=3D '#endif /* %s */\n' % ifc
> +    ret +=3D '\n'
> +    return ret

I guess factoring out the common parts of gen_if() and gen_endif() would
make the code longer and more complex.

> +
> +
> +# Wrap a method to add #if / #endif to generated code, only if some
> +# code was generated.
> +# self must have 'if_members' listing the attributes to wrap.
> +# The last argument of the wrapped function must be the 'ifcond'.
> +def ifcond_decorator(func):
> +
> +    def func_wrapper(self, *args, **kwargs):
> +        ifcond =3D args[-1]
> +        save =3D {}
> +        for mem in self.if_members:
> +            save[mem] =3D getattr(self, mem)
> +        func(self, *args, **kwargs)
> +        for mem, val in save.items():
> +            newval =3D getattr(self, mem)
> +            if newval !=3D val:
> +                assert newval.startswith(val)
> +                newval =3D newval[len(val):]
> +                val +=3D gen_if(ifcond)
> +                val +=3D newval
> +                val +=3D gen_endif(ifcond)
> +            setattr(self, mem, val)
> +
> +    return func_wrapper
> +
> +
>  def gen_enum_lookup(name, values, prefix=3DNone):
>      ret =3D mcgen('''

My gut feeling is "too clever by half", but i'm reserving judgement
until after review of its use.
