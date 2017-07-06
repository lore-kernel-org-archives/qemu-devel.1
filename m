Received: from eggs.gnu.org ([2001:4830:134:3::10]:55044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3LL-0006r6-T2
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3LH-0006lq-25
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:45:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dT3LG-0006kL-R7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:44:58 -0400
Received: by mail-wr0-x243.google.com with SMTP id z45so3735889wrb.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 02:44:58 -0700 (PDT)
Date: Thu, 6 Jul 2017 10:44:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706094455.GE30447@stefanha-x1.localdomain>
References: <CAGKXQyfO-yu3qZf7RHiUPXQZDSZwn6N_48Ji8adPHozkpK9JBQ@mail.gmail.com>
	<20170630112610.GA2437@work-vm>
	<20170705151030.GF29910@stefanha-x1.localdomain>
	<20170705160640.GB2284@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20170705160640.GB2284@work-vm>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 05:06:41PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Fri, Jun 30, 2017 at 12:26:10PM +0100, Dr. David Alan Gilbert wrote:
> > > * ali saeedi (ali.saeedi56@gmail.com) wrote:
> > > > Hello
> > > > what does 'DIRTY_MEMORY_BLOCK_SIZE' mean?
> > > > is it the number of words in a block? or number of pages in a block=
? or
> > > > number of bytes in a block?
> > > > thanks a lot
> > >=20
> > > (cc'ing Stefan)
> > > I think that DIRTY_MEMORY_BLOCK_SIZE is the number of TARGET_PAGEs
> > > within one DIRTY_MEMORY_BLOCK
> > > So with the common 4k target page that's 4k*256k*8=3D8GB/dirty memory
> > > block - note these are just the size of structure sin qemu, it's still
> > > got the ranularity ot mark individual target pages as dirty.
> >=20
> > Right, the calculation is shown in the comment above the code:
> >=20
> >  *   rcu_read_lock();
> >  *
> >  *   DirtyMemoryBlocks *blocks =3D
> >  *       atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]=
);
> >  *
> >  *   ram_addr_t idx =3D (addr >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK=
_SIZE;
> >  *   unsigned long *block =3D blocks.blocks[idx];
> >  *   ...access block bitmap...
> >  *
> >  *   rcu_read_unlock();
> >=20
> > Rather than focussing on DIRTY_MEMORY_BLOCK_SIZE, make sure you
> > understand how DirtyMemoryBlocks works.  It is an array of bitmap
> > pointers.
> >=20
> > Instead of directly indexing into a single huge dirty memory bitmap,
> > QEMU divides the dirty memory bitmap into fixed-sized chunks.  Each
> > chunk covers DIRTY_MEMORY_BLOCK_SIZE pages.
> >=20
> > The reason for this layer of indirection is so that the dirty memory
> > bitmap can be accessed without taking a traditional lock (just RCU) and
> > also supports memory hotplug.
> >=20
> > Without indirection it would be difficult to grow the bitmap while other
> > threads are writing to it.  Thanks to the indirection, it's possible to
> > allocate new chunks and continue using the old chunks when growth
> > occurs.
>=20
> I guess this works like the old non-chunk version, in that there's no
> direct correspondence between DirtyMemoryBlocks and RAMBlock's - i.e.
> one RAMBlock might span two DirtyMemoryBlocks even if it's smaller
> than DIRTY_MEMORY_BLOCK_SIZE.

Yes.

Stefan

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXgaXAAoJEJykq7OBq3PItx0IALyVLb7z5AWhKqd9WkN9k+iK
i3CinjQPX6Jw2U7OU+XK1goa5DdoLIEW0wJiHjVsj+TTiGr7VgnYFo+O0vx6QSd+
KTMEvujHYNyZUnqLlp6pbkzA6jDmiBsSOM3DONHdMvYEpMWm7hODTNV4cyA34yWg
I5Ijn1hotD5JtMoj6UvZuNsi40XxW/SfsIyfjGZEKNTyNipQMA6qlhNVoHD6KGSA
M5R4O3Nqbl9u+2suwzsPYS9KFJtcisnZ5f4crdV1ryinhi/TTS6lpdQIpmlvPnCc
O6xGAgq4MNDSOSWxMMyq9kTKGL/q/Yg32+4OVWM+hLwpp2P/5ejRDy/OsbCZ6G0=
=Se+2
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
