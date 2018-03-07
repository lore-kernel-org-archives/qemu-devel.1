Received: from eggs.gnu.org ([2001:4830:134:3::10]:50534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHt-0004xE-Hc
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHo-0008Rx-QG
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:33 -0500
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com
	([104.47.38.59]:37502
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etcHo-0008RV-Jl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:28 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Mar 2018 10:50:34 -0600
Message-Id: <20180307165038.88640-25-brijesh.singh@amd.com>
In-Reply-To: <20180307165038.88640-1-brijesh.singh@amd.com>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 24/28] sev/i386: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

SEV guest migration is not implemented yet.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/i386/sev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index bcfc09558c8c..0eb2c855bc4d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -19,12 +19,14 @@
 #include "sev_i386.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "migration/blocker.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
 static SEVState *sev_state;
 static MemoryRegionRAMReadWriteOps  sev_ops;
+static Error *sev_mig_blocker;
 
 static const char *const sev_fw_errlist[] = {
     "",
@@ -578,6 +580,7 @@ static void
 sev_launch_finish(SEVState *s)
 {
     int ret, error;
+    Error *local_err = NULL;
 
     trace_kvm_sev_launch_finish();
     ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
@@ -588,6 +591,16 @@ sev_launch_finish(SEVState *s)
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
2.14.3
