Received: from eggs.gnu.org ([2001:4830:134:3::10]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiaoP-0006zB-FL
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiaoJ-0007eg-Fx
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:03:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eiaoJ-0007eI-88
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:03:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-11-marcandre.lureau@redhat.com>
Date: Mon, 05 Feb 2018 08:03:22 +0100
In-Reply-To: <20180111213250.16511-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 11 Jan 2018
	22:32:09 +0100")
Message-ID: <87zi4nx6it.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/51] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add helpers to wrap generated code with #if/#endif lines.
>
> Add a function decorator that will be used to wrap visitor methods.
> The decorator will check if code was generated before adding #if/#endif
> lines. Used in the following patches.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 3d33ed7d76..71f28fc6d8 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1911,6 +1911,53 @@ def guardend(name):
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
> +# Wrap a method to add #if / #endif to generated code, only if some
> +# code was generated. The method must have an 'ifcond' argument.
> +# self must have 'if_members' listing the attributes to wrap.
> +def ifcond_decorator(func):
> +
> +    def func_wrapper(self, *args, **kwargs):
> +        import inspect
> +        idx =3D inspect.getargspec(func).args.index('ifcond')
> +        ifcond =3D args[idx - 1]
> +        save =3D {}
> +        for mem in self.if_members:
> +            save[mem] =3D getattr(self, mem)
> +        func(self, *args, **kwargs)
> +        for mem, val in save.items():
> +            newval =3D getattr(self, mem)
> +            if newval !=3D val:
> +                assert newval.startswith(val)
> +                newval =3D newval[len(val):]
> +                if newval[0] =3D=3D '\n':
> +                    val +=3D '\n'
> +                    newval =3D newval[1:]
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

I dislike this as much as ever, but I lack the time to explore
alternatives right now, and I don't want to block your work.

Reluctantly:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
