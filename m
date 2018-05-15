Received: from eggs.gnu.org ([2001:4830:134:3::10]:32921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIbpB-0002CI-Sg
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIbpA-0005oS-Ta
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 15 May 2018 12:24:59 -0300
Message-Id: <20180515152500.19460-2-f4bug@amsat.org>
In-Reply-To: <20180515152500.19460-1-f4bug@amsat.org>
References: <20180515152500.19460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] hw/isa/superio: Fix inconsistent use of
 Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
use of Chardev->be. Also, this CharBackend member is private and is
not supposed to be accessible.

Fix it by removing the inconsistent check.

Cc: qemu-stable@nongnu.org
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/isa/isa-superio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 76286c81a1..bb88251f95 100644
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
@@ -83,7 +83,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
             /* FIXME use a qdev chardev prop instead of serial_hd() */
             chr = serial_hd(i);
-            if (chr == NULL || chr->be) {
+            if (chr == NULL) {
                 name = g_strdup_printf("discarding-serial%d", i);
                 chr = qemu_chr_new(name, "null");
             } else {
-- 
2.17.0
