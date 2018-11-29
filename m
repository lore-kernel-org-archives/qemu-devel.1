Received: from eggs.gnu.org ([2001:4830:134:3::10]:53008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVAF-0007yy-0J
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVA9-00080d-HR
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:06 -0500
Date: Fri, 30 Nov 2018 09:39:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129223947.GM14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-16-clg@kaod.org>
	<20181128032819.GY2251@umbus.fritz.box>
	<c8f9532c-a27d-0071-0023-25f8b70cb31d@kaod.org>
	<20181129010758.GO2251@umbus.fritz.box>
	<aff0fc45-46b0-fdd0-525c-1ab7923b7e90@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+utxuhC6KVTvgNz"
Content-Disposition: inline
In-Reply-To: <aff0fc45-46b0-fdd0-525c-1ab7923b7e90@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 15/36] spapr: introdude a new machine
 IRQ backend for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--m+utxuhC6KVTvgNz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 04:34:51PM +0100, C=E9dric Le Goater wrote:
> On 11/29/18 2:07 AM, David Gibson wrote:
> > On Wed, Nov 28, 2018 at 06:16:58PM +0100, C=E9dric Le Goater wrote:
> >> On 11/28/18 4:28 AM, David Gibson wrote:
> >>> On Fri, Nov 16, 2018 at 11:57:08AM +0100, C=E9dric Le Goater wrote:
> >>>> The XIVE IRQ backend uses the same layout as the new XICS backend but
> >>>> covers the full range of the IRQ number space. The IRQ numbers for t=
he
> >>>> CPU IPIs are allocated at the bottom of this space, below 4K, to
> >>>> preserve compatibility with XICS which does not use that range.
> >>>>
> >>>> This should be enough given that the maximum number of CPUs is 1024
> >>>> for the sPAPR machine under QEMU. For the record, the biggest POWER8
> >>>> or POWER9 system has a maximum of 1536 HW threads (16 sockets, 192
> >>>> cores, SMT8).
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  include/hw/ppc/spapr.h     |   2 +
> >>>>  include/hw/ppc/spapr_irq.h |   7 ++-
> >>>>  hw/ppc/spapr.c             |   2 +-
> >>>>  hw/ppc/spapr_irq.c         | 119 ++++++++++++++++++++++++++++++++++=
++-
> >>>>  4 files changed, 124 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>> index 6279711fe8f7..1fbc2663e06c 100644
> >>>> --- a/include/hw/ppc/spapr.h
> >>>> +++ b/include/hw/ppc/spapr.h
> >>>> @@ -16,6 +16,7 @@ typedef struct sPAPREventLogEntry sPAPREventLogEnt=
ry;
> >>>>  typedef struct sPAPREventSource sPAPREventSource;
> >>>>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> >>>>  typedef struct ICSState ICSState;
> >>>> +typedef struct sPAPRXive sPAPRXive;
> >>>> =20
> >>>>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
> >>>>  #define SPAPR_ENTRY_POINT       0x100
> >>>> @@ -175,6 +176,7 @@ struct sPAPRMachineState {
> >>>>      const char *icp_type;
> >>>>      int32_t irq_map_nr;
> >>>>      unsigned long *irq_map;
> >>>> +    sPAPRXive  *xive;
> >>>> =20
> >>>>      bool cmd_line_caps[SPAPR_CAP_NUM];
> >>>>      sPAPRCapabilities def, eff, mig;
> >>>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >>>> index 0e9229bf219e..c854ae527808 100644
> >>>> --- a/include/hw/ppc/spapr_irq.h
> >>>> +++ b/include/hw/ppc/spapr_irq.h
> >>>> @@ -13,6 +13,7 @@
> >>>>  /*
> >>>>   * IRQ range offsets per device type
> >>>>   */
> >>>> +#define SPAPR_IRQ_IPI        0x0
> >>>>  #define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
> >>>>  #define SPAPR_IRQ_HOTPLUG    0x1001
> >>>>  #define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
> >>>> @@ -33,7 +34,8 @@ typedef struct sPAPRIrq {
> >>>>      uint32_t    nr_irqs;
> >>>>      uint32_t    nr_msis;
> >>>> =20
> >>>> -    void (*init)(sPAPRMachineState *spapr, int nr_irqs, Error **err=
p);
> >>>> +    void (*init)(sPAPRMachineState *spapr, int nr_irqs, int nr_serv=
ers,
> >>>> +                 Error **errp);
> >>>>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error=
 **errp);
> >>>>      void (*free)(sPAPRMachineState *spapr, int irq, int num);
> >>>>      qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
> >>>> @@ -42,8 +44,9 @@ typedef struct sPAPRIrq {
> >>>> =20
> >>>>  extern sPAPRIrq spapr_irq_xics;
> >>>>  extern sPAPRIrq spapr_irq_xics_legacy;
> >>>> +extern sPAPRIrq spapr_irq_xive;
> >>>> =20
> >>>> -void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
> >>>> +void spapr_irq_init(sPAPRMachineState *spapr, int nr_servers, Error=
 **errp);
> >>>
> >>> I don't see why nr_servers needs to become a parameter, since it can
> >>> be derived from spapr within this routine.
> >>
> >> ok. This is true. We can use directly xics_max_server_number(spapr).
> >>
> >>>>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Er=
ror **errp);
> >>>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> >>>>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index e470efe7993c..9f8c19e56e7a 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -2594,7 +2594,7 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>>>      spapr_set_vsmt_mode(spapr, &error_fatal);
> >>>> =20
> >>>>      /* Set up Interrupt Controller before we create the VCPUs */
> >>>> -    spapr_irq_init(spapr, &error_fatal);
> >>>> +    spapr_irq_init(spapr, xics_max_server_number(spapr), &error_fat=
al);
> >>>
> >>> We should rename xics_max_server_number() since it's no longer xics
> >>> specific.
> >>
> >> yes.
> >>
> >>>>      /* Set up containers for ibm,client-architecture-support negoti=
ated options
> >>>>       */
> >>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >>>> index bac450ffff23..2569ae1bc7f8 100644
> >>>> --- a/hw/ppc/spapr_irq.c
> >>>> +++ b/hw/ppc/spapr_irq.c
> >>>> @@ -12,6 +12,7 @@
> >>>>  #include "qemu/error-report.h"
> >>>>  #include "qapi/error.h"
> >>>>  #include "hw/ppc/spapr.h"
> >>>> +#include "hw/ppc/spapr_xive.h"
> >>>>  #include "hw/ppc/xics.h"
> >>>>  #include "sysemu/kvm.h"
> >>>> =20
> >>>> @@ -91,7 +92,7 @@ error:
> >>>>  }
> >>>> =20
> >>>>  static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_ir=
qs,
> >>>> -                                Error **errp)
> >>>> +                                int nr_servers, Error **errp)
> >>>>  {
> >>>>      MachineState *machine =3D MACHINE(spapr);
> >>>>      Error *local_err =3D NULL;
> >>>> @@ -204,10 +205,122 @@ sPAPRIrq spapr_irq_xics =3D {
> >>>>      .print_info  =3D spapr_irq_print_info_xics,
> >>>>  };
> >>>> =20
> >>>> + /*
> >>>> + * XIVE IRQ backend.
> >>>> + */
> >>>> +static sPAPRXive *spapr_xive_create(sPAPRMachineState *spapr,
> >>>> +                                    const char *type_xive, int nr_i=
rqs,
> >>>> +                                    int nr_servers, Error **errp)
> >>>> +{
> >>>> +    sPAPRXive *xive;
> >>>> +    Error *local_err =3D NULL;
> >>>> +    Object *obj;
> >>>> +    uint32_t nr_ends =3D nr_servers << 3; /* 8 priority ENDs per CP=
U */
> >>>> +    int i;
> >>>> +
> >>>> +    obj =3D object_new(type_xive);
> >>>
> >>> What's the reason for making the type a parameter, rather than just
> >>> using the #define here.
> >>
> >> KVM.
> >=20
> > Yeah, I realised that when I'd read a few patches further on.  As I
> > commented there, I don't think the separate KVM/TCG subclasses is
> > actually a good pattern to follow.
>=20
> I will use the simple pattern in next spin: if (kvm) { }=20

Great.

> We might want to do that for XICS also but it would break migratibility. =
=20

Well, if that breaks migration, we already have a problem migrating
between KVM and non-KVM guests (or even KVM-with-irqchip and
KVM-without-irqchip guests).  I think we put the actual migratable
state in the base class to avoid that, but we should check.  If we
ever get time.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m+utxuhC6KVTvgNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAarMACgkQbDjKyiDZ
s5IBmhAAvBSP9Hd2hDBzdYB93YqtL+/RXVCXeiTSND/YoPGQ1QzMQm6NWqMnY4qf
/Af2VivA0CpBAGmP3gyKhMvYeHzGNM1FZp6454zeL843uQN5iq7t68p26FvswC0X
gh/QPJk+LvS46Ouh8MrCeloxRausOe0Vz5UmxIOPsUOjlTzW3A+y9eeJzfvAfCvF
tk63zDeKsXJAdj35SOXrPUdVZW7pBPfdvP5V02fIIg/kT3CSvAECVKcVx6xgMGk/
JgJFu3AANnQof2LqnmJPwjOqL9Z9F5KZiSbocLziEOykDooKhgieaKpwiNtdyc+/
Nr/wgjr5go/Vj+wKKczlnfKAwrSH+wap5EeRq97B614MTWWdK1k8s3rnTrab98Mg
Bj7nOKNhEbh5HeO5YD4Lzh/XRBwCWm4+sVg2IywyXTQyLileg9I83cqIulQTk2ZL
dmSvDJc/SLuLZhk9lLXzJ91mQ1mH1BZOQDt8cR+/Ut57FojazkfqGTfiAktsO/u2
7bGvlrY7KkKaL5kTaZmZAooKvvh+lv/Z3NzrQONXtOdf7el52CRhSvtEoFfafiNT
OGGxACzc+WAaHX1SLNY+WqlPagQ9e4xt2yDLZQ9bcVkx9XT3f2x/ikNLOPHGKiEb
2KvvY8kd7TbQTi9fG05SQYQz6e7/FZ6n7LrHzOmd9BCARI1pFfU=
=A1Gc
-----END PGP SIGNATURE-----

--m+utxuhC6KVTvgNz--
