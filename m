Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsM7-0004ST-30
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsM3-0006gr-4r
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHsM2-0006gD-SX
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:47:35 -0400
References: <20170602130518.22943-1-alex.bennee@linaro.org>
	<20170602130518.22943-4-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2c59ba0-6b90-4dba-f7af-087a66d43142@redhat.com>
Date: Mon, 5 Jun 2017 15:47:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170602130518.22943-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>



On 02/06/2017 15:05, Alex Benn=C3=A9e wrote:
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

I think bsd-user does not have ts_tid?

Thanks,

Paolo

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>=20
> ---
> v3
>   - fix merge, did move of function in previous commit
> ---
>  gdbstub.c            | 3 ++-
>  include/qom/cpu.h    | 2 --
>  linux-user/syscall.c | 1 -
>  3 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 57befe16e2..45a3a0b16b 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -63,7 +63,8 @@ static inline int target_memory_rw_debug(CPUState *cp=
u, target_ulong addr,
>  static inline int cpu_gdb_index(CPUState *cpu)
>  {
>  #if defined(CONFIG_USER_ONLY)
> -    return cpu->host_tid;
> +    TaskState *ts =3D (TaskState *) cpu->opaque;
> +    return ts->ts_tid;
>  #else
>      return cpu->cpu_index + 1;
>  #endif
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
>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_e=
nd;
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
> index 925ae11ea6..003943b736 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6219,7 +6219,6 @@ static void *clone_func(void *arg)
>      thread_cpu =3D cpu;
>      ts =3D (TaskState *)cpu->opaque;
>      info->tid =3D gettid();
> -    cpu->host_tid =3D info->tid;
>      task_settid(ts);
>      if (info->child_tidptr)
>          put_user_u32(info->tid, info->child_tidptr);
>=20
