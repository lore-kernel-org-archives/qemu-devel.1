Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGS5N-0006oX-Jo
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGS5I-0003VA-Ls
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:32:29 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGS5I-0003Uo-CM
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:32:24 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 971ECFE26F
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 17:32:21 +0200 (CEST)
Date: Thu, 1 Jun 2017 17:32:13 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601173213.08fe7e4f@bahia.lan>
In-Reply-To: <20170601144915.20778-4-alex.bennee@linaro.org>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
	<20170601144915.20778-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/3w+jSWkEFUJE=UhcSb5tAmp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

--Sig_/3w+jSWkEFUJE=UhcSb5tAmp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  1 Jun 2017 15:49:14 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> This was only used by the gdbstub and even then was only being set for
> subsequent threads. Rather the continue duplicating the number just
> make the gdbstub get the information from TaskState structure.
>=20
> Now the tid is correctly reported for all threads the bug I was seeing
> with "vCont;C04:0;c" packets is fixed as the correct tid is reported
> to gdb.
>=20
> I moved cpu_gdb_index into the gdbstub to facilitate easy access to
> the TaskState which is used elsewhere in gdbstub.
>=20

FWIW, this change would make more sense in patch 2 since all users
are in gdbstub.c and it would avoid to change things twice. No big
deal compared to the benefit of dropping the broken @host_tid :)

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

In any case.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  gdbstub.c              | 15 +++++++++++++++
>  include/exec/gdbstub.h | 14 --------------
>  include/qom/cpu.h      |  2 --
>  linux-user/syscall.c   |  1 -
>  4 files changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 026d1fe6bb..45a3a0b16b 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -55,6 +55,21 @@ static inline int target_memory_rw_debug(CPUState *cpu=
, target_ulong addr,
>      return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
>  }
> =20
> +/* Return the GDB index for a given vCPU state.
> + *
> + * For user mode this is simply the thread id. In system mode GDB
> + * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
> + */
> +static inline int cpu_gdb_index(CPUState *cpu)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    TaskState *ts =3D (TaskState *) cpu->opaque;
> +    return ts->ts_tid;
> +#else
> +    return cpu->cpu_index + 1;
> +#endif
> +}
> +
>  enum {
>      GDB_SIGNAL_0 =3D 0,
>      GDB_SIGNAL_INT =3D 2,
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index c4fe567600..9aa7756d92 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -58,20 +58,6 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_reg_cb get_reg, gdb_reg_cb set_reg,
>                                int num_regs, const char *xml, int g_pos);
> =20
> -/* Return the GDB index for a given vCPU state.
> - *
> - * For user mode this is simply the thread id. In system mode GDB
> - * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
> - */
> -static inline int cpu_gdb_index(CPUState *cpu)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    return cpu->host_tid;
> -#else
> -    return cpu->cpu_index + 1;
> -#endif
> -}
> -
>  /* The GDB remote protocol transfers values in target byte order.  This =
means
>   * we can use the raw memory access routines to access the value buffer.
>   * Conveniently, these also handle the case where the buffer is mis-alig=
ned.
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 55214ce131..909e7ae994 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -266,7 +266,6 @@ struct qemu_work_item;
>   * @nr_cores: Number of cores within this CPU package.
>   * @nr_threads: Number of threads within this CPU.
>   * @numa_node: NUMA node this CPU is belonging to.
> - * @host_tid: Host thread ID.
>   * @running: #true if CPU is currently running (lockless).
>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>   * valid under cpu_list_lock.
> @@ -321,7 +320,6 @@ struct CPUState {
>      HANDLE hThread;
>  #endif
>      int thread_id;
> -    uint32_t host_tid;
>      bool running, has_waiter;
>      struct QemuCond *halt_cond;
>      bool thread_kicked;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cec8428589..cada188e58 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6216,7 +6216,6 @@ static void *clone_func(void *arg)
>      thread_cpu =3D cpu;
>      ts =3D (TaskState *)cpu->opaque;
>      info->tid =3D gettid();
> -    cpu->host_tid =3D info->tid;
>      task_settid(ts);
>      if (info->child_tidptr)
>          put_user_u32(info->tid, info->child_tidptr);


--Sig_/3w+jSWkEFUJE=UhcSb5tAmp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwM30ACgkQAvw66wEB28KHEACfccH3sBnubM1S5vbcvC7lb5bR
lREAn28/5lWs72CwieNLbEbB6pCzeE6W
=3nvd
-----END PGP SIGNATURE-----

--Sig_/3w+jSWkEFUJE=UhcSb5tAmp--
