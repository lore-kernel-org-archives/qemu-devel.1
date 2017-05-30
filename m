Received: from eggs.gnu.org ([2001:4830:134:3::10]:33495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFgo7-00051m-GH
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFgo4-0008T9-Dj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:03:31 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170526052319.28096-3-david@gibson.dropbear.id.au> (David
	Gibson's message of "Fri, 26 May 2017 15:23:16 +1000")
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-3-david@gibson.dropbear.id.au>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 15:03:23 +0200
Message-ID: <87tw42fqec.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCHv4 2/5] migration: Mark CPU states dirty
 before incoming migration/loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

David Gibson <david@gibson.dropbear.id.au> wrote:
> As a rule, CPU internal state should never be updated when
> !cpu->kvm_vcpu_dirty (or the HAX equivalent).  If that is done, then
> subsequent calls to cpu_synchronize_state() - usually safe and idempotent -
> will clobber state.
>
> However, we routinely do this during a loadvm or incoming migration.
> Usually this is called shortly after a reset, which will clear all the cpu
> dirty flags with cpu_synchronize_all_post_reset().  Nothing is expected
> to set the dirty flags again before the cpu state is loaded from the
> incoming stream.
>
> This means that it isn't safe to call cpu_synchronize_state() from a
> post_load handler, which is non-obvious and potentially inconvenient.
>
> We could cpu_synchronize_all_state() before the loadvm, but that would be
> overkill since a) we expect the state to already be synchronized from the
> reset and b) we expect to completely rewrite the state with a call to
> cpu_synchronize_all_post_init() at the end of qemu_loadvm_state().
>
> To clear this up, this patch introduces cpu_synchronize_pre_loadvm() and
> associated helpers, which simply marks the cpu state as dirty without
> actually changing anything.  i.e. it says we want to discard any existing
> KVM (or HAX) state and replace it with what we're going to load.
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dave Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Juan Quintela <quintela@redhat.com>

>  
> +static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
> +{
> +    cpu->kvm_vcpu_dirty = true;
> +}
> +
> +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +    run_on_cpu(cpu, do_kvm_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
> +}

They are exactly the same, does it make sense to only have a copy?

I don't really know, so I do the reviewed-by anyways.
