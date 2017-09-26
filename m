Received: from eggs.gnu.org ([2001:4830:134:3::10]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnsd-0007K7-MD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnsU-0006rR-NK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwnsU-0006r9-CO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A6945275A
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:18:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 13:17:57 +0200
Message-Id: <20170926111757.3628-2-kraxel@redhat.com>
In-Reply-To: <20170926111757.3628-1-kraxel@redhat.com>
References: <20170926111757.3628-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] add Makefile, add configs for seabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Largely identical to roms/Makefile in qemu repo.
Paths have been adapted to qemu-firmware repo layout.
seabios submodule is updated automatically for builds.
"make install" target has been added.
"make help" text is more verbose.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile             | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configs/seabios-128k | 12 ++++++++
 configs/seabios-256k |  3 ++
 configs/vga-cirrus   |  3 ++
 configs/vga-isavga   |  3 ++
 configs/vga-qxl      |  6 ++++
 configs/vga-stdvga   |  3 ++
 configs/vga-virtio   |  6 ++++
 configs/vga-vmware   |  6 ++++
 9 files changed, 122 insertions(+)
 create mode 100644 Makefile
 create mode 100644 configs/seabios-128k
 create mode 100644 configs/seabios-256k
 create mode 100644 configs/vga-cirrus
 create mode 100644 configs/vga-isavga
 create mode 100644 configs/vga-qxl
 create mode 100644 configs/vga-stdvga
 create mode 100644 configs/vga-virtio
 create mode 100644 configs/vga-vmware

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000000..bf16c3b562
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,80 @@
+# directories
+DESTDIR	?=
+prefix	?= /usr/local
+datadir	:= $(DESTDIR)$(prefix)/share/qemu-firmware
+
+vgabios_variants := stdvga cirrus vmware qxl isavga virtio
+vgabios_targets  := $(subst -isavga,,$(patsubst %,vgabios-%.bin,$(vgabios_variants)))
+
+#
+# cross compiler auto detection
+#
+path := $(subst :, ,$(PATH))
+system := $(shell uname -s | tr "A-Z" "a-z")
+
+# first find cross binutils in path
+find-cross-ld = $(firstword $(wildcard $(patsubst %,%/$(1)-*$(system)*-ld,$(path))))
+# then check we have cross gcc too
+find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld,$(1)))))
+# finally strip off path + toolname so we get the prefix
+find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
+
+powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
+powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
+x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
+
+# tag our seabios builds
+SEABIOS_EXTRAVERSION="-prebuilt.qemu-project.org"
+
+default help:
+	@echo
+	@echo "nothing is done by default"
+	@echo
+	@echo "build targets:"
+	@echo "  bios           -- update bios.bin (seabios)"
+	@echo "  vgabios        -- update vgabios binaries (seabios)"
+	@echo
+	@echo "other targets:"
+	@echo "  clean          -- cleanup"
+	@echo "  install        -- install blobs to $(datadir)"
+	@echo
+	@echo "You can set DESTDIR and prefix on the command line to"
+	@echo "to change the install target directory, for example:"
+	@echo "$ make prefix=/usr install"
+	@echo
+
+install:
+	mkdir -p $(datadir)
+	cp -v blobs/*.bin $(datadir)
+
+bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
+	cp repos/seabios/builds/seabios-128k/bios.bin blobs/bios.bin
+	cp repos/seabios/builds/seabios-256k/bios.bin blobs/bios-256k.bin
+
+vgabios: $(patsubst %,vgabios-%,$(vgabios_variants))
+
+vgabios-isavga: build-seabios-config-vga-isavga
+	cp repos/seabios/builds/vga-isavga/vgabios.bin blobs/vgabios.bin
+
+vgabios-%: build-seabios-config-vga-%
+	cp repos/seabios/builds/vga-$*/vgabios.bin blobs/vgabios-$*.bin
+
+build-seabios-config-%: configs/% submodule-seabios
+	mkdir -p repos/seabios/builds/$*
+	cp $< repos/seabios/builds/$*/.config
+	$(MAKE) -C repos/seabios \
+		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
+		CROSS_COMPILE=$(x86_64_cross_prefix) \
+		KCONFIG_CONFIG=$(CURDIR)/repos/seabios/builds/$*/.config \
+		OUT=$(CURDIR)/repos/seabios/builds/$*/ oldnoconfig
+	$(MAKE) -C repos/seabios \
+		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
+		CROSS_COMPILE=$(x86_64_cross_prefix) \
+		KCONFIG_CONFIG=$(CURDIR)/repos/seabios/builds/$*/.config \
+		OUT=$(CURDIR)/repos/seabios/builds/$*/ all
+
+clean:
+	rm -rf repos/seabios/.config repos/seabios/out repos/seabios/builds
+
+submodule-%:
+	git submodule update --init repos/$*
diff --git a/configs/seabios-128k b/configs/seabios-128k
new file mode 100644
index 0000000000..93203af0de
--- /dev/null
+++ b/configs/seabios-128k
@@ -0,0 +1,12 @@
+# for qemu machine types 1.7 + older
+# need to turn off features (xhci,uas) to make it fit into 128k
+CONFIG_QEMU=y
+CONFIG_ROM_SIZE=128
+CONFIG_BOOTSPLASH=n
+CONFIG_XEN=n
+CONFIG_USB_OHCI=n
+CONFIG_USB_XHCI=n
+CONFIG_USB_UAS=n
+CONFIG_SDCARD=n
+CONFIG_TCGBIOS=n
+CONFIG_MPT_SCSI=n
diff --git a/configs/seabios-256k b/configs/seabios-256k
new file mode 100644
index 0000000000..65e5015c2f
--- /dev/null
+++ b/configs/seabios-256k
@@ -0,0 +1,3 @@
+# for qemu machine types 2.0 + newer
+CONFIG_QEMU=y
+CONFIG_ROM_SIZE=256
diff --git a/configs/vga-cirrus b/configs/vga-cirrus
new file mode 100644
index 0000000000..c8fe58239f
--- /dev/null
+++ b/configs/vga-cirrus
@@ -0,0 +1,3 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_CIRRUS=y
+CONFIG_VGA_PCI=y
diff --git a/configs/vga-isavga b/configs/vga-isavga
new file mode 100644
index 0000000000..e55e294a0c
--- /dev/null
+++ b/configs/vga-isavga
@@ -0,0 +1,3 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_BOCHS=y
+CONFIG_VGA_PCI=n
diff --git a/configs/vga-qxl b/configs/vga-qxl
new file mode 100644
index 0000000000..d393f0c34f
--- /dev/null
+++ b/configs/vga-qxl
@@ -0,0 +1,6 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_BOCHS=y
+CONFIG_VGA_PCI=y
+CONFIG_OVERRIDE_PCI_ID=y
+CONFIG_VGA_VID=0x1b36
+CONFIG_VGA_DID=0x0100
diff --git a/configs/vga-stdvga b/configs/vga-stdvga
new file mode 100644
index 0000000000..7d063b787c
--- /dev/null
+++ b/configs/vga-stdvga
@@ -0,0 +1,3 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_BOCHS=y
+CONFIG_VGA_PCI=y
diff --git a/configs/vga-virtio b/configs/vga-virtio
new file mode 100644
index 0000000000..aa7a15ba11
--- /dev/null
+++ b/configs/vga-virtio
@@ -0,0 +1,6 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_BOCHS=y
+CONFIG_VGA_PCI=y
+CONFIG_OVERRIDE_PCI_ID=y
+CONFIG_VGA_VID=0x1af4
+CONFIG_VGA_DID=0x1050
diff --git a/configs/vga-vmware b/configs/vga-vmware
new file mode 100644
index 0000000000..eb10427afd
--- /dev/null
+++ b/configs/vga-vmware
@@ -0,0 +1,6 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_BOCHS=y
+CONFIG_VGA_PCI=y
+CONFIG_OVERRIDE_PCI_ID=y
+CONFIG_VGA_VID=0x15ad
+CONFIG_VGA_DID=0x0405
-- 
2.9.3
