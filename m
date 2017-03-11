Received: from eggs.gnu.org ([2001:4830:134:3::10]:52643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cmWLe-0006ef-0U
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cmWLZ-0007VM-4d
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cmWLY-0007U4-Uv
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:01:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECE0F4E8AB
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 02:01:27 +0000 (UTC)
References: <20170310112819.16760-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7133a51c-c080-5acc-6eda-5c6096a6a4ac@redhat.com>
Date: Sat, 11 Mar 2017 03:01:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170310112819.16760-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2] scripts/dump-guest-memory.py: fix
 int128_get64 on recent gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 03/10/17 12:28, Marc-Andr=C3=A9 Lureau wrote:
> The Int128 is no longer a struct, reaching a python exception:
> Python Exception <class 'gdb.error'> Attempt to extract a component of =
a value that is not a (null).:
>=20
> Replace struct access with a cast to uint64[] instead.
>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1427466
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> v2:
>  - try with old struct hi/lo fields first for compatibility
>  - handle endianess in uint64[] case
>=20
> Note: untested on other arch than x86_64
>=20
> scripts/dump-guest-memory.py | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
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
> =20
>  def qlist_foreach(head, field_str):
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
