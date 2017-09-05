Received: from eggs.gnu.org ([2001:4830:134:3::10]:54601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpHv8-0005G7-DW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpHv3-0005HK-RK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpHv3-0005H5-L3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:45:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-29-marcandre.lureau@redhat.com>
Date: Tue, 05 Sep 2017 19:45:44 +0200
In-Reply-To: <20170822132255.23945-29-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:29 +0200")
Message-ID: <87bmmphwdz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 28/54] qapi: do not define enumeration
 value explicitely
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

> The C standard has the initial value at 0 and the subsequent values
> incremented by 1. No need to set this explicitely.
>
> This will prevent from artificial "gaps" when compiling out some enum
> values and having unnecessarily large MAX values & enums arrays.

Yes, but it also risks entertaining mishaps like compiling this one

    typedef enum Color {
        COLOR_WHITE,
#if defined(NEED_CPU_H)
#if defined(TARGET_S390X)
        COLOR_BLUE,
#endif /* defined(TARGET_S390X) */
#endif /* defined(NEED_CPU_H) */
        COLOR_BLACK,
    } Color;

in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
(COLOR_BLACK =3D 1), then linking the two together.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 52099332f1..9d075440d3 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1979,14 +1979,11 @@ typedef enum %(c_name)s {
>  ''',
>                  c_name=3Dc_name(name))
>=20=20
> -    i =3D 0
>      for value in enum_values:
>          ret +=3D mcgen('''
> -    %(c_enum)s =3D %(i)d,
> +    %(c_enum)s,
>  ''',
> -                     c_enum=3Dc_enum_const(name, value, prefix),
> -                     i=3Di)
> -        i +=3D 1
> +                     c_enum=3Dc_enum_const(name, value, prefix))
>=20=20
>      ret +=3D mcgen('''
>  } %(c_name)s;
