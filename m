Received: from eggs.gnu.org ([209.51.188.92]:36086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4pr-0004OS-GU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4pq-00026i-KG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:23:43 -0500
Date: Thu, 17 Jan 2019 10:23:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190117102331.GD27840@stefanha-x1.localdomain>
References: <20190115132942.b7xgq7dpwpkrmebb@perseus.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20190115132942.b7xgq7dpwpkrmebb@perseus.local>
Subject: Re: [Qemu-devel] [Qemu-block] Crash when deleting an iothread that
 is being used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 03:29:42PM +0200, Alberto Garcia wrote:
> Here's how to reproduce the crash:
>=20
> { "execute": "qmp_capabilities" }
> { "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-nam=
e": "hd0"}}
> { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "i=
othread0"}}
> { "execute": "x-blockdev-set-iothread", "arguments": {"node-name": "hd0",=
 "iothread": "iothread0"}}
> { "execute": "object-del", "arguments": {"id": "iothread0"}}
> { "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>=20
> The problem is that bs->aio_context is the one that belonged to the
> IOThread and was destroyed by the object-del call. One would need to
> do x-blockdev-set-iothread(hd0, null) before deleting the thread.
>=20
> The IOThread class does not have a can_be_deleted() method to prevent
> threads from being deleted. One possible implementation would require
> a reference count but that doesn't seem immediately trivial because
> users don't use the IOThread itself but its AioContext, and not all
> bdrv_set_aio_context() are related to IOThreads.
>=20
> A quicker fix is of course to prevent the threads from being deleted
> at all :-)

What is the real-world scenario for crashes like this?

object-del on an IOThread that is currently in use by
virtio-blk/virtio-scsi?

I'm asking because x-blockdev-set-iothread is a low-level testing
command and it can create IOThread configurations that real-world users
never reach.  It's only worth worrying about if users are affected.

Stefan

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQFejAAoJEJykq7OBq3PIII0H/jQS7k0LJ8hf25w92TAXUEjG
eqwKtzZvxinEBgJvXAzxfDLYiXibGbxdkWpcFps0NO3vjuxNFts3KGU/7CPLzjQj
1a6RK2JruZ7hrrhVM+hU/O9cm/RhgXZUFK9StAcVoLU2KkdMaFod2mTtARWktY6X
9/p0qSwulDdvFGwP777iQhiTbQrBw7aoJaHpLQh4Bt09Sb1bH9MIfYcSeFz6aJj+
MAVUieTRUkUE9XhqV8q3lV7pleeH2XTBhz2viMFmlUNks/7miK6rIAYTXul1Zw/g
4tOc1gE9HFMySMoRveU5z9KJVO7Ci+/QckzGTML0S9I7kEqH+wx/OqWgXYz2iWE=
=7R40
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
