Received: from eggs.gnu.org ([209.51.188.92]:36084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR4-0004Rq-Ni
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR0-0008Ua-VG
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:40 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:37 +0200
Message-Id: <20190505221544.31568-7-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] hw/block/pflash_cfi02: Add helpers to
 manipulate the status bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Pull out all of the code to modify the status into simple helper
functions. Status handling becomes more complex once multiple
chips are interleaved to produce a single device.

No change in functionality is intended with this commit.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index b27796d74d2..9673eee969f 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -100,6 +100,31 @@ struct PFlashCFI02 {
     void *storage;
 };
=20
+/*
+ * Toggle status bit DQ7.
+ */
+static inline void toggle_dq7(PFlashCFI02 *pfl)
+{
+    pfl->status ^=3D 0x80;
+}
+
+/*
+ * Set status bit DQ7 to bit 7 of value.
+ */
+static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
+{
+    pfl->status &=3D 0x7F;
+    pfl->status |=3D value & 0x80;
+}
+
+/*
+ * Toggle status bit DQ6.
+ */
+static inline void toggle_dq6(PFlashCFI02 *pfl)
+{
+    pfl->status ^=3D 0x40;
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -129,7 +154,7 @@ static void pflash_timer (void *opaque)
=20
     trace_pflash_timer_expired(pfl->cmd);
     /* Reset flash */
-    pfl->status ^=3D 0x80;
+    toggle_dq7(pfl);
     if (pfl->bypass) {
         pfl->wcycle =3D 2;
     } else {
@@ -232,7 +257,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
         ret =3D pfl->status;
         DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
         /* Toggle bit 6 */
-        pfl->status ^=3D 0x40;
+        toggle_dq6(pfl);
         break;
     case 0x98:
         /* CFI query mode */
@@ -381,7 +406,11 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
                     break;
                 }
             }
-            pfl->status =3D 0x00 | ~(value & 0x80);
+            /*
+             * While programming, status bit DQ7 should hold the opposit=
e
+             * value from how it was programmed.
+             */
+            set_dq7(pfl, ~value);
             /* Let's pretend write is immediate */
             if (pfl->bypass)
                 goto do_bypass;
@@ -429,7 +458,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
                 memset(pfl->storage, 0xFF, pfl->chip_len);
                 pflash_update(pfl, 0, pfl->chip_len);
             }
-            pfl->status =3D 0x00;
+            set_dq7(pfl, 0x00);
             /* Let's wait 5 seconds before chip erase is done */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
                       (NANOSECONDS_PER_SECOND * 5));
@@ -444,7 +473,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
                 memset(p + offset, 0xFF, pfl->sector_len);
                 pflash_update(pfl, offset, pfl->sector_len);
             }
-            pfl->status =3D 0x00;
+            set_dq7(pfl, 0x00);
             /* Let's wait 1/2 second before sector erase is done */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
                       (NANOSECONDS_PER_SECOND / 2));
--=20
2.20.1
