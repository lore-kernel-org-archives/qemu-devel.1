Received: from eggs.gnu.org ([2001:4830:134:3::10]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG4uX-0004FB-HO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG4uT-00067E-KS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:47:45 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG4uT-00064U-CT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:47:41 -0400
Received: by mail-wm0-x229.google.com with SMTP id 7so121608984wmo.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:47:39 -0700 (PDT)
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
Date: Wed, 31 May 2017 15:47:53 +0100
Message-ID: <871sr5t752.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>
> When GDB issues a "vCont", QEMU was not handling it correctly when
> multiple VCPUs are active.
> For vCont, for each thread (VCPU), it can be specified whether to
> single step, continue or stop that thread. The default is to stop a
> thread.
<snip>
>
> +/**
> + * gdb_handle_vcont - Parses and handles a vCont packet.
> + * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if there is
> + *         a format error, 0 on success.
> + */
> +static int gdb_handle_vcont(GDBState *s, const char *p)
> +{
> +    int res, idx, signal = 0;
> +    char cur_action;
> +    char *newstates;
> +    unsigned long tmp;
> +    CPUState *cpu;
> +#ifdef CONFIG_USER_ONLY
> +    int max_cpus = 1; /* global variable max_cpus exists only in system mode */
> +
> +    CPU_FOREACH(cpu) {
> +        max_cpus = max_cpus <= cpu->cpu_index ? cpu->cpu_index + 1 : max_cpus;
> +    }
> +#endif
> +    /* uninitialised CPUs stay 0 */
> +    newstates = g_new0(char, max_cpus);
> +
> +    /* mark valid CPUs with 1 */
> +    CPU_FOREACH(cpu) {
> +        newstates[cpu->cpu_index] = 1;
> +    }
> +
> +    /*
> +     * res keeps track of what error we are returning, with -ENOTSUP meaning
> +     * that the command is unknown or unsupported, thus returning an empty
> +     * packet, while -EINVAL and -ERANGE cause an E22 packet, due to invalid,
> +     *  or incorrect parameters passed.
> +     */
> +    res = 0;
> +    while (*p) {
> +        if (*p++ != ';') {
> +            res = -ENOTSUP;
> +            goto out;
> +        }
> +
> +        cur_action = *p++;
> +        if (cur_action == 'C' || cur_action == 'S') {
> +            cur_action = tolower(cur_action);
> +            res = qemu_strtoul(p + 1, &p, 16, &tmp);
> +            if (res) {
> +                goto out;
> +            }
> +            signal = gdb_signal_to_target(tmp);
> +        } else if (cur_action != 'c' && cur_action != 's') {
> +            /* unknown/invalid/unsupported command */
> +            res = -ENOTSUP;
> +            goto out;
> +        }
> +        /* thread specification. special values: (none), -1 = all; 0 = any */
> +        if ((p[0] == ':' && p[1] == '-' && p[2] == '1') || (p[0] != ':')) {
> +            if (*p == ':') {
> +                p += 3;
> +            }
> +            for (idx = 0; idx < max_cpus; idx++) {
> +                if (newstates[idx] == 1) {
> +                    newstates[idx] = cur_action;
> +                }
> +            }
> +        } else if (*p == ':') {
> +            p++;
> +            res = qemu_strtoul(p, &p, 16, &tmp);
> +            if (res) {
> +                goto out;
> +            }
> +            idx = tmp;
> +            /* 0 means any thread, so we pick the first valid CPU */
> +            if (!idx) {
> +                idx = cpu_index(first_cpu);
> +            }
> +
> +            /*
> +             * If we are in user mode, the thread specified is actually a
> +             * thread id, and not an index. We need to find the actual
> +             * CPU first, and only then we can use its index.
> +             */
> +            cpu = find_cpu(idx);
> +            /* invalid CPU/thread specified */
> +            if (!idx || !cpu) {
> +                res = -EINVAL;
> +                goto out;
> +            }

This fails on a packet like vCont;C04:0;c where we do find a cpu but it
happens to have a internal cpu_index of 0.

I'm sending a patch.

--
Alex Bennée
