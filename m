Received: from eggs.gnu.org ([2001:4830:134:3::10]:50133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfwC-0006c2-SL
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw9-0002qd-L2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:05:00 -0500
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com
	([104.47.32.47]:21328
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfw9-0002q4-Ee
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:57 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:43 -0600
Message-Id: <20171206200346.116537-21-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 20/23] hw: i386: set ram_debug_ops when
 memory encryption is enabled
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

When memory encryption is enabled, the guest RAM and boot flash ROM will
contain the encrypted data. By setting the debug ops allow us to invoke
encryption APIs when accessing the memory for the debug purposes.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/pc.c       | 9 +++++++++
 hw/i386/pc_sysfw.c | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 186545d2a4e5..937cf75d5545 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1355,6 +1355,15 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(0x100000000ULL, pcms->above_4g_mem_size, E820_RAM);
     }
 
+    /*
+     * When memory encryption is enabled, the guest RAM will be encrypted with
+     * a guest unique key. Set the debug ops so that any debug access to the
+     * guest RAM will go through the memory encryption APIs.
+     */
+    if (kvm_memcrypt_enabled()) {
+        kvm_memcrypt_set_debug_ops(ram);
+    }
+
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 8ddbbf74d330..3d149b1c9f3c 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -180,6 +180,12 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
                     error_report("failed to encrypt pflash rom");
                     exit(1);
                 }
+
+                /*
+                 * The pflash ROM is encrypted, set the debug ops so that any
+                 * debug accesses will use memory encryption APIs.
+                 */
+                kvm_memcrypt_set_debug_ops(flash_mem);
             }
         }
     }
-- 
2.9.5
