Received: from eggs.gnu.org ([209.51.188.92]:46378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gn3rT-0008K9-5T
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gn3rQ-00084A-TH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:57:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 25 Jan 2019 15:57:11 +0000
Message-Id: <20190125155711.2351-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] pflash: flush rom device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

pflash devices should mark the memory region dirty and invalidate TBs
after directly writing to the RAM backing the ROM device.

Note that pflash_cfi01_get_memory() is used by several machine types to
populate ROM contents directly.  Callers are untouched by this patch
because they only modify memory before the guest is started.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Based-on: <20190123212234.32068-1-stefanha@redhat.com>

Split from the original patch series.  Philippe asked me to drop the
flush calls in ->realize() since they are unnecessary.

Peter: Your ARM tree has the memory_region_flush_rom_device() patch that
this depends on, so it may be easiest for this to go via your tree.

 hw/block/pflash_cfi01.c | 3 +++
 hw/block/pflash_cfi02.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index bffb4c40e7..2f0b9c4c02 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -446,6 +446,7 @@ static inline void pflash_data_write(pflash_t *pfl, h=
waddr offset,
         break;
     }
=20
+    memory_region_flush_rom_device(&pfl->mem, offset, width);
 }
=20
 static void pflash_write(pflash_t *pfl, hwaddr offset,
@@ -482,6 +483,8 @@ static void pflash_write(pflash_t *pfl, hwaddr offset=
,
             if (!pfl->ro) {
                 memset(p + offset, 0xff, pfl->sector_len);
                 pflash_update(pfl, offset, pfl->sector_len);
+                memory_region_flush_rom_device(&pfl->mem, offset,
+                                               pfl->sector_len);
             } else {
                 pfl->status |=3D 0x20; /* Block erase error */
             }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 0f8b7b8c7b..47edce8dcf 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -378,6 +378,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offse=
t,
                     pflash_update(pfl, offset, 4);
                     break;
                 }
+
+                memory_region_flush_rom_device(&pfl->orig_mem, offset, w=
idth);
             }
             pfl->status =3D 0x00 | ~(value & 0x80);
             /* Let's pretend write is immediate */
@@ -426,6 +428,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offse=
t,
             if (!pfl->ro) {
                 memset(pfl->storage, 0xFF, pfl->chip_len);
                 pflash_update(pfl, 0, pfl->chip_len);
+                memory_region_flush_rom_device(&pfl->orig_mem, 0,
+                                               pfl->chip_len);
             }
             pfl->status =3D 0x00;
             /* Let's wait 5 seconds before chip erase is done */
@@ -441,6 +445,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offse=
t,
             if (!pfl->ro) {
                 memset(p + offset, 0xFF, pfl->sector_len);
                 pflash_update(pfl, offset, pfl->sector_len);
+                memory_region_flush_rom_device(&pfl->orig_mem, offset,
+                                               pfl->sector_len);
             }
             pfl->status =3D 0x00;
             /* Let's wait 1/2 second before sector erase is done */
--=20
2.20.1
