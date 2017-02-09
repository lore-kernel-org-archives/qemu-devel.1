Received: from eggs.gnu.org ([2001:4830:134:3::10]:37835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUL-00006F-OM
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUK-0005Zu-H7
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:57 -0500
Date: Fri, 10 Feb 2017 10:26:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209232659.GE27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-5-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] pc: pass apic_id to pc_find_cpu_slot()
 directly so lookup could be done without CPU object
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


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:35PM +0100, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f03a555..ec6dded 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1783,12 +1783,11 @@ static int pc_apic_cmp(const void *a, const void =
*b)
>   * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
>   * entry corresponding to CPU's apic_id returns NULL.
>   */
> -static CPUArchId *pc_find_cpu_slot(MachineState *ms, CPUState *cpu, int =
*idx)
> +static CPUArchId *pc_find_cpu_slot(MachineState *ms, uint32_t id, int *i=
dx)
>  {
> -    CPUClass *cc =3D CPU_GET_CLASS(cpu);
>      CPUArchId apic_id, *found_cpu;
> =20
> -    apic_id.arch_id =3D cc->get_arch_id(CPU(cpu));
> +    apic_id.arch_id =3D id;
>      found_cpu =3D bsearch(&apic_id, ms->possible_cpus->cpus,
>          ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
>          pc_apic_cmp);
> @@ -1804,6 +1803,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
>      CPUArchId *found_cpu;
>      HotplugHandlerClass *hhc;
>      Error *local_err =3D NULL;
> +    X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> =20
>      if (pcms->acpi_dev) {
> @@ -1823,7 +1823,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
>          fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>      }
> =20
> -    found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
> +    found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
>      found_cpu->cpu =3D CPU(dev);
>  out:
>      error_propagate(errp, local_err);
> @@ -1834,9 +1834,10 @@ static void pc_cpu_unplug_request_cb(HotplugHandle=
r *hotplug_dev,
>      int idx =3D -1;
>      HotplugHandlerClass *hhc;
>      Error *local_err =3D NULL;
> +    X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> =20
> -    pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
> +    pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      assert(idx !=3D -1);
>      if (idx =3D=3D 0) {
>          error_setg(&local_err, "Boot CPU is unpluggable");
> @@ -1861,6 +1862,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplu=
g_dev,
>      CPUArchId *found_cpu;
>      HotplugHandlerClass *hhc;
>      Error *local_err =3D NULL;
> +    X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> =20
>      hhc =3D HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> @@ -1870,7 +1872,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplu=
g_dev,
>          goto out;
>      }
> =20
> -    found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
> +    found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
>      found_cpu->cpu =3D NULL;
>      object_unparent(OBJECT(dev));
> =20
> @@ -1928,7 +1930,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
>          cpu->apic_id =3D apicid_from_topo_ids(smp_cores, smp_threads, &t=
opo);
>      }
> =20
> -    cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
> +    cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms =3D MACHINE(pcms);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnPrCAAoJEGw4ysog2bOShf4P/0vhxUZpquKN00SUyGQiDf6/
WP/lfyeCA8rzkhPPqQt5al1ZN+NzNSRCDcUx5PzHX/Lu6eIEFGlMwz4O4o0FNnkz
hSGpOiDYHoUPUu5tl2+wigAeSLFbyDGZDRdNtCqkaVHTBPRZzFJHyL81IcEXA66g
oky803/gdJbIA/dmu3nRjHW1hsgfxiqJMNU9nIOzrlt4slNFe+oZ1GwD4ytgGpeP
0KhhLkYxRyjczhoZxzlJETOQvL5xTSdSgnDzS+ln9HkFyzdB1p5Rc9gVvsWNTkLy
mgOaDLHH74rkA1YPHPt+l8/EPPQw2OoiRjm/Rh0EQ7IONKAyxHl5ZsqDtyHWTssT
hZBrtuEO3lArsOGXc2wz/AgeS8811ZYZppKPzv/S0bZgC5DLNovd83S4KAjdUF/c
fXr5OHPM11IVzILHSzfoRawIcmczbK5Xm4ZhSvSyp+1DUnKX7dyIfUwBKWedi05e
8x/3oAjhqbz78EG0QXh8J5ZIVzY6Qcwy+T3LHSLnTiOmRPD2LYDmuhH5atK6SPPG
rMysmi+PqpXvMQQ8A17PdMfQKiqr7UHRBi8C7WogeMkIqOZoEbO7Nx5jFFJgiwJE
GCf0KShIc4hTNjDaHIiJ8S5eus3uJShQkXjEQWPbfuWKiGbNTVnuVrdpr0mGcsDM
Ww6pvUZgQ0xdo7i4vZEw
=ivzO
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
