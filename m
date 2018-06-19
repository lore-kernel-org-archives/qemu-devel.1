Received: from eggs.gnu.org ([2001:4830:134:3::10]:35017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4aG-0002x1-Tg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4aC-0000vp-KE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:33:20 -0400
Date: Tue, 19 Jun 2018 10:30:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619003002.GK25461@umbus.fritz.box>
References: <152932479544.500483.1342368406182952616.stgit@bahia.lan>
	<152932480918.500483.5347446234353746966.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Umuxdmn6ztF4e1GK"
Content-Disposition: inline
In-Reply-To: <152932480918.500483.5347446234353746966.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr_cpu_core: migrate VPA related
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Umuxdmn6ztF4e1GK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 02:26:49PM +0200, Greg Kurz wrote:
> QEMU implements the "Shared Processor LPAR" (SPLPAR) option, which allows
> the hypervisor to time-slice a physical processor into multiple virtual
> processor. The intent is to allow more guests to run, and to optimize
> processor utilization.
>=20
> The guest OS can cede idle VCPUs, so that their processing capacity may
> be used by other VCPUs, with the H_CEDE hcall. The guest OS can also
> optimize spinlocks, by confering the time-slice of a spinning VCPU to the
> spinlock holder if it's currently notrunning, with the H_CONFER hcall.
>=20
> Both hcalls depend on a "Virtual Processor Area" (VPA) to be registered
> by the guest OS, generally during early boot. Other per-VCPU areas can
> be registered: the "SLB Shadow Buffer" which allows a more efficient
> dispatching of VCPUs, and the "Dispatch Trace Log Buffer" (DTL) which
> is used to compute time stolen by the hypervisor. Both DTL and SLB Shadow
> areas depend on the VPA to be registered.
>=20
> The VPA/SLB Shadow/DTL are state that QEMU should migrate, but this doesn=
't
> happen, for no apparent reason other than it was just never coded. This
> causes the features listed above to stop working after migration, and it
> breaks the logic of the H_REGISTER_VPA hcall in the destination.
>=20
> The VPA is set at the guest request, ie, we don't have to migrate
> it before the guest has actually set it. This patch hence adds an
> "spapr_cpu/vpa" subsection to the recently introduced per-CPU machine
> data migration stream.
>=20
> Since DTL and SLB Shadow are optional and both depend on VPA, they get
> their own subsections "spapr_cpu/vpa/slb_shadow" and "spapr_cpu/vpa/dtl"
> hanging from the "spapr_cpu/vpa" subsection.
>=20
> Note that this won't break migration to older QEMUs. Is is already handled
> by only registering the vmstate handler for per-CPU data with newer machi=
ne
> types.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c |   65 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 96d1dfad00e1..f7e7b739ae49 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -129,6 +129,67 @@ static void spapr_cpu_core_unrealize(DeviceState *de=
v, Error **errp)
>      g_free(sc->threads);
>  }
> =20
> +static bool slb_shadow_needed(void *opaque)
> +{
> +    sPAPRCPUState *spapr_cpu =3D opaque;
> +
> +    return spapr_cpu->slb_shadow_addr !=3D 0;
> +}
> +
> +static const VMStateDescription vmstate_spapr_cpu_slb_shadow =3D {
> +    .name =3D "spapr_cpu/vpa/slb_shadow",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D slb_shadow_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(slb_shadow_addr, sPAPRCPUState),
> +        VMSTATE_UINT64(slb_shadow_size, sPAPRCPUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool dtl_needed(void *opaque)
> +{
> +    sPAPRCPUState *spapr_cpu =3D opaque;
> +
> +    return spapr_cpu->dtl_addr !=3D 0;
> +}
> +
> +static const VMStateDescription vmstate_spapr_cpu_dtl =3D {
> +    .name =3D "spapr_cpu/vpa/dtl",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D dtl_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(dtl_addr, sPAPRCPUState),
> +        VMSTATE_UINT64(dtl_size, sPAPRCPUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool vpa_needed(void *opaque)
> +{
> +    sPAPRCPUState *spapr_cpu =3D opaque;
> +
> +    return spapr_cpu->vpa_addr !=3D 0;
> +}
> +
> +static const VMStateDescription vmstate_spapr_cpu_vpa =3D {
> +    .name =3D "spapr_cpu/vpa",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D vpa_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(vpa_addr, sPAPRCPUState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription * []) {
> +        &vmstate_spapr_cpu_slb_shadow,
> +        &vmstate_spapr_cpu_dtl,
> +        NULL
> +    }
> +};
> +
>  static const VMStateDescription vmstate_spapr_cpu_state =3D {
>      .name =3D "spapr_cpu",
>      .version_id =3D 1,
> @@ -136,6 +197,10 @@ static const VMStateDescription vmstate_spapr_cpu_st=
ate =3D {
>      .fields =3D (VMStateField[]) {
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections =3D (const VMStateDescription * []) {
> +        &vmstate_spapr_cpu_vpa,
> +        NULL
> +    }
>  };
> =20
>  static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Umuxdmn6ztF4e1GK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoTokACgkQbDjKyiDZ
s5LD0A//SDamxaR4bI7YIiMwnibHAdVxFQ80wkOLiJv8pJSucG+zeWYRN82VsNhq
Mgu0NQmVhGoNbXUydloowuOL6gAQl3v+jbobATAQ/nAPg1gIhZQ4cedUynCKO+3p
DeThloIBe7aKpUvIVyFDoL5eTvnvjucWQsassXuMOUy1cv3TNo/DvFq3yY1pQHap
wK+TMmHYpiJbIG0bdIZa+p2P3rQvX/7PyHzoDqDmALeDJygj56uwZy871OpDkURA
yxmAJiBrHcYcEBzux9Jto9KE7uMC6ZSRRBdeRFGDoZXNj47c89F09ubO7zcp88Cw
XBjArTopGIGyCEEtLOlZ3ZLNHWfAOX4sajQ0E3qZPyVkmtRcE3h/FDfg5atgRnLA
bbSX/UTcZdEG19aU0/A/whmW8FSylFyzUrbRXVZ2onzgLqsScW7jkuajFFy9N+u2
0VTidHlwPOVaIxwkzHxGBzSH1mYYVFFrH7+nyBmx0TiPHHf7GqnX5qqAAacxiCAN
GRBk9Bo3ZSUNXICH3tR9lxdndDjA7RSuyLVH9WgiJDXvFFXwJV4bRvlU4VN6VrWQ
wVbOuBfdtKplQJ30i659BxSqXU68jR9jLZcqqVDG5XWAg0GSkrOFB/46dAb5MghJ
0m56Ntj+OIoBFUylR5AnKxud5LkTOWUgJ2/lWBGKuw4dQQokQFE=
=63Am
-----END PGP SIGNATURE-----

--Umuxdmn6ztF4e1GK--
