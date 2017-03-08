Received: from eggs.gnu.org ([2001:4830:134:3::10]:52185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6S-0006Py-Or
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6P-0005dx-C6
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:36 -0500
Received: from mail-by2nam03on0060.outbound.protection.outlook.com
	([104.47.42.60]:18307
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj6P-0005dV-0E
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:33 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:53:16 -0500
Message-ID: <148900639629.27090.3342242561788466949.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 12/20] SEV: add GUEST_STATUS command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

The command is used to retrieve status information about an SEV-enabled guest.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/sysemu/sev.h |    9 +++++++++
 sev.c                |   28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 747fe87..88cbea5 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -82,6 +82,15 @@ struct SEVState {
 
 typedef struct SEVState SEVState;
 
+enum {
+    SEV_STATE_INVALID = 0,
+    SEV_STATE_LAUNCHING,
+    SEV_STATE_SECRET,
+    SEV_STATE_RUNNING,
+    SEV_STATE_RECEIVING,
+    SEV_STATE_SENDING,
+    SEV_STATE_MAX
+};
 
 bool sev_enabled(void);
 void *sev_guest_init(const char *keyid);
diff --git a/sev.c b/sev.c
index 4b3f39a..c13bbfd 100644
--- a/sev.c
+++ b/sev.c
@@ -197,6 +197,34 @@ err:
 }
 
 static int
+sev_get_current_state(SEVState *s)
+{
+    int error;
+    int ret = SEV_STATE_INVALID;
+    struct kvm_sev_guest_status *status;
+
+    if (!s) {
+        return ret;
+    }
+
+    status = g_malloc(sizeof(*status));
+    if (!status) {
+        return ret;
+    }
+
+    ret = sev_ioctl(KVM_SEV_GUEST_STATUS, status, &error);
+    if (ret) {
+        fprintf(stderr, "failed GUEST_STATUS %d (%#x)\n", ret, error);
+        goto err;
+    }
+
+    ret = status->state;
+err:
+    g_free(status);
+    return ret;
+}
+
+static int
 sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 {
     return 0;
