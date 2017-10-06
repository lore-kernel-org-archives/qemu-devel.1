Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCy-0002cT-RX
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0005Gi-LE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:52 -0400
Date: Fri, 6 Oct 2017 14:16:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006031613.GN3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ukZ3tWq1IjZw6zEx"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-12-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/23] ppc: spapr: replace
 ppc_cpu_parse_features() with cpu_parse_cpu_model()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--ukZ3tWq1IjZw6zEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:38PM +0200, Igor Mammedov wrote:
> ppc_cpu_parse_features() is doing practically the same thing as
> generic cpu_parse_cpu_model(). So remove duplicated impl. and
> reuse generic one.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/ppc.h    |  2 --
>  hw/ppc/ppc.c            | 25 -------------------------
>  hw/ppc/spapr_cpu_core.c |  9 ++++-----
>  3 files changed, 4 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 4e7fe11..ff0ac30 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -105,6 +105,4 @@ enum {
> =20
>  /* ppc_booke.c */
>  void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flag=
s);
> -
> -void ppc_cpu_parse_features(const char *cpu_model);
>  #endif
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 05da316..7ec35de 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1359,28 +1359,3 @@ void PPC_debug_write (void *opaque, uint32_t addr,=
 uint32_t val)
>          break;
>      }
>  }
> -
> -void ppc_cpu_parse_features(const char *cpu_model)
> -{
> -    CPUClass *cc;
> -    ObjectClass *oc;
> -    const char *typename;
> -    gchar **model_pieces;
> -
> -    model_pieces =3D g_strsplit(cpu_model, ",", 2);
> -    if (!model_pieces[0]) {
> -        error_report("Invalid/empty CPU model name");
> -        exit(1);
> -    }
> -
> -    oc =3D cpu_class_by_name(TYPE_POWERPC_CPU, model_pieces[0]);
> -    if (oc =3D=3D NULL) {
> -        error_report("Unable to find CPU definition: %s", model_pieces[0=
]);
> -        exit(1);
> -    }
> -
> -    typename =3D object_class_get_name(oc);
> -    cc =3D CPU_CLASS(oc);
> -    cc->parse_features(typename, model_pieces[1], &error_fatal);
> -    g_strfreev(model_pieces);
> -}
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3e20b1d..3dea5ff 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -34,6 +34,7 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
>       *   before passing it on to the cpu level parser.
>       */
>      gchar **inpieces;
> +    gchar *newprops;
>      int i, j;
>      gchar *compat_str =3D NULL;
> =20
> @@ -58,17 +59,15 @@ void spapr_cpu_parse_features(sPAPRMachineState *spap=
r)
> =20
>      if (compat_str) {
>          char *val =3D compat_str + strlen("compat=3D");
> -        gchar *newprops =3D g_strjoinv(",", inpieces);
> =20
>          object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
>                                  &error_fatal);
> =20
> -        ppc_cpu_parse_features(newprops);
> -        g_free(newprops);
> -    } else {
> -        ppc_cpu_parse_features(MACHINE(spapr)->cpu_model);
>      }
> =20
> +    newprops =3D g_strjoinv(",", inpieces);
> +    cpu_parse_cpu_model(TYPE_POWERPC_CPU, newprops);
> +    g_free(newprops);
>      g_strfreev(inpieces);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ukZ3tWq1IjZw6zEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW9X0ACgkQbDjKyiDZ
s5Lgww//THpEkDT/5beg+dNQhvyqbgt6CAzhIyNBNn+a/ejna2wB26j4+9L3uq24
7qF1f+9wmPmKgtXT+bBBS8gtyIsh1Y3aD3PsaPqWtKBcuUCNN+0ElxjkvmRvGCr9
1hCotNbB7INXiCvYXuLEfhgnbncC/9vqNwXkd2/IMoE7lOxT9aAxckxk9tZJaxQH
agXwxRhY3FPKTpx4AdGpuNIAOa5bhViPoCxjDlA2mugsMZluV97JFhqwu//Ajj/+
7An7fwQdHl2tuUrTOCSV3JAJnedEyeSsfQvdyDVBtCgICwXRb6tuIceBNX2AfuSm
88c3O5pfSdv2wBPRTmo2LZwDIZCN5DiQA32oErq8cgyTIJ6dwLB4rjyjXKgQ2iKs
kIUkL97Rh5u3XgjBAK3J8VMZGzEn+nsLs6a14KCvZN1aDxDHymzpd82jCx1ukIl7
hUgHsYpc6M9Clm7tVdAGqKKTSvHnn1S5SgOa/Ir1PeUDgfNHsWC2vaZzegMietW0
rBm/tUp8jjXYojGcVnlIRdpGQd7wJ3wTb4DMYQBaOkRAFqccGfqf1r3PADDBlBZt
ImT4soo2KLc8NfQddvX/+6kyYFTZQQxRxTmaL507WGmtCgUlpZa/CfBLaLDfNVjq
Pm017IXQZLi21lILeVBgWBIR9U6RPjz0OeZEzWpx0yOpTjILsTQ=
=/Iia
-----END PGP SIGNATURE-----

--ukZ3tWq1IjZw6zEx--
