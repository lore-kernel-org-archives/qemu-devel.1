Received: from eggs.gnu.org ([2001:4830:134:3::10]:36139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyK-0003mF-Sn
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyF-0002KO-CU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:32 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyF-0002Jo-5h
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:27 -0400
Received: by mail-wr0-x244.google.com with SMTP id p46so5598582wrb.0
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:15 +0200
Message-Id: <1508343141-31835-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/29] notdirty_mem_write: implement 8-byte
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>

From: Andrew Baumann <Andrew.Baumann@microsoft.com>

Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
always turn into atomic 8-byte writes on the host, however if we missed
in the softmmu, and the TLB line was marked as not dirty, then we
would end up tearing the 8-byte write into two 4-byte writes in
access_with_adjusted_size().

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Message-Id: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/exec.c b/exec.c
index 6579e7a..b58bc4e 100644
--- a/exec.c
+++ b/exec.c
@@ -2376,6 +2376,9 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
     case 4:
         stl_p(qemu_map_ram_ptr(NULL, ram_addr), val);
         break;
+    case 8:
+        stq_p(qemu_map_ram_ptr(NULL, ram_addr), val);
+        break;
     default:
         abort();
     }
@@ -2406,6 +2409,16 @@ static const MemoryRegionOps notdirty_mem_ops = {
     .write = notdirty_mem_write,
     .valid.accepts = notdirty_mem_accepts,
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
 
 /* Generate a debug exception if a watchpoint has been hit.  */
-- 
1.8.3.1
