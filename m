Received: from eggs.gnu.org ([2001:4830:134:3::10]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecIRk-0001r0-5S
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecIRi-000546-Oe
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:14:08 -0500
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
	<20180118181123.37056-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ea9362a-50ff-cea3-67fc-a658a2ff0b93@redhat.com>
Date: Thu, 18 Jan 2018 16:13:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180118181123.37056-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5UIyFLRKw8NfxXEH30JRe6fkVnl2yVCAn"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5UIyFLRKw8NfxXEH30JRe6fkVnl2yVCAn
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <1ea9362a-50ff-cea3-67fc-a658a2ff0b93@redhat.com>
Subject: Re: [PATCH v2 3/6] qapi: add nbd-server-remove
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
 <20180118181123.37056-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180118181123.37056-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
> Add command for export removing. It is needed for cases when we

s/export removing/removing an export/

> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
>=20

No HMP counterpart? I can give a quick shot at that, as a followup patch.=


> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block.json     | 45 +++++++++++++++++++++++++++++++++++++++++++++=

>  include/block/nbd.h |  1 +
>  blockdev-nbd.c      | 24 ++++++++++++++++++++++++
>  nbd/server.c        | 21 +++++++++++++++++++++
>  4 files changed, 91 insertions(+)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index 353e3a45bd..ddf73932ce 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -228,6 +228,51 @@
>    'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
> =20
>  ##
> +# @NbdServerRemoveMode:
> +#
> +# Mode of NBD export removing.

Mode for removing an NBD export.

> +#
> +# @safe: Remove export if there are no existing connections, fail othe=
rwise.
> +#
> +# @hard: Drop all connections immediately and remove export.
> +#
> +# Postponed, not realized yet modes:

Maybe:

Potential additional modes to be added in the future:

> +#
> +# hide: Just hide export from new clients, leave existing connections =
as is.
> +#       Remove export after all clients are disconnected. nbd-server-r=
emove
> +#       with mode=3Dsoft or mode=3Dhard may be called after nbd-server=
-remove
> +#       with mode=3Dhide.

mode=3Dsafe could also be called; I don't see that this last sentence add=
s
much.

> +#
> +# soft: Hide export from new clients, answer with ESHUTDOWN for all fu=
rther
> +#       requests from existing clients. Remove export after all client=
s are
> +#       disconnected. nbd-server-requests with mode=3Dhard may be call=
ed after
> +#       nbd-server-remove with mode=3Dsoft

Again, the last sentence doesn't add mouch (I guess you're arguing that
requesting a hide doesn't make much sense after a soft disconnect has
already started; but I don't see any harm in permitting it as a no-op).

> +#
> +# Since: 2.12
> +##
> +{'enum': 'NbdServerRemoveMode', 'data': ['safe', 'hard']}
> +
> +##
> +# @nbd-server-remove:
> +#
> +# Remove NBD export by name.
> +#
> +# @name: Export name.
> +#
> +# @mode: Mode of command operation. See @NbdServerRemoveMode descripti=
on.
> +#        Default is 'safe'.
> +#
> +# Returns: error if
> +#            - the server is not running
> +#            - export is not found
> +#            - mode is 'safe' and there are existing connections
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'nbd-server-remove',
> +  'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }

Looks reasonable.


> +++ b/nbd/server.c
> @@ -1177,6 +1177,27 @@ void nbd_export_close(NBDExport *exp)
>      nbd_export_put(exp);
>  }
> =20
> +void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error=
 **errp)
> +{
> +    NBDClient *client;
> +    int nb_clients =3D 0;
> +
> +    if (mode =3D=3D NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->=
clients)) {
> +        nbd_export_close(exp);
> +        return;
> +    }
> +
> +    assert(mode =3D=3D NBD_SERVER_REMOVE_MODE_SAFE);
> +
> +    QTAILQ_FOREACH(client, &exp->clients, next) {
> +        nb_clients++;
> +    }
> +
> +    error_setg(errp, "NBD export '%s' has %d active connection%s. To f=
orce "
> +               "remove it (and hard disconnect clients) use mode=3D'ha=
rd'",
> +               exp->name, nb_clients, nb_clients =3D=3D 1 ? "" : "s");=


Playing games with English pluralization doesn't work too well in error
messages, if we ever want to allow translations; does the number of
active clients actually matter?  Also, error_setg() recommends against
using '.' or more than one sentence.  Better might be:

error_setg(errp, "export '%s' still in use");
error_append_hint(errp, "Use mode=3D'hard' to force client disconnect\n")=
;

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5UIyFLRKw8NfxXEH30JRe6fkVnl2yVCAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphHCQACgkQp6FrSiUn
Q2olWwf/T+PY/BMbJJOxIIyh1FVPM23BzcOwxAGfXa+dL/Z+DEc6wBYBQqj5naWw
C6rnhZJdrqbuArIYnSSaPUq1x1DHizi/UJ0uHSPuFwO31dMZ/CqMb0pibaYgxEFV
ZzSSgYxcCJh44SV7kIkt9HN1TRXxMgl3Sd8+DQwzAs93ndFJMFxZcc6xCK2VmQgL
uAZPl75WxcI+OXfLKVWkOMkbwY35xyFFcXGP1z9R+8cEk9BiDUH4xxTVYFKXkW5O
+e3UZ7Zjp/gu2d8TXlOLBRoxKWMiz0x1Br2v6wqJ/AnzmzC8rL8thEc0rehN9WIS
M2Ahmsjh0cIIYiRE2YZPu7FLkDxB1w==
=QK4F
-----END PGP SIGNATURE-----

--5UIyFLRKw8NfxXEH30JRe6fkVnl2yVCAn--
