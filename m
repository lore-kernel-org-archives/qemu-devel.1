Received: from eggs.gnu.org ([209.51.188.92]:37984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmPyQ-0005Ht-7H
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmPkE-0003hI-2X
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:07:35 -0500
Date: Wed, 23 Jan 2019 21:07:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190123210725.GA13509@stefanha-x1.localdomain>
References: <20190120143452.21683-1-stefanha@redhat.com>
	<20190120143452.21683-2-stefanha@redhat.com>
	<CAFEAcA9KkYC7MHquASjoghuDrvkkE_brnM6teLknj1H-waM_0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9KkYC7MHquASjoghuDrvkkE_brnM6teLknj1H-waM_0A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] memory: add
 memory_region_flush_rom_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 04:36:36PM +0000, Peter Maydell wrote:
> On Sun, 20 Jan 2019 at 14:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > ROM devices go via MemoryRegionOps->write() callbacks for write
> > operations and do not dirty/invalidate that memory.  Device emulation
> > must be able to mark memory ranges that have been modified internally
> > (e.g. using memory_region_get_ram_ptr()).
> >
> > Introduce the memory_region_flush_rom_device() API for this purpose.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/exec/memory.h | 18 ++++++++++++++++++
> >  exec.c                | 12 ++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index cd2f209b64..abe9cc79c0 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -1344,6 +1344,24 @@ bool memory_region_snapshot_get_dirty(MemoryRegi=
on *mr,
> >  void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
> >                                 hwaddr size, unsigned client);
> >
> > +/**
> > + * memory_region_flush_rom_device: Mark a range of pages dirty and inv=
alidate
> > + *                                 TBs (for self-modifying code).
> > + *
> > + * The MemoryRegionOps->write() callback of a ROM device must use this=
 function
> > + * to mark byte ranges that have been modified internally, such as by =
directly
> > + * accessing the memory returned by memory_region_get_ram_ptr().
> > + *
> > + * This function marks the range dirty and invalidates TBs so that TCG=
 can
> > + * detect self-modifying code.
> > + *
> > + * @mr: the region being flushed.
> > + * @addr: the start, relative to the start of the region, of the range=
 being
> > + *        flushed.
> > + * @size: the size, in bytes, of the range being flushed.
> > + */
> > +void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwa=
ddr size);
> > +
> >  /**
> >   * memory_region_set_readonly: Turn a memory region read-only (or read=
-write)
> >   *
> > diff --git a/exec.c b/exec.c
> > index 895449f926..105ff21e74 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -3162,6 +3162,18 @@ static void invalidate_and_set_dirty(MemoryRegio=
n *mr, hwaddr addr,
> >      cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
> >  }
> >
> > +void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwa=
ddr size)
> > +{
> > +    /* In principle this function would work on other memory region ty=
pes too,
> > +     * but the ROM device use case is the only one where this operatio=
n is
> > +     * necessary.  Other memory regions should use the
> > +     * address_space_read/write() APIs.
> > +     */
> > +    assert(memory_region_is_romd(mr));
> > +
> > +    invalidate_and_set_dirty(mr, addr, size);
> > +}
> > +
> >  static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr add=
r)
> >  {
> >      unsigned access_size_max =3D mr->ops->valid.max_access_size;
>=20
> API and implementation make sense to me, but better that Paolo reviews
> this I think. I guess we should add calls to this to the pflash device
> models too...

Okay, will cover pflash in the next revision.

Stefan

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSNeMAAoJEJykq7OBq3PIYmYH/15i/DuXt2chEkJw81hGkwvI
3vNBDf9cw5eBSmNKK3avGgKM06FcmEaaDQ4rY9p3b+geNEGGDsk7mGeIK0pxEsxW
MaztayQfKkp157zhZJD53vYmLS7aazFi8woTzIcVAQHw7biUHlLSNwqeKurgj+Tf
3DsivU1ElOCUGX8qVvCmjxyECebUKvJtuT7d/CyW+Gwhm5r1PxWqyf5zH8rc5zRO
VJY07TxiRM1mWsneeQHwcYj+nQKqKGu1OSc5I9DfuRocsPbZpq8AKuWG5fguH1yQ
XOOhB568fGJyfhI/lVaAM/k/wYerm2KeYJD9zMF6th8OQnXxogb9GeYZv1imxew=
=0WTz
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
