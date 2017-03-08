Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5r-0005wM-RX
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5o-0005ZR-JZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:59 -0500
Received: from mail-co1nam03on0060.outbound.protection.outlook.com
	([104.47.40.60]:55296
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj5o-0005YQ-8c
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:56 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:52:55 -0500
Message-ID: <148900637563.27090.8781580144264908372.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 10/20] vl: add memory encryption support
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

If memory encryption is enabled then create memory encryption launch
context to ensure that bootstrap data (bios images) get encrypted. Also
release the encryption context after machine is succesfully created.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 vl.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/vl.c b/vl.c
index 71b75ef..c6e7846 100644
--- a/vl.c
+++ b/vl.c
@@ -4521,6 +4521,14 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
+    /* If memory encryption is enabled then create encryption context. */
+    if (kvm_memcrypt_enabled()) {
+        if (kvm_memcrypt_create_launch_context()) {
+            error_report("failed to create memory encryption context");
+            exit(1);
+        }
+    }
+
     machine_class->init(current_machine);
 
     realtime_init();
@@ -4671,6 +4679,13 @@ int main(int argc, char **argv, char **envp)
         vm_start();
     }
 
+    if (kvm_memcrypt_enabled()) {
+        if (kvm_memcrypt_release_launch_context()) {
+            error_report("failed to stop encryption context");
+            exit(1);
+        }
+    }
+
     os_setup_post();
 
     main_loop();
