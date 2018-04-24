Received: from eggs.gnu.org ([2001:4830:134:3::10]:41242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6JP-00022E-ID
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6JM-0001je-DY
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:21:23 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6JM-0001jH-9S
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:21:20 -0400
Received: by mail-qt0-x242.google.com with SMTP id q13-v6so24350056qtl.3
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 15:21:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 24 Apr 2018 19:21:03 -0300
Message-Id: <20180424222103.19946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The libfdt does not guarantee than fdt_getprop() returns a pointer
aligned to the property size.

Assuming the base of the fdt is aligned, a 32-bit property returns
a 32-bit aligned pointer. This is however not guaranteed for 64-bit
properties, where 64-bit loads might trigger unaligned access.

Fix the 64-bit access using the ldst (host) API, which uses a local
copy on the stack, thus guaranteeing a safe aligned access.

This fixes the following ASan warning:

  $ qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -nographic
  hw/core/loader-fit.c:108:17: runtime error: load of misaligned address 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
  0x7f95cd7e4264: note: pointer points here
    00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30 00 00  00 00 00 03 00 00 00 14
                ^

Reported-by: AddressSanitizer
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4: do not change the 32-bit access, use ldq_he_p() for the 64-bit access
v3: do not use memcpy(), incorrectly change ldl_he_p()
v2: do not change the 32-bit access, use memcpy(), add comments (David Gibson)
v1: use memcpy()

 hw/core/loader-fit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 0c4a7207f4..ed4140061b 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -102,10 +102,17 @@ static int fit_image_addr(const void *itb, int img, const char *name,
 
     switch (len) {
     case 4:
+        /* Assuming the base of the fdt is aligned, then fdt_getprop()
+         * returns 32-bit aligned properties, so this load is guaranteed
+         * to be 32-bit aligned.
+         */
         *addr = fdt32_to_cpu(*(fdt32_t *)prop);
         return 0;
     case 8:
-        *addr = fdt64_to_cpu(*(fdt64_t *)prop);
+        /* Since the property is not guaranteed to be 64-bit aligned,
+         * use ldq_he_p()'s stack to avoid an unaligned load.
+         */
+        *addr = fdt64_to_cpu(ldq_he_p(prop));
         return 0;
     default:
         error_printf("invalid %s address length %d\n", name, len);
-- 
2.17.0
