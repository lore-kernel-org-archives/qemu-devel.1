Received: from eggs.gnu.org ([209.51.188.92]:34395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1hFtvb-0005SW-KO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1hFtva-0008Ix-C4
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:13:11 -0400
Message-ID: <6b177677d32eff4d3969b6601b13de2c97324812.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Apr 2019 15:12:48 +1000
In-Reply-To: <20190415033836.GD32705@umbus.fritz.box>
References: <20190411080004.8690-1-clg@kaod.org>
	<20190411080004.8690-6-clg@kaod.org>
	<20190415033836.GD32705@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] memory_ldst: Add atomic ops for PTE
 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, 2019-04-15 at 13:38 +1000, David Gibson wrote:
> On Thu, Apr 11, 2019 at 10:00:03AM +0200, C=C3=A9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > On some architectures, PTE updates for dirty and changed bits need
> > to be performed atomically. This adds a couple of
> > address_space_cmpxchg*
> > helpers for that purpose.
> >=20
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> But I think this needs to go past Paolo for review as memory
> subsystem maintainer.

This needs to go to rth and Peter. They were talking about a change in
the abstraction to do these more cleanly... that said, it might be
worthwhile merging the fixes first.

Cheers,
Ben.

>=20
> > ---
> >  include/exec/memory_ldst.inc.h |  6 +++
> >  memory_ldst.inc.c              | 80
> > ++++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >=20
> > diff --git a/include/exec/memory_ldst.inc.h
> > b/include/exec/memory_ldst.inc.h
> > index 272c20f02eae..f3cfa7e9a622 100644
> > --- a/include/exec/memory_ldst.inc.h
> > +++ b/include/exec/memory_ldst.inc.h
> > @@ -28,6 +28,12 @@ extern uint64_t glue(address_space_ldq,
> > SUFFIX)(ARG1_DECL,
> >      hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
> >  extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
> >      hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult
> > *result);
> > +extern uint32_t glue(address_space_cmpxchgl_notdirty,
> > SUFFIX)(ARG1_DECL,
> > +    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
> > +    MemTxResult *result);
> > +extern uint32_t glue(address_space_cmpxchgq_notdirty,
> > SUFFIX)(ARG1_DECL,
> > +    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
> > +    MemTxResult *result);
> >  extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
> >      hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult
> > *result);
> >  extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
> > diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
> > index acf865b900d7..1d58d2fea67d 100644
> > --- a/memory_ldst.inc.c
> > +++ b/memory_ldst.inc.c
> > @@ -320,6 +320,86 @@ void glue(address_space_stl_notdirty,
> > SUFFIX)(ARG1_DECL,
> >      RCU_READ_UNLOCK();
> >  }
> > =20
> > +/* This is meant to be used for atomic PTE updates under MT-TCG */
> > +uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
> > +    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
> > +    MemTxResult *result)
> > +{
> > +    uint8_t *ptr;
> > +    MemoryRegion *mr;
> > +    hwaddr l =3D 4;
> > +    hwaddr addr1;
> > +    MemTxResult r;
> > +    uint8_t dirty_log_mask;
> > +
> > +    /* Must test result */
> > +    assert(result);
> > +
> > +    RCU_READ_LOCK();
> > +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
> > +    if (l < 4 || !memory_access_is_direct(mr, true)) {
> > +        r =3D MEMTX_ERROR;
> > +    } else {
> > +        uint32_t orig =3D old;
> > +
> > +        ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> > +        old =3D atomic_cmpxchg(ptr, orig, new);
> > +
> > +        if (old =3D=3D orig) {
> > +            dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
> > +            dirty_log_mask &=3D ~(1 << DIRTY_MEMORY_CODE);
> > +            cpu_physical_memory_set_dirty_range(memory_region_get_
> > ram_addr(mr) +
> > +                                                addr, 4,
> > dirty_log_mask);
> > +        }
> > +        r =3D MEMTX_OK;
> > +    }
> > +    *result =3D r;
> > +    RCU_READ_UNLOCK();
> > +
> > +    return old;
> > +}
> > +
> > +#ifdef CONFIG_ATOMIC64
> > +/* This is meant to be used for atomic PTE updates under MT-TCG */
> > +uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
> > +    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
> > +    MemTxResult *result)
> > +{
> > +    uint8_t *ptr;
> > +    MemoryRegion *mr;
> > +    hwaddr l =3D 8;
> > +    hwaddr addr1;
> > +    MemTxResult r;
> > +    uint8_t dirty_log_mask;
> > +
> > +    /* Must test result */
> > +    assert(result);
> > +
> > +    RCU_READ_LOCK();
> > +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
> > +    if (l < 8 || !memory_access_is_direct(mr, true)) {
> > +        r =3D MEMTX_ERROR;
> > +    } else {
> > +        uint32_t orig =3D old;
> > +
> > +        ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> > +        old =3D atomic_cmpxchg(ptr, orig, new);
> > +
> > +        if (old =3D=3D orig) {
> > +            dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
> > +            dirty_log_mask &=3D ~(1 << DIRTY_MEMORY_CODE);
> > +            cpu_physical_memory_set_dirty_range(memory_region_get_
> > ram_addr(mr) +
> > +                                                addr, 8,
> > dirty_log_mask);
> > +        }
> > +        r =3D MEMTX_OK;
> > +    }
> > +    *result =3D r;
> > +    RCU_READ_UNLOCK();
> > +
> > +    return old;
> > +}
> > +#endif /* CONFIG_ATOMIC64 */
> > +
> >  /* warning: addr must be aligned */
> >  static inline void glue(address_space_stl_internal,
> > SUFFIX)(ARG1_DECL,
> >      hwaddr addr, uint32_t val, MemTxAttrs attrs,
>=20
>=20
