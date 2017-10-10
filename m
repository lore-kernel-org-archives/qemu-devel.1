Received: from eggs.gnu.org ([2001:4830:134:3::10]:47232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yAn-0004tf-KJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yAm-0001Tq-NT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1yAm-0001Te-Dm
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85657C04B317
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:18:27 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44b7c0ce-b6a7-87e0-0317-059cb84d57b1@redhat.com>
Date: Tue, 10 Oct 2017 12:18:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SXGD0pa600nJRKNH4gAINQB6ewxhKJchK"
Subject: Re: [Qemu-devel] [PATCH v1 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SXGD0pa600nJRKNH4gAINQB6ewxhKJchK
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <44b7c0ce-b6a7-87e0-0317-059cb84d57b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-5-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> Instead of requiring use of another Buffer, pass a struct iovec
> into qio_channel_websock_encode, which gives callers more
> flexibility in how they process data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 69 ++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 42 insertions(+), 27 deletions(-)
>=20

> +static void qio_channel_websock_encode(QIOChannelWebsock *ioc,
> +                                       uint8_t opcode,
> +                                       const struct iovec *iov,
> +                                       size_t niov,
> +                                       size_t size)
>  {

Is size redundant with iov_size(iov, niov)?  Or is a caller allowed to
pass a smaller size (tail end of iov is not encoded) or larger size
(encoding stops at end of iov, even if size is not exhausted)?  I'd lean
towards the former (one less parameter), especially since all callers in
this patch could have passed iov_size(&iov, 1) for the same effect.

> -    trace_qio_channel_websock_encode(ioc, opcode, header_size, buffer-=
>offset);
> -    buffer_reserve(output, header_size + buffer->offset);
> -    buffer_append(output, header.buf, header_size);
> -    buffer_append(output, buffer->buffer, buffer->offset);
> +    trace_qio_channel_websock_encode(ioc, opcode, header_size, size);
> +    buffer_reserve(&ioc->encoutput, header_size + size);
> +    buffer_append(&ioc->encoutput, header.buf, header_size);
> +    for (i =3D 0; i < niov && size !=3D 0; i++) {
> +        size_t want =3D iov->iov_len;
> +        if (want > size) {
> +            want =3D size;
> +        }
> +        buffer_append(&ioc->encoutput, iov->iov_base, want);
> +        size -=3D want;
> +    }

Umm, where are you incrementing iov? It appears you only tested with
niov =3D=3D 1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SXGD0pa600nJRKNH4gAINQB6ewxhKJchK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndAOIACgkQp6FrSiUn
Q2oG4Qf9GVu+rwSh33ie9dwycyFfCXZ2hJ9t2tvCqAoE2t09H7nAuUaABKCzZ4hh
3hGGScn3dRCQqOEpG1aMiD/J4+8r8e1h3ihgJiejMgbZW6ciKDmr6kD+144H5r9t
lWrkwwK1aM3do3C6H6wDQjOsNQrvXNfgo5ntdH32yc89hErhrT5YCLFf1KG5c0Ka
oevc4SxI81gY6uXWk49c88YhhHlq3wL0w+MnwGYdhBkE/A2oUQuIAm/oAZFaGhdt
N13DGv7wTqYiSl5L8ejMq2Ik4J6eR+1JcqrP+qoB4We2UsquFguKZpxbyFde3ip0
NRNsHun1joEYTzu/rALsC3VPzBoJSw==
=WriT
-----END PGP SIGNATURE-----

--SXGD0pa600nJRKNH4gAINQB6ewxhKJchK--
