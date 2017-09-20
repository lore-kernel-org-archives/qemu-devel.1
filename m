Received: from eggs.gnu.org ([2001:4830:134:3::10]:42764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dueoE-0000Aq-C0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dueo7-0007iw-4b
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dueo6-0007i9-Qd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87B82C004771
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:47:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:46:35 +0200
Message-Id: <20170920104639.2335-13-quintela@redhat.com>
In-Reply-To: <20170920104639.2335-1-quintela@redhat.com>
References: <20170920104639.2335-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 12/16] bitmap: provide to_le/from_le helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Provide helpers to convert bitmaps to little endian format. It can be
used when we want to send one bitmap via network to some other hosts.

One thing to mention is that, these helpers only solve the problem of
endianess, but it does not solve the problem of different word size on
machines (the bitmaps managing same count of bits may contains different
size when malloced). So we need to take care of the size alignment issue
on the callers for now.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/qemu/bitmap.h |  7 +++++++
 util/bitmap.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 2718706edb..509eeddece 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -39,6 +39,8 @@
  * bitmap_clear(dst, pos, nbits)		Clear specified bit area
  * bitmap_test_and_clear_atomic(dst, pos, nbits)    Test and clear area
  * bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
+ * bitmap_to_le(dst, src, nbits)      Convert bitmap to little endian
+ * bitmap_from_le(dst, src, nbits)    Convert bitmap from little endian
  */
 
 /*
@@ -247,4 +249,9 @@ static inline unsigned long *bitmap_zero_extend(unsigned long *old,
     return new;
 }
 
+void bitmap_to_le(unsigned long *dst, const unsigned long *src,
+                  long nbits);
+void bitmap_from_le(unsigned long *dst, const unsigned long *src,
+                    long nbits);
+
 #endif /* BITMAP_H */
diff --git a/util/bitmap.c b/util/bitmap.c
index 90a42ff625..e80bcc74e2 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -370,3 +370,35 @@ long slow_bitmap_count_one(const unsigned long *bitmap, long nbits)
 
     return result;
 }
+
+static void bitmap_to_from_le(unsigned long *dst,
+                              const unsigned long *src, long nbits)
+{
+    long len = BITS_TO_LONGS(nbits);
+
+#ifdef HOST_WORDS_BIGENDIAN
+    long index;
+
+    for (index = 0; index < len; index++) {
+# if __WORD_SIZE == 64
+        dst[index] = bswap64(src[index]);
+# else
+        dst[index] = bswap32(src[index]);
+# endif
+    }
+#else
+    memcpy(dst, src, len * sizeof(unsigned long));
+#endif
+}
+
+void bitmap_from_le(unsigned long *dst, const unsigned long *src,
+                    long nbits)
+{
+    bitmap_to_from_le(dst, src, nbits);
+}
+
+void bitmap_to_le(unsigned long *dst, const unsigned long *src,
+                  long nbits)
+{
+    bitmap_to_from_le(dst, src, nbits);
+}
-- 
2.13.5
