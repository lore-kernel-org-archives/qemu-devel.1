Received: from eggs.gnu.org ([2001:4830:134:3::10]:56687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhd17-0003mf-T3
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhd13-00026O-0U
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhd12-00023k-OG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:40:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-2-marcandre.lureau@redhat.com>
Date: Tue, 15 Aug 2017 16:40:12 +0200
In-Reply-To: <20170727154126.11339-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:01 +0200")
Message-ID: <87zib0j3n7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/26] qapi: fix type_seen key error
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

> The type_seen member can be of a different type than the 'qtype' being
> checked, since a string create several conflicts. Lookup the real
> conflicting type in the conflict set, that one must be present in
> type_seen.
>
> This fixes the following error, reproducible with the modified test:
>
> Traceback (most recent call last):
>   File "/home/elmarco/src/qq/tests/qapi-schema/test-qapi.py", line 56, in=
 <module>
>     schema =3D QAPISchema(sys.argv[1])
>   File "/home/elmarco/src/qq/scripts/qapi.py", line 1470, in __init__
>     self.exprs =3D check_exprs(parser.exprs)
>   File "/home/elmarco/src/qq/scripts/qapi.py", line 959, in check_exprs
>     check_alternate(expr, info)
>   File "/home/elmarco/src/qq/scripts/qapi.py", line 831, in check_alterna=
te
>     % (name, key, types_seen[qtype]))
> KeyError: 'QTYPE_QSTRING'
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                                  | 4 +++-
>  tests/qapi-schema/alternate-conflict-string.json | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 8aa2775f12..4ecc19e944 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -825,7 +825,9 @@ def check_alternate(expr, info):
>              else:
>                  conflicting.add('QTYPE_QNUM')
>                  conflicting.add('QTYPE_QBOOL')
> -        if conflicting & set(types_seen):
> +        conflict =3D conflicting & set(types_seen)
> +        if conflict:
> +            qtype =3D list(conflict)[0]
>              raise QAPISemError(info, "Alternate '%s' member '%s' can't "
>                                 "be distinguished from member '%s'"
>                                 % (name, key, types_seen[qtype]))

I see.

The fix is uninvasive, but I'm not thrilled by repurposing @qtype, and
the meaning of list(dict) is less obvious than dict.keys().  What about

           conflict =3D conflicting & set(types_seen)
           if conflict:
               conflicting_member_name =3D conflict.keys()[0]
               raise QAPISemError(info, "Alternate '%s' member '%s' can't "
                                  "be distinguished from member '%s'"
                                  % (name, key, conflicting_member_name))

Alternatively, list all conflicting names (I wouldn't bother).

> diff --git a/tests/qapi-schema/alternate-conflict-string.json b/tests/qap=
i-schema/alternate-conflict-string.json
> index 85adbd4adc..bb2702978e 100644
> --- a/tests/qapi-schema/alternate-conflict-string.json
> +++ b/tests/qapi-schema/alternate-conflict-string.json
> @@ -1,4 +1,4 @@
>  # alternate branches of 'str' type conflict with all scalar types
>  { 'alternate': 'Alt',
> -  'data': { 'one': 'str',
> -            'two': 'int' } }
> +  'data': { 'one': 'int',
> +            'two': 'str' } }

I had to think for several minutes to convince myself that this is a
better test, not just a test that happens to demonstrate a particular
bug.  It's hot, I'm slow :)
