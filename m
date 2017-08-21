Received: from eggs.gnu.org ([2001:4830:134:3::10]:39206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djipG-0001Px-HY
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djipD-0006Tu-Bu
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djipD-0006Ti-5w
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:16:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 21 Aug 2017 11:16:11 +0200
Message-Id: <20170821091614.28251-8-cohuck@redhat.com>
In-Reply-To: <20170821091614.28251-1-cohuck@redhat.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

If we do not provide zpci, pci reconfiguration via sclp is not available
either. Don't indicate it in the sclp facilities and return an invalid
command if the guest tries to issue pci configure/deconfigure.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9253dbbc64..d0104cd784 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -59,6 +59,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int rnsize, rnmax;
     int slots = MIN(machine->ram_slots, s390_get_memslot_count(kvm_state));
     IplParameterBlock *ipib = s390_ipl_get_iplb();
+    uint64_t sclp_facilities = SCLP_HAS_CPU_INFO;
 
     CPU_FOREACH(cpu) {
         cpu_count++;
@@ -79,8 +80,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 
     prepare_cpu_entries(sclp, read_info->entries, cpu_count);
 
-    read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
-                                        SCLP_HAS_PCI_RECONFIG);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        sclp_facilities |= SCLP_HAS_PCI_RECONFIG;
+    }
+    read_info->facilities = cpu_to_be64(sclp_facilities);
 
     /* Memory Hotplug is only supported for the ccw machine type */
     if (mhd) {
@@ -385,10 +388,18 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
         sclp_c->unassign_storage(sclp, sccb);
         break;
     case SCLP_CMDW_CONFIGURE_PCI:
-        s390_pci_sclp_configure(sccb);
+        if (s390_has_feat(S390_FEAT_ZPCI)) {
+            s390_pci_sclp_configure(sccb);
+        } else {
+            sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        }
         break;
     case SCLP_CMDW_DECONFIGURE_PCI:
-        s390_pci_sclp_deconfigure(sccb);
+        if (s390_has_feat(S390_FEAT_ZPCI)) {
+            s390_pci_sclp_deconfigure(sccb);
+        } else {
+            sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        }
         break;
     default:
         efc->command_handler(ef, sccb, code);
-- 
2.13.5
