Received: from eggs.gnu.org ([2001:4830:134:3::10]:33254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSlwq-0001qN-Mc
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSlwn-000189-FB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dSlwn-00017F-67
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:10:33 -0400
Date: Wed, 5 Jul 2017 16:10:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170705151030.GF29910@stefanha-x1.localdomain>
References: <CAGKXQyfO-yu3qZf7RHiUPXQZDSZwn6N_48Ji8adPHozkpK9JBQ@mail.gmail.com>
	<20170630112610.GA2437@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20170630112610.GA2437@work-vm>
Subject: Re: [Qemu-devel] DIRTY_MEMORY_BLOCK_SIZE;
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 12:26:10PM +0100, Dr. David Alan Gilbert wrote:
> * ali saeedi (ali.saeedi56@gmail.com) wrote:
> > Hello
> > what does 'DIRTY_MEMORY_BLOCK_SIZE' mean?
> > is it the number of words in a block? or number of pages in a block? or
> > number of bytes in a block?
> > thanks a lot
>=20
> (cc'ing Stefan)
> I think that DIRTY_MEMORY_BLOCK_SIZE is the number of TARGET_PAGEs
> within one DIRTY_MEMORY_BLOCK
> So with the common 4k target page that's 4k*256k*8=3D8GB/dirty memory
> block - note these are just the size of structure sin qemu, it's still
> got the ranularity ot mark individual target pages as dirty.

Right, the calculation is shown in the comment above the code:

 *   rcu_read_lock();
 *
 *   DirtyMemoryBlocks *blocks =3D
 *       atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
 *
 *   ram_addr_t idx =3D (addr >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZ=
E;
 *   unsigned long *block =3D blocks.blocks[idx];
 *   ...access block bitmap...
 *
 *   rcu_read_unlock();

Rather than focussing on DIRTY_MEMORY_BLOCK_SIZE, make sure you
understand how DirtyMemoryBlocks works.  It is an array of bitmap
pointers.

Instead of directly indexing into a single huge dirty memory bitmap,
QEMU divides the dirty memory bitmap into fixed-sized chunks.  Each
chunk covers DIRTY_MEMORY_BLOCK_SIZE pages.

The reason for this layer of indirection is so that the dirty memory
bitmap can be accessed without taking a traditional lock (just RCU) and
also supports memory hotplug.

Without indirection it would be difficult to grow the bitmap while other
threads are writing to it.  Thanks to the indirection, it's possible to
allocate new chunks and continue using the old chunks when growth
occurs.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXQFmAAoJEJykq7OBq3PIEXAH/03/Mn4aqpl1np8HB0LAHjuw
zhb2DvG6IqssziqIAE8dntxnnhlC64TKaFCgpsL6b4JrMM9k4HtJZxvrgPP7VxfU
hbZudXk9IjOrgUzMRIb9eC9EYImlevsvvnO0lVX6H8C6QCBLVmkw3xe6RiDVemtv
8EhE7hjGtgcNpJVnPwEf85n6D1pe38wzlCKjEpY69NuI0jyIGE6SL+m5JLRV/Dl7
YUbz/get7vU4U8EuiG8wVVlMmf/dmCOg4YTtlXJVA0YnF8IS671v9W1NgSu7Tdai
jD6LchvRPvsGSTKFVynu6Fi5/AJNmNIL2Rw3F865u+7byQHWmSnxPg3Yi1YbKrM=
=LBzF
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
