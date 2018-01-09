Received: from eggs.gnu.org ([2001:4830:134:3::10]:50536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYtzm-0007XA-5q
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYtzh-0006h1-8C
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:31:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYtzg-0006eQ-Vt
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:31:09 -0500
Date: Tue, 9 Jan 2018 13:30:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109133059.GC31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-19-peterx@redhat.com>
	<20171221114246.GO10812@lemon> <20171225051856.GF2443@xz-mi>
	<20171225055556.GC9418@lemon> <20171225061825.GJ2443@xz-mi>
	<20171225071349.GD9418@lemon> <20171225072224.GM2443@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20171225072224.GM2443@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 18/27] monitor: send event when command
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
Cc: Fam Zheng <famz@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2017 at 03:22:24PM +0800, Peter Xu wrote:
> On Mon, Dec 25, 2017 at 03:13:49PM +0800, Fam Zheng wrote:
> > On Mon, 12/25 14:18, Peter Xu wrote:
> > > On Mon, Dec 25, 2017 at 01:55:56PM +0800, Fam Zheng wrote:
> > > > On Mon, 12/25 13:18, Peter Xu wrote:
> > > > > On Thu, Dec 21, 2017 at 07:42:46PM +0800, Fam Zheng wrote:
> > > > > > On Tue, 12/19 16:45, Peter Xu wrote:
> > > > > > > Set maximum QMP command queue length to 8.  If queue full, in=
stead of
> > > > > > > queue the command, we directly return a "command-dropped" eve=
nt, telling
> > > > > > > client that specific command is dropped.
> > > > > > >=20
> > > > > > > Note that this flow control mechanism is only valid if OOB is=
 enabled.
> > > > > > > If it's not, the effective queue length will always be 1, whi=
ch strictly
> > > > > > > follows original behavior of QMP command handling (which neve=
r drop
> > > > > > > messages).
> > > > > > >=20
> > > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > > ---
> > > > > > >  monitor.c | 17 ++++++++++++++++-
> > > > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/monitor.c b/monitor.c
> > > > > > > index ed9a741d06..b571866659 100644
> > > > > > > --- a/monitor.c
> > > > > > > +++ b/monitor.c
> > > > > > > @@ -4038,6 +4038,8 @@ static void monitor_qmp_bh_dispatcher(v=
oid *data)
> > > > > > >      }
> > > > > > >  }
> > > > > > > =20
> > > > > > > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> > > > > >=20
> > > > > > Is this limit introspectable on QMP?
> > > > >=20
> > > > > Not yet.  IMHO it's really QMP internal stuff, and I see no benef=
it so
> > > > > far for a client to know about this...
> > > >=20
> > > > A client may need this number to batch (non-oob) commands without w=
orrying about
> > > > getting command-dropped event.
> > >=20
> > > IMHO QMP batching will only be useful when performance matters, but
> > > for now IMHO we don't need to worry much about QMP performance?  When
> > > we do, I suspect we need to do more things to make sure of it, and
> > > exposing this single parameter may not really help much, say, for now
> > > even the client batches the stuff, they still need to wait for the
> > > completion of commands.
> >=20
> > I think when we declare that commands can be dropped when the queue is =
full, we
> > should be clear about in what condition a queue is full, and don't make=
 users
> > guess. If we want is this incompleteness, and I'm the only one who does=
n't like
> > it, that may be fine. It's just that, like you said, this seems a bit u=
seless.
>=20
> Just to clarify that this maximum queue length is still useful to us
> (not the clients) in the sense that we'll have limited memory usage
> for QMP command queues.  Otherwise we have risk on using up all the
> memory of the host or reach the limitation of existing QEMU process,
> either of which is bad.

I think batching doesn't make much sense when "oob" is enabled.  There
are only very narrow use cases where it's reasonable to batch:

Batched commands must be independent of each other because any batched
command can be dropped:

  A B C

A can be dropped if there are already one or more commands pending.  If
this happens then B or C might run or be dropped too, depending on
timing.

Possible combinations are:

  <none>
  A
  A B
  A C
  A B C
  B
  B C
  C

The client has very little control and needs to implement retry logic if
commands are dropped.  I bet this is going to be very error prone for
client developers...

One reasonable use case is batching query-* commands.  I can't think of
many other use cases where it makes sense.

I'd be perfectly happy if QEMU did no batching at all when "oob" is
enabled (i.e. hardcoded 1 command lookahead).

Stefan

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVMQTAAoJEJykq7OBq3PIZtsH/RD7La4uvxM79hCvoi7pHCYM
MsmMZuRgaeUFzmalzzvMWuOjiOZhJSFLXZ1jNwD41uWxnrsROMd0AIjdSCyvdXl3
A6a8sxfSsHtFulv8I4mbCy2FG5qvCbfqlScy/bx8EH5a4JnsMtTL8FjdalHXnjf5
Bps8DWN5gdla4xBnO1x0A1W7V1HCr8KCxsGTbZ5ww4V6d2/wT8E5cbideycQ7efb
wfUQAZhe2P79H8s+TKihnKugEowdljPY5T3hrzYZ3gIGsvLbNilG4hTyyjhwVHf8
W5DVK1PlgdhU5uCkdAMBoJ0la1wtt6QMCtw5653LXqJQ8FXp3nvpzrOv5a+EbXw=
=naoG
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
