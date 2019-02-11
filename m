Received: from eggs.gnu.org ([209.51.188.92]:49420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtD8c-0007jB-ML
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtD8Y-0005z2-JX
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:04:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gtD8J-0002HS-DS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:04:37 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Mon, 11 Feb 2019 15:03:04 +0000
Message-Id: <1549897385-10091-2-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 2/3] tpm_tis: assert valid addr passed to
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

Defensive check to prevent future caller passing incorrect address
or catch if the MMIO address parameters were not all changed together.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---

I've been running static analysis tools on QEMU and one reports this check.
While it's just theoretically correct (impossible to hit with current code),
fixing this helps minimise noise and find other issues using those static
analyzers as well as defending against the addition of future bugs.

 hw/tpm/tpm_tis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 61a130beef35..860c2ace7d99 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -100,6 +100,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
 
 static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
 {
+    assert(addr < TPM_TIS_ADDR_SIZE);
     return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
 }
 
-- 
1.8.3.1
