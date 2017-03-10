Received: from eggs.gnu.org ([2001:4830:134:3::10]:36615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmIFI-00069K-Aa
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmIFH-0003A4-2w
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmIFG-00039L-Pn
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:58:02 -0500
References: <20170310085331.17916-1-marcandre.lureau@redhat.com>
	<479b756e-b808-eee7-7780-69d2b2669cdf@redhat.com>
	<CAJ+F1CJuPGJ9DOQMy7PP=DJtTxbcDFoBA+rA-NKStcSTrUEPuA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8651eaa2-3098-f048-0d58-d90aaef04efe@redhat.com>
Date: Fri, 10 Mar 2017 11:58:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJuPGJ9DOQMy7PP=DJtTxbcDFoBA+rA-NKStcSTrUEPuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/dump-guest-memory.py: fix
 int128_get64 on recent gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com



On 10/03/2017 11:54, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Mar 10, 2017 at 2:00 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>     On 10/03/2017 09:53, Marc-Andr=C3=A9 Lureau wrote:
>     > The Int128 is no longer a struct, reaching a python exception:
>     > Python Exception <class 'gdb.error'> Attempt to extract a
>     component of a value that is not a (null).:
>     >
>     > Replace struct access with a cast to uint64 instead.
>     >
>     > Fixes:
>     > https://bugzilla.redhat.com/show_bug.cgi?id=3D1427466
>     >
>     > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m
>     <mailto:marcandre.lureau@redhat.com>>
>     > ---
>     >  scripts/dump-guest-memory.py | 6 ++++--
>     >  1 file changed, 4 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/scripts/dump-guest-memory.py
>     b/scripts/dump-guest-memory.py
>     > index 9956fc036c..bbe1c14ba2 100644
>     > --- a/scripts/dump-guest-memory.py
>     > +++ b/scripts/dump-guest-memory.py
>     > @@ -314,8 +314,10 @@ def get_arch_phdr(endianness, elfclass):
>     >  def int128_get64(val):
>     >      """Returns low 64bit part of Int128 struct."""
>     >
>     > -    assert val["hi"] =3D=3D 0
>     > -    return val["lo"]
>     > +    u64t =3D gdb.lookup_type('uint64_t').array(2)
>     > +    u64 =3D val.cast(u64t)
>     > +    assert u64[1] =3D=3D 0
>     > +    return u64[0]
>     >
>     >
>     >  def qlist_foreach(head, field_str):
>     >
>=20
>     I'm afraid this is not big-endian-friendly (Python lets you check t=
hat
>     with "sys.byteorder =3D=3D 'little'").
>=20
>     Also when building on a 32-bit machine the old code should be used;=
 I
>     think you need to use try/except to choose between the two.
>=20
>=20
> Do you think that would be enough?
>=20
>  diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.=
py
> index 9956fc036c..f7c6635f15 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -314,8 +314,18 @@ def get_arch_phdr(endianness, elfclass):
>  def int128_get64(val):
>      """Returns low 64bit part of Int128 struct."""
> =20
> -    assert val["hi"] =3D=3D 0
> -    return val["lo"]
> +    try:
> +        assert val["hi"] =3D=3D 0
> +        return val["lo"]
> +    except gdb.error:
> +        u64t =3D gdb.lookup_type('uint64_t').array(2)
> +        u64 =3D val.cast(u64t)
> +        if sys.byteorder =3D=3D 'little':
> +            assert u64[1] =3D=3D 0
> +            return u64[0]
> +        else:
> +            assert u64[0] =3D=3D 0
> +            return u64[1]
> =20
> (I don't have a 32-bit system handy to check it, and cross-compilation
> with m32 etc is tricky to get right, I am trying though)

Yes, this should work.

Paolo
