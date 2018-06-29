Received: from eggs.gnu.org ([2001:4830:134:3::10]:53417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNR-0007Ih-Cm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNO-0006nW-8K
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:58236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fYoNN-0006ki-WE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:30 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 29 Jun 2018 11:03:15 +0300
Message-Id: <20180629080320.320144-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 2/7] bitops: add some atomic versions of
 bitmap operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

1. test bit
2. test and set bit

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/qemu/bitops.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 3f0926cf40..7b1c8c7baf 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -94,6 +94,21 @@ static inline int test_and_set_bit(long nr, unsigned long *addr)
     return (old & mask) != 0;
 }
 
+/**
+ * test_and_set_bit_atomic - Set a bit atomically and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+static inline int test_and_set_bit_atomic(long nr, unsigned long *addr)
+{
+    unsigned long mask = BIT_MASK(nr);
+    unsigned long *p = addr + BIT_WORD(nr);
+    unsigned long old;
+
+    old = atomic_fetch_or(p, mask);
+    return (old & mask) != 0;
+}
+
 /**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
@@ -134,6 +149,15 @@ static inline int test_bit(long nr, const unsigned long *addr)
     return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+/**
+ * test_bit_atomic - Determine whether a bit is set atomicallly
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static inline int test_bit_atomic(long nr, const unsigned long *addr)
+{
+    return 1UL & (atomic_read(&addr[BIT_WORD(nr)]) >> (nr & (BITS_PER_LONG-1)));
+}
 /**
  * find_last_bit - find the last set bit in a memory region
  * @addr: The address to start the search at
-- 
2.17.0
