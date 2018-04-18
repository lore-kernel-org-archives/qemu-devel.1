Received: from eggs.gnu.org ([2001:4830:134:3::10]:32955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8iDp-00068f-22
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8iDo-0005s5-4Y
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:13:45 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Wed, 18 Apr 2018 10:13:10 +0200
Message-Id: <20180418081311.27803-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1] roms/ipxe: use configured compiler for ipxe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>, "open list:All patches CC here" <qemu-devel@nongnu.org>

configure allows to run a dedicated compiler binary, which is stored in
CC and HOST_CC variables, and overrides the default 'cc' command.

This command however is not used when building ipxe from source.
"make -C roms pxerom" invokes the buildsystem of ipxe.git, which has the
command "gcc" hardcoded. That binary may not be suitable to build ipxe.
Reuse the same compiler command that is used to build qemu by specifying
CC and HOST_CC as make commandline option to override the built-in
defaults of ipxe.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 roms/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index 02b69fbac8..982bf105a3 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -127,11 +127,13 @@ efi-rom-%: build-pxe-roms build-efi-roms
 
 build-pxe-roms:
 	$(MAKE) -C ipxe/src CONFIG=qemu \
+		CC=$(CC) HOST_CC=$(HOST_CC) \
 		CROSS_COMPILE=$(x86_64_cross_prefix) \
 		$(patsubst %,bin/%.rom,$(pxerom_targets))
 
 build-efi-roms: build-pxe-roms
 	$(MAKE) -C ipxe/src CONFIG=qemu \
+		CC=$(CC) HOST_CC=$(HOST_CC) \
 		CROSS_COMPILE=$(x86_64_cross_prefix) \
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
