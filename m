Received: from eggs.gnu.org ([209.51.188.92]:59235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWh-0004VT-DO
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWg-0003RC-93
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWg-0003Qi-2f
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so21738025wrq.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 18:23:02 +0200
Message-Id: <1554826986-37164-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/5] roms: Rename the EFIROM variable to avoid
 clashing with iPXE
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

The iPXE's 'veryclean' recipe removes $(EFIROM) even if the EFIROM
macro originates from elsewhere:

  $ git checkout f590a812c21~
  $ make -C roms clean EFIROM=$(type -P EfiRom)
  make: Entering directory '/source/qemu/roms'
  [...]
  make -C ipxe/src veryclean
  make[1]: Entering directory '/source/qemu/roms/ipxe/src'
  rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.* bin{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin ./util/elf2efi32 ./util/elf2efi64 /usr/bin/EfiRom ./util/efifatbin ./util/iccfix ./util/einfo TAGS bin{,-*}/symtab
  rm: cannot remove '/usr/bin/EfiRom': Permission denied
  make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
  make[1]: Leaving directory '/source/qemu/roms/ipxe/src'
  make: *** [Makefile:152: clean] Error 2
  make: Leaving directory '/source/qemu/roms'

Before f590a812c21 this variable could be overridden or unset,
and the 'veryclean' Makefile rule would not complain.

Commit f590a812c21 enforces this variable to the Intel EfiRom
tool provided by the EDK2 project.

To avoid the name clash and make the difference between the
projects obvious, rename the variable used by the EDK2 project
as EDK2_EFIROM.

Fixes: f590a812c21074e82228de3e1dfb57b75fc02b62
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409134536.15548-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 roms/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd1..d28252d 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
+EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
 
 default:
 	@echo "nothing is build by default"
@@ -102,8 +102,8 @@ pxe-rom-%: build-pxe-roms
 
 efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
 
-efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
-	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
+efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
+	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
 		-b ipxe/src/bin/$(VID)$(DID).rom \
 		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
 		-ec ipxe/src/bin-x86_64-efi/$(VID)$(DID).efidrv \
@@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
 
-$(EFIROM):
+$(EDK2_EFIROM):
 	$(MAKE) -C edk2/BaseTools
 
 slof:
-- 
1.8.3.1
