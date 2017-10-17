Received: from eggs.gnu.org ([2001:4830:134:3::10]:39161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4QoD-0004l4-Co
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4Qo9-0007w2-Dx
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:17:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4Qo9-0007vn-8R
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:17:17 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2017 14:17:14 +0200
Message-Id: <20171017121714.24714-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] watch_mem_write: implement 8-byte accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrew.Baumann@microsoft.com, rth@twiddle.net

Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
always turn into atomic 8-byte writes on the host, however a write
write watchpoint would end up tearing the 8-byte write into two 4-byte
writes in access_with_adjusted_size().

Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/exec.c b/exec.c
index b58bc4eff7..db5ae23118 100644
--- a/exec.c
+++ b/exec.c
@@ -2503,6 +2503,9 @@ static MemTxResult watch_mem_read(void *opaque, hwaddr addr, uint64_t *pdata,
     case 4:
         data = address_space_ldl(as, addr, attrs, &res);
         break;
+    case 8:
+        data = address_space_ldq(as, addr, attrs, &res);
+        break;
     default: abort();
     }
     *pdata = data;
@@ -2528,6 +2531,9 @@ static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
     case 4:
         address_space_stl(as, addr, val, attrs, &res);
         break;
+    case 8:
+        address_space_stq(as, addr, val, attrs, &res);
+        break;
     default: abort();
     }
     return res;
@@ -2537,6 +2543,16 @@ static const MemoryRegionOps watch_mem_ops = {
     .read_with_attrs = watch_mem_read,
     .write_with_attrs = watch_mem_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
 };
 
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-- 
2.14.2
