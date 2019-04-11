Received: from eggs.gnu.org ([209.51.188.92]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEXsI-0006Rx-IA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEXsH-0005qp-I0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hEXsH-0005po-9X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:28:09 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 11 Apr 2019 13:28:18 +0200
Message-Id: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.1] roms: assert if max rom size is less
 than the used size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com, mst@redhat.com, richard.henderson@linaro.org

It would ensure that we would notice attempt to write beyond
the allocated buffer. In case of MemoryRegion backed ROM it's
the host buffer and the guest RAM otherwise.

assert can be triggered with:
  dd if=/dev/zero of=/tmp/blob bs=63k count=1
  qemu-system-x86_64 `for  i in {1..33}; do echo -n " -acpitable /tmp/blob"; done`

Fixes: (a1666142db acpi-build: make ROMs RAM blocks resizeable)

Reported-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fe5cb24..a097bbe 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1025,6 +1025,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     rom->addr     = addr;
     rom->romsize  = max_len ? max_len : len;
     rom->datasize = len;
+    g_assert(rom->romsize >= rom->datasize);
     rom->data     = g_malloc0(rom->datasize);
     memcpy(rom->data, blob, len);
     rom_insert(rom);
-- 
2.7.4
