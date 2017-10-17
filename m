Received: from eggs.gnu.org ([2001:4830:134:3::10]:46197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linuc.decode@gmail.com>) id 1e4TSE-0006FT-AH
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linuc.decode@gmail.com>) id 1e4TS8-0004RN-4J
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:06:50 -0400
Date: Tue, 17 Oct 2017 20:36:18 +0530
From: Linu Cherian <linuc.decode@gmail.com>
Message-ID: <20171017150618.GA6575@virtx40>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-20-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504286483-23327-20-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v7 19/20] hw/arm/smmuv3: [not
 for upstream] add SMMU_CMD_TLBI_NH_VA_AM handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com, mohun106@gmail.com, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mst@redhat.com, jean-philippe.brucker@arm.com, tn@semihalf.com, will.deacon@arm.com, robin.murphy@arm.com, peterx@redhat.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, wtownsen@redhat.com, linu.cherian@cavium.com

Hi Eric,

On Fri Sep 01, 2017 at 07:21:22PM +0200, Eric Auger wrote:
> SMMUV3 does not support any IOVA range TLBI command:
> SMMU_CMD_TLBI_NH_VA invalidates TLB entries by page.
> That's an issue when running DPDK on guest. DPDK uses
> hugepages but each time a hugepage is mapped on guest side,
> a storm of SMMU_CMD_TLBI_NH_VA commands get sent by the
> guest smmuv3 driver and trapped by QEMU for VFIO replay.
> 
> Let's get prepared to handle implementation defined commands,
> SMMU_CMD_TLBI_NH_VA_VM, which invalidate a range of IOVAs.
> 
> Upon this command, we notify the whole range in one host.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3-internal.h |  1 +
>  hw/arm/smmuv3.c          | 13 +++++++++++++
>  hw/arm/trace-events      |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index f9f95ae..e70cf76 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -289,6 +289,7 @@ enum {
>      SMMU_CMD_RESUME          = 0x44,
>      SMMU_CMD_STALL_TERM,
>      SMMU_CMD_SYNC,          /* 0x46 */
> +    SMMU_CMD_TLBI_NH_VA_AM   = 0x8F, /* VIOMMU Impl Defined */
>  };
>  
>  static const char *cmd_stringify[] = {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9c8640f..55dc80b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -880,6 +880,19 @@ static int smmuv3_cmdq_consume(SMMUV3State *s)
>              smmuv3_replay_iova_range(&s->smmu_state, addr, size);
>              break;
>          }
> +        case SMMU_CMD_TLBI_NH_VA_AM:
> +        {
> +            int asid = extract32(cmd.word[1], 16, 16);
> +            int am = extract32(cmd.word[1], 0, 16);
> +            uint64_t low = extract32(cmd.word[2], 12, 20);
> +            uint64_t high = cmd.word[3];
> +            uint64_t addr = high << 32 | (low << 12);
> +            size_t size = am << 12;
> 


While testing dpdk, observed that there are map requests coming to 
arm smmuv3 driver with size greater than 256M. Since the current 
code supports only 256M( 16 + 12 bits), had to abuse the asid field
to pass the extra bits for address mask to get things working.

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 04e2d75..51b1d07 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1418,7 +1418,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
                if (smmu->options & ARM_SMMU_OPT_TLBI_ON_MAP) {
                        cmd.opcode      = CMDQ_OP_TLBI_NH_VA_AM;
                        cmd.tlbi.am   = size >> 12;
+                       cmd.tlbi.asid = size >> 28;
                        granule = size;


On Qemu side,

  if (cfg.disabled || cfg.bypassed) {
@@ -884,12 +899,15 @@ static int smmuv3_cmdq_consume(SMMUV3State *s)
         case SMMU_CMD_TLBI_NH_VA_AM:
         {
             int asid = extract32(cmd.word[1], 16, 16);
             int am = extract32(cmd.word[1], 0, 16);
             uint64_t low = extract32(cmd.word[2], 12, 20);
             uint64_t high = cmd.word[3];
             uint64_t addr = high << 32 | (low << 12);
             size_t size = am << 12;
 
+           am = am | asid << 16;
+           size = am << 12;        
+



+
> +            trace_smmuv3_cmdq_tlbi_nh_va_am(asid, am, addr, size);
> +            smmuv3_replay_iova_range(&s->smmu_state, addr, size);
> +            break;
> +        }
>          case SMMU_CMD_TLBI_NH_VAA:
>          case SMMU_CMD_TLBI_EL3_ALL:
>          case SMMU_CMD_TLBI_EL3_VA:
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 15f84d6..fba33ac 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -26,6 +26,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>  smmuv3_cmdq_cfgi_ste(int streamid) "     |_ streamid =%d"
>  smmuv3_cmdq_cfgi_ste_range(int start, int end) "     |_ start=0x%d - end=0x%d"
>  smmuv3_cmdq_tlbi_nh_va(int asid, int vmid, uint64_t addr) "     |_ asid =%d vmid =%d addr=0x%"PRIx64
> +smmuv3_cmdq_tlbi_nh_va_am(int asid, int am, size_t size, uint64_t addr) "     |_ asid =%d am =%d size=0x%lx addr=0x%"PRIx64
>  smmuv3_cmdq_consume_out(uint8_t prod_wrap, uint32_t prod, uint8_t cons_wrap, uint32_t cons) "prod_wrap:%d, prod:0x%x cons_wrap:%d cons:0x%x"
>  smmuv3_update(bool is_empty, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "q empty:%d prod:%d cons:%d p.wrap:%d p.cons:%d"
>  smmuv3_update_check_cmd(int error) "cmdq not enabled or error :0x%x"
> -- 
> 2.5.5
> 
> 

-- 
Linu cherian
