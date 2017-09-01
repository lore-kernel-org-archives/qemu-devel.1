Received: from eggs.gnu.org ([2001:4830:134:3::10]:38220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpgd-0007Jh-E6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpgY-0004c2-P9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:22 +0200
Message-Id: <1504286483-23327-20-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 19/20] hw/arm/smmuv3: [not for upstream] add
 SMMU_CMD_TLBI_NH_VA_AM handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

SMMUV3 does not support any IOVA range TLBI command:
SMMU_CMD_TLBI_NH_VA invalidates TLB entries by page.
That's an issue when running DPDK on guest. DPDK uses
hugepages but each time a hugepage is mapped on guest side,
a storm of SMMU_CMD_TLBI_NH_VA commands get sent by the
guest smmuv3 driver and trapped by QEMU for VFIO replay.

Let's get prepared to handle implementation defined commands,
SMMU_CMD_TLBI_NH_VA_VM, which invalidate a range of IOVAs.

Upon this command, we notify the whole range in one host.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          | 13 +++++++++++++
 hw/arm/trace-events      |  1 +
 3 files changed, 15 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index f9f95ae..e70cf76 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -289,6 +289,7 @@ enum {
     SMMU_CMD_RESUME          = 0x44,
     SMMU_CMD_STALL_TERM,
     SMMU_CMD_SYNC,          /* 0x46 */
+    SMMU_CMD_TLBI_NH_VA_AM   = 0x8F, /* VIOMMU Impl Defined */
 };
 
 static const char *cmd_stringify[] = {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9c8640f..55dc80b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -880,6 +880,19 @@ static int smmuv3_cmdq_consume(SMMUV3State *s)
             smmuv3_replay_iova_range(&s->smmu_state, addr, size);
             break;
         }
+        case SMMU_CMD_TLBI_NH_VA_AM:
+        {
+            int asid = extract32(cmd.word[1], 16, 16);
+            int am = extract32(cmd.word[1], 0, 16);
+            uint64_t low = extract32(cmd.word[2], 12, 20);
+            uint64_t high = cmd.word[3];
+            uint64_t addr = high << 32 | (low << 12);
+            size_t size = am << 12;
+
+            trace_smmuv3_cmdq_tlbi_nh_va_am(asid, am, addr, size);
+            smmuv3_replay_iova_range(&s->smmu_state, addr, size);
+            break;
+        }
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 15f84d6..fba33ac 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -26,6 +26,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_cfgi_ste(int streamid) "     |_ streamid =%d"
 smmuv3_cmdq_cfgi_ste_range(int start, int end) "     |_ start=0x%d - end=0x%d"
 smmuv3_cmdq_tlbi_nh_va(int asid, int vmid, uint64_t addr) "     |_ asid =%d vmid =%d addr=0x%"PRIx64
+smmuv3_cmdq_tlbi_nh_va_am(int asid, int am, size_t size, uint64_t addr) "     |_ asid =%d am =%d size=0x%lx addr=0x%"PRIx64
 smmuv3_cmdq_consume_out(uint8_t prod_wrap, uint32_t prod, uint8_t cons_wrap, uint32_t cons) "prod_wrap:%d, prod:0x%x cons_wrap:%d cons:0x%x"
 smmuv3_update(bool is_empty, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "q empty:%d prod:%d cons:%d p.wrap:%d p.cons:%d"
 smmuv3_update_check_cmd(int error) "cmdq not enabled or error :0x%x"
-- 
2.5.5
