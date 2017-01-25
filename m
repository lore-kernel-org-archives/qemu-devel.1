Received: from eggs.gnu.org ([2001:4830:134:3::10]:39443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWKuE-0006ab-1U
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWKuA-0001fe-Te
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:34:22 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWKuA-0001cy-KI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:34:18 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so41634386wme.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 02:34:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1477674916-6795-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1477674916-6795-3-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35659f5a-cefe-29ce-ac5b-7959f476fb19@redhat.com>
Date: Wed, 25 Jan 2017 11:34:14 +0100
MIME-Version: 1.0
In-Reply-To: <1477674916-6795-3-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: palves@redhat.com, borntraeger@de.ibm.com



On 28/10/2016 19:15, Claudio Imbrenda wrote:
> When GDB issues a "vCont", QEMU was not handling it correctly when
> multiple VCPUs are active.
> For vCont, for each thread (VCPU), it can be specified whether to
> single step, continue or stop that thread. The default is to stop a
> thread.
> However, when (for example) "vCont;s:2" is issued, all VCPUs continue
> to run, although all but VCPU nr 2 are to be stopped.
> 
> This patch completely rewrites the vCont parsing code.
> 
> Please note that this improvement only works in system emulation mode,
> when in userspace emulation mode the old behaviour is preserved.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  gdbstub.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 142 insertions(+), 47 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index b2e1b79..9bb548f 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -386,6 +386,45 @@ static inline void gdb_continue(GDBState *s)
>  #endif
>  }
>  
> +/*
> + * Resume execution, per CPU actions. For user-more emulation it's
> + * equivalent to gdb_continue .
> + */
> +static int gdb_continue_partial(GDBState *s, char *newstates)
> +{
> +    int res = 0;
> +#ifdef CONFIG_USER_ONLY
> +    s->running_state = 1;
> +#else
> +    CPUState *cpu;
> +
> +    if (!runstate_needs_reset()) {
> +        if (vm_prepare_start()) {
> +            return 0;
> +        }
> +
> +        CPU_FOREACH(cpu) {
> +            switch (newstates[cpu_index(cpu) - 1]) {
> +            case 0:
> +            case 1:
> +                break; /* nothing to do here */
> +            case 's':
> +                cpu_single_step(cpu, sstep_flags);
> +                cpu_resume(cpu);
> +                break;
> +            case 'c':
> +                cpu_resume(cpu);
> +                break;
> +            default:
> +                res = -1;
> +                break;
> +            }
> +        }
> +    }
> +#endif
> +    return res;
> +}
> +
>  static void put_buffer(GDBState *s, const uint8_t *buf, int len)
>  {
>  #ifdef CONFIG_USER_ONLY
> @@ -784,6 +823,102 @@ static int is_query_packet(const char *p, const char *query, char separator)
>          (p[query_len] == '\0' || p[query_len] == separator);
>  }
>  
> +/**
> + * gdb_handle_vcont - Parses and handles a vCont packet.
> + * returns -1 if a command is unsupported, -22 if there is a format error,
> + *         0 on success.
> + */
> +static int gdb_handle_vcont(GDBState *s, const char *p)
> +{
> +    int res, idx, signal = 0;
> +    char cur_action;
> +    char *newstates;
> +    unsigned long tmp;
> +    CPUState *cpu;
> +
> +    /* uninitialised CPUs stay 0 */
> +    newstates = g_new0(char, max_cpus);
> +
> +    /* mark valid CPUs with 1 */
> +    CPU_FOREACH(cpu) {
> +        newstates[cpu_index(cpu) - 1] = 1;
> +    }
> +
> +    /*
> +     * res keeps track of what error we are returning, with -1 meaning
> +     * that the command is unknown or unsupported, and thus returning
> +     * an empty packet, while -22 returns an E22 packet due to
> +     * invalid or incorrect parameters passed.
> +     */

Please use ENOTSUP for unknown/unsupported and any other negative errno
value for invalid/incorrect parameters.  This simplifies the code a bit
in this function, as we know that qemu_strtoul only returns -EINVAL or
-ERANGE.

> +    res = 0;
> +    while (*p) {
> +        if (*p != ';') {

Use *p++ here.

> +            res = -1;
> +            break;

If you change all returns with error to a "goto out", you can avoid the
"if (!res)" at the end of the loop.

> +        }
> +        p++; /* skip the ; */
> +
> +        /* unknown/invalid/unsupported command */
> +        if (*p != 'C' && *p != 'S' && *p != 'c' && *p != 's') {
> +            res = -1;
> +            break;
> +        }
> +        cur_action = tolower(*p);
> +        if (*p == 'C' || *p == 'S') {
> +            if (qemu_strtoul(p + 1, &p, 16, &tmp)) {
> +                res = -22;
> +                break;
> +            }
> +            signal = gdb_signal_to_target(tmp);
> +        } else {
> +            p++;
> +        }

Maybe:

	cur_action = *p++;
	if (cur_action == 'C' || cur_action == 'S') {
	    cur_action = tolower(cur_action);
	    res = qemu_strtoul(p, &p, 16, &tmp);
            if (res < 0) {
                goto out;
            }
	} else if (cur_action != 'c' && cur_action != 's') {
	    res = -ENOTSUP;
	    goto out;
	}

What's the meaning of "signal" for system emulation?

> +        /* thread specification. special values: (none), -1 = all; 0 = any */
> +        if ((p[0] == ':' && p[1] == '-' && p[2] == '1') || (p[0] != ':')) {
> +            for (idx = 0; idx < max_cpus; idx++) {
> +                if (newstates[idx] == 1) {
> +                    newstates[idx] = cur_action;
> +                }
> +            }
> +            if (*p == ':') {
> +                p += 3;
> +            }

Please place this "if" before the "for", to match what you do in the
"else if" case.

> +        } else if (*p == ':') {
> +            p++;
> +            if (qemu_strtoul(p, &p, 16, &tmp)) {
> +                res = -22;
> +                break;
> +            }

As suggested above, you can just assign the result of qemu_strtoul to res.

> +            idx = tmp;
> +            /* 0 means any thread, so we pick the first valid CPU */
> +            if (!idx) {
> +                CPU_FOREACH(cpu) {
> +                    idx = cpu_index(cpu);
> +                    break;
> +                }

Can you use first_cpu here perhaps?

> +            }
> +
> +            /* invalid CPU specified */
> +            if (!idx || idx > max_cpus || !newstates[idx - 1]) {
> +                res = -22;
> +                break;
> +            }
> +            /* only use if no previous match occourred */
> +            if (newstates[idx - 1] == 1) {
> +                newstates[idx - 1] = cur_action;
> +            }
> +        }
> +    }
> +    if (!res) {
> +        s->signal = signal;
> +        gdb_continue_partial(s, newstates);
> +    }
> +

This would be the placement of the "out:" label.

Thanks,

Paolo

> +    g_free(newstates);
> +
> +    return res;
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -829,60 +964,20 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>          return RS_IDLE;
>      case 'v':
>          if (strncmp(p, "Cont", 4) == 0) {
> -            int res_signal, res_thread;
> -
>              p += 4;
>              if (*p == '?') {
>                  put_packet(s, "vCont;c;C;s;S");
>                  break;
>              }
> -            res = 0;
> -            res_signal = 0;
> -            res_thread = 0;
> -            while (*p) {
> -                int action, signal;
> -
> -                if (*p++ != ';') {
> -                    res = 0;
> -                    break;
> -                }
> -                action = *p++;
> -                signal = 0;
> -                if (action == 'C' || action == 'S') {
> -                    signal = gdb_signal_to_target(strtoul(p, (char **)&p, 16));
> -                    if (signal == -1) {
> -                        signal = 0;
> -                    }
> -                } else if (action != 'c' && action != 's') {
> -                    res = 0;
> -                    break;
> -                }
> -                thread = 0;
> -                if (*p == ':') {
> -                    thread = strtoull(p+1, (char **)&p, 16);
> -                }
> -                action = tolower(action);
> -                if (res == 0 || (res == 'c' && action == 's')) {
> -                    res = action;
> -                    res_signal = signal;
> -                    res_thread = thread;
> -                }
> -            }
> +
> +            res = gdb_handle_vcont(s, p);
> +
>              if (res) {
> -                if (res_thread != -1 && res_thread != 0) {
> -                    cpu = find_cpu(res_thread);
> -                    if (cpu == NULL) {
> -                        put_packet(s, "E22");
> -                        break;
> -                    }
> -                    s->c_cpu = cpu;
> -                }
> -                if (res == 's') {
> -                    cpu_single_step(s->c_cpu, sstep_flags);
> +                if (res == -22) {
> +                    put_packet(s, "E22");
> +                    break;
>                  }
> -                s->signal = res_signal;
> -                gdb_continue(s);
> -                return RS_IDLE;
> +                goto unknown_command;
>              }
>              break;
>          } else {
> 
