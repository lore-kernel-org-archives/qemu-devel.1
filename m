Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyJ-0003kP-B6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyG-0002L3-Ez
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:31 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:44429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyG-0002Kc-8v
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:28 -0400
Received: by mail-wm0-x244.google.com with SMTP id 196so13113553wma.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:28 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.13.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:13:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:16 +0200
Message-Id: <1508343141-31835-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/29] watch_mem_write: implement 8-byte accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
index b58bc4e..db5ae23 100644
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
1.8.3.1
