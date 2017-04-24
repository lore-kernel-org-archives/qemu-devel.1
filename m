Received: from eggs.gnu.org ([2001:4830:134:3::10]:42124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006ag-TH
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cve-0007NA-UF
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cve-0007Ls-ON
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5D424E028
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:16:59 +0200
Message-Id: <20170424121708.31953-5-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 04/13] bitmap: add bitmap_copy_and_clear_atomic
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
Message-id: 20170421091632.30900-2-kraxel@redhat.com
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
