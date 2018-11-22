Received: from eggs.gnu.org ([2001:4830:134:3::10]:51125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gPjI6-0002gZ-PY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gPjI1-0001mw-So
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:20:46 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gPjI1-0001lo-MD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:20:41 -0500
Received: by mail-pf1-x443.google.com with SMTP id g62so1485358pfd.12
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 23:20:41 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Thu, 22 Nov 2018 15:20:24 +0800
Message-Id: <20181122072028.22819-2-xiaoguangrong@tencent.com>
In-Reply-To: <20181122072028.22819-1-xiaoguangrong@tencent.com>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 1/5] bitops: introduce change_bit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It will be used by threaded workqueue

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 include/qemu/bitops.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 3f0926cf40..c522958852 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -79,6 +79,19 @@ static inline void change_bit(long nr, unsigned long *addr)
     *p ^= mask;
 }
 
+/**
+ * change_bit_atomic - Toggle a bit in memory atomically
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ */
+static inline void change_bit_atomic(long nr, unsigned long *addr)
+{
+    unsigned long mask = BIT_MASK(nr);
+    unsigned long *p = addr + BIT_WORD(nr);
+
+    atomic_xor(p, mask);
+}
+
 /**
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
-- 
2.14.5
