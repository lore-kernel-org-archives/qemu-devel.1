Received: from eggs.gnu.org ([2001:4830:134:3::10]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN3tL-0006js-4u
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN3tK-0000VZ-A7
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:39:39 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-5-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65e09850-ce6c-340c-50eb-dfa917a1afea@redhat.com>
Date: Thu, 7 Dec 2017 15:39:24 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-5-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q5m5IkmtPiHQPsfm6eCh7AWqGGkIGcTqA"
Subject: Re: [Qemu-devel] [PATCH v2 4/9] block: don't keep AioContext
 acquired after blockdev_backup_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5m5IkmtPiHQPsfm6eCh7AWqGGkIGcTqA
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <65e09850-ce6c-340c-50eb-dfa917a1afea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/9] block: don't keep AioContext acquired
 after blockdev_backup_prepare()
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-5-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockdev.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>=20

>      state->job =3D do_blockdev_backup(backup, common->block_job_txn, &=
local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return;
> +        goto out;
>      }
> +
> +out:
> +    aio_context_release(aio_context);
>  }

Again a weird one-shot label where fallthrough would do the same.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q5m5IkmtPiHQPsfm6eCh7AWqGGkIGcTqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloptQwACgkQp6FrSiUn
Q2qpbQf/StY6WWlSQHYppJwkkWYNVTeo9+gMVtbsF5Wg8Qpq80WZgcZf20TVW/M4
AFEV/eNUOJvUIzMltklB0QMZ/52Ke8xxTp8OhA15Crvu2RwX0tYXqLObo/WeVJIz
3T2PQZP1j1SuqhD2OLpIpfrfGRtv6FMTIJVuvk0uOH/4sKZ2FAdS1Yi4brPMvVTV
IspcwkRJv4QSJ0ME+6fTpmFIV9RCDhbCKnmLR5VkJ8iO7UVFe5Tgibnu5l6BmYzl
4khe2Mn6BbWG5HW7T998w7c+gLsyk+LuMpsYtc5skifGQdhvGWUMT5HASGJH9Fjz
UoWqY0Ho5Sb6n33U/ZjAAZe6RCjlzw==
=ZFkk
-----END PGP SIGNATURE-----

--Q5m5IkmtPiHQPsfm6eCh7AWqGGkIGcTqA--
