Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXO9U-000213-CH
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXO9T-0000Ro-EK
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:51:16 -0400
Date: Mon, 25 Jun 2018 11:51:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180625095105.GD5024@localhost.localdomain>
References: <20180621170657.27542-1-kwolf@redhat.com>
	<20180621170657.27542-2-kwolf@redhat.com>
	<20180625090213.GB29002@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20180625090213.GB29002@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: Convert
 .bdrv_truncate callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.06.2018 um 11:02 hat Stefan Hajnoczi geschrieben:
> On Thu, Jun 21, 2018 at 07:06:56PM +0200, Kevin Wolf wrote:
> > bdrv_truncate() is an operation that can block (even for a quite long
> > time, depending on the PreallocMode) in I/O paths that shouldn't block.
> > Convert it to a coroutine_fn so that we have the infrastructure for
> > drivers to make their .bdrv_co_truncate implementation asynchronous.
>=20
> block/commit.c:commit_run() invokes blk_truncate() outside of a drained
> region.  I haven't looked for other instances, but this patch opens the
> door for races with other I/O requests.  Are you sure it's safe to make
> this asynchronous without request serialization?

After trying to explain why it's correct, I start to think that you're
right at least in one case. The new thing after this patch is that the
truncate operation isn't atomic any more. What this means depends on the
block driver:

* file-posix/win32: I think this one is okay. The truncate
  implementation doesn't depend in any way on the content of the image.
  Preallocation could be critical (in that it could overwrite
  concurrently issued write requests), but the BDS size is only adjusted
  after the driver callback has returned, so there can't be a concurrent
  write request.

* copy-on-read, crypto, raw-format: Essentially just filter drivers that
  pass the request to a child node, no problem.

* gluster, iscsi, nfs, rbd, ssh: Won't yield even after this series, so
  trivially okay.

* qcow2: This one is where you're right, it needs to hold s->lock so
  that the metadata modifications become safe.

* qed: Does a single header update, should be fine without locking.

* sheepdog: Doesn't yield until it starts preallocation. For
  preallocation, the same reasoning as for file-posix applies.

So, if I got this right, the only thing to change is holding s->lock in
qcow2_co_truncate().

Do you agree?

Kevin

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbMLsJAAoJEH8JsnLIjy/WOp0P/jthJMcrmDelxfKd/YlHwIDi
iVklFVqlWn4aWRuGiVLi6huYtXJwxU9Pm359xnlZ/OmpV20tx6VIAUo5Yi9KsKPB
l64iYW4uRJXQ7uQtjqZhDNJUTFzV8Sz7d1WGIUyfePJOe52zveLNIU+gEpY2w2Fm
4uvR1IpBDL9XYAAWiddPIWUeTyE8nWAk9sNjruJzOBTtHH0vRSi0MhSNBtC2frFD
FZ1Cnn4OQIhK8/xPdRgYFzBR1ybTy5kViZHMOyX3BFT41SMHZc9/9GldcAun2mzf
OBiVhXGBbeWBc5C4u9MlkG2ELmJErDMlpyBdgzUcxOimr6EcBZ2nrNDqUItmlCUl
tvdVwl4rgnuIEyARohDv5ajh2j4FXDzY8gllEpNrKjBwHmpe9147QBIWNUuvGxYz
TiXRPHR0JPRd3propYHjY+PV6X6mVqDX4Yw1yUIrphSxi3FoL+SIvenSzUkoviQt
7s6OVTVElYObFxVSa1wA/PSegPYNkfKA+4EdIpX6qLz9veXvuHky3mafLkoNPsCc
d8a2/4kTtwPkdQuNvQo7IENpFVsMAgWZvdvqJlRk1UYOByihZ+1gUA16bKsd4+oW
GbtMAPzpR1NUqFbi+WhHxotIP7yCwuc+EJ5P4izEf+eiqSzI1PxgvQ0qlUbysfYJ
XPEU5tz4Zzmcv7WO8zhD
=YlC0
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
