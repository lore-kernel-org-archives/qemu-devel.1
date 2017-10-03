Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzFwE-0002bj-2z
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzFwA-0005B8-R7
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:40:14 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:51030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dzFwA-0005A6-MH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:40:10 -0400
Received: by mail-it0-x241.google.com with SMTP id y138so10294524itc.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 22:40:10 -0700 (PDT)
References: <20171003051701.17721-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <069078cc-c0a6-1f78-887b-4502d580141f@ozlabs.ru>
Date: Tue, 3 Oct 2017 16:40:03 +1100
MIME-Version: 1.0
In-Reply-To: <20171003051701.17721-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu v2] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>

On 03/10/17 16:17, Alexey Kardashevskiy wrote:
> SLOF receives a device tree and updates it with various properties
> before switching to the guest kernel and QEMU is not aware of any changes
> made by SLOF. Since there is no real RTAS and QEMU implements it,
> it makes sense to pass the SLOF device tree to QEMU so the latter could
> implement RTAS related tasks better.
> 
> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> assisted NMI - FWNMI).
> 
> This stores the initial DT blob in the sPAPR machine and replaces it
> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> 
> This implements a very basic validity check of the new blob - magic and
> size are checked; the new blob size should not increase more than twice.
> 
> This requires SLOF update: "fdt: Pass the resulting device tree to QEMU".
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I could store just a size of the QEMU's blob, or a tree, not sure
> which one makes more sense here.
> 
> This allows up to 2 times blob increase. Not 1.5 just to avoid
> float/double, just looks a bit ugly imho.
> ---
>  include/hw/ppc/spapr.h |  4 +++-
>  hw/ppc/spapr.c         |  4 +++-
>  hw/ppc/spapr_hcall.c   | 33 +++++++++++++++++++++++++++++++++
>  hw/ppc/trace-events    |  2 ++
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a805b817a5..09f3a54dc2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -92,6 +92,7 @@ struct sPAPRMachineState {
>      int vrma_adjust;
>      ssize_t rtas_size;
>      void *rtas_blob;
> +    void *fdt_blob;
>      long kernel_size;
>      bool kernel_le;
>      uint32_t initrd_base;
> @@ -400,7 +401,8 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>  
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 17ea77618c..b471f7e1ff 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1453,7 +1453,9 @@ static void ppc_spapr_reset(void)
>      /* Load the fdt */
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> -    g_free(fdt);
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_blob = fdt;
> +    spapr->fdt_size = fdt_totalsize(fdt);

I did not commit this line removal to my local git so it fails to compile,
the rest should still compile. And it is an rfc anyway :)


-- 
Alexey
