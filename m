Received: from eggs.gnu.org ([2001:4830:134:3::10]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gP0Ov-0005qn-To
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 02:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gP0Or-0008L0-Sb
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 02:24:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gP0Or-0008Jt-N3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 02:24:45 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 20 Nov 2018 12:52:39 +0530
Message-Id: <20181120072239.512-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cheng Feng <PSIRT@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing mmio device r/w operations, guest could set 'addr'
parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=5
after setting new 'locty' via 'tpm_tis_new_active_locality'.
Add check to avoid OOB access.

Reported-by: Cheng Feng <PSIRT@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/tpm/tpm_tis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Update: add assert() calls
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00912.html

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 12f5c9a759..d6bf3ceb26 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -293,6 +293,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     uint8_t locty = s->cmd.locty;
     uint8_t l;
 
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
     if (s->cmd.selftest_done) {
         for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
             s->loc[locty].sts |= TPM_TIS_STS_SELFTEST_DONE;
@@ -401,6 +402,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
     uint32_t avail;
     uint8_t v;
 
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
     if (tpm_backend_had_startup_error(s->be_driver)) {
         return 0;
     }
@@ -523,6 +525,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
     uint16_t len;
     uint32_t mask = (size == 1) ? 0xff : ((size == 2) ? 0xffff : ~0);
 
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
     trace_tpm_tis_mmio_write(size, addr, val);
 
     if (locty == 4) {
@@ -642,7 +645,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             }
         }
 
-        if (set_new_locty) {
+        if (set_new_locty && TPM_TIS_IS_VALID_LOCTY(active_locty)) {
             tpm_tis_new_active_locality(s, active_locty);
         }
 
-- 
2.17.2
