Received: from eggs.gnu.org ([2001:4830:134:3::10]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5IXQ-0003kT-8e
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5IXP-0007rh-0a
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:39:36 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-6-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7b608d1-0c70-d21e-d191-fa2ecdbdb075@redhat.com>
Date: Thu, 19 Oct 2017 16:39:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JHoS7lQix6Fu1JJXfCXB4ueki0NjspDMw"
Subject: Re: [Qemu-devel] [PATCH v4 5/8] nbd/server: Include human-readable
 message in structured errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JHoS7lQix6Fu1JJXfCXB4ueki0NjspDMw
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <e7b608d1-0c70-d21e-d191-fa2ecdbdb075@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/8] nbd/server: Include human-readable
 message in structured errors
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-6-eblake@redhat.com>
In-Reply-To: <20171015010131.12172-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2017 08:01 PM, Eric Blake wrote:
> The NBD spec permits including a human-readable error string if
> structured replies are in force, so we might as well send the
> client the message that we logged on any error.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c     | 22 ++++++++++++++++------
>  nbd/trace-events |  2 +-
>  2 files changed, 17 insertions(+), 7 deletions(-)
>=20

>      assert(nbd_err);
> -    trace_nbd_co_send_structured_error(handle, nbd_err);
> +    trace_nbd_co_send_structured_error(handle, nbd_err,
> +                                       nbd_err_lookup(nbd_err), msg);
>      set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, =
handle,
>                   sizeof(chunk) - sizeof(chunk.h));

Bug - it's a bad idea to not include the message length in the overall
length, because the client then gets out of sync with the server (it
reads only 6 bytes instead of 6+strlen(msg) bytes, and expects the
message to start with the magic number for the next reply).

>      stl_be_p(&chunk.error, nbd_err);
> -    stw_be_p(&chunk.message_length, 0);
> +    stw_be_p(&chunk.message_length, iov[1].iov_len);

But this also highlights a bug in 9/8, where we have:

> +static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
> +                                   uint8_t *payload, int *request_ret,=

> +                                   Error **errp)
> +{
> +    uint32_t error;
> +    uint16_t message_size;
> +
> +    assert(chunk->type & (1 << 15));
> +
> +    if (chunk->length < sizeof(error) + sizeof(message_size)) {
> +        error_setg(errp,
> +                   "Protocol error: invalid payload for structured err=
or");
> +        return -EINVAL;
> +    }
> +
> +    error =3D nbd_errno_to_system_errno(payload_advance32(&payload));
> +    if (error =3D=3D 0) {
> +        error_setg(errp, "Protocol error: server sent structured error=
 chunk"
> +                         "with error =3D 0");
> +        return -EINVAL;
> +    }
> +
> +    *request_ret =3D error;
> +    message_size =3D payload_advance16(&payload);
> +    error_setg_errno(errp, error, "%.*s", message_size, payload);

Whoops - no sanity check that message_size fits within chunk->length.
So when we read message_length 33 (when the server sends a message 33
bytes long), we are then dereferencing up to 33 bytes of garbage beyond
the end of payload.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JHoS7lQix6Fu1JJXfCXB4ueki0NjspDMw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnpG44ACgkQp6FrSiUn
Q2qwYQf+N4Xh2fvBHYr2DF8KGBsYTXnrTCT69t7M424LHwAUcpXbnV//Q5IDgJb1
3ccGYgqWaSXvKw7rScwGB4DTCHOhq2KLtpNfHByaGAsEdelOqee9lFy6CCQFYq55
q9CzeZEuL7MhKHI8dXQyC5JC7AFEE02+964AOtdFT1HYa7K28mcnp/32LWUB1pe/
zg4LJT+9BaUKQS0Q2Z+4X7uLH1YeDSMgs3vuTg0o2N+Ts3ekeBvGZOV2tOXyCljU
WeOCUkXS0aVYVJdt+fysARSeiboQCOC1dx0tDjHx9uurChO9UEerQDi8hUJaW0AH
SoHHJCt4rSm9vFacSEsLqp9Ap/u0Bg==
=VsQI
-----END PGP SIGNATURE-----

--JHoS7lQix6Fu1JJXfCXB4ueki0NjspDMw--
