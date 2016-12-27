Received: from eggs.gnu.org ([2001:4830:134:3::10]:45335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1cM0v3-0000Q0-JN
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 18:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1cM0v0-00088f-Gk
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 18:12:33 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1cM0v0-00088Z-Bg
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 18:12:30 -0500
Received: by mail-yw0-x244.google.com with SMTP id b66so23366656ywh.2
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 15:12:30 -0800 (PST)
From: "=?UTF-8?q?Sergio=20Andr=C3=A9s=20G=C3=B3mez=20Del=20Real?="
	<sergio.g.delreal@gmail.com>
Date: Tue, 27 Dec 2016 18:11:56 -0500
Message-Id: <20161227231156.22745-1-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/dma: Fix dead code in pl080.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Sergio=20Andr=C3=A9s=20G=C3=B3mez=20Del=20Real?= <Sergio.G.DelReal@gmail.com>

The patch fixes dead code in pl080_read() and pl080_write() as reported
in bug #1637974. According to ARM's official Technical Reference Manual,
offsets handled by the switch statement are 0x100, 0x104, 0x108, 0x10C
and 0x110, so the solution suggested by the guy who reported the bug is
right.

Signed-off-by: Sergio Andrés Gómez Del Real <Sergio.G.DelReal@gmail.com>
---
 hw/dma/pl080.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 7724c93..3b0c20b 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -255,7 +255,7 @@ static uint64_t pl080_read(void *opaque, hwaddr offset,
         i = (offset & 0xe0) >> 5;
         if (i >= s->nchannels)
             goto bad_offset;
-        switch (offset >> 2) {
+        switch ((offset - 0x100) >> 2) {
         case 0: /* SrcAddr */
             return s->chan[i].src;
         case 1: /* DestAddr */
@@ -316,7 +316,7 @@ static void pl080_write(void *opaque, hwaddr offset,
         i = (offset & 0xe0) >> 5;
         if (i >= s->nchannels)
             goto bad_offset;
-        switch (offset >> 2) {
+        switch ((offset - 0x100) >> 2) {
         case 0: /* SrcAddr */
             s->chan[i].src = value;
             break;
-- 
2.10.2
