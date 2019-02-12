Received: from eggs.gnu.org ([209.51.188.92]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtf4p-0005bq-11
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtez5-0007W6-Fu
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:48:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gtez2-0007KQ-Rz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:48:50 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Tue, 12 Feb 2019 20:48:18 +0000
Message-Id: <1550004500-24485-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 1/3] tpm_tis: fix loop that cancels any
 seizure by a lower locality
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

In tpm_tis_mmio_write() if the requesting locality is seizing
access, any seizure by a lower locality is cancelled.  However the
loop doing the seizure had an off-by-one error and the locality
immediately preceding the requesting locality was not being cleared.
This is fixed by adjusting the test in the for loop to check the
localities up to the requesting locality.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fd6bb9b59a96..61a130beef35 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -624,7 +624,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 }
 
                 /* cancel any seize by a lower locality */
-                for (l = 0; l < locty - 1; l++) {
+                for (l = 0; l < locty; l++) {
                     s->loc[l].access &= ~TPM_TIS_ACCESS_SEIZE;
                 }
 
-- 
1.8.3.1
