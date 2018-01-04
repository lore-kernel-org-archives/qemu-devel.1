Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX8vI-0003MU-IR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX8v4-0006qH-Ix
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:03:20 -0500
References: <20180104024228.11780-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a288c5a1-e9ff-b50a-ee1e-1b48ab29e31a@redhat.com>
Date: Thu, 4 Jan 2018 11:02:25 -0600
MIME-Version: 1.0
In-Reply-To: <20180104024228.11780-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bmwpEOsrhJS61pDJWdYVgBPOviOsFPm2N"
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bmwpEOsrhJS61pDJWdYVgBPOviOsFPm2N
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Message-ID: <a288c5a1-e9ff-b50a-ee1e-1b48ab29e31a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
References: <20180104024228.11780-1-famz@redhat.com>
In-Reply-To: <20180104024228.11780-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 08:42 PM, Fam Zheng wrote:
> scsi_disk_emulate_command passes in_buf=3DNULL and in_len=3D0 in the
> REQUEST_SENSE branch. Inline the fixed_in evaluation and put it after
> the in_len test.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scsi/utils.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/scsi/utils.c b/scsi/utils.c
> index ddae650a99..9a0a925ef9 100644
> --- a/scsi/utils.c
> +++ b/scsi/utils.c
> @@ -320,10 +320,8 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len=
,
>                         uint8_t *buf, int len, bool fixed)
>  {
>      SCSISense sense;
> -    bool fixed_in;
> =20
> -    fixed_in =3D (in_buf[0] & 2) =3D=3D 0;
> -    if (in_len && fixed =3D=3D fixed_in) {
> +    if (in_len && !!fixed =3D=3D ((in_buf[0] & 2) =3D=3D 0)) {

Huh?  'fixed' is already a bool, so '!!fixed' is just extra typing that
makes things harder to read.  Did you mean:

if (in_len && fixed =3D=3D !(in_buf[0] & 2))

as something that is slightly more legible (the LHS is already bool, the
RHS uses a single ! to convert a bitwise test into a bool with the
correct sense)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bmwpEOsrhJS61pDJWdYVgBPOviOsFPm2N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpOXiEACgkQp6FrSiUn
Q2q3tAf/VfmlkeBsOPV7biWUHJP9Md1c8o/bIcXGoFUEiXUUhAohCh7FSDBfGthb
p3LOqc0n/zWugQ4mf8Kb8ROsGwD2uJR6fk1oXG+jHmMuIHAAHL5rN/xK64gTt1/h
1vLRofN6AzdV1iqHmxaDeo2xOXy+2RxEmCj9+ywpCAo9UrSmKzLnN7aMwFQGjmkK
t1wSMwZ53O/RoAm3Vp9ByJxa/m3yzwjG5OGmSGzvxzvSpd6QM35mVu5a0utu/i7A
5HA8HnlblChPz8MRsk//VvlpXieN3KUyK4a1mGMsPS19+L7eSL6FDF2AfQNZO7lN
fsbvHpNAzy2qUmuyLlO88JHh78D9mQ==
=vOfa
-----END PGP SIGNATURE-----

--bmwpEOsrhJS61pDJWdYVgBPOviOsFPm2N--
