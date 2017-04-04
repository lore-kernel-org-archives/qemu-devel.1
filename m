Received: from eggs.gnu.org ([2001:4830:134:3::10]:54141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026o-LS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002CO-HL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-0002A3-Ad
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:06 +0200
Message-Id: <20170404102315.24923-2-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] bitmap: add bitmap_copy_and_clear_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/bitmap.h |  2 ++
 util/bitmap.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 63ea2d0..c318da1 100644
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
index c1a84ca..efced9a 100644
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
