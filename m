Received: from eggs.gnu.org ([2001:4830:134:3::10]:50984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGRnI-0007Uy-Ad
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGRnF-0004I4-3B
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:13:48 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:46110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGRnE-0004Ho-T2
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:13:45 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 89CBE100742
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 17:13:43 +0200 (CEST)
Date: Thu, 1 Jun 2017 17:13:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601171337.5c81515e@bahia.lan>
In-Reply-To: <20170601144915.20778-3-alex.bennee@linaro.org>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
	<20170601144915.20778-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/AV6mPyHGe9T43Mcz5yEM0PA";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] gdbstub: rename cpu_index ->
 cpu_gdb_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com, qemu-devel@nongnu.org

--Sig_/AV6mPyHGe9T43Mcz5yEM0PA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  1 Jun 2017 15:49:13 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> This is to make it clear the index is purely a gdbstub function and
> should not be confused with the value of cpu->cpu_index.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  gdbstub.c              | 12 ++++++------
>  include/exec/gdbstub.h |  7 ++++++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index a249846954..026d1fe6bb 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -837,7 +837,7 @@ static CPUState *find_cpu(uint32_t thread_id)
>      CPUState *cpu;
> =20
>      CPU_FOREACH(cpu) {
> -        if (cpu_index(cpu) =3D=3D thread_id) {
> +        if (cpu_gdb_index(cpu) =3D=3D thread_id) {
>              return cpu;
>          }
>      }
> @@ -925,7 +925,7 @@ static int gdb_handle_vcont(GDBState *s, const char *=
p)
>              idx =3D tmp;
>              /* 0 means any thread, so we pick the first valid CPU */
>              if (!idx) {
> -                idx =3D cpu_index(first_cpu);
> +                idx =3D cpu_gdb_index(first_cpu);
>              }
> =20
>              /*
> @@ -975,7 +975,7 @@ static int gdb_handle_packet(GDBState *s, const char =
*line_buf)
>      case '?':
>          /* TODO: Make this return the correct value for user-mode.  */
>          snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
> -                 cpu_index(s->c_cpu));
> +                 cpu_gdb_index(s->c_cpu));
>          put_packet(s, buf);
>          /* Remove all the breakpoints when this query is issued,
>           * because gdb is doing and initial connect and the state
> @@ -1243,7 +1243,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>          } else if (strcmp(p,"sThreadInfo") =3D=3D 0) {
>          report_cpuinfo:
>              if (s->query_cpu) {
> -                snprintf(buf, sizeof(buf), "m%x", cpu_index(s->query_cpu=
));
> +                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query=
_cpu));
>                  put_packet(s, buf);
>                  s->query_cpu =3D CPU_NEXT(s->query_cpu);
>              } else
> @@ -1400,7 +1400,7 @@ static void gdb_vm_state_change(void *opaque, int r=
unning, RunState state)
>              }
>              snprintf(buf, sizeof(buf),
>                       "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
> -                     GDB_SIGNAL_TRAP, cpu_index(cpu), type,
> +                     GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
>                       (target_ulong)cpu->watchpoint_hit->vaddr);
>              cpu->watchpoint_hit =3D NULL;
>              goto send_packet;
> @@ -1434,7 +1434,7 @@ static void gdb_vm_state_change(void *opaque, int r=
unning, RunState state)
>          break;
>      }
>      gdb_set_stop_cpu(cpu);
> -    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_index(cpu));
> +    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_gdb_index(c=
pu));
> =20
>  send_packet:
>      put_packet(s, buf);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index f9708bbcd6..c4fe567600 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -58,7 +58,12 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_reg_cb get_reg, gdb_reg_cb set_reg,
>                                int num_regs, const char *xml, int g_pos);
> =20
> -static inline int cpu_index(CPUState *cpu)
> +/* Return the GDB index for a given vCPU state.
> + *
> + * For user mode this is simply the thread id. In system mode GDB
> + * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
> + */
> +static inline int cpu_gdb_index(CPUState *cpu)
>  {
>  #if defined(CONFIG_USER_ONLY)
>      return cpu->host_tid;


--Sig_/AV6mPyHGe9T43Mcz5yEM0PA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwLyEACgkQAvw66wEB28L8mwCfaNlbgqFdukCwru8or1AcCn0w
8LAAnjAu4mAXXETlqtPI6+IS/3ja1zkk
=VRX5
-----END PGP SIGNATURE-----

--Sig_/AV6mPyHGe9T43Mcz5yEM0PA--
