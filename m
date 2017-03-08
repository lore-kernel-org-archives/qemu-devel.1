Received: from eggs.gnu.org ([2001:4830:134:3::10]:51888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5B-0005Pq-9P
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj58-0005Li-33
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:17 -0500
Received: from mail-co1nam03on0070.outbound.protection.outlook.com
	([104.47.40.70]:42411
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj57-0005LV-OA
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:14 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:51:17 -0500
Message-ID: <148900627753.27090.16222970359757079799.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 01/20] kvm: update kvm.h header file
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

Updates kmv.h to include memory encryption ioctls and SEV command structure
introduced in KVM RFC [1]

[1] http://marc.info/?l=linux-mm&m=148846752931115&w=2

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 linux-headers/linux/kvm.h |  100 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4e082a8..1050f53 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1300,6 +1300,106 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
 /* Available with KVM_CAP_X86_SMM */
 #define KVM_SMI                   _IO(KVMIO,   0xb7)
+/* Memory Encryption Commands */
+#define KVM_MEMORY_ENCRYPT_OP	  _IOWR(KVMIO, 0xb8, unsigned long)
+
+/* Secure Encrypted Virtualization mode */
+enum sev_cmd_id {
+	/* Guest launch commands */
+	KVM_SEV_LAUNCH_START = 0,
+	KVM_SEV_LAUNCH_UPDATE_DATA,
+	KVM_SEV_LAUNCH_MEASURE,
+	KVM_SEV_LAUNCH_FINISH,
+	/* Guest migration commands (outgoing) */
+	KVM_SEV_SEND_START,
+	KVM_SEV_SEND_UPDATE_DATA,
+	KVM_SEV_SEND_FINISH,
+	/* Guest migration commands (incoming) */
+	KVM_SEV_RECEIVE_START,
+	KVM_SEV_RECEIVE_UPDATE_DATA,
+	KVM_SEV_RECEIVE_FINISH,
+	/* Guest status and debug commands */
+	KVM_SEV_GUEST_STATUS,
+	KVM_SEV_DBG_DECRYPT,
+	KVM_SEV_DBG_ENCRYPT,
+
+	KVM_SEV_NR_MAX,
+};
+
+struct kvm_sev_cmd {
+	__u32 id;
+	__u64 data;
+	__u32 error;
+	__u32 sev_fd;
+};
+
+struct kvm_sev_launch_start {
+	__u32 handle;
+	__u32 policy;
+	__u64 dh_cert_data;
+	__u32 dh_cert_length;
+	__u64 session_data;
+	__u32 session_length;
+};
+
+struct kvm_sev_launch_update_data {
+	__u64 address;
+	__u32 length;
+};
+
+struct kvm_sev_launch_measure {
+	__u64 address;
+	__u32 length;
+};
+
+struct kvm_sev_send_start {
+	__u64 pdh_cert_data;
+	__u32 pdh_cert_length;
+	__u64 plat_cert_data;
+	__u32 plat_cert_length;
+	__u64 amd_cert_data;
+	__u32 amd_cert_length;
+	__u64 session_data;
+	__u32 session_length;
+};
+
+struct kvm_sev_send_update_data {
+	__u64 hdr_data;
+	__u32 hdr_length;
+	__u64 guest_address;
+	__u32 guest_length;
+	__u64 host_address;
+	__u32 host_length;
+};
+
+struct kvm_sev_receive_start {
+	__u32 handle;
+	__u64 pdh_cert_data;
+	__u32 pdh_cert_length;
+	__u64 session_data;
+	__u32 session_length;
+};
+
+struct kvm_sev_receive_update_data {
+	__u64 hdr_data;
+	__u32 hdr_length;
+	__u64 guest_address;
+	__u32 guest_length;
+	__u64 host_address;
+	__u32 host_length;
+};
+
+struct kvm_sev_guest_status {
+	__u32 handle;
+	__u32 policy;
+	__u32 state;
+};
+
+struct kvm_sev_dbg {
+	__u64 src_addr;
+	__u64 dst_addr;
+	__u32 length;
+};
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
