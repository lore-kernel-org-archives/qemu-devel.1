Received: from eggs.gnu.org ([2001:4830:134:3::10]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3dI-0007Fe-9z
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3dH-0002pb-9x
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:07:28 -0400
Date: Wed, 30 May 2018 18:07:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180530160719.GD4311@localhost.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
	<20180511172531.GB5016@localhost.localdomain>
	<20180514134846.GD5182@stefanha-x1.localdomain>
	<20180530144450.GB5973@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20180530144450.GB5973@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, He Junyan <junyan.he@intel.com>, Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.05.2018 um 16:44 hat Stefan Hajnoczi geschrieben:
> On Mon, May 14, 2018 at 02:48:47PM +0100, Stefan Hajnoczi wrote:
> > On Fri, May 11, 2018 at 07:25:31PM +0200, Kevin Wolf wrote:
> > > Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> > > > On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> > > > > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > > > > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> > > > > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > > > > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> > > > > >> I think it makes sense to invest some effort into such interfa=
ces, but
> > > > > >> be prepared for a long journey.
> > > > > >=20
> > > > > > I like the suggestion but it needs to be followed up with a con=
crete
> > > > > > design that is feasible and fair for Junyan and others to imple=
ment.
> > > > > > Otherwise the "long journey" is really just a way of rejecting =
this
> > > > > > feature.
>=20
> The discussion on NVDIMM via the block layer has runs its course.  It
> would be a big project and I don't think it's fair to ask Junyan to
> implement it.
>=20
> My understanding is this patch series doesn't modify the qcow2 on-disk
> file format.  Rather, it just uses existing qcow2 mechanisms and extends
> live migration to identify the NVDIMM state state region to share the
> clusters.
>=20
> Since this feature does not involve qcow2 format changes and is just an
> optimization (dirty blocks still need to be allocated), it can be
> removed from QEMU in the future if a better alternative becomes
> available.
>=20
> Junyan: Can you rebase the series and send a new revision?
>=20
> Kevin and Max: Does this sound alright?

Do patches exist? I've never seen any, so I thought this was just the
early design stage.

I suspect that while it wouldn't change the qcow2 on-disk format in a
way that the qcow2 spec would have to be change, it does need to change
the VMState format that is stored as a blob within the qcow2 file.
At least, you need to store which other snapshot it is based upon so
that you can actually resume a VM from the incremental state.

Once you modify the VMState format/the migration stream, removing it
=66rom QEMU again later means that you can't load your old snapshots any
more. Doing that, even with the two-release deprecation period, would be
quite nasty.

But you're right, depending on how the feature is implemented, it might
not be a thing that affects qcow2 much, but one that the migration
maintainers need to have a look at. I kind of suspect that it would
actually touch both parts to a degree that it would need approval from
both sides.

Kevin

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbDsw3AAoJEH8JsnLIjy/WKNMQAISgXP/stVQIS1U7HY9uUpG8
RKbZwwV5BhUZ1TnQ6vfNSxY+WruOaZslr7nzYHoPdeZCbop/NSOasvlRi5WZcpBN
tYeei+sdKx95CcthtcRxK0pbr/cJ/mw2xumzFzPpoJ4sUXuOUzUg6GuznhkUUYJE
kAXq7xpHQs64tSvq0x4kr1CiQwQK/e40BtwLLZRw/otObRMVDhQBqAJQEs1Xi4kK
gceaQZQKG6CwKZz7+KY/WE2YwaHe1YcZf4WFk+YSGW5aIbthgBIHAA0iQQEyQVM+
73sgI3UYRNlEzOpU38Ta9uhtIhP802IOzgTlSBJBNOMBE/5oo2TiDVFZ8bFJLF4s
Zj7zBPCe7MgcFlcO0/qIZdm5LEFdG3TyPdR9MOch+wMsEAQTmgJHGYSH8T6WVV3Z
4+Bc7SvwFaaszdM1BvA6CU0aK04CI7PjUR1sZDCh4RP/8kt0RCgMG2hVRsyzrPUC
LPJs5LuiZgzuIo2tMLjd3ZHCCwQ6fUiclj/u2BGYKD5EUHMCJj3I2jF0J2WbFTOk
AWGsb9/4B1UWms7wPlGHZHYUdtqLHrpQLOAU7luEUjcTb71UHFLUNezQ/CmD/O3G
vt/X6EcJ8GW94EJGNqX/aw11lTNx4KjvTN2kHTSt3lTgQ4OY0izkMJcMKRKIc0fU
1QsEtTSLSJJjGcHdGgmv
=C8FX
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
