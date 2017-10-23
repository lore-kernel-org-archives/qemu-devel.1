Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e6bMI-0004fM-Ou
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e6bMH-00066i-J7
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:57:30 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-12-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ffafe3a-ecd0-74b0-ac76-3a93dee3fb6a@redhat.com>
Date: Mon, 23 Oct 2017 06:57:21 -0500
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-12-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sAjbUGt1wVTAq3IBpxB3wJinrtRpsbWJR"
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, nbd list <nbd@other.debian.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sAjbUGt1wVTAq3IBpxB3wJinrtRpsbWJR
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, nbd list <nbd@other.debian.org>
Message-ID: <1ffafe3a-ecd0-74b0-ac76-3a93dee3fb6a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-12-eblake@redhat.com>
In-Reply-To: <20171019222637.17890-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 05:26 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Minimal implementation: for structured error only error_report error
> message.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

> +static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chun=
k,
> +                                         uint8_t *payload, QEMUIOVecto=
r *qiov,
> +                                         Error **errp)
> +{
> +    uint64_t offset;
> +    uint32_t hole_size;
> +
> +    if (chunk->length !=3D sizeof(offset) + sizeof(hole_size)) {
> +        error_setg(errp, "Protocol error: invalid payload for "
> +                         "NBD_REPLY_TYPE_OFFSET_HOLE");
> +        return -EINVAL;
> +    }
> +
> +    offset =3D payload_advance64(&payload);
> +    hole_size =3D payload_advance32(&payload);
> +
> +    if (offset > qiov->size - hole_size) {
> +        error_setg(errp, "Protocol error: server sent chunk exceeding =
requested"
> +                         " region");
> +        return -EINVAL;
> +    }
> +
> +    qemu_iovec_memset(qiov, offset, 0, hole_size);

Ouch. We have a discrepancy here, that needs clarification in the NBD
spec (cc'd).  In your server implementation, you are returning the
offset as sent by the client (that is, all offsets are absolute to the
size of the export).  But in this client implementation, you are
computing where to decode the zeroes by treating offset as though it
were relative to the request, rather than absolute to the export.

Or, in numbers, if I request a read of 2k starting at an offset of 4k,
the server implementation returns an offset of 4k, and the client
rejects the message because 4k is larger than the 2k request.

I think that absolute numbers are better to work with than
request-relative, but don't see anything in the proposed spec that
states one way or the other, so this is your chance to agree with my
preference or else argue why request-relative offsets are nicer, before
wordsmithing a change to the spec to make it obvious which semantics are
intended.  Then I can change either the server to match (if we want
request-relative) or the client to remember the original offset it sent
in order to turn absolute answers from the server back into
request-relative offsets for where to place the zeroes (if we go with
absolute offsets).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sAjbUGt1wVTAq3IBpxB3wJinrtRpsbWJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnt2SEACgkQp6FrSiUn
Q2ofoQf/dy4bG3qSeB6uP/R/pAM+DUwD0azY4s3VbyZ7ykQsM581upTwUXd/CBM1
tjDZX33R6AhKQtN2CFvwmYdlTqPr9QEBU3rmLdQcC8QeMvTYtt5KaRvWr5wLH265
RoMEkrhI5bp/ix38PrwmPmZK2HYae1N/tCYs7G6877PvV+Gr6m+eMwe39kH0uryj
IuCzDiYpWoLbnbYJlDTakcCXfnqLqTb6Yd4Gwn006ftbbUPjIvFItKRVu3/E63fw
UwIJk8CYb6Ee91K/Pdths5U1Rj/X1M57AUuYVnHCqPJqEwvyqotzGKvyHjr2Zl4o
m2OEONdAw6qShMDOH2trH7mVOBOhIg==
=Lido
-----END PGP SIGNATURE-----

--sAjbUGt1wVTAq3IBpxB3wJinrtRpsbWJR--
