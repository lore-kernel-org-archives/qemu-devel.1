Received: from eggs.gnu.org ([2001:4830:134:3::10]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cXAOy-00050O-3J
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cXAOu-0003Oz-3m
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:33:32 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cXAOt-0003Nl-PW
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:33:28 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c206so149946862wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 09:33:27 -0800 (PST)
References: <1476445983-16661-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1476445983-16661-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<87lgtw8m9v.fsf@linaro.org>
	<edf3d939-0e77-9392-94b0-21328163a222@linux.vnet.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <edf3d939-0e77-9392-94b0-21328163a222@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 17:33:24 +0000
Message-ID: <87h94k8l23.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org


Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> writes:

> On 27/01/17 18:07, Alex Bennée wrote:
>>
>> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> writes:
>>
>>> When GDB issues a "vCont", QEMU was not handling it correctly when
>>> multiple VCPUs are active.
>>> For vCont, for each thread (VCPU), it can be specified whether to
>>> single step, continue or stop that thread. The default is to stop a
>>> thread.
>>> However, when (for example) "vCont;s:2" is issued, all VCPUs continue
>>> to run, although all but VCPU nr 2 are to be stopped.
>>>
>>> This patch:
>>> * adds some additional helper functions to selectively restart only
>>>   some CPUs
>>> * completely rewrites the vCont parsing code
>>>
>>> Please note that this improvement only works in system emulation mode,
>>> when in userspace emulation mode the old behaviour is preserved.
>>>
>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>> ---
>>>  gdbstub.c | 226 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
>>>  1 file changed, 179 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index ecea8c4..ea42afa 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -386,6 +386,61 @@ static inline void gdb_continue(GDBState *s)
>>>  #endif
>>>  }
>>>
>>> +static void gdb_single_step_cpus(CPUState **scpus, int flags)
>>> +{
>>> +    CPUState *cpu;
>>> +    int cx;
>>> +
>>> +    if (!scpus) {
>>> +        CPU_FOREACH(cpu) {
>>> +            cpu_single_step(cpu, flags);
>>> +        }
>>> +    } else {
>>> +        for (cx = 0; scpus[cx]; cx++) {
>>> +            cpu_single_step(scpus[cx], flags);
>>> +        }
>>> +    }
>>> +}
>>
>> I missed this last time but as gdb_single_step_cpus() is only called for
>> system emulation it breaks the linux-user compilation with:
>>
>>   error: ‘gdb_single_step_cpus’ defined but not used [-Werror=unused-function]
>
> that function is not there any longer in the patch I sent yesterday (v6)
>
> I'm about to send a v7 to update the description of the first patch.

OK, please CC me when you send it out.

>
>>> +
>>> +/*
>>> + * Resume execution, per CPU actions. For user-more emulation it's
>>> + * equivalent to gdb_continue .
>>> + */
>>> +static int gdb_continue_partial(GDBState *s, char def, CPUState **scpus,
>>> +                                                            CPUState **ccpus)
>>> +{
>>> +    int res = 0;
>>> +#ifdef CONFIG_USER_ONLY
>>> +    s->running_state = 1;
>>> +#else
>>> +    if (!runstate_needs_reset()) {
>>> +        if (vm_prepare_start()) {
>>> +            return 0;
>>> +        }
>>> +
>>> +        if (def == 0) {
>>> +            gdb_single_step_cpus(scpus, sstep_flags);
>>> +            /* CPUs not in scpus or ccpus stay stopped */
>>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>> +            resume_some_vcpus(scpus);
>>> +            resume_some_vcpus(ccpus);
>>> +        } else if (def == 'c' || def == 'C') {
>>> +            gdb_single_step_cpus(scpus, sstep_flags);
>>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>> +            resume_all_vcpus();
>>> +        } else if (def == 's' || def == 'S') {
>>> +            gdb_single_step_cpus(NULL, sstep_flags);
>>> +            gdb_single_step_cpus(ccpus, 0);
>>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>> +            resume_all_vcpus();
>>> +        } else {
>>> +            res = -1;
>>> +        }
>>> +    }
>>> +#endif
>>> +    return res;
>>> +}
>>> +
>>>  static void put_buffer(GDBState *s, const uint8_t *buf, int len)
>>>  {
>>>  #ifdef CONFIG_USER_ONLY
>>> @@ -784,6 +839,123 @@ static int is_query_packet(const char *p, const char *query, char separator)
>>>          (p[query_len] == '\0' || p[query_len] == separator);
>>>  }
>>>
>>> +/**
>>> + * gdb_handle_vcont - Parses and handles a vCont packet.
>>> + * returns -1 if a command is unsupported, -22 if there is a format error,
>>> + *         0 on success.
>>> + */
>>> +static int gdb_handle_vcont(GDBState *s, const char *p)
>>> +{
>>> +    CPUState **s_cpus, **c_cpus;
>>> +    CPUState *curcpu;
>>> +    int res, idx, signal, scnt, ccnt;
>>> +    char cur_action, default_action, broadcast_action;
>>> +    unsigned long tmp;
>>> +
>>> +    /*
>>> +     * For us: vCont[;action[:thread-id]]...
>>> +     * where action can be one of c s C<sig> S<sig>
>>> +     */
>>> +    for (idx = scnt = 0; p[idx]; idx++) {
>>> +        if (p[idx] == ';') {
>>> +            scnt++;
>>> +        }
>>> +    }
>>> +    s_cpus = g_new(CPUState *, scnt + 1);
>>> +    c_cpus = g_new(CPUState *, scnt + 1);
>>> +    scnt = ccnt = signal = 0;
>>> +    default_action = broadcast_action = 0;
>>> +
>>> +    /*
>>> +     * res keeps track of what error we are returning, with -1 meaning
>>> +     * that the command is unknown or unsupported, and thus returning
>>> +     * an empty packet, while -22 returns an E22 packet due to
>>> +     * invalid or incorrect parameters passed.
>>> +     */
>>> +    res = 0;
>>> +    while (*p) {
>>> +        if (*p != ';') {
>>> +            res = -1;
>>> +            break;
>>> +        }
>>> +        p++; /* skip the ; */
>>> +
>>> +        /* unknown/invalid/unsupported command */
>>> +        if (*p != 'C' && *p != 'S' && *p != 'c' && *p != 's') {
>>> +            res = -1;
>>> +            break;
>>> +        }
>>> +        cur_action = *p;
>>> +        if (*p == 'C' || *p == 'S') {
>>> +            if (qemu_strtoul(p + 1, &p, 16, &tmp)) {
>>> +                res = -22;
>>> +                break;
>>> +            }
>>> +            signal = gdb_signal_to_target(tmp);
>>> +        } else {
>>> +            p++;
>>> +        }
>>> +        /* thread specified. special values: -1 = all, 0 = any */
>>> +        if (*p == ':') {
>>> +            /*
>>> +             * cannot specify an action for a single thread when an action
>>> +             * was already specified for all threads
>>> +             */
>>> +            if (broadcast_action) {
>>> +                res = -22;
>>> +                break;
>>> +            }
>>> +            p++;
>>> +            if ((p[0] == '-') && (p[1] == '1')) {
>>> +                /*
>>> +                 * specifying an action for all threads when some threads
>>> +                 * already have actions.
>>> +                 */
>>> +                if (scnt || ccnt) {
>>> +                    res = -22;
>>> +                    break;
>>> +                }
>>> +                broadcast_action = cur_action;
>>> +                p += 2;
>>> +                continue;
>>> +            }
>>> +            if (qemu_strtoul(p, &p, 16, &tmp)) {
>>> +                res = -22;
>>> +                break;
>>> +            }
>>> +            /* 0 means any thread, so we pick the first */
>>> +            idx = tmp ? tmp : 1;
>>> +            curcpu = find_cpu(idx);
>>> +            if (!curcpu) {
>>> +                res = -22;
>>> +                break;
>>> +            }
>>> +            if (cur_action == 's' || cur_action == 'S') {
>>> +                s_cpus[scnt++] = curcpu;
>>> +            } else {
>>> +                c_cpus[ccnt++] = curcpu;
>>> +            }
>>> +        } else { /* no thread specified */
>>> +            if (default_action != 0) {
>>> +                res = -22; /* error, can't specify multiple defaults! */
>>> +                break;
>>> +            }
>>> +            default_action = cur_action;
>>> +        }
>>> +    }
>>> +    if (!res) {
>>> +        s->signal = signal;
>>> +        s_cpus[scnt] = c_cpus[ccnt] = NULL;
>>> +        default_action = broadcast_action ? broadcast_action : default_action;
>>> +        gdb_continue_partial(s, default_action, s_cpus, c_cpus);
>>> +    }
>>> +
>>> +    g_free(s_cpus);
>>> +    g_free(c_cpus);
>>> +
>>> +    return res;
>>> +}
>>> +
>>>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>>>  {
>>>      CPUState *cpu;
>>> @@ -829,60 +1001,20 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>>>          return RS_IDLE;
>>>      case 'v':
>>>          if (strncmp(p, "Cont", 4) == 0) {
>>> -            int res_signal, res_thread;
>>> -
>>>              p += 4;
>>>              if (*p == '?') {
>>>                  put_packet(s, "vCont;c;C;s;S");
>>>                  break;
>>>              }
>>> -            res = 0;
>>> -            res_signal = 0;
>>> -            res_thread = 0;
>>> -            while (*p) {
>>> -                int action, signal;
>>> -
>>> -                if (*p++ != ';') {
>>> -                    res = 0;
>>> -                    break;
>>> -                }
>>> -                action = *p++;
>>> -                signal = 0;
>>> -                if (action == 'C' || action == 'S') {
>>> -                    signal = gdb_signal_to_target(strtoul(p, (char **)&p, 16));
>>> -                    if (signal == -1) {
>>> -                        signal = 0;
>>> -                    }
>>> -                } else if (action != 'c' && action != 's') {
>>> -                    res = 0;
>>> -                    break;
>>> -                }
>>> -                thread = 0;
>>> -                if (*p == ':') {
>>> -                    thread = strtoull(p+1, (char **)&p, 16);
>>> -                }
>>> -                action = tolower(action);
>>> -                if (res == 0 || (res == 'c' && action == 's')) {
>>> -                    res = action;
>>> -                    res_signal = signal;
>>> -                    res_thread = thread;
>>> -                }
>>> -            }
>>> +
>>> +            res = gdb_handle_vcont(s, p);
>>> +
>>>              if (res) {
>>> -                if (res_thread != -1 && res_thread != 0) {
>>> -                    cpu = find_cpu(res_thread);
>>> -                    if (cpu == NULL) {
>>> -                        put_packet(s, "E22");
>>> -                        break;
>>> -                    }
>>> -                    s->c_cpu = cpu;
>>> -                }
>>> -                if (res == 's') {
>>> -                    cpu_single_step(s->c_cpu, sstep_flags);
>>> +                if (res == -22) {
>>> +                    put_packet(s, "E22");
>>> +                    break;
>>>                  }
>>> -                s->signal = res_signal;
>>> -                gdb_continue(s);
>>> -                return RS_IDLE;
>>> +                goto unknown_command;
>>>              }
>>>              break;
>>>          } else {
>>
>>
>> --
>> Alex Bennée
>>


--
Alex Bennée
