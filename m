Received: from eggs.gnu.org ([209.51.188.92]:40616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOAh-0000o3-Rb
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOAg-0004vC-Si
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:19:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOAg-0004uS-NE
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:19:18 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 16:19:04 +0200
Message-Id: <20190427141905.20393-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/i386: The i440fx is not a machine,
 remove it from the machine list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

When building with CONFIG_ISAPC=3Dn and CONFIG_I440FX=3Dy we get:

  $ make subdir-x86_64-softmmu
  [...]
  /usr/bin/ld: hw/i386/pc_piix.o: in function `pc_init1':
  /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_ini=
t'
  /usr/bin/ld: /source/qemu/hw/i386/pc_piix.c:261: undefined reference to=
 `isa_ide_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1

This is because the I440FX device is a North Bridge, not a machine.
It is however used by the ISAPC machine.

Correct the dependency in the ISAPC Kconfig.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 -
 hw/i386/Kconfig                  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index ba3fb3ff50a..b33f5952128 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -23,5 +23,4 @@
 # Boards:
 #
 CONFIG_ISAPC=3Dy
-CONFIG_I440FX=3Dy
 CONFIG_Q35=3Dy
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6aed7c1313..9211adf2bb3 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -69,7 +69,7 @@ config ISAPC
     select VGA_ISA
     # FIXME: it is in the same file as i440fx, and does not compile
     # if separated
-    depends on I440FX
+    select I440FX
=20
 config Q35
     bool
--=20
2.20.1
