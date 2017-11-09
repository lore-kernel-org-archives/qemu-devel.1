Received: from eggs.gnu.org ([2001:4830:134:3::10]:48600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCqe7-0004EJ-J9
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCqe6-00071U-Jf
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:29:43 -0500
Date: Thu, 9 Nov 2017 18:29:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171109172933.GC5260@localhost.localdomain>
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<9efcfcce-5c7c-c5a0-5985-3b0e7598cadd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <9efcfcce-5c7c-c5a0-5985-3b0e7598cadd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockdev-backup: enable non-root nodes for
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, den@openvz.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.11.2017 um 17:33 hat Eric Blake geschrieben:
> On 11/09/2017 08:16 AM, Vladimir Sementsov-Ogievskiy wrote:
> > This is needed to implement image-fleecing scheme, when we create
> > a temporary node, mark our active node to be backing for the temp,
> > and start backup(sync=3Dnone) from active node to the temp node.
> > Temp node then represents a kind of snapshot and may be used
> > for external backup through NBD.
> >=20
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >=20
> > What was the reason to abandon non-root nodes?
>=20
> I think the original restriction was that we didn't know all the
> implications to having multiple readers to an intermediate node, so it
> was easier to prevent it with plans to add it later than to add it up
> front and deal with the fallout.  But I think that now we are
> sufficiently versed in handling BDS trees with multiple readers, with
> proper op-blocking in place; so you are right that we can probably
> support it now.

Op blockers are actually the reason why I'm not so sure. The old
blockers often still only work on the top level, and we haven't fully
replaced them yet. In particular, graph modifications might not be
protected well enough by the new system yet.

But then, backup works only on a single node in the source tree, not on
a whole subchain, so I don't see what other operation could conflict
with a backup job. The only thing is resizes, but that is covered by the
new system.

So in the end, I think this specific change should be okay.

> However, I'm a bit worried that there is no documentation change about
> this in a .json QAPI file, nor any easy way to introspect via QMP
> whether a particular qemu implementation supports this (short of trying
> it and seeing whether it works).  I'm also thinking that this is 2.12
> material, unless we can prove it is fixing a bug for 2.11 that was not
> previously present.

Sounds like another use case for the capability annotations that Markus
wants to introduce for commands in the QAPI schema.

Kevin

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaBJB8AAoJEH8JsnLIjy/WXRwQALZ45eYdTC9ElmUFJFd3luWB
OTu9Auk16Sjrht8cJ8fFpNADRmk8b00sxkebA0xjFcUCw31X+2GbiTVtICPjNIwX
RusWriAiYh1swDtvWMTm2zC7zefzKjorZwOVJVMiUXUAgyxWfY0gkMijIwcodgFn
DrhwUViZHKX/dNXAILI59ZFjzr1v8kS/Q/kdzdQVcUFEKNyvtPfEkL7APnQdpL9p
TueC9THuT0XFULNKd88MhGAI92Qq7qLglFFoQ0uyIxIQR2vzkyz4WAkYfKhR5ova
3zLBuqp/n9Fj3MgIgJlZP9RQIfu5thMjoMUdeKC3ieY74h5fioJdaLX/11e0e3UH
1TehWWcJJ0mS2A/hMzMm8yzqsYflgo5vByMgWyivPmmL9HuDkirN/UsvLpp2mFuu
0eoue4MRSFPHzE1ztyJI0yNsBTs+QB4zWdpQbtpjbKOJ9Vosk8VZhU8LIz7ELqiB
Owy+EZGfd2CDd7s2iVdPwaOZiZhgRZzvyw4G+yN0endppOl0mXwvVWPKYJFKPSeu
2sH64UoVDJXmAqbuiDdoR//VUyFfOS0MvjwPvdZgfiTiaiW/jax8eTSlnqobsCfr
ueP4CduB2Y+iwjqsQ1vDJR62AVQ696r8d4azNvkLYn/ooXxSP75uFLohGYEFOlmi
3SwAi+JpYTjJb4XHgwEd
=xxZN
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
