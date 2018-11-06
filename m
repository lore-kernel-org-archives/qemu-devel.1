Received: from eggs.gnu.org ([2001:4830:134:3::10]:55425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJr4I-000131-6k
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJr0G-00067y-Dq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:22:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gJr0G-00066D-5x
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:22:04 -0500
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-5-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7735eb3f-ef9a-aec6-95f9-cbf2f11c4a4e@redhat.com>
Date: Tue, 6 Nov 2018 03:22:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-5-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dPBm4lS4lL2Y8PvAcEVIc8j3WiQB2lfmF"
Subject: Re: [Qemu-devel] [PATCH 4/4] scsi-generic: do not do VPD emulation
 for sense other than ILLEGAL_REQUEST
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
--dPBm4lS4lL2Y8PvAcEVIc8j3WiQB2lfmF
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <7735eb3f-ef9a-aec6-95f9-cbf2f11c4a4e@redhat.com>
Subject: Re: [PATCH 4/4] scsi-generic: do not do VPD emulation for sense other
 than ILLEGAL_REQUEST
References: <20181029173437.32559-1-pbonzini@redhat.com>
 <20181029173437.32559-5-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.10.18 18:34, Paolo Bonzini wrote:
> Pass other sense, such as UNIT_ATTENTION or BUSY, directly to the
> guest.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

[...]

> @@ -269,12 +268,15 @@ static void scsi_read_complete(void * opaque, int=
 ret)
>       * resulted in sense error but would need emulation.
>       * In this case, emulate a valid VPD response.
>       */
> -    if (s->needs_vpd_bl_emulation) {
> +    if (ret =3D=3D 0 &&
> +        (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
> +        scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr).key=
 =3D=3D ILLEGAL_REQUEST &&

As noted by Patchew, this line needs to be split.  With that done:

Reviewed-by: Max Reitz <mreitz@redhat.com>


Thanks for the series!

Max


--dPBm4lS4lL2Y8PvAcEVIc8j3WiQB2lfmF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvg+sgACgkQ9AfbAGHV
z0Bz/wf/RAJEQdnnT1rQbzGeNMiV8knBGufZ5ObpvMrrfOc6kaYDNb5N8GgL+20U
9PK4uVHmUwDxU4qx6D7evaUnhFUSFAeIALgQSfBBuPmFebTNZYRI1sZGApx7Q5/p
IRQlW5/FrIIDiY88zgAFXSlKji5sOaqTte4A1XgIidJFIcwM3lybjU2wb8tCIIW1
TmTzOJ88Gj9QUBHENxhCrWYh801xCFxcLRxGPq90f6QrXf2CPPdfUDqAnG3H1RCk
hWIvX2A+mY/MtaU7mhyFuEOpBPhTZ4nrfHVGBPBVFr4A4/JeCkzKqnjfkJH1S47V
rr/i2mNUKCybm2IBlRniCMH8TGPk1Q==
=0SG2
-----END PGP SIGNATURE-----

--dPBm4lS4lL2Y8PvAcEVIc8j3WiQB2lfmF--
