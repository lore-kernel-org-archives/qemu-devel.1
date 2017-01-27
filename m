Received: from eggs.gnu.org ([2001:4830:134:3::10]:57389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cXAC1-00082X-KH
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cXABt-0007CI-CC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:20:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cXABt-0007BO-3L
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:20:01 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0RHJWCv070450
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 12:20:00 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2884k9xkwv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 12:19:59 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 17:19:57 -0000
References: <1476445983-16661-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1476445983-16661-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<87lgtw8m9v.fsf@linaro.org>
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 18:19:53 +0100
MIME-Version: 1.0
In-Reply-To: <87lgtw8m9v.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <edf3d939-0e77-9392-94b0-21328163a222@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 27/01/17 18:07, Alex Benn=C3=A9e wrote:
>=20
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> writes:
>=20
>> When GDB issues a "vCont", QEMU was not handling it correctly when
>> multiple VCPUs are active.
>> For vCont, for each thread (VCPU), it can be specified whether to
>> single step, continue or stop that thread. The default is to stop a
>> thread.
>> However, when (for example) "vCont;s:2" is issued, all VCPUs continue
>> to run, although all but VCPU nr 2 are to be stopped.
>>
>> This patch:
>> * adds some additional helper functions to selectively restart only
>>   some CPUs
>> * completely rewrites the vCont parsing code
>>
>> Please note that this improvement only works in system emulation mode,
>> when in userspace emulation mode the old behaviour is preserved.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> ---
>>  gdbstub.c | 226 +++++++++++++++++++++++++++++++++++++++++++++++++----=
---------
>>  1 file changed, 179 insertions(+), 47 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index ecea8c4..ea42afa 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -386,6 +386,61 @@ static inline void gdb_continue(GDBState *s)
>>  #endif
>>  }
>>
>> +static void gdb_single_step_cpus(CPUState **scpus, int flags)
>> +{
>> +    CPUState *cpu;
>> +    int cx;
>> +
>> +    if (!scpus) {
>> +        CPU_FOREACH(cpu) {
>> +            cpu_single_step(cpu, flags);
>> +        }
>> +    } else {
>> +        for (cx =3D 0; scpus[cx]; cx++) {
>> +            cpu_single_step(scpus[cx], flags);
>> +        }
>> +    }
>> +}
>=20
> I missed this last time but as gdb_single_step_cpus() is only called fo=
r
> system emulation it breaks the linux-user compilation with:
>=20
>   error: =E2=80=98gdb_single_step_cpus=E2=80=99 defined but not used [-=
Werror=3Dunused-function]

that function is not there any longer in the patch I sent yesterday (v6)

I'm about to send a v7 to update the description of the first patch.

>> +
>> +/*
>> + * Resume execution, per CPU actions. For user-more emulation it's
>> + * equivalent to gdb_continue .
>> + */
>> +static int gdb_continue_partial(GDBState *s, char def, CPUState **scp=
us,
>> +                                                            CPUState =
**ccpus)
>> +{
>> +    int res =3D 0;
>> +#ifdef CONFIG_USER_ONLY
>> +    s->running_state =3D 1;
>> +#else
>> +    if (!runstate_needs_reset()) {
>> +        if (vm_prepare_start()) {
>> +            return 0;
>> +        }
>> +
>> +        if (def =3D=3D 0) {
>> +            gdb_single_step_cpus(scpus, sstep_flags);
>> +            /* CPUs not in scpus or ccpus stay stopped */
>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>> +            resume_some_vcpus(scpus);
>> +            resume_some_vcpus(ccpus);
>> +        } else if (def =3D=3D 'c' || def =3D=3D 'C') {
>> +            gdb_single_step_cpus(scpus, sstep_flags);
>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>> +            resume_all_vcpus();
>> +        } else if (def =3D=3D 's' || def =3D=3D 'S') {
>> +            gdb_single_step_cpus(NULL, sstep_flags);
>> +            gdb_single_step_cpus(ccpus, 0);
>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>> +            resume_all_vcpus();
>> +        } else {
>> +            res =3D -1;
>> +        }
>> +    }
>> +#endif
>> +    return res;
>> +}
>> +
>>  static void put_buffer(GDBState *s, const uint8_t *buf, int len)
>>  {
>>  #ifdef CONFIG_USER_ONLY
>> @@ -784,6 +839,123 @@ static int is_query_packet(const char *p, const =
char *query, char separator)
>>          (p[query_len] =3D=3D '\0' || p[query_len] =3D=3D separator);
>>  }
>>
>> +/**
>> + * gdb_handle_vcont - Parses and handles a vCont packet.
>> + * returns -1 if a command is unsupported, -22 if there is a format e=
rror,
>> + *         0 on success.
>> + */
>> +static int gdb_handle_vcont(GDBState *s, const char *p)
>> +{
>> +    CPUState **s_cpus, **c_cpus;
>> +    CPUState *curcpu;
>> +    int res, idx, signal, scnt, ccnt;
>> +    char cur_action, default_action, broadcast_action;
>> +    unsigned long tmp;
>> +
>> +    /*
>> +     * For us: vCont[;action[:thread-id]]...
>> +     * where action can be one of c s C<sig> S<sig>
>> +     */
>> +    for (idx =3D scnt =3D 0; p[idx]; idx++) {
>> +        if (p[idx] =3D=3D ';') {
>> +            scnt++;
>> +        }
>> +    }
>> +    s_cpus =3D g_new(CPUState *, scnt + 1);
>> +    c_cpus =3D g_new(CPUState *, scnt + 1);
>> +    scnt =3D ccnt =3D signal =3D 0;
>> +    default_action =3D broadcast_action =3D 0;
>> +
>> +    /*
>> +     * res keeps track of what error we are returning, with -1 meanin=
g
>> +     * that the command is unknown or unsupported, and thus returning
>> +     * an empty packet, while -22 returns an E22 packet due to
>> +     * invalid or incorrect parameters passed.
>> +     */
>> +    res =3D 0;
>> +    while (*p) {
>> +        if (*p !=3D ';') {
>> +            res =3D -1;
>> +            break;
>> +        }
>> +        p++; /* skip the ; */
>> +
>> +        /* unknown/invalid/unsupported command */
>> +        if (*p !=3D 'C' && *p !=3D 'S' && *p !=3D 'c' && *p !=3D 's')=
 {
>> +            res =3D -1;
>> +            break;
>> +        }
>> +        cur_action =3D *p;
>> +        if (*p =3D=3D 'C' || *p =3D=3D 'S') {
>> +            if (qemu_strtoul(p + 1, &p, 16, &tmp)) {
>> +                res =3D -22;
>> +                break;
>> +            }
>> +            signal =3D gdb_signal_to_target(tmp);
>> +        } else {
>> +            p++;
>> +        }
>> +        /* thread specified. special values: -1 =3D all, 0 =3D any */
>> +        if (*p =3D=3D ':') {
>> +            /*
>> +             * cannot specify an action for a single thread when an a=
ction
>> +             * was already specified for all threads
>> +             */
>> +            if (broadcast_action) {
>> +                res =3D -22;
>> +                break;
>> +            }
>> +            p++;
>> +            if ((p[0] =3D=3D '-') && (p[1] =3D=3D '1')) {
>> +                /*
>> +                 * specifying an action for all threads when some thr=
eads
>> +                 * already have actions.
>> +                 */
>> +                if (scnt || ccnt) {
>> +                    res =3D -22;
>> +                    break;
>> +                }
>> +                broadcast_action =3D cur_action;
>> +                p +=3D 2;
>> +                continue;
>> +            }
>> +            if (qemu_strtoul(p, &p, 16, &tmp)) {
>> +                res =3D -22;
>> +                break;
>> +            }
>> +            /* 0 means any thread, so we pick the first */
>> +            idx =3D tmp ? tmp : 1;
>> +            curcpu =3D find_cpu(idx);
>> +            if (!curcpu) {
>> +                res =3D -22;
>> +                break;
>> +            }
>> +            if (cur_action =3D=3D 's' || cur_action =3D=3D 'S') {
>> +                s_cpus[scnt++] =3D curcpu;
>> +            } else {
>> +                c_cpus[ccnt++] =3D curcpu;
>> +            }
>> +        } else { /* no thread specified */
>> +            if (default_action !=3D 0) {
>> +                res =3D -22; /* error, can't specify multiple default=
s! */
>> +                break;
>> +            }
>> +            default_action =3D cur_action;
>> +        }
>> +    }
>> +    if (!res) {
>> +        s->signal =3D signal;
>> +        s_cpus[scnt] =3D c_cpus[ccnt] =3D NULL;
>> +        default_action =3D broadcast_action ? broadcast_action : defa=
ult_action;
>> +        gdb_continue_partial(s, default_action, s_cpus, c_cpus);
>> +    }
>> +
>> +    g_free(s_cpus);
>> +    g_free(c_cpus);
>> +
>> +    return res;
>> +}
>> +
>>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>>  {
>>      CPUState *cpu;
>> @@ -829,60 +1001,20 @@ static int gdb_handle_packet(GDBState *s, const=
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
>> +                if (res =3D=3D -22) {
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
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
