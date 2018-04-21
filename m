Received: from eggs.gnu.org ([2001:4830:134:3::10]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9zsW-00041b-2K
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 17:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9zsS-0000fB-To
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 17:17:04 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:41850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9zsS-0000eX-Ok
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 17:17:00 -0400
Received: by mail-qk0-x242.google.com with SMTP id s78so12212796qkl.8
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 14:17:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 21 Apr 2018 18:16:52 -0300
Message-Id: <20180421211652.14794-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Burton <paul.burton@mips.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This fixes the following ASan warning:

  $ mips64el-softmmu/qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -nographic
  hw/core/loader-fit.c:108:17: runtime error: load of misaligned address 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
  0x7f95cd7e4264: note: pointer points here
    00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30 00 00  00 00 00 03 00 00 00 14
                ^

Reported-by: AddressSanitizer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/loader-fit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 0c4a7207f4..1a69697f89 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -93,6 +93,8 @@ static int fit_image_addr(const void *itb, int img, const char *name,
                           hwaddr *addr)
 {
     const void *prop;
+    fdt32_t v32;
+    fdt64_t v64;
     int len;
 
     prop = fdt_getprop(itb, img, name, &len);
@@ -102,10 +104,12 @@ static int fit_image_addr(const void *itb, int img, const char *name,
 
     switch (len) {
     case 4:
-        *addr = fdt32_to_cpu(*(fdt32_t *)prop);
+        memcpy(&v32, prop, sizeof(v32));
+        *addr = fdt32_to_cpu(v32);
         return 0;
     case 8:
-        *addr = fdt64_to_cpu(*(fdt64_t *)prop);
+        memcpy(&v64, prop, sizeof(v64));
+        *addr = fdt64_to_cpu(v64);
         return 0;
     default:
         error_printf("invalid %s address length %d\n", name, len);
-- 
2.17.0
