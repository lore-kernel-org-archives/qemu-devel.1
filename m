Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df31M-0006HO-TQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df31J-0003V0-0x
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:50:00 -0400
References: <20170808060817.2832-1-david@gibson.dropbear.id.au>
	<20170808060817.2832-3-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54c9ef1f-b41c-3ac6-9497-6bec8e5a3a8c@redhat.com>
Date: Tue, 8 Aug 2017 13:49:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170808060817.2832-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.10 2/2] target/ppc: Add
 stub implementation of the PSSCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org

On 08.08.2017 08:08, David Gibson wrote:
> The PSSCR register added in POWER9 controls certain power saving mode
> behaviours.  Mostly, it's not relevant to TCG, however because qemu
> doesn't know about it yet, it doesn't synchronize the state with KVM,
> and thus it doesn't get migrated.
> 
> To fix that, this adds a minimal stub implementation of the register.
> This isn't complete, even to the extent that an implementation is
> possible in TCG, just enough to get migration working.  We need to
> come back later and at least properly filter the various fields in the
> register based on privilege level.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/cpu.h            | 1 +
>  target/ppc/translate_init.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f6e5413fad..46d3dd88f6 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1771,6 +1771,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
>  #define SPR_IC                (0x350)
>  #define SPR_VTB               (0x351)
>  #define SPR_MMCRC             (0x353)
> +#define SPR_PSSCR             (0x357)
>  #define SPR_440_INV0          (0x370)
>  #define SPR_440_INV1          (0x371)
>  #define SPR_440_INV2          (0x372)
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 94800cd29d..8fb407ed73 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8846,6 +8846,11 @@ static void init_proc_POWER9(CPUPPCState *env)
>                       spr_read_generic, spr_write_generic,
>                       KVM_REG_PPC_TIDR, 0);
>  
> +    /* FIXME: Filter fields properly based on privilege level */
> +    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
> +                        spr_read_generic, spr_write_generic,
> +                        KVM_REG_PPC_PSSCR, 0);
> +
>      /* env variables */
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr = 32;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
