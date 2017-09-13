Received: from eggs.gnu.org ([2001:4830:134:3::10]:51899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds87I-0005hk-A5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds87H-00088d-7y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:54:12 -0400
References: <20170913082817.24731-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a01f3fe2-6315-34d4-6f68-c0e1f38e4e1e@redhat.com>
Date: Wed, 13 Sep 2017 08:54:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170913082817.24731-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FLfiQXoECgfGxwst3V32VE8j4DBTXwXlh"
Subject: Re: [Qemu-devel] [PATCH] throttle: Assert that bkt->max is valid in
 throttle_compute_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FLfiQXoECgfGxwst3V32VE8j4DBTXwXlh
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <a01f3fe2-6315-34d4-6f68-c0e1f38e4e1e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] throttle: Assert that bkt->max is valid in
 throttle_compute_wait()
References: <20170913082817.24731-1-berto@igalia.com>
In-Reply-To: <20170913082817.24731-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 03:28 AM, Alberto Garcia wrote:
> If bkt->max =3D=3D 0 and bkt->burst_length > 1 then we could have a
> division by 0 in throttle_do_compute_wait(). That configuration is
> however not permitted and is already detected by throttle_is_valid(),
> but let's assert it in throttle_compute_wait() to make it explicit.
>=20
> Found by Coverity (CID: 1381016).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  util/throttle.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/util/throttle.c b/util/throttle.c
> index 06bf916adc..b38e742da5 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -124,6 +124,7 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
>      /* If the main bucket is not full yet we still have to check the
>       * burst bucket in order to enforce the burst limit */
>      if (bkt->burst_length > 1) {
> +        assert(bkt->max > 0); /* see throttle_is_valid() */
>          extra =3D bkt->burst_level - burst_bucket_size;
>          if (extra > 0) {
>              return throttle_do_compute_wait(bkt->max, extra);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FLfiQXoECgfGxwst3V32VE8j4DBTXwXlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5OHkACgkQp6FrSiUn
Q2pT5wf/Sc+rVU7LVeM3tFbvtSX2fMG+ZpLtB8OIskFV70d/Y/UIDLSVUN2fNKXj
/TDTmj+aYyCY5SNYGkeUH49hi7/VvnIqmp361d0D9wxcxqrEd+ZzsmNdViSj/OVH
HU6jKrNPlRvdAqoqpjbQcon5Bia9ApZl/30R+AocGXcUcKJ92iHCBLDoJRCALyeW
KRxMBZOWOhee0tnjSSwDK3DjvscbtqX/NUnUbCSfzBsDkP7RWtUN6D8Y16QJGZzK
Rg0wPVRNR5TG7dsOrgo9jyewG/2d/TlXMCosMWlHT61grLP1MNnRICYE5DdPQFzN
HRKGNiz7R9aeAb4x6c42drx8Q9jrCQ==
=doCj
-----END PGP SIGNATURE-----

--FLfiQXoECgfGxwst3V32VE8j4DBTXwXlh--
