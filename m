Received: from eggs.gnu.org ([2001:4830:134:3::10]:54857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnebk-0005pa-AS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnebj-0006dW-2T
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:02:52 -0400
Date: Tue, 14 Mar 2017 16:02:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314050236.GG12564@umbus.fritz.box>
References: <20170310011328.30719-1-david@gibson.dropbear.id.au>
	<20170310011328.30719-3-david@gibson.dropbear.id.au>
	<CAGZKiBpsD56N2o2xD8dpuuxp+isKF-2L0EtioVuo+sCJsxT4tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
In-Reply-To: <CAGZKiBpsD56N2o2xD8dpuuxp+isKF-2L0EtioVuo+sCJsxT4tQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] pseries: Implement HPT
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata.rao@gmail.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, sjitindarsingh@gmail.com, Alexander Graf <agraf@suse.de>


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 03:37:16PM +0530, Bharata B Rao wrote:
> On Fri, Mar 10, 2017 at 6:43 AM, David Gibson <david@gibson.dropbear.id.a=
u>
> wrote:
>=20
> > This patch implements hypercalls allowing a PAPR guest to resize its own
> > hash page table.  This will eventually allow for more flexible memory
> > hotplug.
> >
> > The implementation is partially asynchronous, handled in a special thre=
ad
> > running the hpt_prepare_thread() function.  The state of a pending resi=
ze
> > is stored in SPAPR_MACHINE->pending_hpt.
> >
> > The H_RESIZE_HPT_PREPARE hypercall will kick off creation of a new HPT,=
 or,
> > if one is already in progress, monitor it for completion.  If there is =
an
> > existing HPT resize in progress that doesn't match the size specified in
> > the call, it will cancel it, replacing it with a new one matching the
> > given size.
> >
> > The H_RESIZE_HPT_COMMIT completes transition to a resized HPT, and can =
only
> > be called successfully once H_RESIZE_HPT_PREPARE has successfully
> > completed initialization of a new HPT.  The guest must ensure that there
> > are no concurrent accesses to the existing HPT while this is called (th=
is
> > effectively means stop_machine() for Linux guests).
> >
> > For now H_RESIZE_HPT_COMMIT goes through the whole old HPT, rehashing e=
ach
> > HPTE into the new HPT.  This can have quite high latency, but it seems =
to
> > be of the order of typical migration downtime latencies for HPTs of size
> > up to ~2GiB (which would be used in a 256GiB guest).
> >
> > In future we probably want to move more of the rehashing to the "prepar=
e"
> > phase, by having H_ENTER and other hcalls update both current and
> > pending HPTs.  That's a project for another day, but should be possible
> > without any changes to the guest interface.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c          |   4 +-
> >  hw/ppc/spapr_hcall.c    | 338 ++++++++++++++++++++++++++++++
> > +++++++++++++++++-
> >  include/hw/ppc/spapr.h  |   6 +
> >  target/ppc/mmu-hash64.h |   4 +
> >  4 files changed, 346 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 06b436d..bf6ba64 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -94,8 +94,6 @@
> >
> >  #define PHANDLE_XICP            0x00001111
> >
> > -#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> > -
> >  static int try_create_xics(sPAPRMachineState *spapr, const char
> > *type_ics,
> >                             const char *type_icp, int nr_servers,
> >                             int nr_irqs, Error **errp)
> > @@ -1169,7 +1167,7 @@ static void spapr_store_hpte(PPCVirtualHypervisor
> > *vhyp, hwaddr ptex,
> >      }
> >  }
> >
> > -static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> > +int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> >  {
> >      int shift;
> >
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 9f88960..4c0b0fb 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -3,6 +3,7 @@
> >  #include "sysemu/hw_accel.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/log.h"
> > +#include "qemu/error-report.h"
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> >  #include "helper_regs.h"
> > @@ -352,20 +353,316 @@ static target_ulong h_read(PowerPCCPU *cpu,
> > sPAPRMachineState *spapr,
> >      return H_SUCCESS;
> >  }
> >
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
> > +    if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt =3D=3D pending)=
 {
> > +        /* Ready to go */
> > +        pending->complete =3D true;
> > +    } else {
> > +        /* We've been cancelled, clean ourselves up */
> > +        free_pending_hpt(pending);
> > +    }
> > +
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
> >
>=20
> You could use the existing API pc_existing_dimms_capacity() for the
> above.

Good idea, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx3lqAAoJEGw4ysog2bOS6HwQALcg6wGnbQJ3DpmjoPISGHBw
UZud0acCo0/b15SVxMBCciMAPOmHGJFvbn5Lgrnok8+E9O+BA62W86/7P34Q35qh
QvVcsngolcPp2WLWbThvH6FBt9OhLTssq7Res79CqyD/K/ztr/QGNoiScImON7ne
X/Qq6dbxUA2wkp6PQahMjB9M3x5FK1kOfXcUK3DAAuILOUl6b2PYa6TnlJqz8IX1
xYByMTS3oW5hnoqR6cXuMTRtAcTpvNDJ1GQwTg+ncVeSlOddWfxnY/WbP4cDGiNT
SUJ+fRKuCECnd9LixZ/dAHkujepmvSUbhM4VXm92qyosW11Lo8nXaB5h11OnaU6B
6oOgtVrc6xoN/zVUGuffIN8HnkcM9ay7UenvrV/hkC54J8cwA3Y3CfdvPQ6ywvlE
nLaHISAAI7Mm4Z2TUC3C/sefzvt5Fp6hhzBomsasgqNt7LmKxeyU05E6F56iEnlX
kXoaqj3RyI+yIq8gmEthwAYU4nZowyUcHtkRL1y50VpmOlQjCY2bt1uPOe3RjH82
RkPRrQEi9IRfcDx8TklLdkbc+4+6Dp9B99ys5ddEr+U/TeVVlXBJDU3dVNQR+jls
z62+5THIDx6aW4yjLpF9ihDtzyE7CbZno2U3gzTW35taLj9opxK+5kwAkJ0uW9/B
q3FP3DstmysiTeAgkogV
=umzW
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
