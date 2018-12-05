Received: from eggs.gnu.org ([2001:4830:134:3::10]:42130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUYI1-0002CG-Ps
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUYHz-00009m-7j
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:36:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUYHz-000074-0l
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:36:35 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so19931785wra.6
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 06:36:34 -0800 (PST)
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
	<154401449112.8440.1747971561547810226.stgit@Misha-PC.lan02.inno>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <154401449112.8440.1747971561547810226.stgit@Misha-PC.lan02.inno>
Date: Wed, 05 Dec 2018 14:36:32 +0000
Message-ID: <87zhtk11n3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2 30/39] windbg: debug exception subscribing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org


Mikhail Abakumov <mikhail.abakumov@ispras.ru> writes:

> Add handler registration of gdb debug exception. Its exception also can b=
e used
> for windbg.
>
> Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> ---
>  cpus.c                  |   19 ++++++++++++++++++-
>  gdbstub.c               |    4 ++++
>  include/sysemu/sysemu.h |    2 ++
>  windbgstub.c            |   14 ++++++++++++++
>  4 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index a2b33ccb29..c8b05260b4 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -79,6 +79,8 @@ int64_t max_advance;
>  static QEMUTimer *throttle_timer;
>  static unsigned int throttle_percentage;
>
> +static void (*excp_debug_handler)(CPUState *cpu);
> +
>  #define CPU_THROTTLE_PCT_MIN 1
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
> @@ -1103,9 +1105,24 @@ static bool cpu_can_run(CPUState *cpu)
>      return true;
>  }
>
> +bool register_excp_debug_handler(void (*handler)(CPUState *cpu))
> +{
> +    if (excp_debug_handler =3D=3D NULL) {
> +        excp_debug_handler =3D handler;
> +        return true;
> +    } else {
> +        error_report("Something debugger is already in use. '-gdb' and "
> +                     "'-windbg' cannot be used at the same time");
> +        return false;
> +    }
> +}
> +
>  static void cpu_handle_guest_debug(CPUState *cpu)
>  {
> -    gdb_set_stop_cpu(cpu);

If we are going to have a handler approach we can make gdb_set_stop_cpu
static and remove the gdbstub.h reference from cpus.c as well.

> +    if (excp_debug_handler !=3D NULL) {
> +        excp_debug_handler(cpu);
> +    }
> +
>      qemu_system_debug_request();
>      cpu->stopped =3D true;
>  }
> diff --git a/gdbstub.c b/gdbstub.c
> index c4e4f9f082..9ed4fe2e8e 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2074,6 +2074,10 @@ int gdbserver_start(const char *device)
>      s->mon_chr =3D mon_chr;
>      s->current_syscall_cb =3D NULL;
>
> +    if (!register_excp_debug_handler(gdb_set_stop_cpu)) {
> +        exit(1);
> +    }
> +
>      return 0;
>  }
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 8d6095d98b..826b701bfa 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -203,6 +203,8 @@ QemuOpts *qemu_get_machine_opts(void);
>
>  bool defaults_enabled(void);
>
> +bool register_excp_debug_handler(void (*handler)(CPUState *cpu));
> +
>  extern QemuOptsList qemu_legacy_drive_opts;
>  extern QemuOptsList qemu_common_drive_opts;
>  extern QemuOptsList qemu_drive_opts;
> diff --git a/windbgstub.c b/windbgstub.c
> index a1c013cd8c..0e4ad6d009 100644
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -129,9 +129,19 @@ static void windbg_send_control_packet(WindbgState *=
state, uint16_t type,
>      qemu_chr_fe_write(&state->chr, PTR(packet), sizeof(packet));
>  }
>
> +static void windbg_bp_handler(CPUState *cs)
> +{
> +    DBGKD_ANY_WAIT_STATE_CHANGE *sc =3D kd_state_change_exc(cs);
> +    windbg_send_data_packet(windbg_state, (uint8_t *) sc,
> +                            sizeof(DBGKD_ANY_WAIT_STATE_CHANGE),
> +                            PACKET_TYPE_KD_STATE_CHANGE64);
> +}
> +
>  static void windbg_vm_stop(void)
>  {
> +    CPUState *cs =3D qemu_get_cpu(0);

This can fail - although I guess it's unlikely someone has hotplugged cpu0.

>      vm_stop(RUN_STATE_PAUSED);
> +    windbg_bp_handler(cs);
>  }
>
>  static void windbg_process_manipulate_packet(WindbgState *state)
> @@ -481,6 +491,10 @@ int windbg_server_start(const char *device)
>
>      qemu_register_reset(windbg_handle_reset, NULL);
>
> +    if (!register_excp_debug_handler(windbg_bp_handler)) {
> +        exit(1);
> +    }
> +
>      atexit(windbg_exit);
>      return 0;
>  }


--
Alex Benn=C3=A9e
