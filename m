Received: from eggs.gnu.org ([2001:4830:134:3::10]:50872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eJplw-0004gv-EE
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eJplr-0006GP-KT
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:58:40 -0500
Message-ID: <1511913509.2513.2.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 29 Nov 2017 10:58:29 +1100
In-Reply-To: <20171128174310.15700-1-lvivier@redhat.com>
References: <20171128174310.15700-1-lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 2017-11-28 at 18:43 +0100, Laurent Vivier wrote:
> Migration of pseries is broken with TCG because
> QEMU tries to restore KVM MMU state unconditionally.
> 
> The result is a SIGSEGV in kvm_vm_ioctl():
> 
>   #0  kvm_vm_ioctl (s=0x0, type=-2146390353)
>       at qemu/accel/kvm/kvm-all.c:2032
>   #1  0x00000001003e3e2c in kvmppc_configure_v3_mmu (cpu=<optimized
> out>,
>       radix=<optimized out>, gtse=<optimized out>,
> proc_tbl=<optimized out>)
>       at qemu/target/ppc/kvm.c:396
>   #2  0x00000001002f8b88 in spapr_post_load (opaque=0x1019103c0,
>       version_id=<optimized out>) at qemu/hw/ppc/spapr.c:1578
>   #3  0x000000010059e4cc in vmstate_load_state (f=0x106230000,
>       vmsd=0x1009479e0 <vmstate_spapr>, opaque=0x1019103c0,
>       version_id=<optimized out>) at qemu/migration/vmstate.c:165
>   #4  0x00000001005987e0 in vmstate_load (f=<optimized out>,
> se=<optimized out>)
>       at qemu/migration/savevm.c:748
> 
> This patch fixes the problem by not calling the KVM function with the
> TCG mode.
> 
> Fixes: d39c90f5f3 ("spapr: Fix migration of Radix guests")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Ah, guess I never hit this because I never tested tcg migration with a
qemu compiled on a kvm enabled system. Nice catch :)

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
> v2: fix the comment to keep GDB backtrace lines starting with '#'
> 
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9efddeaee5..a471de6cab 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1570,7 +1570,7 @@ static int spapr_post_load(void *opaque, int
> version_id)
>          err = spapr_rtc_import_offset(&spapr->rtc, spapr-
> >rtc_offset);
>      }
>  
> -    if (spapr->patb_entry) {
> +    if (kvm_enabled() && spapr->patb_entry) {
>          PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>          bool radix = !!(spapr->patb_entry & PATBE1_GR);
>          bool gtse = !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
