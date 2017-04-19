Received: from eggs.gnu.org ([2001:4830:134:3::10]:41098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0lhX-0002Z4-I1
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0lhW-0008Vt-I6
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:15:03 -0400
Date: Wed, 19 Apr 2017 10:14:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170419091451.GC3343@stefanha-x1.localdomain>
References: <20170412091819.GB4955@noname.str.redhat.com>
	<20170418144725.GJ21261@stefanha-x1.localdomain>
	<20170418153256.GE9236@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20170418153256.GE9236@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] migrate -b problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 05:32:56PM +0200, Kevin Wolf wrote:
> Am 18.04.2017 um 16:47 hat Stefan Hajnoczi geschrieben:
> > On Wed, Apr 12, 2017 at 11:18:19AM +0200, Kevin Wolf wrote:
> > > after getting assertion failure reports for block migration in the la=
st
> > > minute, we just hacked around it by commenting out op blocker asserti=
ons
> > > for the 2.9 release, but now we need to see how to fix things properl=
y.
> > > Luckily, get_maintainer.pl doesn't report me, but only you. :-)
> > >=20
> > > The main problem I see with the block migration code (on the
> > > destination) is that it abuses the BlockBackend that belongs to the
> > > guest device to make its own writes to the image file. If the guest
> > > isn't allowed to write to the image (which it now isn't during incomi=
ng
> > > migration since it would conflict with the newer style of block
> > > migration using an NBD server), writing to this BlockBackend doesn't
> > > work any more.
> > >=20
> > > So what should really happen is that incoming block migration creates
> > > its own BlockBackend for writing to the image. Now we don't want to do
> > > this anew for every incoming block, but ideally we'd just create all
> > > necessary BlockBackends upfront and then keep using them throughout t=
he
> > > whole migration. Is there a way to get some setup/teardown callbacks
> > > at the start/end of the migration that could initialise and free such
> > > global data?
> >=20
> > It can be done in the beginning of block_load() similar to
> > block_mig_state.bmds_list, which is created in init_blk_migration() at
> > save time.
>=20
> The difference is that block_load() is the counterpart for
> block_save_iterate(), not for init_blk_migration(). That is, it is
> called for each chunk of block migration data, which is interleaved with
> normal RAM migration chunks.
>=20
> So we can either create each BlockBackend the first time we need it in
> block_load(), or create BlockBackends for all existing device BBs and
> BDSes the first time block_load() is called. We still need some place
> to actually free the BlockBackends again when the migration completes.
>=20
> Dave suggested migration state notifiers, which looked like an option,
> but at least the existing migration states aren't enough, because the
> BlockBackends need to go away before blk_resume_after_migration() is
> called, but MIGRATION_STATUS_COMPLETED is set only afterwards.
>=20
> > We can also move the if (blk !=3D blk_prev) blk_invalidate_cache() code
> > out of the load loop.  It should be done once when setting up
> > BlockBackends.
>=20
> Same problem as above, while saving has setup/cleanup callbacks, we only
> have the iterate callback for loading.

I see what you are saying.  setup/cleanups need to be added to
SaveVMHandlers.

Stefan

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9yqLAAoJEJykq7OBq3PIneAH/0CwMbMLoyB2rFMV2OjzgMkM
cxr8CuL/HFF54hcIQ/B37jGMg8uh1Hl9t2IMzvEsmr9C9/clTpMoij3+mahq0ZGy
aTzvsjF6g6lDYwE4hOW8pIN1/FNwGsdtYX/FJfWKny+YV3VX6NS+/ZYybE6/J/i2
2gZIBs6OqbtQhXeFXAAgVix7JT+4rM6M3BzRQeRAzfOOetuiU3QHpkE2OSVVu6dH
CXZ7dwMAMYRvTzE5UVi0Zh9y4UqNHq26Ys3KyP3a57RXs6UDrfAgMGKVZomD1HGY
5abhxqmRQ5e3ywHV8jmIDxk3u77lPbRQv4/HDNMST/Pnjt8kG7Ug5RxSVDoLpmo=
=+H58
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
