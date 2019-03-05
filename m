Received: from eggs.gnu.org ([209.51.188.92]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcH-0001Ew-Ek
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcG-0001zn-I9
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1EcG-0001yu-Aw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:36 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:54 +0000
Message-Id: <20190305181602.9051-14-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/21] bitmap: bitmap_count_one_with_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Wei Wang <wei.w.wang@intel.com>

Count the number of 1s in a bitmap starting from an offset.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <1544516693-5395-3-git-send-email-wei.w.wang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/bitmap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 679f1bdce4..5c313346b9 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -232,6 +232,19 @@ static inline long bitmap_count_one(const unsigned l=
ong *bitmap, long nbits)
     }
 }
=20
+static inline long bitmap_count_one_with_offset(const unsigned long *bit=
map,
+                                                long offset, long nbits)
+{
+    long aligned_offset =3D QEMU_ALIGN_DOWN(offset, BITS_PER_LONG);
+    long redundant_bits =3D offset - aligned_offset;
+    long bits_to_count =3D nbits + redundant_bits;
+    const unsigned long *bitmap_start =3D bitmap +
+                                        aligned_offset / BITS_PER_LONG;
+
+    return bitmap_count_one(bitmap_start, bits_to_count) -
+           bitmap_count_one(bitmap_start, redundant_bits);
+}
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
--=20
2.20.1
