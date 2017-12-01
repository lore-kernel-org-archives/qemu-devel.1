Received: from eggs.gnu.org ([2001:4830:134:3::10]:45596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eKo9n-0003yF-Md
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eKo9k-0003Yy-Bk
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:27:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eKo9k-0003Xb-2B
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:27:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5CA077356
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:51:28 +0000 (UTC)
References: <20171201113744.2313-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <64aec2f9-4ec3-4aaf-0a25-845d4d37b67a@redhat.com>
Date: Fri, 1 Dec 2017 13:51:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171201113744.2313-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: fix No symbol
 "vmcoreinfo_find"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 12/01/17 12:37, Marc-Andr=C3=A9 Lureau wrote:
> When qemu is compiled without debug, the dump gdb python script can fai=
l with:
>=20
> Error occurred in Python command: No symbol "vmcoreinfo_find" in curren=
t context.
>=20
> Because vmcoreinfo_find() is inlined and not exported.
>=20
> Use the underlying object_resolve_path_type() to get the instance inste=
ad.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 69dd5efadf..1af26c1a45 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -546,13 +546,15 @@ shape and this command should mostly work."""
>          return None
> =20
>      def add_vmcoreinfo(self):
> -        if not gdb.parse_and_eval("vmcoreinfo_find()") \
> -           or not gdb.parse_and_eval("vmcoreinfo_find()->has_vmcoreinf=
o"):
> +        vmci =3D '(VMCoreInfoState *)' + \
> +               'object_resolve_path_type("", "vmcoreinfo", 0)'
> +        if not gdb.parse_and_eval("%s" % vmci) \
> +           or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
>              return
> =20
> -        fmt =3D gdb.parse_and_eval("vmcoreinfo_find()->vmcoreinfo.gues=
t_format")
> -        addr =3D gdb.parse_and_eval("vmcoreinfo_find()->vmcoreinfo.pad=
dr")
> -        size =3D gdb.parse_and_eval("vmcoreinfo_find()->vmcoreinfo.siz=
e")
> +        fmt =3D gdb.parse_and_eval("(%s)->vmcoreinfo.guest_format" % v=
mci)
> +        addr =3D gdb.parse_and_eval("(%s)->vmcoreinfo.paddr" % vmci)
> +        size =3D gdb.parse_and_eval("(%s)->vmcoreinfo.size" % vmci)
> =20
>          fmt =3D le16_to_cpu(fmt)
>          addr =3D le64_to_cpu(addr)
>=20

This is why I had recommended a volatile assignment back then.

http://mid.mail-archive.com/bbc74cf4-4d61-8ad3-7a33-0e6c49490892@redhat.c=
om

http://mid.mail-archive.com/c661a649-e438-e80b-baf4-b44ee6612ca3@redhat.c=
om

Anyway,

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
