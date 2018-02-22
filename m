Received: from eggs.gnu.org ([2001:4830:134:3::10]:43180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoszv-0004MM-H0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoszn-0001IL-K5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:41:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoszn-0001Hf-DO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:41:19 -0500
Date: Thu, 22 Feb 2018 15:41:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180222154116.GB12629@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-10-peterx@redhat.com>
	<20180221160007.GA21436@stefanha-x1.localdomain>
	<20180222100119.GH18962@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20180222100119.GH18962@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 09/23] monitor: allow using IO thread
 for parsing
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


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 06:01:19PM +0800, Peter Xu wrote:
> On Wed, Feb 21, 2018 at 04:00:07PM +0000, Stefan Hajnoczi wrote:
> > On Wed, Jan 24, 2018 at 01:39:43PM +0800, Peter Xu wrote:
> > > @@ -4099,24 +4156,55 @@ void monitor_init(Chardev *chr, int flags)
> > >      }
> > > =20
> > >      if (monitor_is_qmp(mon)) {
> > > -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monito=
r_qmp_read,
> > > -                                 monitor_qmp_event, NULL, mon, NULL,=
 true);
> > >          qemu_chr_fe_set_echo(&mon->chr, true);
> > >          json_message_parser_init(&mon->qmp.parser, handle_qmp_comman=
d);
> > > +        if (mon->use_io_thr) {
> > > +            /*
> > > +             * It's possible that we already have an IOWatchPoll
> > > +             * registered for the Chardev during chardev_init_func().
> >=20
> > When does this happen?
> >=20
> > This seems like a hack that breaks when certain -chardev options are
> > used.  For example, what happens if the chardev is a TCP connection with
> > reconnect=3D5.  In that case the socket will be connecting asynchronous=
ly
> > and we cannot just remove the fd watch.
> >=20
> > How does this interact with TCP listen chardevs?  It looks like the
> > listener socket uses the main loop (see tcp_chr_disconnect()).
> >=20
> > I'm worried that the chardev layer isn't thread-safe and you haven't
> > added anything to protect it or at least refuse to run in unsafe
> > conditions.
>=20
> Indeed, I did some more reading and noticed that the TCP typed chardev
> is really special.
>=20
> Firstly there can be the QIO thread that handles sync connecting when
> "reconnect" is setup (I don't really understand why we only need the
> threads when reconnect !=3D 0, but anyway, I'll just assume we need the
> threads).  It's done in qmp_chardev_open_socket().
>=20
> Secondly, TCP can support TLS or TELNET (tcp_chr_new_client() handles
> the main logic of it), so there can be actually more than one GSource
> created for a single TCP chardev.  Meanwhile, the
> chr_update_read_handler() calls never handles the re-setup of those
> special GSources (TLS/TELNET), only the common GSource of TCP stream
> read/write.
>=20
> And the whole TCP channel is based on QIO stuff, which means I need to
> add non-default context support to QIO stuff too...  That's mostly
> about qio_channel_add_watch().  I may need to pass in context
> information, and switch to GSource for that function instead of the
> old tags, just like what I did to chardev in general.
>=20
> I'll think about these.  I may possibly need some pre-requisite and
> separated patches to fix existing problems before going on with OOB
> again.
>=20
> This is the worst thing I'd like to see - "surprises". :(

Yes, this feature is more involved than anyone thought at the beginning.

Stefan

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajuScAAoJEJykq7OBq3PIyKEH/0UocEe/37SgQ0Hs9pEd4+e+
YHNL4MhsjAi2PxNHlDUSobGG4IlgAobmkVuyXLoJGD3EWKtg6c/UH0cJep6FOoeP
hvMLvYD5tAXZX6tNwmiqYsJ8URp2j8VUqWZ/KhiWUSeDMU9+VWNICF5foSlLntuS
cmnj3fF6H00DGXK6KyqK92t6YQVpDWI3WPrlAKg7DMdvyC3rGK21gyBUVpcEB1X0
FVr6JxoCHMTIOC3rgnSgg6K1YRJmNC83nDreTz4xZoV3tYv7d5Mu4h4PZMVW93t1
mnU7in+/tK+VFcGG5Nc2e8qO+SNlFefk9id4DaCDVD69FScauQb72yFy6MBXGuo=
=lIsX
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
