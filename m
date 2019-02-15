Received: from eggs.gnu.org ([209.51.188.92]:44139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gudSY-00007d-HT
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gudSW-0001gF-FC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:23:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gudSU-0001NI-M4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:23:15 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Fri, 15 Feb 2019 13:22:58 +0000
Message-Id: <1550236979-15658-2-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1550236979-15658-1-git-send-email-liam.merwick@oracle.com>
References: <1550236979-15658-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 2/3] tpm_tis: assert valid addr passed to
 tpm_tis_locality_from_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.ibm.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, philmd@redhat.com

Assert that the address passed in results in a valid locality value.
Current callers pass a valid address so this is just a defensive check
to prevent future caller passing an incorrect address or catch if the
MMIO address parameters were not all modified correctly.  This is to
help static code analysis tools that report that no explicit checking
is being done.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 hw/tpm/tpm_tis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 61a130beef35..772431f20874 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -100,7 +100,9 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
 
 static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
 {
-    return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
+    uint8_t locty = (uint8_t)(addr >> TPM_TIS_LOCALITY_SHIFT);
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
+    return locty;
 }
 
 static void tpm_tis_show_buffer(const unsigned char *buffer,
-- 
1.8.3.1
