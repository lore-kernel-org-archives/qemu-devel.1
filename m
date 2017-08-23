Received: from eggs.gnu.org ([2001:4830:134:3::10]:42390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkYLc-0003r8-3a
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkYLb-0005mR-7X
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:17:40 -0400
References: <20170822125113.5025-1-stefanha@redhat.com>
	<1e88bead-a955-7db1-0c6e-7436151e46b0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a47967a-43e7-a714-4dc2-0e8c73fd3c61@redhat.com>
Date: Wed, 23 Aug 2017 18:17:19 +0200
MIME-Version: 1.0
In-Reply-To: <1e88bead-a955-7db1-0c6e-7436151e46b0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hvF8OVr10tEEpKmiJGhTkAO5QBdE9Q8CO"
Subject: Re: [Qemu-devel] [PATCH] nbd-client: avoid spurious
 qio_channel_yield() re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hvF8OVr10tEEpKmiJGhTkAO5QBdE9Q8CO
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a47967a-43e7-a714-4dc2-0e8c73fd3c61@redhat.com>
Subject: Re: [PATCH] nbd-client: avoid spurious qio_channel_yield() re-entry
References: <20170822125113.5025-1-stefanha@redhat.com>
 <1e88bead-a955-7db1-0c6e-7436151e46b0@redhat.com>
In-Reply-To: <1e88bead-a955-7db1-0c6e-7436151e46b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/08/2017 16:51, Eric Blake wrote:
> On 08/22/2017 07:51 AM, Stefan Hajnoczi wrote:
>> The following scenario leads to an assertion failure in
>> qio_channel_yield():
>>
>> 1. Request coroutine calls qio_channel_yield() successfully when sendi=
ng
>>    would block on the socket.  It is now yielded.
>> 2. nbd_read_reply_entry() calls nbd_recv_coroutines_enter_all() becaus=
e
>>    nbd_receive_reply() failed.
>> 3. Request coroutine is entered and returns from qio_channel_yield().
>>    Note that the socket fd handler has not fired yet so
>>    ioc->write_coroutine is still set.
>> 4. Request coroutine attempts to send the request body with nbd_rwv()
>>    but the socket would still block.  qio_channel_yield() is called
>>    again and assert(!ioc->write_coroutine) is hit.
>>
>> The problem is that nbd_read_reply_entry() does not distinguish betwee=
n
>> request coroutines that are waiting to receive a reply and those that
>> are not.
>>
>> This patch adds a per-request bool receiving flag so
>> nbd_read_reply_entry() can avoid spurious aio_wake() calls.
>>
>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> This should fix the issue that Dave is seeing but I'm concerned that
>> there are more problems in nbd-client.c.  We don't have good
>> abstractions for writing coroutine socket I/O code.  Something like Go=
's
>> channels would avoid manual low-level coroutine calls.  There is
>> currently no way to cancel qio_channel_yield() so requests doing I/O m=
ay
>> remain in-flight indefinitely and nbd-client.c doesn't join them...
>=20
> Vladimir has some cleanups that rewrite the NBD coroutines to be more
> legible, but it is invasive enough to be 2.11 material.  I think that
> for a stop-gap of getting 2.10 out the door, we may be better off
> including this patch - but I would still like some positive review from=

> more than just me.  There's not much time left before I need to send th=
e
> -rc4 NBD pull request, though.
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


--hvF8OVr10tEEpKmiJGhTkAO5QBdE9Q8CO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmdqpMACgkQv/vSX3jH
roMn8gf/dcxmGLmQIpleEZS1KX16+FrWuXcKC0uUGZs7ZVJvgtAcDEX4TM5I5+7W
g6BCxzinzRwJjXFtBuYg9ooyBgBgPI5Xn2HTX0znMC7y4qmK1aFodO0uXpjv1l35
EW+ar78Ab4KRUIG29fi1XB8hxY9Hetj1d/9bqWJ0zXZvTkQ+ulNclCfpGKDGHX76
2+MMb/AHzBKX1/FkiuhPgiLjk0WZPFBBZIy5SKDYTgBD/2YUmlE4tQtqViC03bP6
lC4RUWr+8tUSlQ4v2WC9EgRhKDeTHwynrg4T5jCVqy1G8QUbUvBIlUDc4uqqFJZj
8FCzwdQvC5wGzzTt1z4s0tWlYE+pOQ==
=ONhX
-----END PGP SIGNATURE-----

--hvF8OVr10tEEpKmiJGhTkAO5QBdE9Q8CO--
