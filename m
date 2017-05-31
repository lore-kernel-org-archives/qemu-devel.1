Received: from eggs.gnu.org ([2001:4830:134:3::10]:54873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG8ha-0005jk-F1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG8hX-0005ID-AM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dG8hX-0005Hk-1N
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:50:35 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ad9ba3c-f7cc-c46b-7126-a2e9be5263f8@redhat.com>
Date: Wed, 31 May 2017 13:50:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170531165541.47338-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qKTIiWJdC5emPpLoOSiMJl7X2F4mRkfkB"
Subject: Re: [Qemu-devel] [PATCH 03/12] nbd/server: get rid of
 nbd_negotiate_read and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKTIiWJdC5emPpLoOSiMJl7X2F4mRkfkB
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <1ad9ba3c-f7cc-c46b-7126-a2e9be5263f8@redhat.com>
Subject: Re: [PATCH 03/12] nbd/server: get rid of nbd_negotiate_read and
 friends
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
 <20170531165541.47338-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170531165541.47338-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 11:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> Functions nbd_negotiate_{read,write,drop_sync} were introduced in
> 1a6245a5b, when nbd_rwv (was nbd_wr_sync) was working through
> qemu_co_sendv_recvv (the path is nbd_wr_sync -> qemu_co_{recv/send} ->
> qemu_co_send_recv -> qemu_co_sendv_recvv), which just yields, without
> setting any handlers. But starting from ff82911cd nbd_rwv (was
> nbd_wr_syncv) works through qio_channel_yield() which sets handlers, so=

> watchers are redundant in nbd_negotiate_{read,write,drop_sync}, then,
> let's just use nbd_{read,write,drop} functions.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 107 ++++++++++++---------------------------------------=
--------
>  1 file changed, 22 insertions(+), 85 deletions(-)


>     Server         Client
> @@ -205,22 +142,22 @@ static int nbd_negotiate_send_rep_len(QIOChannel =
*ioc, uint32_t type,
>            type, opt, len);
> =20
>      magic =3D cpu_to_be64(NBD_REP_MAGIC);
> -    if (nbd_negotiate_write(ioc, &magic, sizeof(magic)) < 0) {
> +    if (nbd_write(ioc, &magic, sizeof(magic), NULL) < 0) {
>          LOG("write failed (rep magic)");
>          return -EINVAL;

This says that you are ignoring errors (via errp) rather than reporting
them (because we LOG() it instead).  You do clean it up later, but it
would be nice to mention that in the commit message.

But because we have the later error fixups, I'm okay with:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qKTIiWJdC5emPpLoOSiMJl7X2F4mRkfkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLxB4AAoJEKeha0olJ0NqMMkH/2EwbXtf80DLraPqbTcsRjGS
xCbVIBnpi0EVOXCi9KKhPGB54PES2AVTXLA73kVHSfITm463UTbwVzaMINHrm0rx
5vBs/1UPGUHkeczYuxcoq42rso8C/IhdN673KjDp0o7MAaM9o1WmWLyGhFVlFyqH
0cWqtxIO15EXQbYYvBhGJAEat5KevcYugfkYTPbCplr+s9ACXBzZmRnyCSXbWa70
8fm/fwrmbLFahOLsKkLvcVnN1NgMERhB0c01lHG+7+g+dv9VDSIIuaHypnt3Mr9h
S1PrDlTGFmpIvRrqcjYj1zq0rq/sFd9aNVqG74mQiWGqFBObqgFzaREmRDkw/Tc=
=2WVs
-----END PGP SIGNATURE-----

--qKTIiWJdC5emPpLoOSiMJl7X2F4mRkfkB--
