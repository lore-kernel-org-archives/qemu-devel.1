Received: from eggs.gnu.org ([209.51.188.92]:38550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmPzU-0006Hg-Da
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmPzT-0001rB-Ja
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:23:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 21:22:31 +0000
Message-Id: <20190123212234.32068-3-stefanha@redhat.com>
In-Reply-To: <20190123212234.32068-1-stefanha@redhat.com>
References: <20190123212234.32068-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, jusual@mail.ru, Laurent Vivier <lvivier@redhat.com>, jim@groklearning.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>

pflash devices should mark the memory region dirty and invalidate TBs
after directly writing to the RAM backing the ROM device.

Note that pflash_cfi01_get_memory() is used by several machine types to
populate ROM contents directly.  Callers are untouched by this patch
because they only modify memory before the guest is started.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/pflash_cfi01.c | 5 +++++
 hw/block/pflash_cfi02.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index bffb4c40e7..5301c11c18 100644
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
@@ -763,6 +766,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
             error_setg(errp, "failed to read the initial flash content")=
;
             return;
         }
+
+        memory_region_flush_rom_device(&pfl->mem, 0, total_len);
     }
=20
     /* Default to devices being used at their maximum device width. This=
 was
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 0f8b7b8c7b..d04572eca4 100644
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
@@ -590,6 +596,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
             error_setg(errp, "failed to read the initial flash content")=
;
             return;
         }
+
+        memory_region_flush_rom_device(&pfl->orig_mem, 0, chip_len);
     }
=20
     pflash_setup_mappings(pfl);
--=20
2.20.1
