Received: from eggs.gnu.org ([2001:4830:134:3::10]:37143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTuc-0003gU-TS
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTuc-0002bn-2E
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:26:50 -0400
Date: Fri, 7 Apr 2017 14:26:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407132642.GF16146@stefanha-x1.localdomain>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-6-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 02:54:13PM +0800, Fam Zheng wrote:
> Coroutine in block layer should always be waken up in bs->aio_context
> rather than the "current" context where it is entered. They differ when
> the main loop is doing QMP tasks.
>=20
> Race conditions happen without this patch, because the wrong context is
> acquired in co_schedule_bh_cb, while the entered coroutine works on a
> different one:
>=20
>   main loop                                iothread
> -----------------------------------------------------------------------
>   blockdev_snapshot
>     aio_context_acquire(bs->ctx)
>     bdrv_flush(bs)
>       bdrv_co_flush(bs)
>         ...
>         qemu_coroutine_yield(co)
>       BDRV_POLL_WHILE()
>         aio_context_release(bs->ctx)
>                                             aio_context_acquire(bs->ctx)
>                                               ...
>                                                 aio_co_wake(co)
>         aio_poll(qemu_aio_context)              ...
>           co_schedule_bh_cb()                   ...
>             qemu_coroutine_enter(co)            ...
>               /* (A) bdrv_co_flush(bs)              /* (B) I/O on bs */
>                       continues... */
>                                             aio_context_release(bs->ctx)
>=20
> Both (A) and (B) can access resources protected by bs->ctx, but (A) is
> not thread-safe.
>=20
> Make the block layer explicitly specify a desired context for the
> entered coroutine. For the rest callers, stick to the old behavior,
> qemu_get_aio_context() or qemu_get_current_aio_context().

I wasn't expecting the patch to touch so many places.  If a coroutine
can be permanently associated with an AioContext then there's no need to
keep assigning co->ctx on each qemu_coroutine_enter().

I don't know about this one.  Paolo is the best person to review it
since he's most familiar with the recent Coroutine/AioContext changes.

Stefan

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY55OSAAoJEJykq7OBq3PIpMUH/ialEDJE9lzp2g8+8FzMawmG
gfEFr8QgTnE9Tk7QqwqI8fNV1T6nZRknEUtLR6aIKIk47rwHiIHjS64VmLzFbgxM
mZKlfexFDVZqDMy/5TCtdafi8ETCH9ccrb16TtTLIEf1ird2tvzLSfa/n5U/Ue6l
1/CRNRER1FWJy7Pu7/MEu9Zm5peM7Dh2GKm5sLGxU+MHRKgj2BXvtr9r/Rn7IKff
C4poyzySXTpS2Rvt5VKS9aarRGFt0EMElw7QI9PGKWm6llLEt1XD/U41sJ+P3lPN
UwhOGGrn9dkhk99pRqFA9VNGvIbW5vOJzYzSQC9f8KDmjhmvd78Gvd2/AX9MpXg=
=noBj
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
