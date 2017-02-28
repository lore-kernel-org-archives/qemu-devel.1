Received: from eggs.gnu.org ([2001:4830:134:3::10]:46742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cikPg-00037M-I9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cikPe-0000sr-HV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cikPe-0000sT-B5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:14:06 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Feb 2017 17:14:01 +0100
Message-Id: <20170228161402.25122-3-pbonzini@redhat.com>
In-Reply-To: <20170228161402.25122-1-pbonzini@redhat.com>
References: <20170228161402.25122-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/19] memory: Introduce DEVICE_HOST_ENDIAN for
 ram device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongji Xie <xyjxie@linux.vnet.ibm.com>

From: Yongji Xie <xyjxie@linux.vnet.ibm.com>

At the moment ram device's memory regions are DEVICE_NATIVE_ENDIAN. It's
incorrect. This memory region is backed by a MMIO area in host, so the
uint64_t data that MemoryRegionOps read from/write to this area should be
host-endian rather than target-endian. Hence, current code does not work
when target and host endianness are different which is the most common case
on PPC64. To fix it, this introduces DEVICE_HOST_ENDIAN for the ram device.

This has been tested on PPC64 BE/LE host/guest in all possible combinations
including TCG.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-Id: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-common.h | 6 ++++++
 memory.c                  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index bd15853..eef74df 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -36,6 +36,12 @@ enum device_endian {
     DEVICE_LITTLE_ENDIAN,
 };
 
+#if defined(HOST_WORDS_BIGENDIAN)
+#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
+#else
+#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
+#endif
+
 /* address in the RAM (different from a physical address) */
 #if defined(CONFIG_XEN_BACKEND)
 typedef uint64_t ram_addr_t;
diff --git a/memory.c b/memory.c
index d61caee..573fa6e 100644
--- a/memory.c
+++ b/memory.c
@@ -1182,7 +1182,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
2.9.3
