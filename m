Received: from eggs.gnu.org ([2001:4830:134:3::10]:35663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1emyIV-0000xI-1c
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1emyIQ-0006Qf-45
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:56:43 -0500
Received: from mout.web.de ([217.72.192.78]:53445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1emyIP-0006Pi-LT
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:56:38 -0500
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
Date: Sat, 17 Feb 2018 09:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BlX2IMXkeP1khhl7Vl4IAav6Sz497oAet"
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BlX2IMXkeP1khhl7Vl4IAav6Sz497oAet
From: Jan Kiszka <jan.kiszka@web.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-ID: <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
Subject: Re: [PULL 09/23] gdbstub: Fix vCont behaviour
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
 <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-02-16 15:31, Paolo Bonzini wrote:
> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>=20
> When GDB issues a "vCont", QEMU was not handling it correctly when
> multiple VCPUs are active.
> For vCont, for each thread (VCPU), it can be specified whether to
> single step, continue or stop that thread. The default is to stop a
> thread.
> However, when (for example) "vCont;s:2" is issued, all VCPUs continue
> to run, although all but VCPU nr 2 are to be stopped.
>=20
> This patch completely rewrites the vCont parsing code.
>=20
> Please note that this improvement only works in system emulation mode,
> when in userspace emulation mode the old behaviour is preserved.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Message-Id: <1487092068-16562-3-git-send-email-imbrenda@linux.vnet.ibm.=
com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  gdbstub.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++------=
--------
>  1 file changed, 162 insertions(+), 47 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 755a8e3..9911153 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -387,6 +387,60 @@ static inline void gdb_continue(GDBState *s)
>  #endif
>  }
> =20
> +/*
> + * Resume execution, per CPU actions. For user-mode emulation it's
> + * equivalent to gdb_continue.
> + */
> +static int gdb_continue_partial(GDBState *s, char *newstates)
> +{
> +    CPUState *cpu;
> +    int res =3D 0;
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * This is not exactly accurate, but it's an improvement compared =
to the
> +     * previous situation, where only one CPU would be single-stepped.=

> +     */
> +    CPU_FOREACH(cpu) {
> +        if (newstates[cpu->cpu_index] =3D=3D 's') {
> +            cpu_single_step(cpu, sstep_flags);
> +        }
> +    }
> +    s->running_state =3D 1;
> +#else
> +    int flag =3D 0;
> +
> +    if (!runstate_needs_reset()) {
> +        if (vm_prepare_start()) {
> +            return 0;
> +        }
> +
> +        CPU_FOREACH(cpu) {
> +            switch (newstates[cpu->cpu_index]) {
> +            case 0:
> +            case 1:
> +                break; /* nothing to do here */
> +            case 's':
> +                cpu_single_step(cpu, sstep_flags);
> +                cpu_resume(cpu);
> +                flag =3D 1;
> +                break;
> +            case 'c':
> +                cpu_resume(cpu);
> +                flag =3D 1;
> +                break;
> +            default:
> +                res =3D -1;
> +                break;
> +            }
> +        }
> +    }
> +    if (flag) {
> +        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
> +    }
> +#endif
> +    return res;
> +}
> +
>  static void put_buffer(GDBState *s, const uint8_t *buf, int len)
>  {
>  #ifdef CONFIG_USER_ONLY
> @@ -785,6 +839,107 @@ static int is_query_packet(const char *p, const c=
har *query, char separator)
>          (p[query_len] =3D=3D '\0' || p[query_len] =3D=3D separator);
>  }
> =20
> +/**
> + * gdb_handle_vcont - Parses and handles a vCont packet.
> + * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if=
 there is
> + *         a format error, 0 on success.
> + */
> +static int gdb_handle_vcont(GDBState *s, const char *p)
> +{
> +    int res, idx, signal =3D 0;
> +    char cur_action;
> +    char *newstates;
> +    unsigned long tmp;
> +    CPUState *cpu;
> +#ifdef CONFIG_USER_ONLY
> +    int max_cpus =3D 1; /* global variable max_cpus exists only in sys=
tem mode */
> +
> +    CPU_FOREACH(cpu) {
> +        max_cpus =3D max_cpus <=3D cpu->cpu_index ? cpu->cpu_index + 1=
 : max_cpus;
> +    }
> +#endif
> +    /* uninitialised CPUs stay 0 */
> +    newstates =3D g_new0(char, max_cpus);
> +
> +    /* mark valid CPUs with 1 */
> +    CPU_FOREACH(cpu) {
> +        newstates[cpu->cpu_index] =3D 1;
> +    }
> +
> +    /*
> +     * res keeps track of what error we are returning, with -ENOTSUP m=
eaning
> +     * that the command is unknown or unsupported, thus returning an e=
mpty
> +     * packet, while -EINVAL and -ERANGE cause an E22 packet, due to i=
nvalid,
> +     *  or incorrect parameters passed.
> +     */
> +    res =3D 0;
> +    while (*p) {
> +        if (*p++ !=3D ';') {
> +            res =3D -ENOTSUP;
> +            goto out;
> +        }
> +
> +        cur_action =3D *p++;
> +        if (cur_action =3D=3D 'C' || cur_action =3D=3D 'S') {
> +            cur_action =3D tolower(cur_action);
> +            res =3D qemu_strtoul(p + 1, &p, 16, &tmp);
> +            if (res) {
> +                goto out;
> +            }
> +            signal =3D gdb_signal_to_target(tmp);
> +        } else if (cur_action !=3D 'c' && cur_action !=3D 's') {
> +            /* unknown/invalid/unsupported command */
> +            res =3D -ENOTSUP;
> +            goto out;
> +        }
> +        /* thread specification. special values: (none), -1 =3D all; 0=
 =3D any */
> +        if ((p[0] =3D=3D ':' && p[1] =3D=3D '-' && p[2] =3D=3D '1') ||=
 (p[0] !=3D ':')) {
> +            if (*p =3D=3D ':') {
> +                p +=3D 3;
> +            }
> +            for (idx =3D 0; idx < max_cpus; idx++) {
> +                if (newstates[idx] =3D=3D 1) {
> +                    newstates[idx] =3D cur_action;
> +                }
> +            }
> +        } else if (*p =3D=3D ':') {
> +            p++;
> +            res =3D qemu_strtoul(p, &p, 16, &tmp);
> +            if (res) {
> +                goto out;
> +            }
> +            idx =3D tmp;
> +            /* 0 means any thread, so we pick the first valid CPU */
> +            if (!idx) {
> +                idx =3D cpu_index(first_cpu);
> +            }
> +
> +            /*
> +             * If we are in user mode, the thread specified is actuall=
y a
> +             * thread id, and not an index. We need to find the actual=

> +             * CPU first, and only then we can use its index.
> +             */
> +            cpu =3D find_cpu(idx);
> +            /* invalid CPU/thread specified */
> +            if (!idx || !cpu) {
> +                res =3D -EINVAL;
> +                goto out;
> +            }
> +            /* only use if no previous match occourred */
> +            if (newstates[cpu->cpu_index] =3D=3D 1) {
> +                newstates[cpu->cpu_index] =3D cur_action;
> +            }
> +        }
> +    }
> +    s->signal =3D signal;
> +    gdb_continue_partial(s, newstates);
> +
> +out:
> +    g_free(newstates);
> +
> +    return res;
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -830,60 +985,20 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          return RS_IDLE;
>      case 'v':
>          if (strncmp(p, "Cont", 4) =3D=3D 0) {
> -            int res_signal, res_thread;
> -
>              p +=3D 4;
>              if (*p =3D=3D '?') {
>                  put_packet(s, "vCont;c;C;s;S");
>                  break;
>              }
> -            res =3D 0;
> -            res_signal =3D 0;
> -            res_thread =3D 0;
> -            while (*p) {
> -                int action, signal;
> -
> -                if (*p++ !=3D ';') {
> -                    res =3D 0;
> -                    break;
> -                }
> -                action =3D *p++;
> -                signal =3D 0;
> -                if (action =3D=3D 'C' || action =3D=3D 'S') {
> -                    signal =3D gdb_signal_to_target(strtoul(p, (char *=
*)&p, 16));
> -                    if (signal =3D=3D -1) {
> -                        signal =3D 0;
> -                    }
> -                } else if (action !=3D 'c' && action !=3D 's') {
> -                    res =3D 0;
> -                    break;
> -                }
> -                thread =3D 0;
> -                if (*p =3D=3D ':') {
> -                    thread =3D strtoull(p+1, (char **)&p, 16);
> -                }
> -                action =3D tolower(action);
> -                if (res =3D=3D 0 || (res =3D=3D 'c' && action =3D=3D '=
s')) {
> -                    res =3D action;
> -                    res_signal =3D signal;
> -                    res_thread =3D thread;
> -                }
> -            }
> +
> +            res =3D gdb_handle_vcont(s, p);
> +
>              if (res) {
> -                if (res_thread !=3D -1 && res_thread !=3D 0) {
> -                    cpu =3D find_cpu(res_thread);
> -                    if (cpu =3D=3D NULL) {
> -                        put_packet(s, "E22");
> -                        break;
> -                    }
> -                    s->c_cpu =3D cpu;
> -                }
> -                if (res =3D=3D 's') {
> -                    cpu_single_step(s->c_cpu, sstep_flags);
> +                if ((res =3D=3D -EINVAL) || (res =3D=3D -ERANGE)) {
> +                    put_packet(s, "E22");
> +                    break;
>                  }
> -                s->signal =3D res_signal;
> -                gdb_continue(s);
> -                return RS_IDLE;
> +                goto unknown_command;
>              }
>              break;
>          } else {
>=20

Seems like no one is doing guest debugging with kvm on x86 except me,
and I'm only doing it too infrequently now: This one broke that use case
for SMP guests long ago. How was it tested?

To reproduce the bug: set up an x86-64 guest kernel with > 1 core, break
on some prominent syscall entry (e.g. sys_execve), continue the guest on
hit and it will quickly lock up, even after disabling the breakpoint
again. Kernel version doesn't matter (was my first guess), gdb is
7.7.50.20140604-cvs (OpenSUSE) here.

Jan


--BlX2IMXkeP1khhl7Vl4IAav6Sz497oAet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqH7joACgkQitSsb3rl5xRM/QCdFSu5Cxrqx+iS6hweQpRdO8VX
WDgAoIg38i2y/uHItchGc8rhKBW2N3zz
=lh+y
-----END PGP SIGNATURE-----

--BlX2IMXkeP1khhl7Vl4IAav6Sz497oAet--
