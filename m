Received: from eggs.gnu.org ([2001:4830:134:3::10]:43532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9PEQ-0000H2-Ql
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9PEM-0007d5-2m
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:09:14 -0400
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-10-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9a2e3789-aafa-44b5-e7e0-31713114fad9@redhat.com>
Date: Fri, 20 Apr 2018 08:08:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180417071722.9399-10-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 09/10] target/ppc:
 Don't bother with MSR_EP in cpu_ppc_set_papr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 17.04.2018 09:17, David Gibson wrote:
> cpu_ppc_set_papr() removes the EP and HV bits from the MSR mask.  While
> removing the HV bit makes sense (a cpu in PAPR mode should never be
> emulated in hypervisor mode), the EP bit is just bizarre.  Although it's
> true that a papr mode guest shouldn't be able to change the exception
> prefix, the MSR[EP] bit doesn't even exist on the cpus supported for PAPR
> mode, so it's pointless to do anything with it here.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/translate_init.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 5e89901149..bb5559d799 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8870,12 +8870,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>  
>      cpu->vhyp = vhyp;
>  
> -    /* PAPR always has exception vectors in RAM not ROM. To ensure this,
> -     * MSR[IP] should never be set.
> -     *
> -     * We also disallow setting of MSR_HV
> +    /*
> +     * With a virtual hypervisor mode we never allow the CPU to go
> +     * hypervisor mode itself
>       */
> -    env->msr_mask &= ~((1ull << MSR_EP) | MSR_HVB);
> +    env->msr_mask &= ~MSR_HVB;
>  
>      /* Tell KVM that we're in PAPR mode */
>      if (kvm_enabled()) {

Looks right.

Reviewed-by: Thomas Huth <thuth@redhat.com>
