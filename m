Received: from eggs.gnu.org ([2001:4830:134:3::10]:46369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCPSh-0001Fd-KB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCPSg-0006YZ-Gy
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:07 -0500
Date: Wed, 8 Nov 2017 09:24:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171108092447.GA2889@stefanha-x1.localdomain>
References: <20171108063447.2842-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20171108063447.2842-1-slp@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] util/async: use
 atomic_mb_set in qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 07:34:47AM +0100, Sergio Lopez wrote:
> Commit b7a745d added a qemu_bh_cancel call to the completion function
> as an optimization to prevent it from unnecessarily rescheduling itself.
>=20
> This completion function is scheduled from worker_thread, after setting
> the state of a ThreadPoolElement to THREAD_DONE.
>=20
> This was considered to be safe, as the completion function restarts the
> loop just after the call to qemu_bh_cancel. But, under certain access
> patterns and scheduling conditions, the loop may wrongly use a
> pre-fetched elem->state value, reading it as THREAD_QUEUED, and ending
> the completion function without having processed a pending TPE linked at
> pool->head:
>=20
>          worker thread             |            I/O thread
> ------------------------------------------------------------------------
>                                    | speculatively read req->state
> req->state =3D THREAD_DONE;          |
> qemu_bh_schedule(p->completion_bh) |
>   bh->scheduled =3D 1;               |
>                                    | qemu_bh_cancel(p->completion_bh)
>                                    |   bh->scheduled =3D 0;
>                                    | if (req->state =3D=3D THREAD_DONE)
>                                    |   // sees THREAD_QUEUED
>=20
> The source of the misunderstanding was that qemu_bh_cancel is now being
> used by the _consumer_ rather than the producer, and therefore now needs
> to have acquire semantics just like e.g. aio_bh_poll.
>=20
> In some situations, if there are no other independent requests in the
> same aio context that could eventually trigger the scheduling of the
> completion function, the omitted TPE and all operations pending on it
> will get stuck forever.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  util/async.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAs1fAAoJEJykq7OBq3PI6h8H/2kyiSyMLPb6Q/6rdBf0fOgl
6rYsIDumEQXz6MEymECFzBCRKCvOnmkL7NTWIJBvdJWdeNK7TIdLlN9HeK7PU2cA
qA3ok2IGK/BakR6OggvPZXWvs3psOleHWrEig2G4pWyhdgCfE7KCjVRPViP5Vbx3
ljLZqubFii6P6ECfApVnYOYOQyY4gRctav5eWVoV4baaJhJEaaTACFKuLv9CM5ls
PiMTOG6qFL+Ogyrl1R3AlFBBXjTiylfTwS86/6nejBxZzsxUEQ8MGPiAOdZSpXR9
sEfAJltmiZNnX5di5kHq8ysvGMXngSXARGEdKpjWJT0hJLYtHAORNpeYSGMC8wc=
=qasE
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
