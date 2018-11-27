Received: from eggs.gnu.org ([2001:4830:134:3::10]:41129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gReha-0000cQ-Ji
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gRehX-0002kh-93
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:51:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gRehX-0002gS-15
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:50:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id z5so18676720wrt.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:50:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 27 Nov 2018 15:50:43 +0100
Message-Id: <20181127145043.18545-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] configure: Disable the nanoMIPS
 disassembler on big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Stefan noticed the nanoMIPS disassembler uses incorrect format strings
on big endian hosts.

On big endian hosts, the output will appear as:

$ qemu-system-mipsel -M malta -cpu I7200 -semihosting \
  -bios nanoboot.bin -d in_asm
0xbfc0000: Asm output not supported on this arch

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 0a3c6a72c3..83a7c4746e 100755
--- a/configure
+++ b/configure
@@ -7382,7 +7382,11 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   mips*)
     disas_config "MIPS"
     if test -n "${cxx}"; then
-      disas_config "NANOMIPS"
+      # The nanomips disassembler currently does not work correctly
+      # on big endian host.
+      if test "$bigendian" = "no" ; then
+        disas_config "NANOMIPS"
+      fi
     fi
   ;;
   moxie*)
-- 
2.17.2
