Received: from eggs.gnu.org ([2001:4830:134:3::10]:55261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctK4W-0007f9-C7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctK4S-0001sE-6N
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:20:00 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27410c8a-0213-6ede-e9a3-cbb248f3e7a4@redhat.com>
Date: Wed, 29 Mar 2017 15:19:40 -0500
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N5Nw65dcbpuo9FkFr6hUKak6Gu74ciIfW"
Subject: Re: [Qemu-devel] [for-2.9 7/8] nbd: Tidy up blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N5Nw65dcbpuo9FkFr6hUKak6Gu74ciIfW
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <27410c8a-0213-6ede-e9a3-cbb248f3e7a4@redhat.com>
Subject: Re: [for-2.9 7/8] nbd: Tidy up blockdev-add interface
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2017 11:45 AM, Markus Armbruster wrote:
> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  I intend to limit its use to
> existing external interfaces, and convert all internal interfaces to
> SocketAddressFlat.
>=20
> BlockdevOptionsNbd is an external interface using SocketAddress, but
> it's new in 2.9.  Replace it by SocketAddressFlat while we can.  This
> simplifies
>=20
>     { "execute": "blockdev-add",
>       "arguments": { "node-name": "foo", "driver": "nbd",
>                      "server": { "type": "inet",
> 		                 "data": { "host": "localhost",
> 				           "port": "12345" } } } }
>=20
> to
>=20
>     { "execute": "blockdev-add",
>       "arguments": { "node-name": "foo", "driver": "nbd",
>                      "server": { "type": "inet",
> 		                 "host": "localhost", "port": "12345" } } }

This part makes sense, and means this has to go in 2.9.

>=20
> Since the internal interfaces still take SocketAddress, this requires
> conversion function socket_address_crumple().  It'll go away when I
> update the interfaces.

This is probably the fastest way forward for 2.9, even if we rip it out
later in 2.10.

>=20
> Unfortunately, SocketAddress is also visible in -drive since 2.8.  Add
> still more gunk to nbd_process_legacy_socket_options().  You can now
> shorten
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.data.host=3D=
127.0.0.1,server.data.port=3D12345
>=20
> to
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.host=3D127.=
0.0.1,server.port=3D12345

Here, I'm 50/50 on whether the compatibility gunk is worth it, or
whether to make a clean break of old configurations, as I'm not sure who
is using the old configurations.  But given the lateness of the change
(and my recent case of being burned on qom-type during freeze when I was
not conservative), I agree with your conservative approach of remaining
compatible, even if it means the patch is larger than desired, and even
if we rip it out again in 2.10.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c          | 131 ++++++++++++++++++++++++++++++++++++++++---=
--------
>  qapi/block-core.json |   2 +-
>  2 files changed, 104 insertions(+), 29 deletions(-)
>=20

> @@ -223,17 +224,45 @@ static bool nbd_process_legacy_socket_options(QDi=
ct *output_options,
>      const char *path =3D qemu_opt_get(legacy_opts, "path");
>      const char *host =3D qemu_opt_get(legacy_opts, "host");
>      const char *port =3D qemu_opt_get(legacy_opts, "port");
> +    const char *sd_path =3D qemu_opt_get(legacy_opts, "server.data.pat=
h");
> +    const char *sd_host =3D qemu_opt_get(legacy_opts, "server.data.hos=
t");
> +    const char *sd_port =3D qemu_opt_get(legacy_opts, "server.data.por=
t");
> +    bool no_server =3D path || host || port;
> +    bool server_data =3D sd_path || sd_host || sd_port;
>      const QDictEntry *e;
> =20
> -    if (!path && !host && !port) {
> +    if (!no_server && !server_data) {

Feels like a double negative, although it's not really serving that
role.  Maybe a better name would be s/no_server/bare/, so that 'bare' is
now your counterpart to 'server_data'.

> +        return true;
> +    }
> +
> +    if (no_server && server_data) {
> +        error_setg(errp, "Cannot use %s and %s at the same time",
> +                   "path/host/port", "server.data.*");
> +        return false;

Again, 'bare' makes this conditional read a bit better.

> +    }
> +
> +    if (server_data) {
> +        if (sd_host) {
> +            qdict_put(output_options, "server.host",
> +                      qstring_from_str(sd_host));
> +        }
> +        if (sd_port) {
> +            qdict_put(output_options, "server.port",
> +                      qstring_from_str(sd_port));
> +        }
> +        if (sd_path) {
> +            qdict_put(output_options, "server.path",
> +                      qstring_from_str(sd_path));
> +        }

Wow, I need to rebase my qdict_put_str() stuff again - that ought to be
something we include early in 2.10, as it touches a lot of stuff.
Doesn't affect your patch for now, though.

Renaming the local variable is trivial, so whether or not you
incorporate my naming suggestion,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--N5Nw65dcbpuo9FkFr6hUKak6Gu74ciIfW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3BbcAAoJEKeha0olJ0Nq/eYIAI6AZuCI/qoxRRVtpcZhPId0
a357IEBk/IDRVU/oQ4rGtcdH1Jc1ycFsDBdks23hhqsuANYzRj+7D97kDFo/SMCW
PgFjnXvzyqj5ooJ+zrxQXLzK+AW/7TNZmxQwBvuwL9OMp2+ux45Z/dUqBz2PSU1S
VW9UW7roqmv9p0F8YpghI9XeveYBjO9m7vrue15w3AurSE4+vpbbv8NkcyNHB7D9
SHiK0bLz9UQzU54MBGFuo5BHQB+DLtX+YJBu4onHWMyyBXl35z+sQ+jm/s1MoFAV
5N88U0vx4SUW4GEHRUwSnvxzrKqMUcYDqnnebgyjd52RXvGc+tfUy4FIsDTIJzc=
=iUdH
-----END PGP SIGNATURE-----

--N5Nw65dcbpuo9FkFr6hUKak6Gu74ciIfW--
