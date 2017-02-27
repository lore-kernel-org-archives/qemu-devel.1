Received: from eggs.gnu.org ([2001:4830:134:3::10]:59912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1ciDJ0-0005Dp-6F
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1ciDIw-0000kM-9b
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:53:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51418
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xyjxie@linux.vnet.ibm.com>)
	id 1ciDIw-0000kC-47
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:52:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R4o8ls015688
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:52:56 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28urfuj508-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:52:56 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xyjxie@linux.vnet.ibm.com>;
	Sun, 26 Feb 2017 23:52:56 -0500
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 12:52:44 +0800
Message-Id: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] memory: Introduce DEVICE_HOST_ENDIAN for
 ram device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net
Cc: qemu-devel@nongnu.org, xyjxie@linux.vnet.ibm.com, alex.williamson@redhat.com, aik@ozlabs.ru, peter.maydell@linaro.org, paulus@samba.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com

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
---
 include/exec/cpu-common.h |    6 ++++++
 memory.c                  |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

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
index ed8b5aa..17cfada 100644
--- a/memory.c
+++ b/memory.c
@@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
1.7.1
