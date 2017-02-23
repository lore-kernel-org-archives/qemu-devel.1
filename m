Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cgl4j-00053X-GO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cgl4i-0002dJ-Ew
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:32:17 -0500
Message-ID: <1487824324.23895.10.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 23 Feb 2017 15:32:04 +1100
In-Reply-To: <20170223020936.29220-4-david@gibson.dropbear.id.au>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/ppc: SDR1 is a hypervisor
 resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org

On Thu, 2017-02-23 at 13:09 +1100, David Gibson wrote:
> At present the SDR1 register - the base of the system's hashed page
> table
> (HPT) - is represented as an SPR with supervisor read and write
> permission.
> However, on CPUs which have a hypervisor mode, the SDR1 is a
> hypervisor
> only resource.  Change the permission checking on the SPR to reflect
> this.
> 
> Now that this is done, we don't need to check for an external HPT
> executing
> mtsdr1: an external HPT only applies when we're emulating the
> behaviour of
> a hypervisor, rather than modelling the CPU's hypervisor mode
> internally,
> so if we're permitted to execute mtsdr1, we don't have an external
> HPT.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/misc_helper.c    |  8 +++-----
>  target/ppc/translate_init.c | 20 ++++++++++++++++----
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index ab432ba..fa573dd 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -82,11 +82,9 @@ void helper_store_sdr1(CPUPPCState *env,
> target_ulong val)
>  {
>      PowerPCCPU *cpu = ppc_env_get_cpu(env);
>  
> -    if (!env->external_htab) {
> -        if (env->spr[SPR_SDR1] != val) {
> -            ppc_store_sdr1(env, val);
> -            tlb_flush(CPU(cpu));
> -        }

It may have been the case we didn't have to check this before anyway...
Oh well

> +    if (env->spr[SPR_SDR1] != val) {
> +        ppc_store_sdr1(env, val);
> +        tlb_flush(CPU(cpu));
>      }
>  }
>  
> diff --git a/target/ppc/translate_init.c
> b/target/ppc/translate_init.c
> index a1405e9..c92435d 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -740,10 +740,22 @@ static void gen_spr_ne_601 (CPUPPCState *env)
>                   &spr_read_decr, &spr_write_decr,
>                   0x00000000);
>      /* Memory management */
> -    spr_register(env, SPR_SDR1, "SDR1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_sdr1,
> -                 0x00000000);
> +#ifndef CONFIG_USER_ONLY
> +    if (env->has_hv_mode) {
> +        /* SDR1 is a hypervisor resource on CPUs which have a
> +         * hypervisor mode */
> +        spr_register_hv(env, SPR_SDR1, "SDR1",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_sdr1,
> +                        0x00000000);
> +    } else {
> +        spr_register(env, SPR_SDR1, "SDR1",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_sdr1,
> +                     0x00000000);
> +    }
> +#endif
>  }
>  
>  /* BATs 0-3 */

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
