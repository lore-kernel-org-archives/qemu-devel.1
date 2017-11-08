Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCUHA-00016V-J6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCUH9-0001L3-NB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:36:32 -0500
Date: Wed, 8 Nov 2017 17:36:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171108173621.GB8403@stefanha-x1.localdomain>
References: <20171107223708.17935-1-eblake@redhat.com>
	<20171108154226.GC6118@stefanha-x1.localdomain>
	<462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
	<061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 09:57:47AM -0600, Eric Blake wrote:
> On 11/08/2017 09:47 AM, Paolo Bonzini wrote:
> > On 08/11/2017 16:42, Stefan Hajnoczi wrote:
> >>> In any case, co_aio_sleep_ns()
> >>> + * does not affect the #AioContext where the current coroutine is ru=
nning,
> >>> + * as the coroutine will restart on the same #AioContext that it is
> >>> + * running on.
> >> I cannot parse the second sentence.  What does "affecting" an AioConte=
xt
> >> mean?  Does "where the current coroutine is running" simply mean "the
> >> caller"?
> >>
> >> What is it trying to say?  My guess is: the caller will be resumed in
> >> the current AioContext, not the timer's AioContext.
> >=20
> > Yes, that is the intended meaning.  Perhaps just s/current//.
>=20
> How about:
>=20
> This function uses timers and hence needs to know the event loop
> (#AioContext) to place the timer on.  After the time elapses, the
> current coroutine will restart with the same #AioContext it is currently
> running in, even if that is different than the timer context passed to
> co_aio_sleep_ns().

These complicated semantics are a clue that the API should be
simplified.  QEMU has changed since this function was first introduced.
Now we can do the following:

  void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
  {
      AioContext *ctx =3D qemu_get_current_aio_context();
      CoSleepCB sleep_cb =3D {
          .co =3D qemu_coroutine_self(),
      };
      sleep_cb.ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &slee=
p_cb);
      timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
      qemu_coroutine_yield();
      timer_del(sleep_cb.ts);
      timer_free(sleep_cb.ts);
  }

I don't see a reason for the caller to pass in an AioContext.

Any objections?  Will send a patch if this is okay.

Stefan

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaA0CVAAoJEJykq7OBq3PIi14H+gK3EFo9UR9K8fnE9xmRo94R
nkSd1xQMcyI497zNjIlALIbyKszPJLeBkwEf7q6KuZQG2KYB0FoS3hFBGTWNuBgc
RUDvfuwPnK3CbbYtZlboUa9S5e5WVXNBTKB+UDyVlBU0yFD32sLahrnJy5bUhzx4
AHQ/S09t7Kpoi+5MASepPeTkFt/z2DM/cxIcLNkak0jIn59vmzO0marHXecGOMHM
ojCq/nfXi3Z1RhER43kLWCHlwWXXSaJuEbnofyT1QYjswVfBcvvdTUaTKzVNv/jt
r/oDPIr3ZLRtGS8FBpgKp5s+4djR7RDfZs0/ZguHst6TdKj/UQhE19IF3CZmIGE=
=jJ6y
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
