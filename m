Received: from eggs.gnu.org ([2001:4830:134:3::10]:45131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHH0m-0002ss-7Q
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHH0i-0003WO-3a
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:55:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHH0h-0003W1-RZ
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:55:04 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-18-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dc3fd5c-45ab-3d32-bd72-bbb0a6986bee@redhat.com>
Date: Sat, 3 Jun 2017 16:55:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-18-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wgwLEUWMUVwCCAVpXXdfksEOSFW6nnqtW"
Subject: Re: [Qemu-devel] [PATCH 17/19] nbd/common: nbd_tls_handshake: use
 error_reportf_err instead of TRACE
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
--wgwLEUWMUVwCCAVpXXdfksEOSFW6nnqtW
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <9dc3fd5c-45ab-3d32-bd72-bbb0a6986bee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/19] nbd/common: nbd_tls_handshake: use
 error_reportf_err instead of TRACE
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-18-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use error_reportf_err instead of TRACE in case of fail.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/nbd/common.c b/nbd/common.c
> index 88e0297fb2..574a551abe 100644
> --- a/nbd/common.c
> +++ b/nbd/common.c
> @@ -102,7 +102,7 @@ void nbd_tls_handshake(QIOTask *task,
>      struct NBDTLSHandshakeData *data =3D opaque;
> =20
>      if (qio_task_propagate_error(task, &data->error)) {
> -        TRACE("TLS failed %s", error_get_pretty(data->error));
> +        error_reportf_err(data->error, "TLS failed");

I don't think this is right. You already populated &data->error(), which
means you have the error message available to the caller, and should let
the caller handle the message rather than blindly reporting it here
yourself (especially since if the caller also reports it, you've now
doubled up error messages).  Converting this TRACE() into a proper
tracepoint may be okay, but it may also be sufficient to just delete
this TRACE() since the caller should already be handling the failure.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wgwLEUWMUVwCCAVpXXdfksEOSFW6nnqtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMzA1AAoJEKeha0olJ0NqpUIH/2uiDjQ+z+/kF3Oz9nglK762
d9FFv3KYJCdowPerjNRC4og68fPXB0hJfNx7Rbg1yHe97aiRFX2EAIP6VaoNdRyD
LCyKi7jUtqOEsJeQraGXhL7SBK9scmVNBXetcOWZ8dt0lZumuc6Taykfc4uSIHDN
iWs60gFy+VCiM8l+yk4G/kSE9vfeJK1r61FA2Te01zvd8xJt6+usePm3tmVBeB7E
A9rqXAbnqlwN5Ml8NKh4qWfw7vGXYTVrrSnyrfzFV9HOnaInUD0u/uRoj8ff8ysz
WkEr0g5/vnxPKFh4OI3oTQ6Mje7GGYQ4tjHs5pmrarmN0UfTMPn7bLUXac5O1DQ=
=Brml
-----END PGP SIGNATURE-----

--wgwLEUWMUVwCCAVpXXdfksEOSFW6nnqtW--
