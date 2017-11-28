Received: from eggs.gnu.org ([2001:4830:134:3::10]:57060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJl1s-0007JT-Dt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJl1p-0005xK-Nu
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:54:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJl1p-0005wo-Dl
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:54:45 -0500
Date: Tue, 28 Nov 2017 20:54:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171128205345-mutt-send-email-mst@kernel.org>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, rkagan@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org

On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
> introduced and set by default exposing l3 to the guest.
> 
> The motivation behind it was that in the Linux scheduler, when waking up
> a task on a sibling CPU, the task was put onto the target CPU's runqueue
> directly, without sending a reschedule IPI.  Reduction in the IPI count
> led to performance gain.
> 
> However, this isn't the whole story.  Once the task is on the target
> CPU's runqueue, it may have to preempt the current task on that CPU, be
> it the idle task putting the CPU to sleep or just another running task.
> For that a reschedule IPI will have to be issued, too.  Only when that
> other CPU is running a normal task for too little time, the fairness
> constraints will prevent the preemption and thus the IPI.
> 
> This boils down to the improvement being only achievable in workloads
> with many actively switching tasks.  We had no access to the
> (proprietary?) SAP HANA benchmark the commit referred to, but the
> pattern is also reproduced with "perf bench sched messaging -g 1"
> on 1 socket, 8 cores vCPU topology, we see indeed:
> 
> l3-cache	#res IPI /s	#time / 10000 loops
> off		560K		1.8 sec
> on		40K		0.9 sec
> 
> Now there's a downside: with L3 cache the Linux scheduler is more eager
> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
> sched pipe -i 100000" gives
> 
> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
> off		200 (no K)	230		0.2 sec
> on		400K		330K		0.5 sec
> 
> In a more realistic test, we observe 15% degradation in VM density
> (measured as the number of VMs, each running Drupal CMS serving 2 http
> requests per second to its main page, with 95%-percentile response
> latency under 100 ms) with l3-cache=on.
> 
> We think that mostly-idle scenario is more common in cloud and personal
> usage, and should be optimized for by default; users of highly loaded
> VMs should be able to tune them up themselves.
> 
> So switch l3-cache off by default, and add a compat clause for the range
> of machine types where it was on.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

Pls add a new machine type so 2.11 can keep it on by
default.

> ---
>  include/hw/i386/pc.h | 7 ++++++-
>  target/i386/cpu.c    | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 087d184..1d2dcae 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -375,7 +375,12 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = TYPE_X86_CPU,\
>          .property = "x-hv-max-vps",\
>          .value    = "0x40",\
> -    },
> +    },\
> +    {\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "l3-cache",\
> +        .value    = "on",\
> +    },\
>  
>  #define PC_COMPAT_2_9 \
>      HW_COMPAT_2_9 \
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1edcf29..95a51bd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4154,7 +4154,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> -    DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> +    DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, false),
>      DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
>                       false),
>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
> -- 
> 2.7.4
