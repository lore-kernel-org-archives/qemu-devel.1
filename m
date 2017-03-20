Received: from eggs.gnu.org ([2001:4830:134:3::10]:52507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cpsCg-0004Ml-Em
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 03:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cpsCe-0006zZ-V5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 03:58:10 -0400
Date: Mon, 20 Mar 2017 17:40:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170320064040.GD29814@umbus.fritz.box>
References: <20170314053422.10922-1-david@gibson.dropbear.id.au>
	<20170314053422.10922-3-david@gibson.dropbear.id.au>
	<CAGZKiBrOrwpFntHkXspSdjmvPqhTeots+0rPqJa1j6G260keuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <CAGZKiBrOrwpFntHkXspSdjmvPqhTeots+0rPqJa1j6G260keuw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCHv2 for-2.10 2/5] pseries: Implement HPT
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, lvivier@redhat.com, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 12:44:18PM +0530, Bharata B Rao wrote:
> On Tue, Mar 14, 2017 at 11:04 AM, David Gibson <david@gibson.dropbear.id.=
au>
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
> >  hw/ppc/spapr_hcall.c    | 306 ++++++++++++++++++++++++++++++
> > +++++++++++++++++-
> >  include/hw/ppc/spapr.h  |   6 +
> >  target/ppc/mmu-hash64.h |   4 +
> >  4 files changed, 314 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 558109c..83db110 100644
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
> > index 9f88960..cdafc3f 100644
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
> > @@ -352,20 +353,286 @@ static target_ulong h_read(PowerPCCPU *cpu,
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
> >  static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
> >                                           sPAPRMachineState *spapr,
> >                                           target_ulong opcode,
> >                                           target_ulong *args)
> >  {
> >      target_ulong flags =3D args[0];
> > -    target_ulong shift =3D args[1];
> > +    int shift =3D args[1];
> > +    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > +    uint64_t current_ram_size;
> >
> >      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> >          return H_AUTHORITY;
> >      }
> >
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
> > +    current_ram_size =3D pc_existing_dimms_capacity(&error_fatal);
> > +
> > +    /* We only allow the guest to allocate an HPT one order above what
> > +     * we'd normally give them (to stop a small guest claiming a huge
> > +     * chunk of resources in the HPT */
> > +    if (shift > (spapr_hpt_shift_for_ramsize(current_ram_size) + 1)) {
> > +        return H_RESOURCE;
> > +    }
> >
>=20
> In your previous version, get_current_ram_size() returned ram_size + dimm
> size, but here,  pc_existing_dimms_capacity() gives only the dimm size. I
> guess you need to add ram_size to it ?

Oops, thanks for catching that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz3lmAAoJEGw4ysog2bOSc7kQAKepLE3RfAuIqwq1tRbvsRNI
kz2aZ2Dil8pZMM7/mNy8pWfL5dMTqN9t0o8YY+IXhsQOLu4WSZgO7dLLmJJuiO5i
yQBR4NgbY9dg7u8os6SRxPtF9TadL6C1DXw8PNQGgENfRuNa+adEV3u7H0MQakz8
IVRhe1nQkDCPqBUuRXCThGZDa28HwND+PJXODjSe/O+GowAIrsaqy2hFmD8DTGbE
d0kfujeuOztrQeLtMOzvSLSjp/jQFMUDI7pO1S+vzf+/+LmaEOMzoaValMqL+1Dj
B4HwvksNQhduoZyqJzxty20MNGe+R6ESItOkvAUAoPUuPQmq8VYrFmj+CT56hCtW
JbuAGfLr642k/HLGDiDiu3uf3q0DRzpooYfjdWnw5jzKsMzF4Gl8+4QYt78jTDjk
ZAnDJusApc91mhN80LONeD9bC5X5E+UNoKK99Mc/szZ3CsXyaUtcCUAkmfIiASqo
T4YWU7LPxH6HUylRxCS8vw56KFdNfw99FczsgbkvLqP/vWHIZ7jzQLwVPZ9R40mG
L00zmxCRc6iDhITv1TMrgRY9cYhmTxJqqrcdD7+rKjOyrHGfjTKxVTIbNF+mqWqS
6UkNj9FAk0JCHFHHUCw3p94xA1wh1YKs/yF6E1dZqMU+Dw6k5/jfhpyvQlmGxKRW
9O/9z7kMCiPP1/vXec8n
=0Jxk
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
