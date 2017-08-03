Received: from eggs.gnu.org ([2001:4830:134:3::10]:34891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddEYl-0006TW-V1
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddEYh-000209-Je
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:44:59 -0400
References: <1501577097-14248-1-git-send-email-frederic.konrad@adacore.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <abac426c-5db4-7dd7-a727-880b60f5e9be@redhat.com>
Date: Thu, 3 Aug 2017 13:37:06 +0200
MIME-Version: 1.0
In-Reply-To: <1501577097-14248-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH] booke206: fix MAS update on
 tlb miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 01.08.2017 10:44, KONRAD Frederic wrote:
> When a tlb instruction miss happen, rw is set to 0 at the bottom
> of cpu_ppc_handle_mmu_fault which cause the MAS update function to miss
> the SAS and TS bit in MAS6, MAS1 in booke206_update_mas_tlb_miss.
> 
> Just calling booke206_update_mas_tlb_miss with rw = 2 solve the issue.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  target/ppc/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b7b9088..f06b938 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1551,7 +1551,7 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *env, target_ulong address,
>                      env->spr[SPR_40x_ESR] = 0x00000000;
>                      break;
>                  case POWERPC_MMU_BOOKE206:
> -                    booke206_update_mas_tlb_miss(env, address, rw);
> +                    booke206_update_mas_tlb_miss(env, address, 2);

Couldn't that code path be called for normal data read miss (instead of
instruction miss), too?

Anyway, could we please use MMU_INST_FETCH instead of magic values like
2 here?

 Thomas
