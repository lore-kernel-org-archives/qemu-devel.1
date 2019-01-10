Received: from eggs.gnu.org ([209.51.188.92]:40977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghYSq-0007Im-LD
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghYSo-0008Dl-3r
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghYSm-00087l-2j
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:25:29 -0500
Date: Thu, 10 Jan 2019 12:25:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190110112508.GA6361@linux.fritz.box>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 20:02 hat Eric Blake geschrieben:
> On 1/9/19 12:51 PM, Kevin Wolf wrote:
>=20
> >> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
> >> human-monitor-command, since there is no QMP counterpart for internal
> >> snapshot.  Even though lately we consistently tell people that internal
> >> snapshots are underdeveloped and you should use external snapshots, it
> >> does not get away from the fact that libvirt has been using 'savevm' to
> >> drive internal snapshots for years now, and that we MUST consider
> >> back-compat and/or add an introspectible QMP interface before making
> >> changes that would break libvirt.
> >=20
> > Okay, so what does libvirt do when you request a snapshot with a
> > numerical name? Without having looked at the code, the best case I would
> > expect that it forbids them, and more realistically I suspect that we
> > may actually fix a bug for libvirt by changing the semantics.
> >=20
> > Or does libvirt really use snapshot IDs rather than names?
>=20
> At the moment, libvirt does not place any restriction on internal
> snapshot names, but passes the user's name through without thought of
> whether it is an id or a name.
>=20
> So yes, arguably tightening the semantics fixes a libvirt bug for
> libvirt having allowed internal snapshots to get into an inconsistent
> state.

So there are two scenarios to consider with respect to breaking
backwards compatibility:

1. There may be code out there that relies on numeric arguments being
   interpreted as IDs. This code will break if we make this change and
   numeric snapshot names exist. That such code exists is speculation
   (even though plausible) and we don't know how widespread it is.

2. There may be code out there that blindly assumes that whatever it
   passes is interpreted as a name. Nobody considered that with a
   numeric snapshot name, it maybe misinterpreted as an ID. We know that
   this is true for libvirt, the single most used management tool for
   QEMU. More code like this may (and probably does) exist.

Essentially the same two categories exist for human users: those who
somehow found out that QEMU accepts IDs as monitor command arguments and
are using those (mitigated by not displaying IDs any more), and those
who are trapped because they wanted to access a numeric name, but
surprisingly got it interpreted as an ID. Both are speculation to some
degree, but my guess is that the latter group is larger.

Given all this, this is a no-brainer for me. We simplify the interface,
we simplify the code, we make things less confusing for manual users and
we fix the management tool that everybody uses. How could we not make
this change?

> But again, it falls in the category of "properly fixing this
> requires a lot of auditing, time, mental power, and unit tests", which
> makes it a rather daunting task to state for certain.

Fix the world before we can fix anything?

Kevin

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNyuUAAoJEH8JsnLIjy/WyVwQAMQUe848h4BfVamBFYMDsbig
FoyS/tFFUD9US3qLlvQeNu1PjBWmRZCbAo6FXFVktR9F99+/G2QRa2hy3rDfQzZ2
iNNlIrH7Go6EV6HTG+iFT55BjDrJLIHSVd1BLqQt0lhgKqg3GOJhMXu5ooExnaWr
NrliGcLw40bIgHf03aLBydZoAlQAr7de/XDTe4oZjku+IFPeBwGzx6W36QqaCqBJ
JQVR1DSIycNvkh5Fp2S0MCP5XyMCpVOhI1TCg78WMuX7H5IYM3UDc6oet3LDQxTU
xODAJO19RrAdvwFiA9zEqp2/Jo+DN5vpwFqO9VV9fs2HZD/VTJEKLoJrofZE6x67
VjUMajZz+gbvGv3kxOJ0gMnl7TZkZvaIoBDeLgBQQqgMvxKi9H6H/NC65kJ/06L3
WuA7NxDnp48F3XluR4eTWk0hrtAtLqPZ+9XGEIsZqystqtcHGUgIaHCdVAphhB1g
QyUr0uVRR2VHJKY1DaUIqnMGXDKBFcuN58AIcdcz4MhtPVctZof1xMDUMeEh0RVF
08bWch4RuHURTqGLn+rubZ6f4CwbRSiK+om7AnxWmnYjr9CucZ902yAw/zuBdayW
1uw08aTitXrrNQUHuIQyg5WhBgqdT7ekUon+l8cfq/xJTw77961WEMZ3hwh+N8HP
bVSCFkjMQc7dwcWNBtJC
=3UPy
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
