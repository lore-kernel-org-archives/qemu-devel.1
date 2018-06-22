Received: from eggs.gnu.org ([2001:4830:134:3::10]:45313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWH7C-00064k-D0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWH77-0006Zv-DX
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:08:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWH77-0006YR-8c
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:08:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50BEC4001389
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:08:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-16-marcandre.lureau@redhat.com>
Date: Fri, 22 Jun 2018 10:08:09 +0200
In-Reply-To: <20180321115211.17937-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:37 +0100")
Message-ID: <87zhzndz12.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/49] qapi: do not define enumeration
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Subject: explicitly

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The C standard has the initial value at 0 and the subsequent values
> incremented by 1. No need to set this explicitely.
>
> This will prevent from artificial "gaps" when compiling out some enum
> values and having unnecessarily large MAX values & enums arrays.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 60c1d0a783..68a567f53f 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -2032,14 +2032,11 @@ typedef enum %(c_name)s {
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

What excactly in your series depends on this?

What safeguards do you propose to ensure an enumeration with
conditionals is compiled only with the exact same conditionals within
the same program?

Example of the kind of deathtrap to guard against: compile

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

Yes, I know a similar deathtrap will be set up for struct and union
types.  No excuse for ignoring either of the two.
