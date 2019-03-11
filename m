Received: from eggs.gnu.org ([209.51.188.92]:35656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6M-00005S-DD
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6K-0004Zr-PC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6I-0004WO-Kf
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DB35308FF19
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 691105C23B
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:18 +0100
Message-Id: <20190311220843.4026-3-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/27] pflash_cfi01: Do not exit() on guest
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

When a guest tries to abort "write to buffer" (command 0xE8), we print
"PFLASH: Possible BUG - Write block confirm", then exit(1).  Letting
the guest terminate QEMU is not a good idea.  Instead, LOG_UNIMP we
screwed up, then reset the device.

Macro PFLASH_BUG() is now unused; delete it.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190308094610.21210-3-armbru@redhat.com>
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
