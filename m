Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvNNx-00041p-G7
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvNNt-00020q-Fo
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:16:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cvNNt-00020Z-77
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:16:29 -0400
Date: Tue, 4 Apr 2017 14:16:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170404121624.GA4536@noname.str.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20170403135012.GY26598@andariel.pipo.sk>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.04.2017 um 15:50 hat Peter Krempa geschrieben:
> On Mon, Apr 03, 2017 at 15:00:41 +0200, Kevin Wolf wrote:
> > If I understand correctly, this is a case of incoming live migration,
> > i.e. the virtio-blk device which is blocking the writes to the image
> > doesn't really belong to a running guest yet.
>=20
> Yes, exactly. libvirt starts the NBD server on the destination of
> the migration. Until then the VM did not ever run yet. The VM will run
> once the memory migration finishes, so the guest front-end will not
> write anything at that point.
>=20
> > So if we need to make an exception (and actually reading the context
> > makes it appear so), I guess it would have to be that devices actually
> > can share the write permission during incoming migration, but not any
> > more later (unless the share-rw flag is set).
>=20
> Yes, this would be desired to avoid a regression. Libvirt then tears
> down the mirror prior to resuming the VM (afaik).

Now the big question is how to implement this. Just not requesting the
write permission initially if runstate_check(RUN_STATE_INMIGRATE) is
easy. But we need to find a place to actually request it later, after
the mirror has completed, and before the VM is running.

My first thought was that we could add a VMChangeStateHandler and just
request the permission in there. However, requesting the permission can
fail (e.g. because the NBD server hasn't been shut down) and we can't
let a state transition fail from a VMChangeStateHandler.

Maybe the next best thing we could do is to have a BlockDevOps callback
for invalidate_cache/inactivate and get the permissions there. This one
could return an error, which would be passed up the stack and eventually
cause qmp_cont() to fail (i.e. it would refuse to resume the VM). This
sounds workable to me.

Any comments on this approach, or maybe other ideas?

Kevin

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY446YAAoJEH8JsnLIjy/WD3IP/2naNXjVvoBAm56B3hKd7Ltc
Cuv8xHukc7Q2d7uqvZT05Og7x5cczurNQEVCq9oO8BvF0YqmpGz/SmoCN3guSgdw
srQW+BL/U1YhgWN2wPsEz6SvaQi/a+IMrSekAUnLBXCpWQYNQhARLDv8DKAb5QwW
PgJW1lNLWkYptUi0dbTE4/VvMGLYxEJyMVn8RrFU7fI7VAONezBwlWOZYTY9ozFL
QCuQxh2H/zGUdBSweLn+VFDYARRIKgtgWPCrhmiOKP3V5+Low9AsPsHJyKmr/cQq
hgETqyd8Ru5RHZvcmU3rOxMkFuLUrQevGtLTCcGktndckN821+T2lpGPvVa7eyzP
9EcsFVn2Fi0P21PSx/bXGXqwuB0gNLB+qHK/yiNAzPiB6Gbtbg0BYoRyOFyY2S4r
d9tUJhlIDADlLl3Owy6x2j8qt2VSwGHzRRehr73Iuo5QxHOZq4KbYhMz15oEQXPu
TGc2u4+tiGU/lF3nKLSH17CLJyqkSghH44VvHFfwmxaURr5Jb/s3s3aRPg/FpoZz
/kRKAs//FprPdKl01RL6bQD6OHPeJVcubwZYEaV87GjxovreX4RGKViJTC9Z7Nd3
55ux+X2/LgIzUmH+CK+rA9kGfS01tZbg1zfTeGuwynKuyBjGiFhTOj0wn4jPvc/6
5+JjkxkEUbTaY4jRVEaH
=GuWF
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
