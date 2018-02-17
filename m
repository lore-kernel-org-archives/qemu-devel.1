Received: from eggs.gnu.org ([2001:4830:134:3::10]:36804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1emyTN-0004x7-PU
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 04:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1emyTJ-00053E-Ky
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 04:07:57 -0500
Received: from mout.web.de ([212.227.17.12]:32811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1emyTJ-00052O-49
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 04:07:53 -0500
From: Jan Kiszka <jan.kiszka@web.de>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
	<3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
Message-ID: <acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
Date: Sat, 17 Feb 2018 10:07:38 +0100
MIME-Version: 1.0
In-Reply-To: <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OBOw6dF6xLPE6RXgLNrTgdlMQHG0gQWqo"
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
--OBOw6dF6xLPE6RXgLNrTgdlMQHG0gQWqo
From: Jan Kiszka <jan.kiszka@web.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-ID: <acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
Subject: Re: [PULL 09/23] gdbstub: Fix vCont behaviour
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
 <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
 <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
In-Reply-To: <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-17 09:56, Jan Kiszka wrote:
> On 2017-02-16 15:31, Paolo Bonzini wrote:
>> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>
>> When GDB issues a "vCont", QEMU was not handling it correctly when
>> multiple VCPUs are active.
>> For vCont, for each thread (VCPU), it can be specified whether to
>> single step, continue or stop that thread. The default is to stop a
>> thread.
>> However, when (for example) "vCont;s:2" is issued, all VCPUs continue
>> to run, although all but VCPU nr 2 are to be stopped.
>>
>> This patch completely rewrites the vCont parsing code.
>>
>> Please note that this improvement only works in system emulation mode,=

>> when in userspace emulation mode the old behaviour is preserved.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> Message-Id: <1487092068-16562-3-git-send-email-imbrenda@linux.vnet.ibm=
=2Ecom>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  gdbstub.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
---------
>>  1 file changed, 162 insertions(+), 47 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 755a8e3..9911153 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -387,6 +387,60 @@ static inline void gdb_continue(GDBState *s)
>>  #endif
>>  }
>> =20
>> +/*
>> + * Resume execution, per CPU actions. For user-mode emulation it's
>> + * equivalent to gdb_continue.
>> + */
>> +static int gdb_continue_partial(GDBState *s, char *newstates)
>> +{
>> +    CPUState *cpu;
>> +    int res =3D 0;
>> +#ifdef CONFIG_USER_ONLY
>> +    /*
>> +     * This is not exactly accurate, but it's an improvement compared=
 to the
>> +     * previous situation, where only one CPU would be single-stepped=
=2E
>> +     */
>> +    CPU_FOREACH(cpu) {
>> +        if (newstates[cpu->cpu_index] =3D=3D 's') {
>> +            cpu_single_step(cpu, sstep_flags);
>> +        }
>> +    }
>> +    s->running_state =3D 1;
>> +#else
>> +    int flag =3D 0;
>> +
>> +    if (!runstate_needs_reset()) {
>> +        if (vm_prepare_start()) {
>> +            return 0;
>> +        }
>> +
>> +        CPU_FOREACH(cpu) {
>> +            switch (newstates[cpu->cpu_index]) {
>> +            case 0:
>> +            case 1:
>> +                break; /* nothing to do here */
>> +            case 's':
>> +                cpu_single_step(cpu, sstep_flags);
>> +                cpu_resume(cpu);
>> +                flag =3D 1;
>> +                break;
>> +            case 'c':
>> +                cpu_resume(cpu);
>> +                flag =3D 1;
>> +                break;
>> +            default:
>> +                res =3D -1;
>> +                break;
>> +            }
>> +        }
>> +    }
>> +    if (flag) {
>> +        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>> +    }
>> +#endif
>> +    return res;
>> +}
>> +
>>  static void put_buffer(GDBState *s, const uint8_t *buf, int len)
>>  {
>>  #ifdef CONFIG_USER_ONLY
>> @@ -785,6 +839,107 @@ static int is_query_packet(const char *p, const =
char *query, char separator)
>>          (p[query_len] =3D=3D '\0' || p[query_len] =3D=3D separator);
>>  }
>> =20
>> +/**
>> + * gdb_handle_vcont - Parses and handles a vCont packet.
>> + * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE i=
f there is
>> + *         a format error, 0 on success.
>> + */
>> +static int gdb_handle_vcont(GDBState *s, const char *p)
>> +{
>> +    int res, idx, signal =3D 0;
>> +    char cur_action;
>> +    char *newstates;
>> +    unsigned long tmp;
>> +    CPUState *cpu;
>> +#ifdef CONFIG_USER_ONLY
>> +    int max_cpus =3D 1; /* global variable max_cpus exists only in sy=
stem mode */
>> +
>> +    CPU_FOREACH(cpu) {
>> +        max_cpus =3D max_cpus <=3D cpu->cpu_index ? cpu->cpu_index + =
1 : max_cpus;
>> +    }
>> +#endif
>> +    /* uninitialised CPUs stay 0 */
>> +    newstates =3D g_new0(char, max_cpus);
>> +
>> +    /* mark valid CPUs with 1 */
>> +    CPU_FOREACH(cpu) {
>> +        newstates[cpu->cpu_index] =3D 1;
>> +    }
>> +
>> +    /*
>> +     * res keeps track of what error we are returning, with -ENOTSUP =
meaning
>> +     * that the command is unknown or unsupported, thus returning an =
empty
>> +     * packet, while -EINVAL and -ERANGE cause an E22 packet, due to =
invalid,
>> +     *  or incorrect parameters passed.
>> +     */
>> +    res =3D 0;
>> +    while (*p) {
>> +        if (*p++ !=3D ';') {
>> +            res =3D -ENOTSUP;
>> +            goto out;
>> +        }
>> +
>> +        cur_action =3D *p++;
>> +        if (cur_action =3D=3D 'C' || cur_action =3D=3D 'S') {
>> +            cur_action =3D tolower(cur_action);
>> +            res =3D qemu_strtoul(p + 1, &p, 16, &tmp);
>> +            if (res) {
>> +                goto out;
>> +            }
>> +            signal =3D gdb_signal_to_target(tmp);
>> +        } else if (cur_action !=3D 'c' && cur_action !=3D 's') {
>> +            /* unknown/invalid/unsupported command */
>> +            res =3D -ENOTSUP;
>> +            goto out;
>> +        }
>> +        /* thread specification. special values: (none), -1 =3D all; =
0 =3D any */
>> +        if ((p[0] =3D=3D ':' && p[1] =3D=3D '-' && p[2] =3D=3D '1') |=
| (p[0] !=3D ':')) {
>> +            if (*p =3D=3D ':') {
>> +                p +=3D 3;
>> +            }
>> +            for (idx =3D 0; idx < max_cpus; idx++) {
>> +                if (newstates[idx] =3D=3D 1) {
>> +                    newstates[idx] =3D cur_action;
>> +                }
>> +            }
>> +        } else if (*p =3D=3D ':') {
>> +            p++;
>> +            res =3D qemu_strtoul(p, &p, 16, &tmp);
>> +            if (res) {
>> +                goto out;
>> +            }
>> +            idx =3D tmp;
>> +            /* 0 means any thread, so we pick the first valid CPU */
>> +            if (!idx) {
>> +                idx =3D cpu_index(first_cpu);
>> +            }
>> +
>> +            /*
>> +             * If we are in user mode, the thread specified is actual=
ly a
>> +             * thread id, and not an index. We need to find the actua=
l
>> +             * CPU first, and only then we can use its index.
>> +             */
>> +            cpu =3D find_cpu(idx);
>> +            /* invalid CPU/thread specified */
>> +            if (!idx || !cpu) {
>> +                res =3D -EINVAL;
>> +                goto out;
>> +            }
>> +            /* only use if no previous match occourred */
>> +            if (newstates[cpu->cpu_index] =3D=3D 1) {
>> +                newstates[cpu->cpu_index] =3D cur_action;
>> +            }
>> +        }
>> +    }
>> +    s->signal =3D signal;
>> +    gdb_continue_partial(s, newstates);
>> +
>> +out:
>> +    g_free(newstates);
>> +
>> +    return res;
>> +}
>> +
>>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>>  {
>>      CPUState *cpu;
>> @@ -830,60 +985,20 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>>          return RS_IDLE;
>>      case 'v':
>>          if (strncmp(p, "Cont", 4) =3D=3D 0) {
>> -            int res_signal, res_thread;
>> -
>>              p +=3D 4;
>>              if (*p =3D=3D '?') {
>>                  put_packet(s, "vCont;c;C;s;S");
>>                  break;
>>              }
>> -            res =3D 0;
>> -            res_signal =3D 0;
>> -            res_thread =3D 0;
>> -            while (*p) {
>> -                int action, signal;
>> -
>> -                if (*p++ !=3D ';') {
>> -                    res =3D 0;
>> -                    break;
>> -                }
>> -                action =3D *p++;
>> -                signal =3D 0;
>> -                if (action =3D=3D 'C' || action =3D=3D 'S') {
>> -                    signal =3D gdb_signal_to_target(strtoul(p, (char =
**)&p, 16));
>> -                    if (signal =3D=3D -1) {
>> -                        signal =3D 0;
>> -                    }
>> -                } else if (action !=3D 'c' && action !=3D 's') {
>> -                    res =3D 0;
>> -                    break;
>> -                }
>> -                thread =3D 0;
>> -                if (*p =3D=3D ':') {
>> -                    thread =3D strtoull(p+1, (char **)&p, 16);
>> -                }
>> -                action =3D tolower(action);
>> -                if (res =3D=3D 0 || (res =3D=3D 'c' && action =3D=3D =
's')) {
>> -                    res =3D action;
>> -                    res_signal =3D signal;
>> -                    res_thread =3D thread;
>> -                }
>> -            }
>> +
>> +            res =3D gdb_handle_vcont(s, p);
>> +
>>              if (res) {
>> -                if (res_thread !=3D -1 && res_thread !=3D 0) {
>> -                    cpu =3D find_cpu(res_thread);
>> -                    if (cpu =3D=3D NULL) {
>> -                        put_packet(s, "E22");
>> -                        break;
>> -                    }
>> -                    s->c_cpu =3D cpu;
>> -                }
>> -                if (res =3D=3D 's') {
>> -                    cpu_single_step(s->c_cpu, sstep_flags);
>> +                if ((res =3D=3D -EINVAL) || (res =3D=3D -ERANGE)) {
>> +                    put_packet(s, "E22");
>> +                    break;
>>                  }
>> -                s->signal =3D res_signal;
>> -                gdb_continue(s);
>> -                return RS_IDLE;
>> +                goto unknown_command;
>>              }
>>              break;
>>          } else {
>>
>=20
> Seems like no one is doing guest debugging with kvm on x86 except me,
> and I'm only doing it too infrequently now: This one broke that use cas=
e
> for SMP guests long ago. How was it tested?
>=20
> To reproduce the bug: set up an x86-64 guest kernel with > 1 core, brea=
k
> on some prominent syscall entry (e.g. sys_execve), continue the guest o=
n
> hit and it will quickly lock up, even after disabling the breakpoint
> again. Kernel version doesn't matter (was my first guess), gdb is
> 7.7.50.20140604-cvs (OpenSUSE) here.
>=20

I case it helps:

GNU gdb (GDB) 7.7.50.20140604-cvs
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying=
"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from vmlinux...done.
(gdb) tar rem :1234
Remote debugging using :1234
0xffffffff81719d51 in native_safe_halt () at ../arch/x86/include/asm/irqf=
lags.h:54
warning: Source file is more recent than executable.
54              asm volatile("hlt": : :"memory");
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0xffffffff81719d51 in native_safe_halt () at ../arch/x86/include/asm/irqf=
lags.h:54
54              asm volatile("hlt": : :"memory");
(gdb) set debug remote 1
(gdb) b sys_execve
Sending packet: $Hg4#e3...Ack
Packet received: OK
Sending packet: $g#67...Ack
Packet received: c023ef390088ffff000000000000000044be080000c9ffff00f70000=
000000000100000000000000c023ef390088ffff0000000000000000c8be080000c9ffff0=
100000000000000010000000000000010be080000c9ffff089a0082ffffffffc023ef3900=
88ffffc023ef390088ffff0300000000000000c023ef390088ffff519d7181ffffffff060=
2000010000000180000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000007f0300=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000ff000000ffffffffffffffffffffffff00ffffff70617273655f616e645f6578=
65637574414d4500000000000000000000000000000000000000000031000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000801f0000
Sending packet: $mffffffff811a3800,40#f3...Ack
Packet received: 5b5d415ce9aa65ebffe8a2e265004883ec10488974240848891424e8=
4c620000488b14244889c7488b742408e8cdfdffff48984883c410c3e873e26500554489
Sending packet: $mffffffff811a3809,1#c9...Ack
Packet received: e8
Breakpoint 1 at 0xffffffff811a3809: file ../fs/exec.c, line 1923.
(gdb) c
Continuing.
Sending packet: $Z0,ffffffff811a3809,1#12...Ack
Packet received: OK
Packet Z0 (software-breakpoint) is supported
Sending packet: $vCont;c#a8...Ack
Packet received: T05thread:01;
Sending packet: $g#67...Ack
Packet received: 3b0000000000000058bfc00000c9ffff60f1d015ff7f0000e0f07300=
0000000090b673000000000090436b00000000003b0000000000000030bfc00000c9ffff4=
0bd73000000000060b37300000000000000000000000000000000000000000000a8523700=
88ffff00000000000000000000000000000000000000000000000009381a81ffffffff020=
2000010000000180000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000007f0300=
0000000000000000000000000000000000000000000000000000000000ff0000000000000=
00000000000ffffff00000000000000000000000000000000ff0000000000000000000000=
00ffffff000000000000000000ff00ffffffffff000000000000000031000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000801f0000
Sending packet: $Hg4#e3...Ack
Packet received: OK
Sending packet: $g#67...Ack
Packet received: c023ef390088ffff000000000000000001000000000000004013da3f=
0088ffff0100000000000000c023ef390088ffff0000000000000000c8be080000c9ffff0=
100000000000000010000000000000080bd080000c9ffff88af0383ffffffffc023ef3900=
88ffffc023ef390088ffff0300000000000000c023ef390088ffff519d7181ffffffff060=
2000010000000180000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000007f0300=
0000010000000000000000000000000000000000000000000000000000000000000000000=
00000ffffffffffff00000000000000000000000000000000000000000000000000000000=
0000000000000000ff00000000000000ff00000074726163743d2f646275732d7666732d0=
0000000008064400000000000000000fefdfdfdfdfded3f00000000000000000000000000=
00f03f0000000000000000000000000000944000000000000000000000000000008e40000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000a01f0000
Sending packet: $z0,ffffffff811a3809,1#32...Ack
Packet received: OK

Sending packet: $Hg1#e0...Ack
Packet received: OK
Sending packet: $mffffc90000c0bf30,8#83...Ack
Packet received: ae180081ffffffff
Sending packet: $mffffc90000c0bf30,8#83...Ack
Packet received: ae180081ffffffff
Breakpoint 1, SyS_execve (filename=3D7029648, argv=3D7583376, envp=3D7598=
304) at ../fs/exec.c:1923
warning: Source file is more recent than executable.
(gdb) c
Continuing.
Sending packet: $vCont;s:1#23...Ack
Packet received: T05thread:01;
Sending packet: $g#67...Ack
Packet received: 0020000000c9ffff46000000000000000c3fc03f0088ffff8287ac56=
00000000f1a60381fffffffff1a60381ffffffff000000006622ab56383fc03f0088ffff0=
1000000000000000100000000000000d83ec03f0088ffff88af0383ffffffff18bec13f00=
88ffff98bec13f0088ffff18bfc13f0088ffff0a180000000000004da70381ffffffff460=
0000010000000180000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000007f0300=
0000000000000000000000000000000000000000000000000000000000ff0000000000000=
00000000000ffffff00000000000000000000000000000000ff0000000000000000000000=
00ffffff000000000000000000ff00ffffffffff000000000000000031000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000801f0000
Sending packet: $Z0,ffffffff811a3809,1#12...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T05thread:01;
Sending packet: $g#67...Ack
Packet received: 3b0000000000000058bfc00000c9ffff60f1d015ff7f0000e0f07300=
0000000090b673000000000090436b00000000003b0000000000000030bfc00000c9ffff4=
0bd73000000000060b37300000000000000000000000000000000000000000000a8523700=
88ffff00000000000000000000000000000000000000000000000009381a81ffffffff020=
3000010000000180000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000007f0300=
0000000000000000000000000000000000000000000000000000000000ff0000000000000=
00000000000ffffff00000000000000000000000000000000ff0000000000000000000000=
00ffffff000000000000000000ff00ffffffffff000000000000000031000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000801f0000
Sending packet: $Hg4#e3...Ack
Packet received: OK
Sending packet: $g#67...Ack
Packet received: c023ef390088ffff000000000000000001000000000000004013da3f=
0088ffff0100000000000000c023ef390088ffff0000000000000000c8be080000c9ffff0=
100000000000000010000000000000080bd080000c9ffff88af0383ffffffffc023ef3900=
88ffffc023ef390088ffff0300000000000000c023ef390088ffff519d7181ffffffff060=
2000010000000180000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000007f0300=
0000010000000000000000000000000000000000000000000000000000000000000000000=
00000ffffffffffff00000000000000000000000000000000000000000000000000000000=
0000000000000000ff00000000000000ff00000074726163743d2f646275732d7666732d0=
0000000008064400000000000000000fefdfdfdfdfded3f00000000000000000000000000=
00f03f0000000000000000000000000000944000000000000000000000000000008e40000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000a01f0000
Sending packet: $z0,ffffffff811a3809,1#32...Ack
Packet received: OK

Sending packet: $Hg1#e0...Ack
Packet received: OK
Sending packet: $mffffc90000c0bf30,8#83...Ack
Packet received: ae180081ffffffff
Sending packet: $mffffc90000c0bf30,8#83...Ack
Packet received: ae180081ffffffff
Breakpoint 1, SyS_execve (filename=3D7029648, argv=3D7583376, envp=3D7598=
304) at ../fs/exec.c:1923
(gdb) c
Continuing.
Sending packet: $vCont;s:1#23...Ack

=2E..and now the guest is dead. I can still interrupt it, but it's
otherwise not working properly.

Jan


--OBOw6dF6xLPE6RXgLNrTgdlMQHG0gQWqo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqH8N0ACgkQitSsb3rl5xS5hwCeJ85bQk3mkfvikffPHQuNVqMd
24kAn34dOfSyUugleFcHLkVbMcgMYBGx
=9Xl7
-----END PGP SIGNATURE-----

--OBOw6dF6xLPE6RXgLNrTgdlMQHG0gQWqo--
