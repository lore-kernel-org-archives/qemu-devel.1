Received: from eggs.gnu.org ([2001:4830:134:3::10]:41135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4s8-0005H7-1e
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4s7-0002AT-6l
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:42:28 -0500
References: <20171207201320.19284-1-stefanha@redhat.com>
	<20171207201320.19284-6-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54bf1d3e-4417-4f7e-74e6-ff8d69621643@redhat.com>
Date: Thu, 7 Dec 2017 16:42:16 -0600
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-6-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JF3XhXwq30T1AVCidKdX0aVBfKW2g8gGP"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] iothread: fix iothread_stop() race
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JF3XhXwq30T1AVCidKdX0aVBfKW2g8gGP
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54bf1d3e-4417-4f7e-74e6-ff8d69621643@redhat.com>
Subject: Re: [PATCH v2 5/6] iothread: fix iothread_stop() race condition
References: <20171207201320.19284-1-stefanha@redhat.com>
 <20171207201320.19284-6-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 02:13 PM, Stefan Hajnoczi wrote:
> There is a small chance that iothread_stop() hangs as follows:
>=20

>=20
> The bug is explained by the AioContext->notify_me doc comments:
>=20
>   "If this field is 0, everything (file descriptors, bottom halves,
>   timers) will be re-evaluated before the next blocking poll(), thus th=
e
>   event_notifier_set call can be skipped."
>=20
> The problem is that "everything" does not include checking
> iothread->stopping.  This means iothread_run() will block in aio_poll()=

> if aio_notify() was called just before aio_poll().
>=20
> This patch fixes the hang by replacing aio_notify() with
> aio_bh_schedule_oneshot().  This makes aio_poll() or g_main_loop_run()
> to return.

s/to //

>=20
> Implementing this properly required a new bool running flag.  The new
> flag prevents races that are tricky if we try to use iothread->stopping=
=2E
> Now iothread->stopping is purely for iothread_stop() and
> iothread->running is purely for the iothread_run() thread.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> I'm including this patch in this series because it is needed to make th=
e
> test case reliable.  It's unrelated to the main goal of the patch
> series.
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JF3XhXwq30T1AVCidKdX0aVBfKW2g8gGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopw8gACgkQp6FrSiUn
Q2oNIggApMp6P4jYdWwtqFiP+gZ6MU+rVr5POWCBW0g1bvVqxAYuI4egsNDLWcxC
3Qfc5bQ0lSKqAzY4hQGKH+Dt+hKdxeD+mufj7B9Zz+XSMpNzPu1ktoshj47BUNVM
H7FLnZEP7pbDvexhEuRf6gzWyO8f2iMregsuSapR9+yqMBkC31ZWGyhiYVM6Ufwu
mgAwr4oaguUvEWzKLSfvkgXtB7sV4V5mp+ILWxNe1rhGxTG+Px2GHMFEKbe0vcgu
szpPLelk5yHjM6/yLVN6TGW40moOqW0TPXJZl8lCClFwS5yHTwmH4idNb7TbmGcl
2Lwm+SqzUQGcGs0f6d8f6e2dWPZNdg==
=eTmU
-----END PGP SIGNATURE-----

--JF3XhXwq30T1AVCidKdX0aVBfKW2g8gGP--
