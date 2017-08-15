Received: from eggs.gnu.org ([2001:4830:134:3::10]:33770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dhQqc-0001cM-KQ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 21:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dhQqY-0006OC-N6
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 21:40:46 -0400
Message-ID: <1502761234.2143.4.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 15 Aug 2017 11:40:34 +1000
In-Reply-To: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
References: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ppc: fix ppc_set_compat() with KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 2017-08-14 at 19:49 +0200, Greg Kurz wrote:
> When running in KVM PR mode, kvmppc_set_compat() always fail because
> the
> current PR implementation doesn't handle KVM_REG_PPC_ARCH_COMPAT. Now
> that
> the machine code inconditionally calls ppc_set_compat_all() at reset
> time
> to restore the compat mode default value (commit 66d5c492dd3a9), it
> is
> impossible to start a guest with PR:
> 
> qemu-system-ppc64: Unable to set CPU compatibility mode in KVM:
>  Invalid argument
> 
> A tentative patch [1] was recently sent by Suraj to address the
> issue, but
> it would prevent the compat mode to be turned off on reset. And we
> really
> don't want to explicitely check for KVM PR. During the patch's
> review,
> David suggested that we should only call the KVM ioctl() if the
> compat
> PVR changes. This allows at least to run with KVM PR, provided no
> compat
> mode is requested from the command line (which should be the case
> when
> running PR nested). This is what this patch does.
> 
> While here, we also fix the side effect where KVM would fail but we
> would
> change the CPU state in QEMU anyway.
> 
> [1] http://patchwork.ozlabs.org/patch/782039/
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

I meant to send a follow up but it fell on my priority list so thanks
for this

Looks good to me

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
>  target/ppc/compat.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index f1b67faa97e3..f8729fe46d61 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -140,16 +140,17 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t
> compat_pvr, Error **errp)
>  
>      cpu_synchronize_state(CPU(cpu));
>  
> -    cpu->compat_pvr = compat_pvr;
> -    env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
> -
> -    if (kvm_enabled()) {
> +    if (kvm_enabled() && cpu->compat_pvr != compat_pvr) {
>          int ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret,
>                               "Unable to set CPU compatibility mode
> in KVM");
> +            return;
>          }
>      }
> +
> +    cpu->compat_pvr = compat_pvr;
> +    env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
>  }
>  
>  typedef struct {
> 
