Received: from eggs.gnu.org ([2001:4830:134:3::10]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLew-0004o7-8L
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLes-0003f3-Ao
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:41:18 -0500
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com
	([104.47.33.48]:15268
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1emLer-0003eo-S1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:41:14 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu, 15 Feb 2018 09:39:51 -0600
Message-Id: <20180215153955.3253-26-brijesh.singh@amd.com>
In-Reply-To: <20180215153955.3253-1-brijesh.singh@amd.com>
References: <20180215153955.3253-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 25/29] sev/i386: add support to
 KVM_SEV_GUEST_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

The command is used to query the current SEV guest status. We use this
command to query the guest policy for QMP query-sev command.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index e3236f5bb7b6..559881084d50 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -437,6 +437,22 @@ sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build)
 void
 sev_get_policy(uint32_t *policy)
 {
+    struct kvm_sev_guest_status status = {};
+    int r, err;
+
+    if (current_sev_guest_state == SEV_STATE_UNINIT) {
+        return;
+    }
+
+    r = sev_ioctl(KVM_SEV_GUEST_STATUS, &status, &err);
+    if (r) {
+        error_report("%s: failed to get platform status ret=%d "
+                     "fw_error='%d: %s'", __func__, r, err,
+                     fw_error_to_str(err));
+        return;
+    }
+
+    *policy = status.policy;
 }
 
 static int
-- 
2.14.3
