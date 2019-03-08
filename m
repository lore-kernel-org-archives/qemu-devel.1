Received: from eggs.gnu.org ([209.51.188.92]:42900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C55-0002C0-4G
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C54-00064o-8Y
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 10:45:57 +0100
Message-Id: <20190308094610.21210-3-armbru@redhat.com>
In-Reply-To: <20190308094610.21210-1-armbru@redhat.com>
References: <20190308094610.21210-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/15] pflash_cfi01: Do not exit() on guest
 aborting "write to buffer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu

When a guest tries to abort "write to buffer" (command 0xE8), we print
"PFLASH: Possible BUG - Write block confirm", then exit(1).  Letting
the guest terminate QEMU is not a good idea.  Instead, LOG_UNIMP we
screwed up, then reset the device.

Macro PFLASH_BUG() is now unused; delete it.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 hw/block/pflash_cfi01.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a51ac9f399..e6d933a06d 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -49,12 +49,6 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
=20
-#define PFLASH_BUG(fmt, ...) \
-do { \
-    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__); \
-    exit(1); \
-} while(0)
-
 /* #define PFLASH_DEBUG */
 #ifdef PFLASH_DEBUG
 #define DPRINTF(fmt, ...)                                   \
@@ -623,8 +617,11 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
             } else {
-                DPRINTF("%s: unknown command for \"write block\"\n", __f=
unc__);
-                PFLASH_BUG("Write block confirm");
+                qemu_log_mask(LOG_UNIMP,
+                    "%s: Aborting write to buffer not implemented,"
+                    " the data is already written to storage!\n"
+                    "Flash device reset into READ mode.\n",
+                    __func__);
                 goto reset_flash;
             }
             break;
--=20
2.17.2
