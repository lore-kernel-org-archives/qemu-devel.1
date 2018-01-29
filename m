Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRu-0005xt-2Y
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRp-0003mV-Um
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:30 -0500
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com
	([104.47.41.70]:22464
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRp-0003ko-Mb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:25 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:32 -0600
Message-Id: <20180129174132.108925-24-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 23/23] sev: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>

SEV guest migration is not implemented yet.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 accel/kvm/sev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 65d34c531ee5..6800e059f57c 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qapi-event.h"
+#include "migration/blocker.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -28,6 +29,7 @@
 static int sev_fd;
 static SEVState *sev_state;
 static MemoryRegionRAMReadWriteOps  sev_ops;
+static Error *sev_mig_blocker;
 
 #define SEV_FW_MAX_ERROR      0x17
 
@@ -479,6 +481,7 @@ static void
 sev_launch_finish(SEVState *s)
 {
     int ret, error;
+    Error *local_err = NULL;
 
     trace_kvm_sev_launch_finish();
     ret = sev_ioctl(KVM_SEV_LAUNCH_FINISH, 0, &error);
@@ -489,6 +492,16 @@ sev_launch_finish(SEVState *s)
     }
 
     sev_set_guest_state(SEV_STATE_RUNNING);
+
+    /* add migration blocker */
+    error_setg(&sev_mig_blocker,
+               "SEV: Migration is not implemented");
+    ret = migrate_add_blocker(sev_mig_blocker, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        error_free(sev_mig_blocker);
+        exit(1);
+    }
 }
 
 static void
-- 
2.9.5
