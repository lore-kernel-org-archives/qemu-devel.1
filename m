Received: from eggs.gnu.org ([2001:4830:134:3::10]:56104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXS2Q-0006bu-6q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXS2P-0003iM-4t
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:32:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXS2O-0003hm-Ua
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17428307D858
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:32:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-7-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 15:32:21 +0100
In-Reply-To: <20181213123724.4866-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:08 +0400")
Message-ID: <87r2elpkei.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 06/22] qapi: add a dictionary form with
 'name' key for enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

One little thing...

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Desugar the enum NAME form to { 'name': NAME }. This will allow to add
> new enum members, such as 'if' in the following patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
[...]
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index f205805751..bb928d2f7d 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
[...]
> @@ -847,19 +851,29 @@ def check_alternate(expr, info):
>              types_seen[qt] =3D key
>=20=20
>=20=20
> +def normalize_enum(expr):
> +    if isinstance(expr['data'], list):
> +        expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
> +                        for m in expr['data']]
> +
> +
>  def check_enum(expr, info):
>      name =3D expr['enum']
> -    members =3D expr.get('data')
> +    members =3D expr['data']
>      prefix =3D expr.get('prefix')
>=20=20
> -    if not isinstance(members, list):
> -        raise QAPISemError(info,
> -                           "Enum '%s' requires an array for 'data'" % na=
me)
>      if prefix is not None and not isinstance(prefix, str):
>          raise QAPISemError(info,
>                             "Enum '%s' requires a string for 'prefix'" % =
name)
> +
> +    if not isinstance(members, list):
> +        raise QAPISemError(info,
> +                           "Enum '%s' requires an array for 'data'" % na=
me)
> +

The move of the "requires an array" check looks accidental.  I'll back
it out unless you tell me it's needed.

>      for member in members:
> -        check_name(info, "Member of enum '%s'" % name, member,
> +        source =3D "dictionary member of enum '%s'" % name
> +        check_known_keys(info, source, member, ['name'], [])
> +        check_name(info, "Member of enum '%s'" % name, member['name'],
>                     enum_member=3DTrue)
>=20=20
>=20=20
[...]
