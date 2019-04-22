Received: from eggs.gnu.org ([209.51.188.92]:45082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwF-0007um-Q5
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgs-0005Ld-S8
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:03 -0400
Received: from m12-12.163.com ([220.181.12.12]:59543)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgs-0005Kp-8C
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
From: Li Qiang <liq3ea@163.com>
Date: Mon, 22 Apr 2019 07:11:54 -0700
Message-Id: <20190422141156.15746-2-liq3ea@163.com>
In-Reply-To: <20190422141156.15746-1-liq3ea@163.com>
References: <20190422141156.15746-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v3 1/3] edu: mmio: allow 64-bit access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, philmd@redhat.com, Li Qiang <liq3ea@163.com>

The edu spec says the MMIO area can be accessed by 64-bit.
However currently the 'max_access_size' is not so the MMIO
access dispatch can only access 32-bit one time. This patch fixes
this to respect the spec.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
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
