Received: from eggs.gnu.org ([2001:4830:134:3::10]:38649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejT6G-00027k-Sc
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejT6A-0004Ol-Lx
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:01:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ejT6A-0004OX-IX
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:01:30 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed,  7 Feb 2018 12:01:24 -0500
Message-Id: <20180207170124.26704-2-jsnow@redhat.com>
In-Reply-To: <20180207170124.26704-1-jsnow@redhat.com>
References: <20180207170124.26704-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] hbitmap: fix missing restore count when
 finish deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Liang Li <liliangleo@didichuxing.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Weiping Zhang <zhangweiping@didichuxing.com>

From: Liang Li <liliangleo@didichuxing.com>

The .count of HBitmap is forgot to set in function
hbitmap_deserialize_finish, let's set it to the right value.

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
Signed-off-by: Liang Li <liliangleo@didichuxing.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180118131308.GA2181@liangdeMacBook-Pro.local
Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/hbitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 289778a55c..58a2c93842 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
     }
 
     bitmap->levels[0][0] |= 1UL << (BITS_PER_LONG - 1);
+    bitmap->count = hb_count_between(bitmap, 0, bitmap->size - 1);
 }
 
 void hbitmap_free(HBitmap *hb)
-- 
2.14.3
