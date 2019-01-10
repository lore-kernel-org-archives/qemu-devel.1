Received: from eggs.gnu.org ([209.51.188.92]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghcmG-0003mj-TN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghcm9-0000Z8-Bh
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:01:49 -0500
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:48853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ghcm0-0000MB-2x
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:01:37 -0500
Received: from player750.ha.ovh.net (unknown [10.109.159.136])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7AC7820E1E4
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 17:01:11 +0100 (CET)
Date: Thu, 10 Jan 2019 17:00:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190110170054.232da6a0@bahia.lan>
In-Reply-To: <8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
References: <1547111736-3962-1-git-send-email-thuth@redhat.com>
	<1547111736-3962-3-git-send-email-thuth@redhat.com>
	<20190110132838.31365c55@bahia.lan>
	<8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] ppc: Drop duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "Daniel P.
	=?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 10 Jan 2019 15:07:59 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 2019-01-10 14:15, Greg Kurz wrote:
> > On Thu, 10 Jan 2019 10:15:35 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >  =20
> >> When compiling the ppc code with clang and -std=3Dgnu99, there are a
> >> couple of warnings/errors like this one:
> >>
> >>   CC      ppc64-softmmu/hw/intc/xics.o
> >> In file included from /home/thuth/devel/qemu/hw/intc/xics.c:35:
> >> /home/thuth/devel/qemu/include/hw/ppc/xics.h:43:25: error: redefinitio=
n of typedef 'ICPState' is a C11 feature
> >>       [-Werror,-Wtypedef-redefinition]
> >> typedef struct ICPState ICPState;
> >>                         ^
> >> /home/thuth/devel/qemu/target/ppc/cpu.h:1181:25: note: previous defini=
tion is here
> >> typedef struct ICPState ICPState;
> >>                         ^
> >>
> >> Drop the duplicated typedefs and use normal "struct" forward declarati=
ons
> >> like we already do it at the top of spapr.h for a couple of other defi=
nitions.
> >> =20
> >=20
> > Hmm... so the choice here is to simply ignore the official coding
> > style ? =20
>=20
> Are typedefs really our "official coding style"? It's mentioned in
> HACKING, not in CODING_STYLE, so I rather see this as a recommendation

Indeed.

> only. (Otherwise, all the forward struct definitions at the beginning of
> spapr.h are a plain violation of the coding style, too...)
>=20

Yeah.

> IMHO we should rather adopt the coding style of the kernel which rather
> tries to avoid to typedef each and every struct.
>=20

=46rom https://www.kernel.org/doc/html/latest/process/coding-style.html#typed=
efs :

"In general, a pointer, or a struct that has elements that can reasonably be
 directly accessed should never be a typedef."

So if we were to adopt the coding style of the kernel, we'd have to face a
lot more violations with the current QEMU code base :)

> > It is a bit confusing to end up with even more struct/non-struct
> > inconsistency. It would be good at least to update HACKING so that
> > people know when they can legitimately do that... or we simply don't
> > care anymore for the typedef rule ? =20
>=20
> We should maybe limit the recommendation for the typedefs to things that
> we mainly need in common code and that also fit into
> include/qemu/typedefs.h nicely. If we agree on that, I could send an
> update for the HACKING file.
>=20

Makes sense.

> > All these forward declarations could be typedefs in a "hw/ppc/spapr_typ=
es.h"
> > header as well, as suggested elsewhere by Daniel. =20
>=20
> I'd prefer to rather get rid of the typedefs in this case instead of
> introducing spapr_types.h ... but if other ppc folks are also keen on
> that file (David?), I can rework my patch to introduce it.
>=20
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 9e01a5a..10d069e 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -12,11 +12,12 @@
> >>  struct VIOsPAPRBus;
> >>  struct sPAPRPHBState;
> >>  struct sPAPRNVRAM;
> >> +struct ICSState;
> >> +struct sPAPRXive;
> >> +
> >>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
> >>  typedef struct sPAPREventSource sPAPREventSource;
> >>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> >> -typedef struct ICSState ICSState; =20
> >=20
> > Thanks to the previous patch, I guess the ICSState type could be
> > obtained by including "hw/ppc/xics.h". =20
>=20
> There are already plenty of other struct forward declarations without
> typedefs here, so I assume my changes are ok here. David?
>=20
> >> -typedef struct sPAPRXive sPAPRXive;
> >> =20
> >>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
> >>  #define SPAPR_ENTRY_POINT       0x100
> >> @@ -127,7 +128,7 @@ struct sPAPRMachineState {
> >>      struct VIOsPAPRBus *vio_bus;
> >>      QLIST_HEAD(, sPAPRPHBState) phbs;
> >>      struct sPAPRNVRAM *nvram;
> >> -    ICSState *ics;
> >> +    struct ICSState *ics;
> >>      sPAPRRTCState rtc;
> >> =20
> >>      sPAPRResizeHPT resize_hpt;
> >> @@ -180,7 +181,7 @@ struct sPAPRMachineState {
> >>      const char *icp_type;
> >>      int32_t irq_map_nr;
> >>      unsigned long *irq_map;
> >> -    sPAPRXive  *xive;
> >> +    struct sPAPRXive  *xive;
> >>      sPAPRIrq *irq;
> >>      qemu_irq *qirqs; =20
> [...]
> >> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >> index 486abaf..a62ff60 100644
> >> --- a/target/ppc/cpu.h
> >> +++ b/target/ppc/cpu.h
> >> @@ -1177,8 +1177,9 @@ do {                                            \
> >> =20
> >>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
> >>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> >> -typedef struct XiveTCTX XiveTCTX;
> >> -typedef struct ICPState ICPState;
> >> +
> >> +struct XiveTCTX;
> >> +struct ICPState; =20
> >=20
> > These could be made available from the XICS/XIVE header files.
> >=20
> > #ifndef CONFIG_USER_ONLY
> > #include "hw/ppc/xive.h" /* for XiveTCTX */
> > #include "hw/ppc/xics.h" /* for ICPState */
> > #endif =20
>=20
> Ok, I can change it if we agree that normal struct forward declarations
> are a no-go. Otherwise, I'd prefer the non-typedeffed struct forward
> declarations here, I think.
>=20

Sure.

>  Thomas
