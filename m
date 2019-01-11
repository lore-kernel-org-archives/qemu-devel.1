Received: from eggs.gnu.org ([209.51.188.92]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpc-0005aZ-0K
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpZ-0003Ss-MC
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:51 -0500
Date: Fri, 11 Jan 2019 11:17:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111001716.GK6682@umbus.fritz.box>
References: <1547111736-3962-1-git-send-email-thuth@redhat.com>
	<1547111736-3962-3-git-send-email-thuth@redhat.com>
	<20190110132838.31365c55@bahia.lan>
	<8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline
In-Reply-To: <8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 03:07:59PM +0100, Thomas Huth wrote:
> On 2019-01-10 14:15, Greg Kurz wrote:
> > On Thu, 10 Jan 2019 10:15:35 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >=20
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
> >>
> >=20
> > Hmm... so the choice here is to simply ignore the official coding
> > style ?
>=20
> Are typedefs really our "official coding style"? It's mentioned in
> HACKING, not in CODING_STYLE, so I rather see this as a recommendation
> only. (Otherwise, all the forward struct definitions at the beginning of
> spapr.h are a plain violation of the coding style, too...)

I'd say it's definitely qemu coding style in practice, whatever you
argue about the wording in the docs.

> IMHO we should rather adopt the coding style of the kernel which rather
> tries to avoid to typedef each and every struct.
>=20
> > It is a bit confusing to end up with even more struct/non-struct
> > inconsistency. It would be good at least to update HACKING so that
> > people know when they can legitimately do that... or we simply don't
> > care anymore for the typedef rule ?
>=20
> We should maybe limit the recommendation for the typedefs to things that
> we mainly need in common code and that also fit into
> include/qemu/typedefs.h nicely. If we agree on that, I could send an
> update for the HACKING file.
>=20
> > All these forward declarations could be typedefs in a "hw/ppc/spapr_typ=
es.h"
> > header as well, as suggested elsewhere by Daniel.
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
> >> -typedef struct ICSState ICSState;
> >=20
> > Thanks to the previous patch, I guess the ICSState type could be
> > obtained by including "hw/ppc/xics.h".
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
> >>      qemu_irq *qirqs;
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
> >> +struct ICPState;
> >=20
> > These could be made available from the XICS/XIVE header files.
> >=20
> > #ifndef CONFIG_USER_ONLY
> > #include "hw/ppc/xive.h" /* for XiveTCTX */
> > #include "hw/ppc/xics.h" /* for ICPState */
> > #endif
>=20
> Ok, I can change it if we agree that normal struct forward declarations
> are a no-go. Otherwise, I'd prefer the non-typedeffed struct forward
> declarations here, I think.
>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw34IwACgkQbDjKyiDZ
s5KNKBAAtmNyvIoQrGUMkK6WE77yJgKXeZSR25oeVbqiWDsxlGZUEpDKXTUG3k9Y
MmIrpjd+AmGh/xfm0xvuxjyX3E17RkxPwQ5mzxX+FwItl6DOZ9IXGdp8w4Oz/5pi
nKP3W31GK+AW3TZ2B4ueSVJIoRVadd5+K8ruYK6OrdtfS8TDzVtmSFleFHMD6jk9
gW8P7T5JJ9LjP6rkfHN6bnS6IK2W52xCAJ+DIRZHfOwGFkxeP38AvZgEP64chyhC
wINDGKR0ZB/ME/b8CCjS+xH6MGoQqSRiDAHwNsTB709xa4HMorsrnwOMTZo/kbsP
RJu4gThjmD11jgAzYUSDMLyateyGxPsObZMAmTGfujx44ETMXzYAXQ1HG+PjJa1s
6i5xp9EtiHPbVq57grKlJXv8suEFSLTExw3YNwhribFAMRfSIdhWB6JjzffyXQur
Q5EqE+GrK4+zLCGfIzZoelseyUJjOmoFJGzc2j3cUU60aNVQfVrvJMGGqywPY4r5
TQf0ATrVjaP9GtBLGK95+4wnVRB/9Zr+haMF8AqgwgMmjnsNQGudO813VGFI717C
m9V3X2hu2jltXmKoQgAb8TVdjEYw1S32Lu5qdiwKAGT1NX6NwLrVSHeKFYyd9DtB
oUKCYMoBJBJvkc0IhOIjJac947hlIvqgyrM8MwG6my9+devXHqM=
=JG8+
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--
