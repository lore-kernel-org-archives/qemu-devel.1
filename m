Received: from eggs.gnu.org ([2001:4830:134:3::10]:57216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clc6J-0005dJ-9n
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clc6E-00064r-B2
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clc6E-00064m-4s
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:57:54 -0500
Date: Wed, 8 Mar 2017 10:57:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308135751.GE4694@thinpad.lan.raisama.net>
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308115909.GD10232@work-vm>
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org, Julian Kirsch <mail@kirschju.re>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

On Wed, Mar 08, 2017 at 11:59:11AM +0000, Dr. David Alan Gilbert wrote:
[...]
> > +MsrInfoList *qmp_msr_list(uint32_t msr_idx, Error **errp)
> > +{
> > +#ifdef TARGET_I386
> > +    bool valid;
> > +    X86CPU *cpu;
> > +    CPUX86State *env;
> > +    CPUState *cpu_state;
> > +    MsrInfoList *head = NULL, *cur_item = NULL;
> > +
> > +    CPU_FOREACH(cpu_state) {
> > +        cpu = X86_CPU(cpu_state);
> > +        env = &cpu->env;
> > +
> > +        cpu_synchronize_state(cpu_state);
> > +
> > +        MsrInfoList *info;
> > +        info = g_malloc0(sizeof(*info));
> > +        info->value = g_malloc0(sizeof(*info->value));
> > +
> > +        info->value->cpu_idx = cpu_state->cpu_index;
> > +        info->value->msr_idx = msr_idx;
> > +        info->value->value = x86_cpu_rdmsr(env, msr_idx, &valid);
> > +
> > +        if (!valid) {
> > +            error_setg(errp, "Failed to retreive MSR 0x%08x on CPU %u",
> > +                       msr_idx, cpu_state->cpu_index);
> > +            return head;
> > +        }
> > +
> > +        /* XXX: waiting for the qapi to support GSList */
> > +        if (!cur_item) {
> > +            head = cur_item = info;
> > +        } else {
> > +            cur_item->next = info;
> > +            cur_item = info;
> > +        }
> > +    }
> > +
> > +    return head;
> > +#else
> > +    error_setg(errp, "MSRs are not supported on this architecture");
> > +    return NULL;
> > +#endif
> > +}
> 
> This should be abstracted some how so that we don't need
> x86 specifics in cpus.c; perhaps just an architecture call
> back on the CPU.

If it's only supported by x86, I would just move the
implementation to a x86-specific file, and add a stub for the
other architectures. See qmp_query_gic_capabilities() for an
example.

Also, the command should be added to
qmp_unregister_commands_hack() so we don't even report it as
available on other architectures.

-- 
Eduardo
