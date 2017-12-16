Received: from eggs.gnu.org ([2001:4830:134:3::10]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQ8m0-0001F5-7f
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQ8lx-00022L-3V
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQ8lw-00020t-Ph
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:28:45 -0500
Date: Sat, 16 Dec 2017 09:28:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171216092836.GD12533@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-19-peterx@redhat.com>
	<20171214114136.GG14433@stefanha-x1.localdomain>
	<20171216071706.GG22308@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20171216071706.GG22308@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 18/26] monitor: send event when request
 queue full
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


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2017 at 03:17:06PM +0800, Peter Xu wrote:
> On Thu, Dec 14, 2017 at 11:41:36AM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:52PM +0800, Peter Xu wrote:
> > > Set maximum QMP request queue length to 8.  If queue full, instead of
> > > queue the command, we directly return a "request-dropped" event, tell=
ing
> > > client that specific command is dropped.
> > >=20
> > > Note that this flow control mechanism is only valid if OOB is enabled.
> > > If it's not, the effective queue length will always be 1, which stric=
tly
> > > follows original behavior of QMP command handling (which never drop
> > > messages).
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  monitor.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/monitor.c b/monitor.c
> > > index c20e659740..f7923c4590 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -4029,6 +4029,8 @@ static void monitor_qmp_bh_dispatcher(void *dat=
a)
> > >      }
> > >  }
> > > =20
> > > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> > > +
> > >  static void handle_qmp_command(JSONMessageParser *parser, GQueue *to=
kens,
> > >                                 void *opaque)
> > >  {
> > > @@ -4061,6 +4063,19 @@ static void handle_qmp_command(JSONMessagePars=
er *parser, GQueue *tokens,
> > >      req_obj->id =3D id;
> > >      req_obj->req =3D req;
> > > =20
> > > +    if (qmp_oob_enabled(mon)) {
> > > +        /* Drop the request if queue is full. */
> > > +        if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX=
) {
> >=20
> > qmp_queue_lock must be held.  Perhaps it's simplest to move this check
> > into the qmp_queue_lock critical section below and unlock before calling
> > qapi_event_send_request_dropped()...
> >=20
> > > +            qapi_event_send_request_dropped(id,
> > > +                                            REQUEST_DROP_REASON_QUEU=
E_FULL,
> > > +                                            NULL);
> > > +            qobject_decref(id);
> > > +            qobject_decref(req);
> > > +            g_free(req_obj);
> > > +            return;
> > > +        }
> > > +    }
> > > +
> > >      /*
> > >       * Put the request to the end of queue so that requests will be
> > >       * handled in time order.  Ownership for req_obj, req, id,
> >=20
> > ... down here.
>=20
> Yeah can do.  I think it's not really a must (IMHO the worst case
> won't be that worse if current queue length is 8)? but it's obviously
> nicer.

That style of coding is risky.  People reading the code won't know if
the lack of the lock was a mistake or intentional.  If not taking the
lock is necessary for performance (it isn't in this case and we're going
to take the lock anyway), then it should have a comment or nop
function/macro that documents the intention.

Stefan

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaNOdEAAoJEJykq7OBq3PIJsQH/j4RiJnb45zFkAhnX6g15Ygz
XfKStJoC7RD+WhC1Oj+A+kxaM5kmoeeronZSJwcwQ7kjrI69iwr14XdxgrZcRTTB
BPQ2pEoj+IrmvhtLjxcqUYaH3QYpOiXEv42X6/iP0kY/W4FQrdS3Q/ZRmVluK2LP
mqCppnQuSMhSPK/fk9+RrHeoyTGwm/K02TLAmTdVylWD5gmuT1FUbPtvPBN8KoSw
ZYS5WgXKgpLCVytnZ0z17h3iz7p9AIQtlJpDAlQDmELZCk+IlTonbvUwZ0Rgh/tc
MjiTmts567FgwuAMVfTcOvkUtG2VLHJ60bcuAh68QvyS67LCskULuhlyLZCZ/AQ=
=BYRV
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
