Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWryC-0003XT-HN
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWryB-0005Pr-FP
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:57:12 -0500
References: <20171226065300.9890-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c7f0e5a-a49c-fc67-7185-5f07cca0f62d@redhat.com>
Date: Wed, 3 Jan 2018 16:57:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171226065300.9890-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="akL3Mkjwl1jW7JYgz5O8IjqTTAnDEFo2r"
Subject: Re: [Qemu-devel] [PATCH] osdep: Retry SETLK upon EINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--akL3Mkjwl1jW7JYgz5O8IjqTTAnDEFo2r
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org
Message-ID: <4c7f0e5a-a49c-fc67-7185-5f07cca0f62d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] osdep: Retry SETLK upon EINTR
References: <20171226065300.9890-1-famz@redhat.com>
In-Reply-To: <20171226065300.9890-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/26/2017 12:53 AM, Fam Zheng wrote:
> We could hit lock failure if there is a signal that makes fcntl return
> -1 and errno set to EINTR. In this case we should retry.

Did you hit this in practice?  In 'man fcntl' on my Fedora 27 box, the
DESCRIPTION section only mentions EINTR as possible for F_[OFD_]SETLKW,
but we don't appear to be using that one (just SETLK and GETLK).  On the
other hand, the ERRORS section of the same document mentions:


       EINTR  cmd  is  F_SETLKW  or  F_OFD_SETLKW and the operation was
inter=E2=80=90
              rupted by a signal; see signal(7).

       EINTR  cmd is F_GETLK, F_SETLK, F_OFD_GETLK, or  F_OFD_SETLK,
and  the
              operation  was  interrupted  by  a  signal  before  the
lock was
              checked or acquired.  Most likely when  locking  a  remote
 file
              (e.g., locking over NFS), but can sometimes happen locally.=


(I hate it when information differs between two places in the same
document, especially if I only read the first place)

>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  util/osdep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/osdep.c b/util/osdep.c
> index 1231f9f876..a73de0e1ba 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -244,7 +244,9 @@ static int qemu_lock_fcntl(int fd, int64_t start, i=
nt64_t len, int fl_type)
>          .l_type   =3D fl_type,
>      };
>      qemu_probe_lock_ops();
> -    ret =3D fcntl(fd, fcntl_op_setlk, &fl);
> +    do {
> +        ret =3D fcntl(fd, fcntl_op_setlk, &fl);
> +    } while (ret =3D=3D -1 && errno =3D=3D EINTR);

The change makes sense from a maintenance point of view, whether or not
you hit it in practice.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--akL3Mkjwl1jW7JYgz5O8IjqTTAnDEFo2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpNX74ACgkQp6FrSiUn
Q2qm5AgApskv+1rLm1Ij/tkGSrabiUPSX1Wj4rqov7iHilJWzF8GH8aWNDf+gN7W
q1C7Xlcba9NW3JPFaBFNcSkEDAUpOtjoMAALEygulRI0PYTXQiNSi/49qSVVW5FO
8149QlseAcO5YT3Qdsc8ZpgWVwNGzjIlpxl+dV34MIa75IJsF9V9VfYKNHOpJLrc
6JXphgr/v+2vUQXbIijkciT1MphuaVoSbnJuNxXHggq03bNYHTAbjsVpReKuJmER
ZS2oRdiEBMCPMRBEwUOIvkGw6Jfa4Q/r2jnQCuNYctg+pMlhm7QD2I7yANEiaGDj
Sekh2lIZvpXQK3tbDO/EN3CraTyVmQ==
=VoDF
-----END PGP SIGNATURE-----

--akL3Mkjwl1jW7JYgz5O8IjqTTAnDEFo2r--
