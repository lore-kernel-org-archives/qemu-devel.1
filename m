Received: from eggs.gnu.org ([2001:4830:134:3::10]:45130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gJtqG-0004FC-6p
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gJtqD-0006kY-2O
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:23:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gJtqC-0006k7-Ti
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:23:53 -0500
From: P J P <ppandit@redhat.com>
Date: Tue,  6 Nov 2018 10:51:43 +0530
Message-Id: <20181106052144.31841-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing mmio device r/w operations, guest could set 'addr'
parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=5.
Add check to avoid OOB access.

Reported-by: Cheng Feng <PSIRT@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/tpm/tpm_tis.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 12f5c9a759..20126dd838 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -293,6 +293,10 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     uint8_t locty = s->cmd.locty;
     uint8_t l;
 
+    if (locty >= TPM_TIS_NUM_LOCALITIES) {
+        return;
+    }
+
     if (s->cmd.selftest_done) {
         for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
             s->loc[locty].sts |= TPM_TIS_STS_SELFTEST_DONE;
@@ -401,7 +405,8 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
     uint32_t avail;
     uint8_t v;
 
-    if (tpm_backend_had_startup_error(s->be_driver)) {
+    if (tpm_backend_had_startup_error(s->be_driver)
+        || locty >= TPM_TIS_NUM_LOCALITIES) {
         return 0;
     }
 
@@ -530,7 +535,8 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
         return;
     }
 
-    if (tpm_backend_had_startup_error(s->be_driver)) {
+    if (tpm_backend_had_startup_error(s->be_driver)
+        || locty >= TPM_TIS_NUM_LOCALITIES) {
         return;
     }
 
-- 
2.17.2
