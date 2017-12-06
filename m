Received: from eggs.gnu.org ([2001:4830:134:3::10]:49674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvm-0005xJ-VE
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvj-0002U0-O9
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:34 -0500
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com
	([104.47.32.45]:39626
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvj-0002Tj-82
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:31 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:31 -0600
Message-Id: <20171206200346.116537-9-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 08/23] docs: add AMD Secure Encrypted
 Virtualization (SEV)
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

Create a documentation entry to describe the AMD Secure Encrypted
Virtualization (SEV) feature.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 docs/amd-memory-encryption.txt | 92 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 docs/amd-memory-encryption.txt

diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
new file mode 100644
index 000000000000..72a92b6c6353
--- /dev/null
+++ b/docs/amd-memory-encryption.txt
@@ -0,0 +1,92 @@
+Secure Encrypted Virtualization (SEV) is a feature found on AMD processors.
+
+SEV is an extension to the AMD-V architecture which supports running encrypted
+virtual machine (VMs) under the control of KVM. Encrypted VMs have their pages
+(code and data) secured such that only the guest itself has access to the
+unencrypted version. Each encrypted VM is associated with a unique encryption
+key; if its data is accessed to a different entity using a different key the
+encrypted guests data will be incorrectly decrypted, leading to unintelligible
+data.
+
+The key management of this feature is handled by separate processor known as
+AMD secure processor (AMD-SP) which is present in AMD SOCs. Firmware running
+inside the AMD-SP provide commands to support common VM lifecycle. This
+includes commands for launching, snapshotting, migrating and debugging the
+encrypted guest. Those SEV command can be issued via KVM_MEMORY_ENCRYPT_OP
+ioctls.
+
+Launching
+---------
+Boot images (such as bios) must be encrypted before guest can be booted.
+MEMORY_ENCRYPT_OP ioctl provides commands to encrypt the images :LAUNCH_START,
+LAUNCH_UPDATE_DATA, LAUNCH_MEASURE and LAUNCH_FINISH. These four commands
+together generate a fresh memory encryption key for the VM, encrypt the boot
+images and provide a measurement than can be used as an attestation of the
+successful launch.
+
+LAUNCH_START is called first to create a cryptographic launch context within
+the firmware. To create this context, guest owner must provides guest policy,
+its public Diffie-Hellman key (PDH) and session parameters. These inputs
+should be treated as binary blob and must be passed as-is to the SEV firmware.
+
+The guest policy is passed as plaintext and hypervisor may able to read it
+but should not modify it (any modification of the policy bits will result
+in bad measurement). The guest policy is a 4-byte data structure containing
+several flags that restricts what can be done on running SEV guest.
+See KM Spec section 3 and 6.2 for more details.
+
+Guest owners provided DH certificate and session parameters will be used to
+establish a cryptographic session with the guest owner to negotiate keys used
+for the attestation.
+
+LAUNCH_UPDATE_DATA encrypts the memory region using the cryptographic context
+created via LAUNCH_START command. If required, this command can be called
+multiple times to encrypt different memory regions. The command also calculates
+the measurement of the memory contents as it encrypts.
+
+LAUNCH_MEASURE command can be used to retrieve the measurement of encrypted
+memory. This measurement is a signature of the memory contents that can be
+sent to the guest owner as an attestation that the memory was encrypted
+correctly by the firmware. The guest owner may wait to provide the guest
+confidential information until it can verify the attestation measurement.
+Since the guest owner knows the initial contents of the guest at boot, the
+attestation measurement can be verified by comparing it to what the guest owner
+expects.
+
+LAUNCH_FINISH command finalizes the guest launch and destroy's the cryptographic
+context.
+
+See SEV KM API Spec [1] 'Launching a guest' usage flow (Appendix A) for the
+complete flow chart.
+
+Debugging
+-----------
+Since memory contents of SEV guest is encrypted hence hypervisor access to the
+guest memory will get a cipher text. If guest policy allows debugging, then
+hypervisor can use DEBUG_DECRYPT and DEBUG_ENCRYPT commands access the guest
+memory region for debug purposes.
+
+Snapshot/Restore
+-----------------
+TODO
+
+Live Migration
+----------------
+TODO
+
+References
+-----------------
+
+AMD Memory Encryption whitepaper:
+http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
+
+Secure Encrypted Virutualization Key Management:
+[1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
+
+KVM Forum slides:
+http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
+
+AMD64 Architecture Programmer's Manual:
+   http://support.amd.com/TechDocs/24593.pdf
+   SME is section 7.10
+   SEV is section 15.34
-- 
2.9.5
