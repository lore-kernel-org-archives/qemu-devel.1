Received: from eggs.gnu.org ([209.51.188.92]:43652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxC-0006Qp-3F
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxB-0005CG-6m
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1UxB-00059p-0Z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:17 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:18 +0000
Message-Id: <20190306114227.9125-14-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/22] bitmap: fix bitmap_count_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com
Cc: eblake@redhat.com, armbru@redhat.com

From: Wei Wang <wei.w.wang@intel.com>

BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=3D0", which
makes bitmap_count_one fail to handle the "nbits=3D0" case. It appears to=
 be
preferred to remain BITMAP_LAST_WORD_MASK identical to the kernel
implementation that it is ported from.

So this patch fixes bitmap_count_one to handle the nbits=3D0 case.

Inital Discussion Link:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg554316.html
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Message-Id: <1544516693-5395-2-git-send-email-wei.w.wang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/bitmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eeddece..679f1bdce4 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -221,6 +221,10 @@ static inline int bitmap_intersects(const unsigned l=
ong *src1,
=20
 static inline long bitmap_count_one(const unsigned long *bitmap, long nb=
its)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits));
     } else {
--=20
2.20.1
