Received: from eggs.gnu.org ([2001:4830:134:3::10]:44341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWE-0003U2-HB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWC-0006AM-Sd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVcWC-0006AB-N9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:24 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Jun 2018 14:47:16 +0200
Message-Id: <20180620124719.16450-5-kraxel@redhat.com>
In-Reply-To: <20180620124719.16450-1-kraxel@redhat.com>
References: <20180620124719.16450-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] vgabios: remove submodule and build rules.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

It's the old, lgpl vgabios implementation.

Was left in as fallback when we switched to seavgabios, so we could
easily switch back in case we see regressions.  It's unused since years
now, reportedly doesn't even build, and lacks support for recently (and
not so recently) added display devices.

Zap it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .gitmodules   |  3 ---
 roms/Makefile | 18 ++----------------
 roms/vgabios  |  1 -
 3 files changed, 2 insertions(+), 20 deletions(-)
 delete mode 160000 roms/vgabios

diff --git a/.gitmodules b/.gitmodules
index 49e9c2e3f4..d108478e0a 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,6 +1,3 @@
-[submodule "roms/vgabios"]
-	path = roms/vgabios
-	url = git://git.qemu-project.org/vgabios.git/
 [submodule "roms/seabios"]
 	path = roms/seabios
 	url = git://git.qemu-project.org/seabios.git/
diff --git a/roms/Makefile b/roms/Makefile
index a73778f60b..f1ac85ae9b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -56,8 +56,7 @@ default:
 	@echo "nothing is build by default"
 	@echo "available build targets:"
 	@echo "  bios           -- update bios.bin (seabios)"
-	@echo "  seavgabios     -- update vgabios binaries (seabios)"
-	@echo "  lgplvgabios    -- update vgabios binaries (lgpl)"
+	@echo "  vgabios        -- update vgabios binaries (seabios)"
 	@echo "  sgabios        -- update sgabios binaries"
 	@echo "  pxerom         -- update nic roms (bios only)"
 	@echo "  efirom         -- update nic roms (bios+efi, this needs"
@@ -71,7 +70,7 @@ bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
 	cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
 
-seavgabios: $(patsubst %,seavgabios-%,$(vgabios_variants))
+vgabios seavgabios: $(patsubst %,seavgabios-%,$(vgabios_variants))
 
 seavgabios-isavga: build-seabios-config-vga-isavga
 	cp seabios/builds/vga-isavga/vgabios.bin ../pc-bios/vgabios.bin
@@ -94,17 +93,6 @@ build-seabios-config-%: config.%
 		OUT=$(CURDIR)/seabios/builds/$*/ all
 
 
-lgplvgabios: $(patsubst %,lgplvgabios-%,$(vgabios_variants))
-
-lgplvgabios-isavga: build-lgplvgabios
-	cp vgabios/VGABIOS-lgpl-latest.bin ../pc-bios/vgabios.bin
-lgplvgabios-%: build-lgplvgabios
-	cp vgabios/VGABIOS-lgpl-latest.$*.bin ../pc-bios/vgabios-$*.bin
-
-build-lgplvgabios:
-	$(MAKE) -C vgabios $(vgabios_targets)
-
-
 .PHONY: sgabios skiboot
 sgabios:
 	$(MAKE) -C sgabios
@@ -159,8 +147,6 @@ skiboot:
 
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
-	$(MAKE) -C vgabios clean
-	rm -f vgabios/VGABIOS-lgpl-latest*
 	$(MAKE) -C sgabios clean
 	rm -f sgabios/.depend
 	$(MAKE) -C ipxe/src veryclean
diff --git a/roms/vgabios b/roms/vgabios
deleted file mode 160000
index 19ea12c230..0000000000
--- a/roms/vgabios
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 19ea12c230ded95928ecaef0db47a82231c2e485
-- 
2.9.3
