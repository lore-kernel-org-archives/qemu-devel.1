Received: from eggs.gnu.org ([2001:4830:134:3::10]:49630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJqf7-0002dQ-BI
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJqY9-0000hf-64
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 20:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gJqY7-0000Zl-3q
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 20:52:59 -0500
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-3-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e5be22fc-7387-38b8-a602-055822f4d038@redhat.com>
Date: Tue, 6 Nov 2018 02:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N19mdA4R1Lz9Q8ZLetQZqwqZxk9BPW9Sk"
Subject: Re: [Qemu-devel] [PATCH 2/4] scsi-generic: avoid out-of-bounds
 access to VPD page list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N19mdA4R1Lz9Q8ZLetQZqwqZxk9BPW9Sk
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e5be22fc-7387-38b8-a602-055822f4d038@redhat.com>
Subject: Re: [PATCH 2/4] scsi-generic: avoid out-of-bounds access to VPD page
 list
References: <20181029173437.32559-1-pbonzini@redhat.com>
 <20181029173437.32559-3-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.10.18 18:34, Paolo Bonzini wrote:
> A device can report an excessive number of VPD pages when asked for a
> list; this can cause an out-of-bounds access to buf in
> scsi_generic_set_vpd_bl_emulation.  It should not happen, but
> it is technically not incorrect so handle it: do not check any byte
> past the allocation length that was sent to the INQUIRY command.

(Minor note: Since the list must be kept in ascending order, it's fully
correct to only check the first sizeof(buf) - 4 =3D=3D 0xf6 bytes, becaus=
e
it actually has to be at index 0xb0 or before, if the device supports it.=
)

> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index aebb7cdd82..c5497bbea8 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -538,7 +538,7 @@ static void scsi_generic_set_vpd_bl_emulation(SCSID=
evice *s)
>      }
> =20
>      page_len =3D buf[3];

You lost your enthusiasm for fixing the accesses to be proper big-endian
16-bit accesses so quickly? :-)

> -    for (i =3D 4; i < page_len + 4; i++) {
> +    for (i =3D 4; i < MIN(sizeof(buf), page_len + 4); i++) {

Reviewed-by: Max Reitz <mreitz@redhat.com>

>          if (buf[i] =3D=3D 0xb0) {
>              s->needs_vpd_bl_emulation =3D false;
>              return;
>=20



--N19mdA4R1Lz9Q8ZLetQZqwqZxk9BPW9Sk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvg8/AACgkQ9AfbAGHV
z0Ci4wf9FjaS+BCKFBGuyU09Bbb2GnrZcRYS09VS0pQcdxS0BuwDShO/MEG1TYfc
bvz6Ex8jowmeSe15hSnjhPi7kk/OkOHFxmMIZuJyn+Hb7lbTJJvDv0OMcb/rNxhr
t2qfw9fRLiK6WtJNlqOBNp7ic3X1Xl7GK8tgcwyjOLNfHjtJ7u7lEgCCREEJc836
c/iKwksPx3cTkjptuK5gHwZLFj0StDpyGYPFREmJE4Wyy9IoPK4vx2pZbNiBgmk7
A2eoEckl9psSYWHeBH/FJsS0mFqnAn6kiHp2oh/RrQ3T+Z0DIVPfUnJTPexGSXI7
RToWzZFGPOtVzh6LBwP6Z3N5na2QAg==
=OoY5
-----END PGP SIGNATURE-----

--N19mdA4R1Lz9Q8ZLetQZqwqZxk9BPW9Sk--
