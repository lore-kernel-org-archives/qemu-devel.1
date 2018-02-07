Received: from eggs.gnu.org ([2001:4830:134:3::10]:51840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSG3-00069x-OD
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFz-00072C-PG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:39 -0500
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com
	([104.47.38.70]:56894
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSFz-00071d-It
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:35 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Feb 2018 10:06:37 -0600
Message-Id: <20180207160638.98872-25-brijesh.singh@amd.com>
In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
References: <20180207160638.98872-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 25/26] sev: add support to
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

The command is used to query the current SEV guest status. We use this
command to query the guest policy for QMP query-sev command.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 186834364eed..b149f4ae6441 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -418,6 +418,18 @@ sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build)
 void
 sev_get_policy(uint32_t *policy)
 {
+    struct kvm_sev_guest_status status = {};
+    int r, err;
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
