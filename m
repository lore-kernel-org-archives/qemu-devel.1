Received: from eggs.gnu.org ([2001:4830:134:3::10]:59023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGB2u-0007zE-F8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGB2t-0005nU-IH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:20:48 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-7-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efff984e-284e-4b42-09f9-f81f627133e2@redhat.com>
Date: Wed, 31 May 2017 16:20:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170531094330.1808-7-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Or5qE9OW8uIAKVXCisqJDAamF4GwRLSkS"
Subject: Re: [Qemu-devel] [PATCH 06/11] nbd: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Or5qE9OW8uIAKVXCisqJDAamF4GwRLSkS
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <efff984e-284e-4b42-09f9-f81f627133e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/11] nbd: make it thread-safe
References: <20170531094330.1808-1-pbonzini@redhat.com>
 <20170531094330.1808-7-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:43 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 1e2952fdae..43e0292ac1 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -114,6 +114,10 @@ static int nbd_co_send_request(BlockDriverState *b=
s,
>      int rc, ret, i;
> =20
>      qemu_co_mutex_lock(&s->send_mutex);
> +    while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
> +        qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
> +    }
> +    s->in_flight++;

Nice - if I'm not mistaken, this also solves
https://bugzilla.redhat.com/show_bug.cgi?id=3D1454582 - you have a while
loop here...

> -static void nbd_coroutine_start(NBDClientSession *s,
> -                                NBDRequest *request)
> -{
> -    /* Poor man semaphore.  The free_sema is locked when no other requ=
est
> -     * can be accepted, and unlocked after receiving one reply.  */
> -    if (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
> -        qemu_co_queue_wait(&s->free_sema, NULL);
> -        assert(s->in_flight < MAX_NBD_REQUESTS);
> -    }

=2E..compared to the old code that only tried once, and could therefore
hit the assertion failure depending on thread load.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Or5qE9OW8uIAKVXCisqJDAamF4GwRLSkS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJZLzOmAAoJEKeha0olJ0NqLMgH90wniJrbdA7Z9V5VJpPvLtCS
i84GCjJy6QUS182UE8hflQ9nsxEBNHtVTSjTea8j+6pmxdrOhHjCmjzkD6WcH1Bn
H4K1n6IKDCW/Q3OIO0LuF+VCSk8VCo+SfuJ8BTcrbHGbVrEHOU11IJMPr79iMlPx
FKDAfKOa00yOym0C3O/MQr2U9RZ+Qq/fwTRyzwejztmeDKJGU+FOt0RpKtNxk/wl
XUFejQRMBAlsDoyt62RUP6s3x0msyzahGOgQ3ksGUJA06tWj7g5e9lP6wRhNKR0y
vpOr1pPQ5aFHBO0rcqVJQeGXmNPTDlFCCHU3fHOg9SiZJcgfPeQneGgM8nV+kw==
=8g5B
-----END PGP SIGNATURE-----

--Or5qE9OW8uIAKVXCisqJDAamF4GwRLSkS--
