Received: from eggs.gnu.org ([2001:4830:134:3::10]:52927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cSuOt-0004qi-Iz
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 18:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cSuOq-0000z0-8M
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 18:39:51 -0500
Date: Sun, 15 Jan 2017 20:15:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170115091556.GA14297@umbus>
References: <1484309555-1935-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <1484309555-1935-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] monitor: Fix crashes when using HMP
 commands without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 01:12:35PM +0100, Thomas Huth wrote:
> When running certain HMP commands ("info registers", "info cpustats",
> "info tlb", "nmi", "memsave" or dumping virtual memory) with the "none"
> machine, QEMU crashes with a segmentation fault. This happens because the
> "none" machine does not have any CPUs by default, but these HMP commands
> did not check for a valid CPU pointer yet. Add such checks now, so we get
> an error message about the missing CPU instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

ppc portion

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  v4:
>  - Added some more target-specifc checks (for "info tlb" for example)
>  v3:
>  - Use UNASSIGNED_CPU_INDEX instead of hard-coded -1
>  v2:
>  - Added more checks to cover "nmi" and "memsave", too
>=20
>  hmp.c                   |  8 +++++++-
>  monitor.c               | 42 ++++++++++++++++++++++++++++++++++--------
>  target/i386/monitor.c   | 16 +++++++++++++++-
>  target/ppc/monitor.c    |  4 ++++
>  target/sh4/monitor.c    |  5 +++++
>  target/sparc/monitor.c  |  4 ++++
>  target/xtensa/monitor.c |  4 ++++
>  7 files changed, 73 insertions(+), 10 deletions(-)
>=20
> diff --git a/hmp.c b/hmp.c
> index b869617..b1c503a 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1013,8 +1013,14 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>      const char *filename =3D qdict_get_str(qdict, "filename");
>      uint64_t addr =3D qdict_get_int(qdict, "val");
>      Error *err =3D NULL;
> +    int cpu_index =3D monitor_get_cpu_index();
> =20
> -    qmp_memsave(addr, size, filename, true, monitor_get_cpu_index(), &er=
r);
> +    if (cpu_index < 0) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    qmp_memsave(addr, size, filename, true, cpu_index, &err);
>      hmp_handle_error(mon, &err);
>  }
> =20
> diff --git a/monitor.c b/monitor.c
> index 0841d43..bf488e9 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1025,6 +1025,9 @@ int monitor_set_cpu(int cpu_index)
>  CPUState *mon_get_cpu(void)
>  {
>      if (!cur_mon->mon_cpu) {
> +        if (!first_cpu) {
> +            return NULL;
> +        }
>          monitor_set_cpu(first_cpu->cpu_index);
>      }
>      cpu_synchronize_state(cur_mon->mon_cpu);
> @@ -1033,17 +1036,27 @@ CPUState *mon_get_cpu(void)
> =20
>  CPUArchState *mon_get_cpu_env(void)
>  {
> -    return mon_get_cpu()->env_ptr;
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    return cs ? cs->env_ptr : NULL;
>  }
> =20
>  int monitor_get_cpu_index(void)
>  {
> -    return mon_get_cpu()->cpu_index;
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>  }
> =20
>  static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>  {
> -    cpu_dump_state(mon_get_cpu(), (FILE *)mon, monitor_fprintf, CPU_DUMP=
_FPU);
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +    cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
>  }
> =20
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> @@ -1076,7 +1089,13 @@ static void hmp_info_history(Monitor *mon, const Q=
Dict *qdict)
> =20
>  static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>  {
> -    cpu_dump_statistics(mon_get_cpu(), (FILE *)mon, &monitor_fprintf, 0);
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +    cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
>  }
> =20
>  static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
> @@ -1235,6 +1254,12 @@ static void memory_dump(Monitor *mon, int count, i=
nt format, int wsize,
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
>      uint64_t v;
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    if (!cs && (format =3D=3D 'i' || !is_physical)) {
> +        monitor_printf(mon, "Can not dump without CPU\n");
> +        return;
> +    }
> =20
>      if (format =3D=3D 'i') {
>          int flags =3D 0;
> @@ -1264,7 +1289,7 @@ static void memory_dump(Monitor *mon, int count, in=
t format, int wsize,
>          flags =3D msr_le << 16;
>          flags |=3D env->bfd_mach;
>  #endif
> -        monitor_disas(mon, mon_get_cpu(), addr, count, is_physical, flag=
s);
> +        monitor_disas(mon, cs, addr, count, is_physical, flags);
>          return;
>      }
> =20
> @@ -1303,7 +1328,7 @@ static void memory_dump(Monitor *mon, int count, in=
t format, int wsize,
>          if (is_physical) {
>              cpu_physical_memory_read(addr, buf, l);
>          } else {
> -            if (cpu_memory_rw_debug(mon_get_cpu(), addr, buf, l, 0) < 0)=
 {
> +            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
>                  monitor_printf(mon, " Cannot access memory\n");
>                  break;
>              }
> @@ -2186,11 +2211,12 @@ expr_error(Monitor *mon, const char *fmt, ...)
>  static int get_monitor_def(target_long *pval, const char *name)
>  {
>      const MonitorDef *md =3D target_monitor_defs();
> +    CPUState *cs =3D mon_get_cpu();
>      void *ptr;
>      uint64_t tmp =3D 0;
>      int ret;
> =20
> -    if (md =3D=3D NULL) {
> +    if (cs =3D=3D NULL || md =3D=3D NULL) {
>          return -1;
>      }
> =20
> @@ -2217,7 +2243,7 @@ static int get_monitor_def(target_long *pval, const=
 char *name)
>          }
>      }
> =20
> -    ret =3D target_get_monitor_def(mon_get_cpu(), name, &tmp);
> +    ret =3D target_get_monitor_def(cs, name, &tmp);
>      if (!ret) {
>          *pval =3D (target_long) tmp;
>      }
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 468aa07..77ead60 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -210,6 +210,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      CPUArchState *env;
> =20
>      env =3D mon_get_cpu_env();
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> =20
>      if (!(env->cr[0] & CR0_PG_MASK)) {
>          monitor_printf(mon, "PG disabled\n");
> @@ -529,6 +533,10 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>      CPUArchState *env;
> =20
>      env =3D mon_get_cpu_env();
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> =20
>      if (!(env->cr[0] & CR0_PG_MASK)) {
>          monitor_printf(mon, "PG disabled\n");
> @@ -624,7 +632,13 @@ const MonitorDef *target_monitor_defs(void)
> =20
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
>  {
> -    x86_cpu_dump_local_apic_state(mon_get_cpu(), (FILE *)mon, monitor_fp=
rintf,
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +    x86_cpu_dump_local_apic_state(cs, (FILE *)mon, monitor_fprintf,
>                                    CPU_DUMP_FPU);
>  }
> =20
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index c2d0806..b8f30e9 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -62,6 +62,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 =3D mon_get_cpu_env();
> =20
> +    if (!env1) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>      dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
>  }
> =20
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 426e5d4..4c7f36c 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -44,6 +44,11 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      CPUArchState *env =3D mon_get_cpu_env();
>      int i;
> =20
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
>      monitor_printf (mon, "ITLB:\n");
>      for (i =3D 0 ; i < ITLB_SIZE ; i++)
>          print_tlb (mon, i, &env->itlb[i]);
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 7cc1b0f..f3ca524 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -32,6 +32,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 =3D mon_get_cpu_env();
> =20
> +    if (!env1) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>      dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
>  }
> =20
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index f3fa4cd..2ee2b5b 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -31,5 +31,9 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 =3D mon_get_cpu_env();
> =20
> +    if (!env1) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>      dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYez3KAAoJEGw4ysog2bOS7fUP/iigNHCcNK+Crpal9hEvuest
urD8L3xXAhUOmn7Odi8i8ReZvSmmeJDnNUmmTGxcd/tHGg9Si75u1CwEec2LktO5
5CnErfVuA+9ZLmjtuD8p7ui4iMtoMQ/xzkGVyePmTyO5mpV5tgSipugSlppN5Nty
CLOj4HOnyXgYz9eugxvFm85xcIIxO3lFJqnMuNUcLD8ZkTQv+cdxsWZi6aKCiv1S
TdgUCvBqKcxtcd1fB4wm5eKarHWZrN0thRmbn8V98Ec7cEzMZc695w0/vQaqmZMH
QSo75X7th8utmnVpyFKA9ST3EqhBSVr3ItdpYnm6w2X6qXNq2b8d/0QGtav6oMvJ
hK561scZMySwSZToBuuK0+SUi7MdnLMirQ6PCq95BNoxyNQIqkseOHrobnqk6c6T
YZy9CQn/0Bmpfji2kZcIKOAb9ybwGLFjtxOmqSLGOZGCbNhYKYhvrXaBtaZ4s4uj
56KJc6wt0cNw0KZsWEW7ugiT9+iXin7rMcsck5l/LykfhcWzQU70mPgnrTKn9Rht
Bcd3N1D58fz0gwH23mmIvTtfYp4yqnetD1STSZbmtL1GErR4f4T4qomLYIscchXE
/owmt1rDnECPDB4x/Tn2ryfXe3NAbwN3g0M/89Cvcfb4FaFi0FLl/0nUhFTedZar
qewFfjVJT+nb+7ojuuZH
=QkvK
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
