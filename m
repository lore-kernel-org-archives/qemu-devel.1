Received: from eggs.gnu.org ([209.51.188.92]:58054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAm-0000lS-Hi
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAl-00028C-My
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAl-00027b-GC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C701C3092656
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:49:06 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:26 +0100
Message-Id: <20190309004826.9027-11-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/10] Makefile: install the edk2 firmware
 images and their descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 Makefile | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d2463c92371f..a29dc5f87a3d 100644
--- a/Makefile
+++ b/Makefile
@@ -714,9 +714,16 @@ spapr-rtas.bin slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
-hppa-firmware.img
+hppa-firmware.img \
+edk2-aarch64-code.fd edk2-arm-code.fd edk2-i386-code.fd \
+edk2-i386-secure-code.fd edk2-x86_64-code.fd edk2-x86_64-secure-code.fd =
\
+edk2-arm-vars.fd edk2-i386-vars.fd edk2-licenses.txt
+
+DESCS=3D50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
+60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.j=
son
 else
 BLOBS=3D
+DESCS=3D
 endif
=20
 define install-manual =3D
@@ -797,6 +804,14 @@ ifneq ($(BLOBS),)
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
+	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
+	set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
+	for x in $(DESCS); do \
+		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
+			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
+		$(INSTALL_DATA) "$$tmpf" \
+			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
+	done
 endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
--=20
2.19.1.3.g30247aa5d201
