Received: from eggs.gnu.org ([2001:4830:134:3::10]:34317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJbo3-0004uI-D4
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJbo2-0002dU-K7
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:59:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJbo2-0002dQ-BA
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:59:22 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 21 Dec 2016 15:58:56 +0800
Message-Id: <1482307137-5106-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1482307137-5106-1-git-send-email-peterx@redhat.com>
References: <1482307137-5106-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] memory: provide common macros for
 mtree_print_mr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@gmail.com, peterx@redhat.com

mtree_print_mr() has some common codes. Generalize it.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/memory.c b/memory.c
index 33110e9..5dcc2e1 100644
--- a/memory.c
+++ b/memory.c
@@ -2450,6 +2450,13 @@ struct MemoryRegionList {
=20
 typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
=20
+#define MR_CHAR_RD(mr) ((mr)->romd_mode ? 'R' : '-')
+#define MR_CHAR_WR(mr) (!(mr)->readonly && !((mr)->rom_device && \
+                                             (mr)->romd_mode) ? 'W' : '-=
')
+#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
+                           int128_sub((size), int128_one())) : 0)
+#define MTREE_INDENT "  "
+
 static void mtree_print_mr(fprintf_function mon_printf, void *f,
                            const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
@@ -2465,7 +2472,7 @@ static void mtree_print_mr(fprintf_function mon_pri=
ntf, void *f,
     }
=20
     for (i =3D 0; i < level; i++) {
-        mon_printf(f, "  ");
+        mon_printf(f, MTREE_INDENT);
     }
=20
     if (mr->alias) {
@@ -2488,34 +2495,23 @@ static void mtree_print_mr(fprintf_function mon_p=
rintf, void *f,
                    " (prio %d, %c%c): alias %s @%s " TARGET_FMT_plx
                    "-" TARGET_FMT_plx "%s\n",
                    base + mr->addr,
-                   base + mr->addr
-                   + (int128_nz(mr->size) ?
-                      (hwaddr)int128_get64(int128_sub(mr->size,
-                                                      int128_one())) : 0=
),
+                   base + mr->addr + MR_SIZE(mr->size),
                    mr->priority,
-                   mr->romd_mode ? 'R' : '-',
-                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ?=
 'W'
-                                                                       :=
 '-',
+                   MR_CHAR_RD(mr),
+                   MR_CHAR_WR(mr),
                    memory_region_name(mr),
                    memory_region_name(mr->alias),
                    mr->alias_offset,
-                   mr->alias_offset
-                   + (int128_nz(mr->size) ?
-                      (hwaddr)int128_get64(int128_sub(mr->size,
-                                                      int128_one())) : 0=
),
+                   mr->alias_offset + MR_SIZE(mr->size),
                    mr->enabled ? "" : " [disabled]");
     } else {
         mon_printf(f,
                    TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %c%c): =
%s%s\n",
                    base + mr->addr,
-                   base + mr->addr
-                   + (int128_nz(mr->size) ?
-                      (hwaddr)int128_get64(int128_sub(mr->size,
-                                                      int128_one())) : 0=
),
+                   base + mr->addr + MR_SIZE(mr->size),
                    mr->priority,
-                   mr->romd_mode ? 'R' : '-',
-                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ?=
 'W'
-                                                                       :=
 '-',
+                   MR_CHAR_RD(mr),
+                   MR_CHAR_WR(mr),
                    memory_region_name(mr),
                    mr->enabled ? "" : " [disabled]");
     }
--=20
2.7.4
