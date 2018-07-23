Received: from eggs.gnu.org ([2001:4830:134:3::10]:43372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhL3-0004Fa-Hz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhL0-0005XH-Gl
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:49 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:35 -0500
Message-Id: <20180723201748.25573-87-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 86/99] hw/isa/superio: Fix inconsistent use of
 Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
use of Chardev->be. Also, this CharBackend member is private and is
not supposed to be accessible.

Fix it by removing the inconsistent check.

Cc: qemu-stable@nongnu.org
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180515152500.19460-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit d4c8fcd91abba584f2788dfe5fba5245cea380f0)
 Conflicts:
	hw/isa/isa-superio.c
* avoid context dep on 9bca0edb28
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/isa/isa-superio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index b95608a003..8ae6ea6f7b 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -43,7 +43,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
             /* FIXME use a qdev chardev prop instead of parallel_hds[] */
             chr = parallel_hds[i];
-            if (chr == NULL || chr->be) {
+            if (chr == NULL) {
                 name = g_strdup_printf("discarding-parallel%d", i);
                 chr = qemu_chr_new(name, "null");
             } else {
@@ -81,9 +81,9 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             break;
         }
         if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
-            /* FIXME use a qdev chardev prop instead of serial_hds[] */
+            /* FIXME use a qdev chardev prop instead of serial_hd() */
             chr = serial_hds[i];
-            if (chr == NULL || chr->be) {
+            if (chr == NULL) {
                 name = g_strdup_printf("discarding-serial%d", i);
                 chr = qemu_chr_new(name, "null");
             } else {
-- 
2.17.1
