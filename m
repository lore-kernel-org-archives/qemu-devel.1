Received: from eggs.gnu.org ([2001:4830:134:3::10]:58443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQ8gx-0008Na-T7
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQ8gu-0001yW-Oc
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:23:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQ8gu-0001xO-Ei
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:23:32 -0500
Date: Sat, 16 Dec 2017 09:23:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171216092322.GC12533@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-17-peterx@redhat.com>
	<20171213200938.GG8317@stefanha-x1.localdomain>
	<20171216063703.GD22308@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20171216063703.GD22308@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 16/26] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2017 at 02:37:03PM +0800, Peter Xu wrote:
> On Wed, Dec 13, 2017 at 08:09:38PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:50PM +0800, Peter Xu wrote:
> > > @@ -3956,12 +3968,122 @@ static void handle_qmp_command(JSONMessagePa=
rser *parser, GQueue *tokens,
> > >          }
> > >      }
> > > =20
> > > -err_out:
> > > -    monitor_qmp_respond(mon, rsp, err, id);
> > > +    /* Respond if necessary */
> > > +    monitor_qmp_respond(mon, rsp, NULL, id);
> > > +
> > > +    /* This pairs with the monitor_suspend() in handle_qmp_command()=
=2E */
> > > +    if (!qmp_oob_enabled(mon)) {
> > > +        monitor_resume(mon);
> >=20
> > monitor_resume() does not work between threads: if the event loop is
> > currently blocked in poll() it won't notice that the monitor fd should
> > be watched again.
> >=20
> > Please add aio_notify() to monitor_resume() and monitor_suspend().  That
> > way the event loop is forced to check can_read() again.
>=20
> Ah, yes.  I think monitor_suspend() does not need the notify?  Since
> if it's sleeping it won't miss the next check in can_read() after all?

No, that would be a bug.  Imagine the IOThread is blocked in poll
monitoring the chardev file descriptor when the main loop calls
monitor_suspend().  If the file descriptors becomes readable then the
handler function executes even though the monitor is supposed to be
suspended!

> Regarding to monitor_resume(), I noticed that I missed the fact that
> it's only tailored for HMP before, which seems to be a bigger problem.
> Do you agree with a change like this?
>=20
> diff --git a/monitor.c b/monitor.c
> index 9970418d6f..8f96880ad7 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4244,10 +4244,12 @@ int monitor_suspend(Monitor *mon)
> =20
>  void monitor_resume(Monitor *mon)
>  {
> -    if (!mon->rs)
> -        return;
>      if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
> -        readline_show_prompt(mon->rs);
> +        if (monitor_is_qmp(mon)) {
> +            aio_notify(mon_global.mon_iothread->ctx);

Please use iothread_get_aio_context() instead of accessing struct
members.

> +        } else {
> +            assert(mon->rs);
> +            readline_show_prompt(mon->rs);

I haven't studied the HMP and ->rs code.  I'll do that when reviewing
the next revision of this series.

> +        }
>      }
>  }
>=20
> Even, I'm thinking about whether I should start to introduce
> iothread_notify() now to mask out the IOThread.ctx details.

aio_notify() is a low-level AioContext operation that is somewhat
bug-prone.  I think it's better to leave it directly exposed so callers
have to think about what they are doing.

Stefan

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaNOYKAAoJEJykq7OBq3PIy9gH/R/xirtN8Y9RwqxIXqKlniIm
+Kd7ZB92Zka+m24U3i6rZd/zuOBDyHObUGOu80NbCE7G16QIV6A9qJHEIrrGVXSf
03nKAQSfMtqc5JuFzelLDzB2W4MCFzaiSOhj97NsPEYDz/9BxeIDq66LRjYnrYwK
6osh8JWTjKQxQY6Jsjp6t9N4tGCEYralbZ7skqt70lSjNxVjo5UvxRHdIn6Wd4Ww
lV+D1/M3znzjvbuovKA/dPAgfqN2FQrbcfSKA6WqOn3JRKo901tvSvuqf+rmpc6D
vzxMCXUjxkIyDhjoZSr3ml5gr62mfEnxQXsziH/St++v2Ns+9LQyVMMAevuEvi0=
=Z1j1
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
