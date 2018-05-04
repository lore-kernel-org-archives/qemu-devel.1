Received: from eggs.gnu.org ([2001:4830:134:3::10]:46610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEX9o-0005bx-Io
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEX9l-00072H-EJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:37:40 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fEX9l-000700-7J
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:37:37 -0400
Received: from player750.ha.ovh.net (unknown [10.109.108.84])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 60F46131386
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 11:37:35 +0200 (CEST)
Date: Fri, 4 May 2018 11:37:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180504113724.64b7b1c0@bahia.lan>
In-Reply-To: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: only save guest
 timebase once after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu,  3 May 2018 23:20:44 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> via a runstate hook so we can restore it on qmp_cont(). If a migration
> occurs in between those events we end up saving it again, this time
> based on the current timebase the guest would be seeing had it been
> running. This has the effect of advancing the guest timebase while
> it is stopped, which is not what the code intends.
> 

Hi Mike,

The current behavior was introduced by:

commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Fri Jan 27 13:24:58 2017 +0100

    spapr: clock should count only if vm is running

and we have this in the changelog:

    We keep timebase_pre_save to reduce the clock difference on
    migration like in:
        6053a86 kvmclock: reduce kvmclock difference on migration


So your patch totally negates ^^ ? Also, I can't see a case where
timebase_save() could be called from vmstate_save_state() while the
VM is running, ie, you could drop timebase_pre_save()... or am I
*probably* missing something ?

> Other than simple jumps in time, this has been seen to trigger what
> appear to be RCU-related crashes in recent kernels when the advance
> exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
> common operations such as `virsh migrate ... --timeout 60`.
> 
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/ppc/ppc.c         | 12 ++++++++++++
>  target/ppc/cpu-qom.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ec4be25f49..ff0a107864 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -865,6 +865,15 @@ static void timebase_save(PPCTimebase *tb)
>      uint64_t ticks = cpu_get_host_ticks();
>      PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
>  
> +    /* since we generally save timebase just after the guest
> +     * has stopped, avoid trying to save it again since we will
> +     * end up advancing it by the amount of ticks that have
> +     * elapsed in the host since the initial save
> +     */
> +    if (tb->saved) {
> +        return;
> +    }
> +
>      if (!first_ppc_cpu->env.tb_env) {
>          error_report("No timebase object");
>          return;
> @@ -877,6 +886,7 @@ static void timebase_save(PPCTimebase *tb)
>       * there is no need to update it from KVM here
>       */
>      tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
> +    tb->saved = true;
>  }
>  
>  static void timebase_load(PPCTimebase *tb)
> @@ -908,6 +918,8 @@ static void timebase_load(PPCTimebase *tb)
>                          &pcpu->env.tb_env->tb_offset);
>  #endif
>      }
> +
> +    tb->saved = false;
>  }
>  
>  void cpu_ppc_clock_vm_state_change(void *opaque, int running,
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index deaa46a14b..ec2dbcdcae 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -210,6 +210,7 @@ typedef struct PowerPCCPUClass {
>  typedef struct PPCTimebase {
>      uint64_t guest_timebase;
>      int64_t time_of_the_day_ns;
> +    bool saved;
>  } PPCTimebase;
>  
>  extern const struct VMStateDescription vmstate_ppc_timebase;
