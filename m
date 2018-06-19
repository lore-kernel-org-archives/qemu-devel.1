Received: from eggs.gnu.org ([2001:4830:134:3::10]:51299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV61d-00005Z-DI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV61c-0000Cs-8j
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:05:41 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
Message-ID: <152937387811.15330.6346338944477555198@sif>
Date: Mon, 18 Jun 2018 21:04:38 -0500
Subject: Re: [Qemu-devel] [PATCH for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2018-05-22 12:17:28)
> The spapr capability framework was introduced in QEMU 2.12. It allows
> to have an explicit control on how host features are exposed to the
> guest. This is especially needed to handle migration between hetero-
> geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> workarounds against speculative execution vulnerabilities to guests.
> The framework was hence backported to QEMU 2.11.1, especially these
> commits:
> =

> 0fac4aa93074 spapr: Add pseries-2.12 machine type
> 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
>  optional capability
> =

> 0fac4aa93074 has the confusing effect of making pseries-2.12 the default
> machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
> patch changes the default machine back to pseries-2.11.
> =

> Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11.
> This isn't supported by TCG and breaks 'make check'. So this patch also
> adds a hack to turn HTM off when using TCG.

I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12, I
get this on the target side even when specifying -machine
pseries-2.11,cap-htm=3Doff for both ends:

  qemu-system-ppc64: cap-htm higher level (1) in incoming stream than on de=
stination (0)
  qemu-system-ppc64: error while loading state for instance 0x0 of device '=
spapr'
  qemu-system-ppc64: load of migration failed: Invalid argument

I'm not sure we care all that much about it but it's a regression from 2.11=
.1
at least. The main issue seems to be the default caps for 2.11.2 for TCG are
now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed still assum=
es
everything is the same across all these versions and as such opts not to
migrate cap-htm=3Doff, since that's the default for 2.11.2. This results in=
 the
target assuming the source was using the default, which is cap-htm=3Don,
and since that disagrees with the spapr->eff we get a failure.

It seems spapr_cap_##cap##_needed needs to be fixed up to address that,
but I'm not sure how best to deal with backward compatibility in that case.
Any ideas? If it ends up being a trade-off I think forward compatibility is
more important.

> =

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c      |    4 ++--
>  hw/ppc/spapr_caps.c |    5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1a2dd1f597d9..6499a867520f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
>      /* Defaults for the latest behaviour inherited from the base class */
>  }
> =

> -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> =

>  /*
>   * pseries-2.11
> @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
> =

> -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> =

>  /*
>   * pseries-2.10
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 7b229517be38..82043e60e78b 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPR=
MachineState *spapr,
> =

>      caps =3D smc->default_caps;
> =

> +    /* HACK for 2.11.2: fix make check */
> +    if (tcg_enabled()) {
> +        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> +    }
> +
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
>                            0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>=20
