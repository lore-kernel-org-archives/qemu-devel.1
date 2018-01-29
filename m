Received: from eggs.gnu.org ([2001:4830:134:3::10]:49173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRj-0005np-Ol
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRf-0003d0-QY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:19 -0500
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com
	([104.47.41.64]:11072
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRf-0003bl-Is
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:15 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:25 -0600
Message-Id: <20180129174132.108925-17-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 16/23] target/i386: encrypt bios rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

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
index 6b183747fcea..8ddbbf74d330 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -112,6 +112,8 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
     pflash_t *system_flash;
     MemoryRegion *flash_mem;
     char name[64];
+    void *flash_ptr;
+    int ret, flash_size;
 
     sector_bits = 12;
     sector_size = 1 << sector_bits;
@@ -168,6 +170,17 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
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
2.9.5
