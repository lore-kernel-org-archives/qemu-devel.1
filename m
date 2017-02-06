Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cag6S-0001w2-4g
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cag6K-0008SA-KL
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:00:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cag6K-0008Rc-Df
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:00:48 -0500
References: <1485540693-31723-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1485540693-31723-3-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63aaa3cc-6623-374d-8f8f-4e48fbbc21ce@redhat.com>
Date: Mon, 6 Feb 2017 11:00:43 +0100
MIME-Version: 1.0
In-Reply-To: <1485540693-31723-3-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com, alex.bennee@linaro.org



On 27/01/2017 19:11, Claudio Imbrenda wrote:
> +    /* mark valid CPUs with 1 */
> +    CPU_FOREACH(cpu) {
> +        newstates[cpu_index(cpu) - 1] = 1;
> +    }

Sorry I didn't notice this before: CPU indices are zero-based in QEMU,
so you are probably overwriting newstates[-1].  I can adjust it myself,
but can you please double check?

Paolo

> +
> +    /*
> +     * res keeps track of what error we are returning, with -1 meaning
> +     * that the command is unknown or unsupported, and thus returning
> +     * an empty packet, while -22 returns an E22 packet due to
> +     * invalid or incorrect parameters passed.
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
> +            /* invalid CPU specified */
> +            if (!idx || idx > max_cpus || !newstates[idx - 1]) {
> +                res = -EINVAL;
> +                goto out;
> +            }
> +            /* only use if no previous match occourred */
> +            if (newstates[idx - 1] == 1) {
> +                newstates[idx - 1] = cur_action;
> +            }
> +        }
