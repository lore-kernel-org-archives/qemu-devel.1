Received: from eggs.gnu.org ([2001:4830:134:3::10]:60759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUh-0001OG-Sw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUh-0000rb-5l
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:31 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUg-0000qp-VC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id k3so2974956wrg.6
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:30 +0100
Message-Id: <1520945798-50640-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/22] target/i386: encrypt bios rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

SEV requires that guest bios must be encrypted before booting the guest.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_sysfw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 4325575..73ac783 100644
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
1.8.3.1
