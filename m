Received: from eggs.gnu.org ([2001:4830:134:3::10]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUL-00006B-Fe
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUH-0005Yr-K5
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:57 -0500
Date: Fri, 10 Feb 2017 10:26:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209232616.GC27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] pc: move pcms->possible_cpus init out
 of pc_cpus_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, ehabkost@redhat.com, drjones@redhat.com, Marcel Apfelbaum <marcel@redhat.com>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:33PM +0100, Igor Mammedov wrote:
> possible_cpus could be initialized earlier then cpu objects,
> i.e. when -smp is parsed so move init code to possible_cpu_arch_ids()
> interface func and do initialization on the first call.
>=20
> it should help later with making -numa cpu/-smp parsing a machine state
> properties.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index cf2bec4..a6cfc97 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1144,7 +1144,9 @@ void pc_cpus_init(PCMachineState *pcms)
>      ObjectClass *oc;
>      const char *typename;
>      gchar **model_pieces;
> +    const CPUArchIdList *possible_cpus;
>      MachineState *machine =3D MACHINE(pcms);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
> =20
>      /* init CPUs */
>      if (machine->cpu_model =3D=3D NULL) {
> @@ -1179,14 +1181,9 @@ void pc_cpus_init(PCMachineState *pcms)
>       * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init=
().
>       */
>      pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
> -    machine->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> -                                       sizeof(CPUArchId) * max_cpus);
> -    for (i =3D 0; i < max_cpus; i++) {
> -        machine->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from=
_index(i);
> -        machine->possible_cpus->len++;
> -        if (i < smp_cpus) {
> -            pc_new_cpu(typename, x86_cpu_apic_id_from_index(i), &error_f=
atal);
> -        }
> +    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> +    for (i =3D 0; i < smp_cpus; i++) {
> +        pc_new_cpu(typename, possible_cpus->cpus[i].arch_id, &error_fata=
l);
>      }
>  }
> =20
> @@ -2248,10 +2245,26 @@ static unsigned pc_cpu_index_to_socket_id(unsigne=
d cpu_index)
>      return topo.pkg_id;
>  }
> =20
> -static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machi=
ne)
> +static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  {
> -    assert(machine->possible_cpus);
> -    return machine->possible_cpus;
> +    int i;
> +
> +    if (ms->possible_cpus) {
> +        /*
> +         * make sure that max_cpus hasn't changed since the first use, i=
=2Ee.
> +         * -smp hasn't been parsed after it
> +        */
> +        assert(ms->possible_cpus->len =3D=3D max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len =3D max_cpus;
> +    for (i =3D 0; i < ms->possible_cpus->len; i++) {
> +        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(i);
> +    }
> +    return ms->possible_cpus;
>  }
> =20
>  static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *mac=
hine)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnPqYAAoJEGw4ysog2bOSei4QANO1z+AVFthZqUKwIcCle5dB
rGeA5xC+zMrA5kCzBqAjys3+IMiErpEt2FQo5RtCwW10CDrDIEtszDY6W+Lb6a4n
JB5Ylc82EIEu0TDb7E9m9kgqL/rCouuPtV+J+wKqQWpOVlPvc8NK7pmZ/NKX9bTf
yus1hUdTKdkSiu7kJxAqDhQC+ychYLe5MoVAFUtNSlqFIHLIsnJX+dBQhoNzY1Gu
R3H0gaq766cscptJELBe8mZGbJvbpk+isf8Fnh3VAueKwYdUEPyUW8WdA1PKSOpQ
1WTk5TIlw8e/glQgyNIUfeaZnh8Ga+4VXmqc5IfNmFP+C6IsJl05GOr594dagWtD
xe/t6QUCSQW9pz5gMbG67bP0ZU8++ReOQmi4JNjNETCZhqajWo4X/TQv71Rkxh1m
rwg+kFAJ2OO5jiQakJHEGLgk2LcWZ8VnrcnlFS1fC0oI2Bhzv2uAVJhUB0jmv687
Fy2M+646nLt570HSlUtNOwhydElx2x/EYrFhTb2SrHQ/578ICn4g0dre2TtPH5d7
nJrLXK5T+kKdTkyHpEc+pEQHMJnOIaxfufEverh2BSMv/hHAJEdTJ9KZwgbX9hgM
i7rA+/x5D/jz2sXtYBgPPSWcGmf43Aj3cGDt0+Jl7erkw6a4eXAtGlLmldPCf2XQ
ypwnAd0/jXixt/6CuHa/
=y4bN
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
