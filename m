Received: from eggs.gnu.org ([209.51.188.92]:57509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdm-0004qC-1r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdj-0001r0-Jd
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:56 -0400
Received: from m12-13.163.com ([220.181.12.13]:43449)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdh-0001oH-Vz
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:54 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 09:14:44 -0700
Message-Id: <20190420161446.2274-2-liq3ea@163.com>
In-Reply-To: <20190420161446.2274-1-liq3ea@163.com>
References: <20190420161446.2274-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 1/3] edu: mmio: set 'max_access_size' to 8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

The edu spec said, the MMIO area can be accessed by 8 bytes.
However currently the 'max_access_size' is not so the MMIO
access dispatch can only access 4 bytes one time. This patch
fixes this to respect the spec.

Notice: here the 'min_access_size' is not a must, I set this
for completement.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/misc/edu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 91af452c9e..65fc32b928 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops = {
     .read = edu_mmio_read,
     .write = edu_mmio_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+
 };
 
 /*
-- 
2.17.1
