Received: from eggs.gnu.org ([209.51.188.92]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gjPq2-0000ex-5O
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gjPq1-0006bw-EE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:37:10 -0500
Received: from smtp39.i.mail.ru ([94.100.177.99]:47222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gjPq0-0006aI-NI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:37:09 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Tue, 15 Jan 2019 17:36:50 +0300
Message-Id: <20190115143650.15725-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@mail.ru>

If the memory is set using a file, and PC is specified on the command
line, it will be overwritten with the value 'entry'. This is not only
illogical, but also incorrect, because the load_ * functions do not take
into account the specifics of the ARM-M PC.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/core/generic-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index fbae05fb3b..fc81fd8e14 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -152,7 +152,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
             size = load_image_targphys_as(s->file, s->addr, ram_size, as);
-        } else {
+        } else if (!s->addr) {
             s->addr = entry;
         }
 
-- 
2.17.1
