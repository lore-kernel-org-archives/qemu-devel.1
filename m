Received: from eggs.gnu.org ([2001:4830:134:3::10]:37425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHabD-00016m-Vm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHabD-0001pu-32
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:22:19 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a852369-099f-b93e-9e5f-aae841b6f815@redhat.com>
Date: Wed, 22 Nov 2017 13:22:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xd64SOJNdk1TfRfJIWgpw3iWkwRUO9b79"
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd/server: add nbd_opt_{read,
 drop} to track client->optlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xd64SOJNdk1TfRfJIWgpw3iWkwRUO9b79
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <2a852369-099f-b93e-9e5f-aae841b6f815@redhat.com>
Subject: Re: [PATCH 2/5] nbd/server: add nbd_opt_{read,drop} to track
 client->optlen
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> @@ -299,7 +312,7 @@ static int nbd_negotiate_handle_export_name(NBDClie=
nt *client,
>          error_setg(errp, "Bad length received");
>          return -EINVAL;
>      }
> -    if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
> +    if (nbd_opt_read(client, name, client->optlen, errp) < 0) {
>          error_prepend(errp, "read failed: ");
>          return -EINVAL;
>      }

More context:

      name[client->optlen] =3D '\0';

Oops - that's broken, because client->optlen is now 0.  Which means your
code was only tested with empty-string default exports.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xd64SOJNdk1TfRfJIWgpw3iWkwRUO9b79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloVzmIACgkQp6FrSiUn
Q2qaSgf7B07fKyW2dBMy/XQNw1rgQd/JAueMBDL7iU2faI9UpnH2zdxlcDj/ChzR
Ofe0DFlLqh0bAWu/3sV6zst33BGtsWthPSCepK1DQkCI0Nts1DjOqou0tfeBHPWu
iGBfT7D9XD8kZBmHMnyHx/UKpg4HN5KckfrvGcoWVXtVR3ybr+1jfDS131ygHPs6
njKl+dK0OoraO5EyFere2DPMpyAewKtzZt5QQvZrNE7zFoqL2V7+InT/uzxE0SWp
3y0FNOMrEeDTPNBnBo0Nk4ulM6SJ7TSuIqdfxabZ7exHHp7neDwnyY3851whJccE
WkWKl51N/0vduRv/S9Ut+QyeB5RlFg==
=IWAP
-----END PGP SIGNATURE-----

--xd64SOJNdk1TfRfJIWgpw3iWkwRUO9b79--
