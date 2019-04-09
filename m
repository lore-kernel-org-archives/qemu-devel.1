Received: from eggs.gnu.org ([209.51.188.92]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWl-0004Z9-4k
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWk-0003US-4h
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWj-0003TX-Tm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id s15so21649839wra.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 18:23:03 +0200
Message-Id: <1554826986-37164-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] roms: Allow passing configure options to
 the EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit f590a812c210 we build the EDK2 EfiRom utility
unconditionally.

Some distributions require to use extra compiler/linker flags,
i.e. SUSE which enforces the PIE protection (see [*]).

EDK2 build tools already provide a set of variables for that,
use them to allow the caller to easily inject compiler/linker
options..

Now build scripts can pass extra options, example:

  $ make -C roms \
      EDK2_BASETOOLS_OPTFLAGS='-fPIE' \
      efirom

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409134536.15548-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 roms/Makefile | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index d28252d..1ff78b6 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -120,8 +120,21 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
 
+# Build scripts can pass compiler/linker flags to the EDK2 build tools
+# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
+# EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
+#
+# Example:
+#
+#  make -C roms \
+#    EDK2_BASETOOLS_OPTFLAGS='...' \
+#    EDK2_BASETOOLS_LDFLAGS='...' \
+#    efirom
+#
 $(EDK2_EFIROM):
-	$(MAKE) -C edk2/BaseTools
+	$(MAKE) -C edk2/BaseTools \
+		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
+		EXTRA_LDFLAGS='$(EDK2_BASETOOLS_LDFLAGS)'
 
 slof:
 	$(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
-- 
1.8.3.1
