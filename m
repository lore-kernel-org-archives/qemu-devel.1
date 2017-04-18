Received: from eggs.gnu.org ([2001:4830:134:3::10]:43674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UPn-00039v-E5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UPm-0006Gy-Ju
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:47:35 -0400
Date: Tue, 18 Apr 2017 15:47:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418144725.GJ21261@stefanha-x1.localdomain>
References: <20170412091819.GB4955@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
In-Reply-To: <20170412091819.GB4955@noname.str.redhat.com>
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
Cc: qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, quintela@redhat.com


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 11:18:19AM +0200, Kevin Wolf wrote:
> after getting assertion failure reports for block migration in the last
> minute, we just hacked around it by commenting out op blocker assertions
> for the 2.9 release, but now we need to see how to fix things properly.
> Luckily, get_maintainer.pl doesn't report me, but only you. :-)
>=20
> The main problem I see with the block migration code (on the
> destination) is that it abuses the BlockBackend that belongs to the
> guest device to make its own writes to the image file. If the guest
> isn't allowed to write to the image (which it now isn't during incoming
> migration since it would conflict with the newer style of block
> migration using an NBD server), writing to this BlockBackend doesn't
> work any more.
>=20
> So what should really happen is that incoming block migration creates
> its own BlockBackend for writing to the image. Now we don't want to do
> this anew for every incoming block, but ideally we'd just create all
> necessary BlockBackends upfront and then keep using them throughout the
> whole migration. Is there a way to get some setup/teardown callbacks
> at the start/end of the migration that could initialise and free such
> global data?

It can be done in the beginning of block_load() similar to
block_mig_state.bmds_list, which is created in init_blk_migration() at
save time.

We can also move the if (blk !=3D blk_prev) blk_invalidate_cache() code
out of the load loop.  It should be done once when setting up
BlockBackends.

> The other problem with block migration is that is uses a BlockBackend
> name to identify which device is migrated. However, there can be images
> that are not attached to any BlockBackend, or if it is, the BlockBackend
> might be anonymous, so this doesn't work. I suppose changing the field
> to "device name if available, node-name otherwise" would solve this.

Yes, that sounds good and is backwards compatible.

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9ib9AAoJEJykq7OBq3PIvB0H/j3M2TMRTR+6itea3g3W2q4G
icStmCwQg9G6s3xV8w7v9oyH5Drfs6lGMR6jWdFEwUszWQs07etpW81MruizIMc1
meA0adTXzoZNo7rY4U/b5P1vE/7CQNwEvBfhyJB0wOeQHpOkw+xZwLXBoFLTE6Pr
UWumas6+BxV0kV8zkDeg5jLAzCXvNNfKRZzyJeRAHZO1riqOEOQJhGgFfqb+ZTq5
QTwJCh6Wd0JRVra+joMX44JROnw47FnnqL3/NCTUGnfnTlv6iqMRcn7fpiMF0UpU
W7dYGbLlI8PKD/WYIPCsDMkTfwe/Ts2MLQrjwjlJG2pkLJTT1OR5r+VQGOzuyns=
=Qz/7
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
