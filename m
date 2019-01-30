Received: from eggs.gnu.org ([209.51.188.92]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor7n-0001B8-D0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor7m-0003br-Nv
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:45:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gor7m-0003bd-Fp
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:45:58 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed, 30 Jan 2019 14:45:50 +0000
Message-Id: <1548859550-32019-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH] tpm_tis: validate locality values don't
 overrun array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.ibm.com, qemu-devel@nongnu.org

Assert that various locality values don't exceed TPM_TIS_NUM_LOCALITIES
by adding specific calls to assert(TPM_TIS_NUM_LOCALITIES(l)) in order
to help static code analysis.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/tpm/tpm_tis.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fd6bb9b59a96..2267bd8c346f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -241,6 +241,9 @@ static void tpm_tis_abort(TPMState *s)
 {
     s->rw_offset = 0;
 
+    assert(TPM_TIS_IS_VALID_LOCTY(s->next_locty));
+    assert(TPM_TIS_IS_VALID_LOCTY(s->aborting_locty));
+
     trace_tpm_tis_abort(s->next_locty);
 
     /*
@@ -531,6 +534,8 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
     uint16_t len;
     uint32_t mask = (size == 1) ? 0xff : ((size == 2) ? 0xffff : ~0);
 
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
+
     trace_tpm_tis_mmio_write(size, addr, val);
 
     if (locty == 4) {
-- 
1.8.3.1
