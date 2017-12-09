Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNaLR-0006oa-OI
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNaLO-0004kl-K4
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:18:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNaLO-0004ka-DP
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:18:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-24-marcandre.lureau@redhat.com>
Date: Sat, 09 Dec 2017 09:18:41 +0100
In-Reply-To: <20170911110623.24981-24-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:05:56 +0200")
Message-ID: <87d13o71r2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 23/50] qapi: add 'if' to struct members
 and implicit objects members
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

> check_type() will now accept a DICT { 'type': TYPENAME, 'if': ... }
> instead of a TYPENAME. This is the case in various situations where
> implicit object types are allowed such as commands/events arguments
> and return type, base and branches of union & alternate.

Uh, do you mean where implicit object type are *not* allowed?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                         | 20 ++++++++++++++++----
>  tests/qapi-schema/qapi-schema-test.json | 12 +++++++++---
>  tests/qapi-schema/qapi-schema-test.out  |  4 +++-
>  3 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index df2a304e8f..15711f96fa 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -696,7 +696,15 @@ def check_type(info, source, value, allow_array=3DFa=
lse,
>          return
>=20=20
>      if not allow_dict:
> -        raise QAPISemError(info, "%s should be a type name" % source)
> +        if isinstance(value, dict) and 'type' in value:
> +            check_type(info, source, value['type'], allow_array,
> +                       allow_dict, allow_optional, allow_metas)
> +            if 'if' in value:
> +                check_if(value, info)
> +            check_unknown_keys(info, value, {'type', 'if'})
> +            return
> +        else:
> +            raise QAPISemError(info, "%s should be a type name" % source)

@allow_dict becomes a misnomer: dictionaries are now always allowed, but
they have different meaning (implicit type vs. named type with
additional attributes).

Rename to @allow_implicit?

>=20=20
>      if not isinstance(value, OrderedDict):
>          raise QAPISemError(info,
[...]
