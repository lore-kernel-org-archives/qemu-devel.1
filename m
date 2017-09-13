Received: from eggs.gnu.org ([2001:4830:134:3::10]:46057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ds8vz-0001AO-En
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ds8vv-0005gn-Fv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ds8vv-0005gH-7i
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:46:31 -0400
Date: Wed, 13 Sep 2017 16:46:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170913164624.6fc7b3e6@nial.brq.redhat.com>
In-Reply-To: <20170913132417.24384-23-david@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-23-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 22/22] s390x: allow CPU hotplug in
 random core-id order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 13 Sep 2017 15:24:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> SCLP correctly indicates the core-id aka. CPU address for each available
> CPU.
> 
> As the core-id corresponds to cpu_index, also a newly created kvm vcpu
> gets assigned this core-id as vcpu id. So SIGP in the kernel works
> correctly (it uses the vcpu id to lookup the correct CPU).
> 
> So there should be nothing hindering us from hotplugging CPUs in random
> core-id order.
> 
> This now makes sure that the output from "query-hotpluggable-cpus"
> is completely true. Until now, a specific order is implicit. Performance
> vice, hotplugging CPUs in non-sequential order might not be the best thing
> to do, as VCPU lookup inside KVM might be a little slower. But that
> doesn't hinder us from supporting it.
> 
> next_core_id is now used by linux user only.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/s390x/cpu.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 5724dffb88..34538c3ab9 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -199,6 +199,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  #else
>      /* implicitly set for linux-user only */
>      cpu->env.core_id = scc->next_core_id;
> +    scc->next_core_id++;
>  #endif
>  
>      if (cpu_exists(cpu->env.core_id)) {
> @@ -206,12 +207,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>                     ", it already exists", cpu->env.core_id);
>          goto out;
>      }
> -    if (cpu->env.core_id != scc->next_core_id) {
> -        error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
> -                   ", the next available core-id is %" PRIu32, cpu->env.core_id,
> -                   scc->next_core_id);
> -        goto out;
> -    }
>  
>      /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
>      cs->cpu_index = env->core_id;
> @@ -219,7 +214,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>      if (err != NULL) {
>          goto out;
>      }
> -    scc->next_core_id++;
>  
>  #if !defined(CONFIG_USER_ONLY)
>      qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
