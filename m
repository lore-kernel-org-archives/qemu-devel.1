Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQrS4-0004DQ-1n
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQrS0-0000vW-RC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:11:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQrS0-0000un-I2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:11:08 -0500
Date: Mon, 18 Dec 2017 09:10:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218091053.GD18648@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-17-peterx@redhat.com>
	<20171213200938.GG8317@stefanha-x1.localdomain>
	<20171216063703.GD22308@xz-mi>
	<20171216092322.GC12533@stefanha-x1.localdomain>
	<20171218052649.GK22308@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <20171218052649.GK22308@xz-mi>
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


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 01:26:49PM +0800, Peter Xu wrote:
> On Sat, Dec 16, 2017 at 09:23:22AM +0000, Stefan Hajnoczi wrote:
> > On Sat, Dec 16, 2017 at 02:37:03PM +0800, Peter Xu wrote:
> > > On Wed, Dec 13, 2017 at 08:09:38PM +0000, Stefan Hajnoczi wrote:
> > > > On Tue, Dec 05, 2017 at 01:51:50PM +0800, Peter Xu wrote:
> > > > > @@ -3956,12 +3968,122 @@ static void handle_qmp_command(JSONMessa=
geParser *parser, GQueue *tokens,
> > > > >          }
> > > > >      }
> > > > > =20
> > > > > -err_out:
> > > > > -    monitor_qmp_respond(mon, rsp, err, id);
> > > > > +    /* Respond if necessary */
> > > > > +    monitor_qmp_respond(mon, rsp, NULL, id);
> > > > > +
> > > > > +    /* This pairs with the monitor_suspend() in handle_qmp_comma=
nd(). */
> > > > > +    if (!qmp_oob_enabled(mon)) {
> > > > > +        monitor_resume(mon);
> > > >=20
> > > > monitor_resume() does not work between threads: if the event loop is
> > > > currently blocked in poll() it won't notice that the monitor fd sho=
uld
> > > > be watched again.
> > > >=20
> > > > Please add aio_notify() to monitor_resume() and monitor_suspend(). =
 That
> > > > way the event loop is forced to check can_read() again.
> > >=20
> > > Ah, yes.  I think monitor_suspend() does not need the notify?  Since
> > > if it's sleeping it won't miss the next check in can_read() after all?
> >=20
> > No, that would be a bug.  Imagine the IOThread is blocked in poll
> > monitoring the chardev file descriptor when the main loop calls
> > monitor_suspend().  If the file descriptors becomes readable then the
> > handler function executes even though the monitor is supposed to be
> > suspended!
>=20
> When you say "the handler function executes", do you mean the handler
> that has already added to the qmp request queue, or the one that
> hasn't yet parsed by the parser?

The chardev file descriptor handler function (the QMP parser).

> For the previous case (the handler that has queued already): IMHO
> that's what we expect it to behave, say, when we call
> monitor_suspend(), we only stop accepting and parsing new inputs from
> the user, but the requests on the queue should still be processed.
>=20
> For the latter (the handler of a newly typed command):
> monitor_suspend() should suspend the parser already, so
> monitor_can_read() check should fail, then that command should never
> be queued until we call another monitor_resume().

You are assuming that monitor_can_read() is called *after* poll()
returns.  This is what I tried to explain in the previous reply.

The the monitor_can_read() function is called *before* the blocking
poll() syscall.  If something changes the monitor_can_read() return
value, you must* kick the event loop to ensure that the event loop
reflects this change.

If you want to check how this works, see chardev/char-io.c for how
fd_can_read() is used.

* Currently monitor.c doesn't need to kick the event loop explicitly
because it runs within the main loop thread.  Therefore the event loop
always calls monitor_can_read() again before entering poll().

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN4YdAAoJEJykq7OBq3PIirgH/3ve9DbIZLEVVOWnYOnB5FJ1
gK1TJyrMlMsXGuFLVhnzck9ACN6+VmpA25Ohbvq6vSMfMtu46KfxDoF+mTHf4XxF
kyw0NKSuoVEL71NPFsgswu3O1CT5PJocgYWvrRDwOfkCaaJyq8U/Ww33f3NXOWkl
dzSnLqDak8kgP8XRu9DkvtJufJkD8hV3j0hTSkryV/ac8JMjd7L6mUnlttb+3W3i
3egm9UFgZDaAy8yCsq8q/VIDmdLyGEOm8Rbtl2kG6RmowVqHkfCyepy4x2DixQP6
3cNJLTN64w1zZF7PBInRWjUoq0g8Hq5J6WTNiSbSU1qyBKLMyXKG/yLXbjJLV2c=
=Y2OJ
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
