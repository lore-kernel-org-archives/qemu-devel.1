Received: from eggs.gnu.org ([2001:4830:134:3::10]:35625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cb2Yr-0004fp-Ts
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cb2Yn-0001FE-2L
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:59:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54421
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cb2Ym-0001Ei-Sm
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:59:41 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v179wfZu112666
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 04:59:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28euqwmqa5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 04:59:39 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Tue, 7 Feb 2017 09:59:37 -0000
References: <1485540693-31723-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1485540693-31723-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<63aaa3cc-6623-374d-8f8f-4e48fbbc21ce@redhat.com>
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Tue, 7 Feb 2017 10:59:33 +0100
MIME-Version: 1.0
In-Reply-To: <63aaa3cc-6623-374d-8f8f-4e48fbbc21ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <db1dcc0a-61fe-652b-b994-12fb3dc10780@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com, alex.bennee@linaro.org

On 06/02/17 11:00, Paolo Bonzini wrote:
> 
> 
> On 27/01/2017 19:11, Claudio Imbrenda wrote:
>> +    /* mark valid CPUs with 1 */
>> +    CPU_FOREACH(cpu) {
>> +        newstates[cpu_index(cpu) - 1] = 1;
>> +    }
> 
> Sorry I didn't notice this before: CPU indices are zero-based in QEMU,
> so you are probably overwriting newstates[-1].  I can adjust it myself,
> but can you please double check?

they are zero based in the struct, but the already existing cpu_index
function (include/exec/gdbstub.h) does this:

static inline int cpu_index(CPUState *cpu)
{
#if defined(CONFIG_USER_ONLY)
    return cpu->host_tid;
#else
    return cpu->cpu_index + 1;
#endif
}


maybe that can just become  newstates[cpu->cpu_index] = 1  ?
(since we're not in CONFIG_USER_ONLY anyway)


> Paolo
> 
>> +
>> +    /*
>> +     * res keeps track of what error we are returning, with -1 meaning
>> +     * that the command is unknown or unsupported, and thus returning
>> +     * an empty packet, while -22 returns an E22 packet due to
>> +     * invalid or incorrect parameters passed.
>> +     */
>> +    res = 0;
>> +    while (*p) {
>> +        if (*p++ != ';') {
>> +            res = -ENOTSUP;
>> +            goto out;
>> +        }
>> +
>> +        cur_action = *p++;
>> +        if (cur_action == 'C' || cur_action == 'S') {
>> +            cur_action = tolower(cur_action);
>> +            res = qemu_strtoul(p + 1, &p, 16, &tmp);
>> +            if (res) {
>> +                goto out;
>> +            }
>> +            signal = gdb_signal_to_target(tmp);
>> +        } else if (cur_action != 'c' && cur_action != 's') {
>> +            /* unknown/invalid/unsupported command */
>> +            res = -ENOTSUP;
>> +            goto out;
>> +        }
>> +        /* thread specification. special values: (none), -1 = all; 0 = any */
>> +        if ((p[0] == ':' && p[1] == '-' && p[2] == '1') || (p[0] != ':')) {
>> +            if (*p == ':') {
>> +                p += 3;
>> +            }
>> +            for (idx = 0; idx < max_cpus; idx++) {
>> +                if (newstates[idx] == 1) {
>> +                    newstates[idx] = cur_action;
>> +                }
>> +            }
>> +        } else if (*p == ':') {
>> +            p++;
>> +            res = qemu_strtoul(p, &p, 16, &tmp);
>> +            if (res) {
>> +                goto out;
>> +            }
>> +            idx = tmp;
>> +            /* 0 means any thread, so we pick the first valid CPU */
>> +            if (!idx) {
>> +                idx = cpu_index(first_cpu);
>> +            }
>> +
>> +            /* invalid CPU specified */
>> +            if (!idx || idx > max_cpus || !newstates[idx - 1]) {
>> +                res = -EINVAL;
>> +                goto out;
>> +            }
>> +            /* only use if no previous match occourred */
>> +            if (newstates[idx - 1] == 1) {
>> +                newstates[idx - 1] = cur_action;
>> +            }
>> +        }
> 
