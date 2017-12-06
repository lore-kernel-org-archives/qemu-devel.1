Received: from eggs.gnu.org ([2001:4830:134:3::10]:50083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfwA-0006ZY-Vw
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw7-0002p9-OP
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:58 -0500
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com
	([104.47.32.76]:59904
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfw7-0002os-HZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:55 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:42 -0600
Message-Id: <20171206200346.116537-20-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 19/23] sev: Finalize the SEV guest launch
 flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

SEV launch flow requires us to issue LAUNCH_FINISH command before guest
is ready to run.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index c0eea371fa06..fbbd99becc0a 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -454,6 +454,35 @@ static Notifier sev_machine_done_notify = {
     .notify = sev_launch_get_measure,
 };
 
+static void
+sev_launch_finish(SEVState *s)
+{
+    int ret, error;
+
+    ret = sev_ioctl(KVM_SEV_LAUNCH_FINISH, 0, &error);
+    if (ret) {
+        error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                     __func__, ret, error, fw_error_to_str(error));
+        exit(1);
+    }
+
+    s->cur_state = SEV_STATE_RUNNING;
+    DPRINTF("SEV: LAUNCH_FINISH\n");
+}
+
+static void
+sev_vm_state_change(void *opaque, int running, RunState state)
+{
+    SEVState *s = opaque;
+
+    if (running) {
+        /* we are about to resume the guest, finalize the launch flow */
+        if (s->cur_state == SEV_STATE_SECRET) {
+            sev_launch_finish(s);
+        }
+    }
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -497,6 +526,7 @@ sev_guest_init(const char *id)
 
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+    qemu_add_vm_change_state_handler(sev_vm_state_change, s);
 
     sev_state = s;
 
-- 
2.9.5
