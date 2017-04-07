Received: from eggs.gnu.org ([2001:4830:134:3::10]:53110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUYR-0005fz-VC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUYQ-0001ZN-VD
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:07:59 -0400
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-6-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1e4fe68-fce7-3d90-d413-f9aa4344cbde@redhat.com>
Date: Fri, 7 Apr 2017 09:07:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170407065414.9143-6-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qJxAQltkcvQex3nIrf02gUOU06HqUKSdV"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] coroutine: Explicitly specify
 AioContext when entering coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qJxAQltkcvQex3nIrf02gUOU06HqUKSdV
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b1e4fe68-fce7-3d90-d413-f9aa4344cbde@redhat.com>
Subject: Re: [PATCH v2 5/6] coroutine: Explicitly specify AioContext when
 entering coroutine
References: <20170407065414.9143-1-famz@redhat.com>
 <20170407065414.9143-6-famz@redhat.com>
In-Reply-To: <20170407065414.9143-6-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 01:54 AM, Fam Zheng wrote:
> Coroutine in block layer should always be waken up in bs->aio_context

s/waken up/awakened/

> rather than the "current" context where it is entered. They differ when=

> the main loop is doing QMP tasks.
>=20
> Race conditions happen without this patch, because the wrong context is=

> acquired in co_schedule_bh_cb, while the entered coroutine works on a
> different one:
>=20
>   main loop                                iothread
> -----------------------------------------------------------------------=

>   blockdev_snapshot
>     aio_context_acquire(bs->ctx)
>     bdrv_flush(bs)
>       bdrv_co_flush(bs)
>         ...
>         qemu_coroutine_yield(co)
>       BDRV_POLL_WHILE()
>         aio_context_release(bs->ctx)
>                                             aio_context_acquire(bs->ctx=
)
>                                               ...
>                                                 aio_co_wake(co)
>         aio_poll(qemu_aio_context)              ...
>           co_schedule_bh_cb()                   ...
>             qemu_coroutine_enter(co)            ...
>               /* (A) bdrv_co_flush(bs)              /* (B) I/O on bs */=

>                       continues... */
>                                             aio_context_release(bs->ctx=
)
>=20
> Both (A) and (B) can access resources protected by bs->ctx, but (A) is
> not thread-safe.
>=20
> Make the block layer explicitly specify a desired context for the
> entered coroutine. For the rest callers, stick to the old behavior,

s/rest/remaining/

> qemu_get_aio_context() or qemu_get_current_aio_context().
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---

At this point, I'm still more comfortable waiting for Paolo's review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qJxAQltkcvQex3nIrf02gUOU06HqUKSdV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY550yAAoJEKeha0olJ0Nq5UwIAIOs3t7qQtt3QIKmszYmYMW5
x9BA48gfxsKpH99mD4Czh/C7crxzcDHNdiVVDwQhVZIjkOSs/HzU/sHTH12Homvl
S61ZUkVXkZHuy2hgwIad1DQHYKs8ttaK4+VoVnMvoSp4pvCcuYlHZJv8Aigf8jWb
g6QwvrKnB4HT8WDhjU8NG0omEVAuUVI1vN8SOBrHP7q4FF9NGgzlEYUR7w5Oyu55
PcIMKTvMmPYHOxoCQ08UGh34acxOGJRve8K/eLufKUXW9pG6ntWkPVRTpF1T/cFX
10Sv4FNDKmma+xlWFWd47FGjqZEZ9FXhmIZz8819GDYxPiLGMZEeQte+DpZpCw8=
=vpd7
-----END PGP SIGNATURE-----

--qJxAQltkcvQex3nIrf02gUOU06HqUKSdV--
