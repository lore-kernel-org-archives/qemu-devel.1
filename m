Received: from eggs.gnu.org ([2001:4830:134:3::10]:35325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddFy9-0007re-GJ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddFy4-0007CA-SU
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:15:17 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:53387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ddFy4-0007Ar-MI
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:15:12 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 333A067213
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 15:15:10 +0200 (CEST)
Date: Thu, 3 Aug 2017 15:15:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170803151504.6d5cacac@bahia.lan>
In-Reply-To: <31205fa54bd9761aee5fb3a6724c98f7e9e86240.1501740002.git.sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<31205fa54bd9761aee5fb3a6724c98f7e9e86240.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rgwarK_khfdoln+uV4A8ai+";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] e500: Use cpu_index instead
 of vcpu_dt_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

--Sig_/rgwarK_khfdoln+uV4A8ai+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 16:28:36 +1000
Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:

> The e500 platform code uses the function ppc_get_vcpu_dt_id() but that
> function is actually specific to SPAPR machines, not PPC CPUs, and
> will always return the cpu_index in this context.
>=20

ie, e500 compatible CPUs don't support SMT ? Then maybe the e500 machine
should ensure smp_threads =3D=3D 1, but this can done in a followup patch.

> Simply use the cpu_index instead (which is 'i' in this context
> because qemu_get_cpu(i) returns the cpu with cpu_index =3D=3D i).
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  hw/ppc/e500.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 62f1857206..2a6d34ceb1 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -382,7 +382,6 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>         the first node as boot node and be happy */
>      for (i =3D smp_cpus - 1; i >=3D 0; i--) {
>          CPUState *cpu;
> -        PowerPCCPU *pcpu;
>          char cpu_name[128];
>          uint64_t cpu_release_addr =3D params->spin_base + (i * 0x20);
> =20
> @@ -391,16 +390,13 @@ static int ppce500_load_device_tree(MachineState *m=
achine,
>              continue;
>          }
>          env =3D cpu->env_ptr;
> -        pcpu =3D POWERPC_CPU(cpu);
> =20
> -        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x",
> -                 ppc_get_vcpu_dt_id(pcpu));
> +        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x", i);
>          qemu_fdt_add_subnode(fdt, cpu_name);
>          qemu_fdt_setprop_cell(fdt, cpu_name, "clock-frequency", clock_fr=
eq);
>          qemu_fdt_setprop_cell(fdt, cpu_name, "timebase-frequency", tb_fr=
eq);
>          qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> -        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> -                              ppc_get_vcpu_dt_id(pcpu));
> +        qemu_fdt_setprop_cell(fdt, cpu_name, "reg", i);
>          qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-line-size",
>                                env->dcache_line_size);
>          qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-line-size",


--Sig_/rgwarK_khfdoln+uV4A8ai+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmDIdgACgkQAvw66wEB28KTIACgmJKXYiyo6QIPDgnfnkWYUev0
rbIAnjAT6TDkhkYt5E+ioPR+FEZZZTXE
=auaD
-----END PGP SIGNATURE-----

--Sig_/rgwarK_khfdoln+uV4A8ai+--
