Received: from eggs.gnu.org ([2001:4830:134:3::10]:53418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90O-0001OV-0k
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90J-0005sE-T1
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:15 -0500
Received: from mail-sn1nam02on0054.outbound.protection.outlook.com
	([104.47.36.54]:29150
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er90J-0005qv-JB
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:11 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:17 -0600
Message-Id: <20180228211028.83970-18-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 17/28] target/i386: encrypt bios rom
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

SEV requires that guest bios must be encrypted before booting the guest.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/pc_sysfw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 4325575e7d82..73ac783f2055 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -113,6 +113,8 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
     pflash_t *system_flash;
     MemoryRegion *flash_mem;
     char name[64];
+    void *flash_ptr;
+    int ret, flash_size;
 
     sector_bits = 12;
     sector_size = 1 << sector_bits;
@@ -169,6 +171,17 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
         if (unit == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
             pc_isa_bios_init(rom_memory, flash_mem, size);
+
+            /* Encrypt the pflash boot ROM */
+            if (kvm_memcrypt_enabled()) {
+                flash_ptr = memory_region_get_ram_ptr(flash_mem);
+                flash_size = memory_region_size(flash_mem);
+                ret = kvm_memcrypt_encrypt_data(flash_ptr, flash_size);
+                if (ret) {
+                    error_report("failed to encrypt pflash rom");
+                    exit(1);
+                }
+            }
         }
     }
 }
-- 
2.14.3
