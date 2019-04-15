Received: from eggs.gnu.org ([209.51.188.92]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1ds-0004jH-Tx
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dq-00055L-TY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:24 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 15 Apr 2019 15:27:20 +0200
Message-Id: <1555334842-195718-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/5] hppa: drop usage of
 memory_region_allocate_system_memory() for ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

machine_hppa_init() violates memory_region_allocate_system_memory() contract
by calling it multiple times which could break with -mem-path. Replace
the second usage (for 'rom') with memory_region_init_ram() instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/hppa/machine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d1b1d3c..b413913 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -158,9 +158,8 @@ static void machine_hppa_init(MachineState *machine)
     g_free(firmware_filename);
 
     rom_region = g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(rom_region, OBJECT(machine),
-                                         "firmware",
-                                         (FIRMWARE_END - FIRMWARE_START));
+    memory_region_init_ram(rom_region, NULL, "firmware",
+                           (FIRMWARE_END - FIRMWARE_START), &error_fatal);
     memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
 
     /* Load kernel */
-- 
2.7.4
