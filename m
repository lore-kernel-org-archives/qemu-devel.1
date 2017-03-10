Received: from eggs.gnu.org ([2001:4830:134:3::10]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmHKW-0005TM-Ek
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmHKT-00024g-RO
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:59:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmHKT-000242-LI
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:59:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1B4862647
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 09:59:20 +0000 (UTC)
References: <20170310085331.17916-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <479b756e-b808-eee7-7780-69d2b2669cdf@redhat.com>
Date: Fri, 10 Mar 2017 10:59:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170310085331.17916-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=windows-1252
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com



On 10/03/2017 09:53, Marc-Andr=E9 Lureau wrote:
> The Int128 is no longer a struct, reaching a python exception:
> Python Exception <class 'gdb.error'> Attempt to extract a component of =
a value that is not a (null).:
>=20
> Replace struct access with a cast to uint64 instead.
>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1427466
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 9956fc036c..bbe1c14ba2 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -314,8 +314,10 @@ def get_arch_phdr(endianness, elfclass):
>  def int128_get64(val):
>      """Returns low 64bit part of Int128 struct."""
> =20
> -    assert val["hi"] =3D=3D 0
> -    return val["lo"]
> +    u64t =3D gdb.lookup_type('uint64_t').array(2)
> +    u64 =3D val.cast(u64t)
> +    assert u64[1] =3D=3D 0
> +    return u64[0]
> =20
> =20
>  def qlist_foreach(head, field_str):
>=20

I'm afraid this is not big-endian-friendly (Python lets you check that
with "sys.byteorder =3D=3D 'little'").

Also when building on a 32-bit machine the old code should be used; I
think you need to use try/except to choose between the two.

Paolo
