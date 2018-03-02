Received: from eggs.gnu.org ([2001:4830:134:3::10]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1erjRG-0008EZ-3r
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1erjRB-00004w-GG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:05:25 -0500
Message-Id: <e185e6a4172237432fb08bd1c616ab670f818cbb.1519991414.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1519991414.git.balaton@eik.bme.hu>
References: <cover.1519991414.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 02 Mar 2018 12:50:14 +0100
Subject: [Qemu-devel] [PATCH v2 1/2] roms: Added git submodule for
 u-boot-sam460 (firmware for sam460ex)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Jeff Cody <jcody@redhat.com>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: Fixed submodule and added Makefile rules to build binary

.gitmodules          | 3 +++
 roms/Makefile        | 7 +++++++
 roms/u-boot-sam460ex | 1 +
 3 files changed, 11 insertions(+)
 create mode 160000 roms/u-boot-sam460ex

diff --git a/.gitmodules b/.gitmodules
index 7a8282d..b76fb45 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,6 @@
 [submodule "roms/seabios-hppa"]
 	path = roms/seabios-hppa
 	url = git://github.com/hdeller/seabios-hppa.git
+[submodule "roms/u-boot-sam460ex"]
+	path = roms/u-boot-sam460ex
+	url = git://github.com/zbalaton/u-boot-sam460ex
diff --git a/roms/Makefile b/roms/Makefile
index b5e5a69..02b69fb 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -65,6 +65,7 @@ default:
 	@echo "  slof           -- update slof.bin"
 	@echo "  skiboot        -- update skiboot.lid"
 	@echo "  u-boot.e500    -- update u-boot.e500"
+	@echo "  u-boot.sam460  -- update u-boot.sam460"
 
 bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
@@ -147,6 +148,11 @@ u-boot.e500:
 	$(powerpc_cross_prefix)strip u-boot/build.e500/u-boot -o \
 		../pc-bios/u-boot.e500
 
+u-boot.sam460:
+	$(MAKE) -C u-boot-sam460ex Sam460ex_config
+	$(MAKE) -C u-boot-sam460ex CROSS_COMPILE=$(powerpc_cross_prefix)
+	cp u-boot-sam460ex/u-boot.bin ../pc-bios/u-boot-sam460-20100605.bin
+
 skiboot:
 	$(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
@@ -160,4 +166,5 @@ clean:
 	$(MAKE) -C ipxe/src veryclean
 	$(MAKE) -C SLOF clean
 	rm -rf u-boot/build.e500
+	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
new file mode 160000
index 0000000..119aa27
--- /dev/null
+++ b/roms/u-boot-sam460ex
@@ -0,0 +1 @@
+Subproject commit 119aa277f74a4a2d3f7ab6c9471292308eba14e4
-- 
2.7.6
