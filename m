Received: from eggs.gnu.org ([2001:4830:134:3::10]:37095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgF-0001wb-Qg
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgD-0001F1-5P
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d1UgC-0001Dk-Vx
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AC56CDF96
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:16:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Apr 2017 11:16:24 +0200
Message-Id: <20170421091632.30900-2-kraxel@redhat.com>
In-Reply-To: <20170421091632.30900-1-kraxel@redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] bitmap: add bitmap_copy_and_clear_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/bitmap.h |  2 ++
 util/bitmap.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 63ea2d0b1e..c318da12d7 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -220,6 +220,8 @@ void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
 bool bitmap_test_and_clear_atomic(unsigned long *map, long start, long nr);
+void bitmap_copy_and_clear_atomic(unsigned long *dst, unsigned long *src,
+                                  long nr);
 unsigned long bitmap_find_next_zero_area(unsigned long *map,
                                          unsigned long size,
                                          unsigned long start,
diff --git a/util/bitmap.c b/util/bitmap.c
index c1a84ca5e3..efced9a7d8 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -287,6 +287,17 @@ bool bitmap_test_and_clear_atomic(unsigned long *map, long start, long nr)
     return dirty != 0;
 }
 
+void bitmap_copy_and_clear_atomic(unsigned long *dst, unsigned long *src,
+                                  long nr)
+{
+    while (nr > 0) {
+        *dst = atomic_xchg(src, 0);
+        dst++;
+        src++;
+        nr -= BITS_PER_LONG;
+    }
+}
+
 #define ALIGN_MASK(x,mask)      (((x)+(mask))&~(mask))
 
 /**
-- 
2.9.3
