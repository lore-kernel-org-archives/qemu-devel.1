Received: from eggs.gnu.org ([2001:4830:134:3::10]:51166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csWqy-0007tq-Jp
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csWqt-0003Qd-QI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1csWqt-0003Pb-Hc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:46:39 -0400
Date: Mon, 27 Mar 2017 12:46:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170327154636.GI28530@thinpad.lan.raisama.net>
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490624810-44752-1-git-send-email-agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org

On Mon, Mar 27, 2017 at 04:26:50PM +0200, Alexander Graf wrote:
> KVM allows trap and emulate (read: NOP) of the MONITOR and MWAIT
> instructions. There is work undergoing to enable actual execution
> of these inside of KVM, but nobody really wants to expose the feature
> to the guest by default, as it would eat up all of the host CPU.

Isn't this something that should be reported using
KVM_GET_EMULATED_CPUID? (QEMU still doesn't know how to use
KVM_GET_EMULATED_CPUID, however.)

> 
> So today there is no streamlined way to actually notify the guest that
> it's ok to execute MONITOR / MWAIT, even when we want to explicitly
> leave the guest in guest context.

I'm not familiar with the variables involved in this decision.
How exactly would somebody (human or software) determine if it's
really ok to let the guest execute MONITOR / MWAIT?

Under what circumstances do you expect this to be used? Is this
just for debugging and development?

> 
> This patch adds a new -cpu parameter called "mwait" which - when
> enabled - force enables the MONITOR / MWAIT CPUID flag, even when
> the underlying accel framework does not explicitly advertise support.
> 

If you really want something that makes QEMU ignore what the
accel code is reporting, I would prefer a syntax that could be
used for other features too, like "-cpu ...,monitor=force".

> With that in place, we can explicitly allow users to specify that
> they want have the guest execute MONITOR / MWAIT in its idle loop.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  target/i386/cpu.c | 5 +++++
>  target/i386/cpu.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7aa7622..c44020b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3460,6 +3460,10 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>              x86_cpu_get_supported_feature_word(w, false);
>          uint32_t requested_features = env->features[w];
>          env->features[w] &= host_feat;
> +        if (cpu->expose_monitor && (w == FEAT_1_ECX)) {
> +            /* Force monitor feature in */
> +            env->features[w] |= CPUID_EXT_MONITOR;
> +        }
>          cpu->filtered_features[w] = requested_features & ~env->features[w];
>          if (cpu->filtered_features[w]) {
>              rv = 1;
> @@ -3988,6 +3992,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
> +    DEFINE_PROP_BOOL("mwait", X86CPU, expose_monitor, false),
>      DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
>      DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>      DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 07401ad..7400d00 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1214,6 +1214,7 @@ struct X86CPU {
>      bool check_cpuid;
>      bool enforce_cpuid;
>      bool expose_kvm;
> +    bool expose_monitor;
>      bool migratable;
>      bool max_features; /* Enable all supported features automatically */
>      uint32_t apic_id;
> -- 
> 1.8.5.6
> 

-- 
Eduardo
