Received: from eggs.gnu.org ([2001:4830:134:3::10]:38019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYYpK-0002Yi-0w
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYYpF-0000SJ-4k
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:50:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYYpE-0000Ru-SA
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:50:25 -0500
Date: Tue, 31 Jan 2017 13:50:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131135021.GI18804@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-8-pbonzini@redhat.com>
	<20170130155044.GP2118@stefanha-x1.localdomain>
	<70a0127e-b698-9530-ddec-466c4a635f0c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
In-Reply-To: <70a0127e-b698-9530-ddec-466c4a635f0c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/17] nbd: convert to use qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, famz@redhat.com


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 04:18:10PM -0500, Paolo Bonzini wrote:
> On 30/01/2017 10:50, Stefan Hajnoczi wrote:
> > On Fri, Jan 20, 2017 at 05:43:12PM +0100, Paolo Bonzini wrote:
> >> +        aio_co_wake(s->recv_coroutine[i]);
> >> =20
> >> -    qemu_coroutine_enter(nbd_get_client_session(bs)->send_coroutine);
> >> +        /* We're woken up by the recv_coroutine itself.  */
> >> +        qemu_coroutine_yield();
> >=20
> > This relies on recv_coroutine() entering us only after we've yielded -
> > otherwise QEMU will crash.  The code and comments don't make it obvious
> > why this is guaranteed to be safe.
>=20
> It doesn't rely on that (that's the magic hidden behind aio_co_wake),
> but you're right there is a documentation problem because I needed 10
> minutes to remind myself why it's correct.
>
> It works because neither coroutine is moving context:
>=20
> - if the two coroutines are in the same context, aio_co_wake queues the
> coroutine for execution after the yield, which is obviously okay;
>=20
> - if they are in different context, the recv_coroutine's aio_co_wake
> queues the read_reply_co with aio_co_schedule.  It is then woken up
> through a bottom half, which executes only after read_reply has yielded.
>=20
> It is implied by the aio_co_wake and aio_co_schedule documentation; all
> requirements are satisfied:
>=20
> 1) aio_co_wake's comment says:
>=20
>    * aio_co_wake may be executed either in coroutine or non-coroutine
>    * context.  The coroutine must not be entered by anyone else while
>    * aio_co_wake() is active.
>=20
>    read_reply_co is only woken by one recv_coroutine at a time
>=20
> 2) And for the case where read_reply_co and recv_coroutine are in
>    different contexts, aio_co_schedule's comment says:
>=20
>    * In addition the coroutine must have yielded unless ctx
>    * is the context in which the coroutine is running (i.e. the value of
>    * qemu_get_current_aio_context() from the coroutine itself).
>=20
>    which is okay because aio_co_wake always uses "the context in
>    which the coroutine is running" as the argument to aio_co_schedule.
>=20
> Any suggestions on how to document this properly?  I'm not sure a
> comment in the NBD driver is the best place, because similar logic will
> appear soon in other networked block drivers.

Maybe add a new function that just does these two calls.  I don't have a
good name for it.

Stefan

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkJYdAAoJEJykq7OBq3PIK1kIAJ3mYmqXjnuvSewUOF/zW96e
JtLYgvnFbnZ1iyrYIPXxlhQ71VPgjM3awxDBcDnjCp6t9BNnAdUZ9aoibWLh68Un
eH7CudG3dJasaYTKPKELKU1e+qeINakN+QHKnTQJ6lXyi4hISCIdLh0ggpFeTUoc
p0Ad+LhFfxDTEKLA+kcvvo515Fss7BW+29xzf/nVpZ2+KiBYOWhjQEYtzXoZwl+f
Fu8ow43O9u6tC1JhtMpcBUj7zStyMmawbyhZeuVA7lyB5Wjk5ahb3hRv/anziFPR
C5/IorvggIAIAdj8lMlkrh8KMMiPTScSC6k9U8YxC2z8n9EqFNTX6EszMMtAtf0=
=qFfr
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
