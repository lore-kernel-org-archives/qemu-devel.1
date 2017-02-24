Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chOu8-0007Cr-GQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chOu5-0007zg-As
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:04:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chOu5-0007zI-39
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:03:57 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03791C056791
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 23:03:57 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <902f6fcc-2aa4-8aca-7c4b-0b5fd0e918b8@redhat.com>
Date: Fri, 24 Feb 2017 17:03:54 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S6PPWd1hKqmH5uD86fKb5iEe8FxF2Pdug"
Subject: Re: [Qemu-devel] [PATCH 06/21] qmp: Drop duplicated QMP command
 object checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S6PPWd1hKqmH5uD86fKb5iEe8FxF2Pdug
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <902f6fcc-2aa4-8aca-7c4b-0b5fd0e918b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/21] qmp: Drop duplicated QMP command
 object checks
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> qmp_check_input_obj() duplicates qmp_dispatch_check_obj(), except the
> latter screws up an error message.  handle_qmp_command() runs first
> the former, then the latter via qmp_dispatch(), masking the screwup.
>=20
> qemu-ga also masks the screwup, because it also duplicates checks,
> just differently.

Cleaning up the duplication is a win in my book.

>=20
> qmp_check_input_obj() exists because handle_qmp_command() needs to
> examine the command before dispatching it.  The previous commit got
> rid of this need, except for a tracepoint, and a bit of "id" code that
> relies on qdict not being null.
>=20
> Fix up the error message in qmp_dispatch_check_obj(), drop
> qmp_check_input_obj() and the tracepoint.  Protect the "id" code with
> a conditional.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c           | 74 +++++----------------------------------------=
--------
>  qapi/qmp-dispatch.c |  3 +--
>  trace-events        |  1 -
>  3 files changed, 7 insertions(+), 71 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index dcf2de7..d83888d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3697,67 +3697,10 @@ static int monitor_can_read(void *opaque)
>      return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
>  }
> =20
> -/*
> - * Input object checking rules
> - *
> - * 1. Input object must be a dict
> - * 2. The "execute" key must exist
> - * 3. The "execute" key must be a string
> - * 4. If the "arguments" key exists, it must be a dict
> - * 5. If the "id" key exists, it can be anything (ie. json-value)
> - * 6. Any argument not listed above is considered invalid

You know, with just a little tweak, we could add something to the .json
file, and let generated code do all the checks of even the top-level
entities:

{ 'struct': 'WireCommand',
  'data': { 'execute': 'str', '*arguments': 'dict', '*id': 'any' } }

if we had a way to force 'dict' as a subset of 'any' but where it must
be a QDict.  (If we had a 'dict' recognized by the QAPI code generators,
we could probably also fix 'object-add' to use '*props':'dict' instead
of its current use of 'any')

But that sounds like a bit much to ask for in the 2.9 timeframe, so it
doesn't hold up this patch.

We lose a trace, but I don't think that's fatal.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--S6PPWd1hKqmH5uD86fKb5iEe8FxF2Pdug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsLvaAAoJEKeha0olJ0NqjygH/RDs0N14jY2gd5tBsYYwU9fU
mz0TfdF5vcpqk+zBStqcj2/rs5i51zCZp2TEiMAN9NC+VAUQkS2Ng+zJz/k/smWe
9PkklP+MnDuWrCy2CjQ4KT4cB/EeuBmK37q6FkFDAaYqoTl2yWX3Xo/jpMKwjmM4
/GdNUO0xNKPzXucyCgF02cuP5S305cnf98H2DDKz6w2SRXLWpACNGGcvoTeaoJJ6
ZidqXfk8zgQS8oQAyLhp0fmCqnA7OdzHexLkRQgrsHwRoe2pxA8yedN53hHlS7s5
ZKR1ubBDELla1Lt916UPTwLYpug/8n0JQTEi5r3tyaa+Ac/GTyZg9ML4UxM4rIs=
=tKqA
-----END PGP SIGNATURE-----

--S6PPWd1hKqmH5uD86fKb5iEe8FxF2Pdug--
