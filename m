Received: from eggs.gnu.org ([209.51.188.92]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAd-0000bA-Qb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAd-0001yh-31
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAc-0001yD-Sl
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3141FC04BD22
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:48:58 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:22 +0100
Message-Id: <20190309004826.9027-7-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/10] roms/Makefile: replace the $(EFIROM)
 target with "edk2-basetools"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

We don't (can't) have a recipe for building just $(EFIROM); therefore,
while we call the target $(EFIROM), we actually build all of the edk2
BaseTools. Rename the target to edk2-basetools, and update the iPXE
prerequisite accordingly. This will let other targets depend on
"edk2-basetools", where an $(EFIROM) pre-requisite would be misleading.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 roms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd18c301..2e83ececa25a 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -102,7 +102,7 @@ pxe-rom-%: build-pxe-roms
=20
 efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
=20
-efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
+efi-rom-%: build-pxe-roms build-efi-roms edk2-basetools
 	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
 		-b ipxe/src/bin/$(VID)$(DID).rom \
 		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
@@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
-$(EFIROM):
+edk2-basetools:
 	$(MAKE) -C edk2/BaseTools
=20
 slof:
--=20
2.19.1.3.g30247aa5d201
