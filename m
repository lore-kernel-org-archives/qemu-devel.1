Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUX5d-0004kk-Rx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUX5Z-0002sP-S6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:19:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUX5Z-0002ra-LM
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:19:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A446C307DAC5
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 13:19:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-7-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 14:19:35 +0100
In-Reply-To: <20180706105753.26700-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 12:57:32 +0200")
Message-ID: <875zw8t8k8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/27] qapi: do not define enumeration
 value explicitly
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The C standard has the initial value at 0 and the subsequent values
> incremented by 1. No need to set this explicitely.
>
> This will prevent from artificial "gaps" when compiling out some enum
> values and having unnecessarily large MAX values & enums arrays, or
> simplifying iterating over valid enum values.

Yes, gaps can be annoying, e.g. in lookup tables where gaps get confused
with sentinels.

Avoiding gaps scares me.  You have to religiously compile the enum with
the exact same configuration everywhere in the program, or else you end
up with bugs that are hard to spot.  Therefore:

> Whenever config-host.h is changed, all the enum/types are recompiled.
>
> (a subsequent patch will split the schema. Target-specific poisoined
> conditionals will be added. They cannot be mixed with the common
> schema: it is not possible to end up with enums of different values in
> common and target builds)

Should we mention config-target.h here?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 02c5c6767a..6f9498566e 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -2045,14 +2045,11 @@ typedef enum %(c_name)s {
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

I need to consider the whole series to decide whether avoiding gaps is a
good idea.  If it is, then this patch is fine.
