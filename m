Received: from eggs.gnu.org ([2001:4830:134:3::10]:41266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFHLG-0001RS-PQ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFHLC-0005Hh-G0
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:19:46 -0500
Date: Fri, 9 Dec 2016 20:19:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161209091932.GB23035@umbus.fritz.box>
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-4-david@gibson.dropbear.id.au>
	<457e8c69-3221-2606-3f54-03b34e928a50@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <457e8c69-3221-2606-3f54-03b34e928a50@redhat.com>
Subject: Re: [Qemu-devel] [for-2.9 3/5] pseries: Implement HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 09:36:17AM +0100, Thomas Huth wrote:
> On 09.12.2016 03:23, David Gibson wrote:
> > This patch implements hypercalls allowing a PAPR guest to resize its own
> > hash page table.  This will eventually allow for more flexible memory
> > hotplug.
> >=20
> > The implementation is partially asynchronous, handled in a special thre=
ad
> > running the hpt_prepare_thread() function.  The state of a pending resi=
ze
> > is stored in SPAPR_MACHINE->pending_hpt.
> >=20
> > The H_RESIZE_HPT_PREPARE hypercall will kick off creation of a new HPT,=
 or,
> > if one is already in progress, monitor it for completion.  If there is =
an
> > existing HPT resize in progress that doesn't match the size specified in
> > the call, it will cancel it, replacing it with a new one matching the
> > given size.
> >=20
> > The H_RESIZE_HPT_COMMIT completes transition to a resized HPT, and can =
only
> > be called successfully once H_RESIZE_HPT_PREPARE has successfully
> > completed initialization of a new HPT.  The guest must ensure that there
> > are no concurrent accesses to the existing HPT while this is called (th=
is
> > effectively means stop_machine() for Linux guests).
> >=20
> > For now H_RESIZE_HPT_COMMIT goes through the whole old HPT, rehashing e=
ach
> > HPTE into the new HPT.  This can have quite high latency, but it seems =
to
> > be of the order of typical migration downtime latencies for HPTs of size
> > up to ~2GiB (which would be used in a 256GiB guest).
> >=20
> > In future we probably want to move more of the rehashing to the "prepar=
e"
> > phase, by having H_ENTER and other hcalls update both current and
> > pending HPTs.  That's a project for another day, but should be possible
> > without any changes to the guest interface.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c          |   4 +-
> >  hw/ppc/spapr_hcall.c    | 346 ++++++++++++++++++++++++++++++++++++++++=
+++++++-
>=20
> I wonder whether it makes sense to put all the hpt related code into a
> separate new file?

Maybe, but not really in scope here.

> >  include/hw/ppc/spapr.h  |   6 +
> >  target-ppc/mmu-hash64.h |   4 +
> >  4 files changed, 354 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ecb0822..f3b74dc 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -93,8 +93,6 @@
> > =20
> >  #define PHANDLE_XICP            0x00001111
> > =20
> > -#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> > -
> >  static XICSState *try_create_xics(const char *type, int nr_servers,
> >                                    int nr_irqs, Error **errp)
> >  {
> > @@ -1055,7 +1053,7 @@ static void close_htab_fd(sPAPRMachineState *spap=
r)
> >      spapr->htab_fd =3D -1;
> >  }
> > =20
> > -static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> > +int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> >  {
> >      int shift;
> > =20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 72a9c4d..9f421c1 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -2,6 +2,7 @@
> >  #include "qapi/error.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/log.h"
> > +#include "qemu/error-report.h"
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> >  #include "helper_regs.h"
> > @@ -355,20 +356,320 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
> >      return H_SUCCESS;
> >  }
> > =20
> > +struct sPAPRPendingHPT {
> > +    /* These fields are read-only after initialization */
> > +    int shift;
> > +    QemuThread thread;
> > +
> > +    /* These fields are protected by the BQL */
> > +    bool complete;
> > +
> > +    /* These fields are private to the preparation thread if
> > +     * !complete, otherwise protected by the BQL */
> > +    int ret;
> > +    void *hpt;
> > +};
> > +
> > +static void free_pending_hpt(sPAPRPendingHPT *pending)
> > +{
> > +    if (pending->hpt) {
> > +        qemu_vfree(pending->hpt);
> > +    }
> > +
> > +    g_free(pending);
> > +}
> > +
> > +static void *hpt_prepare_thread(void *opaque)
> > +{
> > +    sPAPRPendingHPT *pending =3D opaque;
> > +    size_t size =3D 1ULL << pending->shift;
> > +
> > +    pending->hpt =3D qemu_memalign(size, size);
> > +    if (pending->hpt) {
> > +        memset(pending->hpt, 0, size);
> > +        pending->ret =3D H_SUCCESS;
> > +    } else {
> > +        pending->ret =3D H_NO_MEM;
> > +    }
> > +
> > +    qemu_mutex_lock_iothread();
> > +
> > +    if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt !=3D pending) {
> > +        /* We've been cancelled, clean ourselves up */
> > +        free_pending_hpt(pending);
> > +        goto out;
> > +    }
> > +
> > +    pending->complete =3D true;
> > +
> > +out:
>=20
> You could easily avoid the goto here:
>=20
>     if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt !=3D pending) {
>         /* We've been cancelled, clean ourselves up */
>         free_pending_hpt(pending);
>     } else {
>         pending->complete =3D true;
>     }
>=20
> ?

Ah, yeah, I guess so.  I think I had more cases that used the same
bailout path during development.

> > +    qemu_mutex_unlock_iothread();
> > +    return NULL;
> > +}
> > +
> > +/* Must be called with BQL held */
> > +static void cancel_hpt_prepare(sPAPRMachineState *spapr)
> > +{
> > +    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > +
> > +    /* Let the thread know it's cancelled */
> > +    spapr->pending_hpt =3D NULL;
> > +
> > +    if (!pending) {
> > +        /* Nothing to do */
> > +        return;
> > +    }
> > +
> > +    if (!pending->complete) {
> > +        /* thread will clean itself up */
> > +        return;
> > +    }
> > +
> > +    free_pending_hpt(pending);
> > +}
> > +
> > +static int build_dimm_list(Object *obj, void *opaque)
> > +{
> > +    GSList **list =3D opaque;
> > +
> > +    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> > +        DeviceState *dev =3D DEVICE(obj);
> > +        if (dev->realized) { /* only realized DIMMs matter */
> > +            *list =3D g_slist_prepend(*list, dev);
> > +        }
> > +    }
> > +
> > +    object_child_foreach(obj, build_dimm_list, opaque);
> > +    return 0;
> > +}
> > +
> > +static ram_addr_t get_current_ram_size(void)
> > +{
> > +    GSList *list =3D NULL, *item;
> > +    ram_addr_t size =3D ram_size;
> > +
> > +    build_dimm_list(qdev_get_machine(), &list);
> > +    for (item =3D list; item; item =3D g_slist_next(item)) {
> > +        Object *obj =3D OBJECT(item->data);
> > +        if (!strcmp(object_get_typename(obj), TYPE_PC_DIMM)) {
> > +            size +=3D object_property_get_int(obj, PC_DIMM_SIZE_PROP,
> > +                                            &error_abort);
> > +        }
> > +    }
> > +    g_slist_free(list);
> > +
> > +    return size;
> > +}
> > +
> >  static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
> >                                           sPAPRMachineState *spapr,
> >                                           target_ulong opcode,
> >                                           target_ulong *args)
> >  {
> >      target_ulong flags =3D args[0];
> > -    target_ulong shift =3D args[1];
> > +    int shift =3D args[1];
> > +    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > =20
> >      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> >          return H_AUTHORITY;
> >      }
> > =20
> >      trace_spapr_h_resize_hpt_prepare(flags, shift);
> > -    return H_HARDWARE;
> > +
> > +    if (flags !=3D 0) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    if (shift && ((shift < 18) || (shift > 46))) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    if (pending) {
> > +        /* something already in progress */
> > +        if (pending->shift =3D=3D shift) {
> > +            /* and it's suitable */
> > +            if (pending->complete) {
> > +                return pending->ret;
> > +            } else {
> > +                return H_LONG_BUSY_ORDER_100_MSEC;
> > +            }
> > +        }
> > +
> > +        /* not suitable, cancel and replace */
> > +        cancel_hpt_prepare(spapr);
> > +    }
> > +
> > +    if (!shift) {
> > +        /* nothing to do */
> > +        return H_SUCCESS;
> > +    }
> > +
> > +    /* start new prepare */
> > +
> > +    /* We only allow the guest to allocate an HPT one order above what
> > +     * we'd normally give them (to stop a small guest claiming a huge
> > +     * chunk of resources in the HPT */
> > +    if (shift > (spapr_hpt_shift_for_ramsize(get_current_ram_size()) +=
 1)) {
> > +        return H_RESOURCE;
> > +    }
> > +
> > +    pending =3D g_malloc0(sizeof(*pending));
>=20
> Maybe use g_new0() instead?

Ah, good idea.

> > +    pending->shift =3D shift;
> > +    pending->ret =3D H_HARDWARE;
> > +
> > +    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > +                       hpt_prepare_thread, pending, QEMU_THREAD_DETACH=
ED);
> > +
> > +    spapr->pending_hpt =3D pending;
> > +
> > +    /* In theory we could estimate the time more accurately based on
> > +     * the new size, but there's not much point */
> > +    return H_LONG_BUSY_ORDER_100_MSEC;
> > +}
> > +
> > +static uint64_t new_hpte_load0(void *htab, uint64_t pteg, int slot)
> > +{
> > +    uint8_t *addr =3D htab;
> > +
> > +    addr +=3D pteg * HASH_PTEG_SIZE_64;
> > +    addr +=3D slot * HASH_PTE_SIZE_64;
> > +    return  ldq_p(addr);
> > +}
> > +
> > +static void new_hpte_store(void *htab, uint64_t pteg, int slot,
> > +                           uint64_t pte0, uint64_t pte1)
> > +{
> > +    uint8_t *addr =3D htab;
> > +
> > +    addr +=3D pteg * HASH_PTEG_SIZE_64;
> > +    addr +=3D slot * HASH_PTE_SIZE_64;
> > +
> > +    stq_p(addr, pte0);
> > +    stq_p(addr + HASH_PTE_SIZE_64/2, pte1);
> > +}
> > +
> > +static int rehash_hpte(PowerPCCPU *cpu, uint64_t token,
> > +                       void *old, uint64_t oldsize,
> > +                       void *new, uint64_t newsize,
> > +                       uint64_t pteg, int slot)
> > +{
> > +    uint64_t old_hash_mask =3D (oldsize >> 7) - 1;
> > +    uint64_t new_hash_mask =3D (newsize >> 7) - 1;
> > +    target_ulong pte0 =3D ppc_hash64_load_hpte0(cpu, token, slot);
> > +    target_ulong pte1;
> > +    uint64_t avpn;
> > +    unsigned shift;
> > +    uint64_t hash, new_pteg, replace_pte0;
> > +
> > +    if (!(pte0 & HPTE64_V_VALID) || !(pte0 & HPTE64_V_BOLTED)) {
> > +        return H_SUCCESS;
> > +    }
> > +
> > +    pte1 =3D ppc_hash64_load_hpte1(cpu, token, slot);
> > +
> > +    shift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1);
> > +    assert(shift); /* H_ENTER should never have allowed a bad encoding=
 */
> > +    avpn =3D HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << shift) - 1) >> 23);
> > +
> > +    if (pte0 & HPTE64_V_SECONDARY) {
> > +        pteg =3D ~pteg;
> > +    }
> > +
> > +    if ((pte0 & HPTE64_V_SSIZE) =3D=3D HPTE64_V_SSIZE_256M) {
> > +        uint64_t offset, vsid;
> > +
> > +        /* We only have 28 - 23 bits of offset in avpn */
> > +        offset =3D (avpn & 0x1f) << 23;
> > +        vsid =3D avpn >> 5;
> > +        /* We can find more bits from the pteg value */
> > +        if (shift < 23) {
> > +            offset |=3D ((vsid ^ pteg) & old_hash_mask) << shift;
> > +        }
> > +
> > +        hash =3D vsid ^ (offset >> shift);
> > +    } else if ((pte0 & HPTE64_V_SSIZE) =3D=3D HPTE64_V_SSIZE_1T) {
> > +        uint64_t offset, vsid;
> > +
> > +        /* We only have 40 - 23 bits of seg_off in avpn */
> > +        offset =3D (avpn & 0x1ffff) << 23;
> > +        vsid =3D avpn >> 17;
> > +        if (shift < 23) {
> > +            offset |=3D ((vsid ^ (vsid << 25) ^ pteg) & old_hash_mask)=
 << shift;
> > +        }
> > +
> > +        hash =3D vsid ^ (vsid << 25) ^ (offset >> shift);
> > +    } else {
> > +        error_report("rehash_pte: Bad segment size in HPTE");
> > +        return H_HARDWARE;
> > +    }
> > +
> > +    new_pteg =3D hash & new_hash_mask;
> > +    if (pte0 & HPTE64_V_SECONDARY) {
> > +        assert(~pteg =3D=3D (hash & old_hash_mask));
> > +        new_pteg =3D ~new_pteg;
> > +    } else {
> > +        assert(pteg =3D=3D (hash & old_hash_mask));
> > +    }
> > +    assert((oldsize !=3D newsize) || (pteg =3D=3D new_pteg));
> > +    replace_pte0 =3D new_hpte_load0(new, new_pteg, slot);
> > +    if (replace_pte0 & HPTE64_V_VALID) {
> > +        assert(newsize < oldsize);
> > +        if (replace_pte0 & HPTE64_V_BOLTED) {
> > +            if (pte0 & HPTE64_V_BOLTED) {
> > +                /* Bolted collision, nothing we can do */
> > +                return H_PTEG_FULL;
> > +            } else {
> > +                /* Discard this hpte */
> > +                return H_SUCCESS;
> > +            }
> > +        }
> > +    }
> > +
> > +    new_hpte_store(new, new_pteg, slot, pte0, pte1);
> > +    return H_SUCCESS;
> > +}
> > +
> > +static int rehash_hpt(PowerPCCPU *cpu,
> > +                      void *old, uint64_t oldsize,
> > +                      void *new, uint64_t newsize)
> > +{
> > +    CPUPPCState *env =3D &cpu->env;
> > +    uint64_t n_ptegs =3D oldsize >> 7;
> > +    uint64_t pteg;
> > +    int slot;
> > +    int rc;
> > +
> > +    assert(env->external_htab =3D=3D old);
> > +
> > +    for (pteg =3D 0; pteg < n_ptegs; pteg++) {
> > +        uint64_t token =3D ppc_hash64_start_access(cpu, pteg * HPTES_P=
ER_GROUP);
> > +
> > +        if (!token) {
> > +            return H_HARDWARE;
> > +        }
> > +
> > +        for (slot =3D 0; slot < HPTES_PER_GROUP; slot++) {
> > +            rc =3D rehash_hpte(cpu, token, old, oldsize, new, newsize,
> > +                             pteg, slot);
> > +            if (rc !=3D H_SUCCESS) {
> > +                ppc_hash64_stop_access(cpu, token);
> > +                return rc;
> > +            }
> > +        }
> > +        ppc_hash64_stop_access(cpu, token);
> > +    }
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> > +static void pivot_hpt(CPUState *cs, run_on_cpu_data arg)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(arg.host_ptr);
> > +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +
> > +    cpu_synchronize_state(cs);
> > +    ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
> > +                                &error_fatal);
> >  }
> > =20
> >  static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
> > @@ -378,13 +679,52 @@ static target_ulong h_resize_hpt_commit(PowerPCCP=
U *cpu,
> >  {
> >      target_ulong flags =3D args[0];
> >      target_ulong shift =3D args[1];
> > +    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > +    int rc;
> > +    size_t newsize;
>=20
> Why size_t here? size_t could be 32-bit on some systems, and don't you
> rather want to always have 64-bit (or at least target_ulong) here?

In that case (and if newsize would be > 4G) we're stuffed anyway - we
allocate the htab with qemu_memalign(), which only takes a size_t, and
even if it didn't there's nowhere we could actually allocate the hash table.

> >      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> >          return H_AUTHORITY;
> >      }
> > =20
> >      trace_spapr_h_resize_hpt_commit(flags, shift);
> > -    return H_HARDWARE;
> > +
> > +    if (flags !=3D 0) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    if (!pending || (pending->shift !=3D shift)) {
> > +        /* no matching prepare */
> > +        return H_CLOSED;
> > +    }
> > +
> > +    if (!pending->complete) {
> > +        /* prepare has not completed */
> > +        return H_BUSY;
> > +    }
> > +
> > +    newsize =3D 1ULL << pending->shift;
> > +    rc =3D rehash_hpt(cpu, spapr->htab, HTAB_SIZE(spapr),
> > +                    pending->hpt, newsize);
> > +    if (rc =3D=3D H_SUCCESS) {
> > +        CPUState *cs;
> > +
> > +        qemu_vfree(spapr->htab);
> > +        spapr->htab =3D pending->hpt;
> > +        spapr->htab_shift =3D pending->shift;
> > +
> > +        CPU_FOREACH(cs) {
> > +            run_on_cpu(cs, pivot_hpt, RUN_ON_CPU_HOST_PTR(spapr));
> > +        }
> > +
> > +        pending->hpt =3D NULL; /* so it's not free()d */
> > +    }
> > +
> > +    /* Clean up */
> > +    spapr->pending_hpt =3D NULL;
> > +    free_pending_hpt(pending);
> > +
> > +    return rc;
> >  }
>=20
>  Thomas
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSnchAAoJEGw4ysog2bOSVwsQAIUT2yuNy1msb2jE8zthyEVF
UFaRUVQ0yxEZqz3GCbMh2ec+OUZvu0Wuj7RRM11COmr6mXdo8EnibuBPJPy+CzC+
ogST5j8MFnQFRKsIzrOkP6K1uRwJP8N8BN4rVDiC5Uvco/hzjYmNAcST4LRJLqrJ
VlJROOIHJ/tmZI7xAf4EgXfNNk3hw7PQjVKjknfeGldyCaoEKoxeLlpdyJt6qHDh
Dr+EuVgEV2u+rhwSjF5DRq78TeUK0jyBr9BTh4CRbrxrwPD8jn6RFYg6eMBf3mmO
er9YoOQjyV3GN0lCnYe+Jm4Nvf0U3GximIRqIRXcszYaqD8llHLf4cPqquKH6gWy
Z3HXgmdi1n1N12GoCqbXdcc2BNdhaXPCYeSxIdX8jsBFjq68yRyTiYGqGQOQ/o3x
OYg8ZvP8OihjWIQohYVUtVfseAqld0PXFZEd21GaKq9cSlaXHH0fLduJvtnNcpUq
9RJZTgwj6SBXgYB7damA3/K/8vrDub/g4d1GeVGqm4057FcaWqxWetlc3jGApM6i
/Qp52CWSR7CmUYCH5w4d/l2a7Lr/OelLfCCQ7+BwqMntB4C7Mhas58885pSAQINk
bxFsup+XY2JDjI98SetLD0uvbheHt0R7ndm98KVDuRxH0q5ehdVP4ZwDGCf81qFw
7SR2cqd3igMVTrCc0ouq
=6zkj
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
