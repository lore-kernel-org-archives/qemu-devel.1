Received: from eggs.gnu.org ([2001:4830:134:3::10]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUn-0001Uu-Oy
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUl-0000uG-4i
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:37 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:41781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUk-0000to-Ts
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:35 -0400
Received: by mail-wr0-x241.google.com with SMTP id f14so22395370wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:33 +0100
Message-Id: <1520945798-50640-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/22] sev/i386: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>

From: Brijesh Singh <brijesh.singh@amd.com>

SEV guest migration is not implemented yet.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index bb85d94..bcf4f1e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -24,11 +24,13 @@
 #include "sev_i386.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "migration/blocker.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
 static SEVState *sev_state;
+static Error *sev_mig_blocker;
 
 static const char *const sev_fw_errlist[] = {
     "",
@@ -582,6 +584,7 @@ static void
 sev_launch_finish(SEVState *s)
 {
     int ret, error;
+    Error *local_err = NULL;
 
     trace_kvm_sev_launch_finish();
     ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
@@ -592,6 +595,16 @@ sev_launch_finish(SEVState *s)
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
1.8.3.1
