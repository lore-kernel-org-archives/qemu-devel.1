Received: from eggs.gnu.org ([209.51.188.92]:58011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAg-0000dG-NQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAf-00020N-Bd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAf-0001zi-22
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 547EA30832CB
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:49:00 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:23 +0100
Message-Id: <20190309004826.9027-8-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/10] roms: build edk2 firmware binaries and
 variable store templates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Add the "efi" target to "Makefile".

Introduce "Makefile.edk2" for building and cleaning the firmware images
and varstore templates.

Collect the common bits from the recipes in the helper script
"edk2-build.sh".

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 roms/Makefile      |   5 +
 roms/Makefile.edk2 | 138 ++++++++++++++++++++
 roms/edk2-build.sh |  55 ++++++++
 3 files changed, 198 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index 2e83ececa25a..054b432834ba 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -61,6 +61,7 @@ default:
 	@echo "  skiboot        -- update skiboot.lid"
 	@echo "  u-boot.e500    -- update u-boot.e500"
 	@echo "  u-boot.sam460  -- update u-boot.sam460"
+	@echo "  efi            -- update UEFI (edk2) platform firmware"
=20
 bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256=
k
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
@@ -143,6 +144,9 @@ skiboot:
 	$(MAKE) -C skiboot CROSS=3D$(powerpc64_cross_prefix)
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
=20
+efi: edk2-basetools
+	$(MAKE) -f Makefile.edk2
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -153,3 +157,4 @@ clean:
 	rm -rf u-boot/build.e500
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
+	$(MAKE) -f Makefile.edk2 clean
diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
new file mode 100644
index 000000000000..ad6fff044cd6
--- /dev/null
+++ b/roms/Makefile.edk2
@@ -0,0 +1,138 @@
+# Makefile for building firmware binaries and variable store templates f=
or a
+# number of virtual platforms in edk2.
+#
+# Copyright (C) 2019, Red Hat, Inc.
+#
+# This program and the accompanying materials are licensed and made avai=
lable
+# under the terms and conditions of the BSD License that accompanies thi=
s
+# distribution. The full text of the license may be found at
+# <http://opensource.org/licenses/bsd-license.php>.
+#
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+
+toolchain =3D $(shell source ./edk2-funcs.sh && qemu_edk2_get_toolchain =
$(1))
+
+licenses :=3D \
+	edk2/License.txt \
+	edk2/OvmfPkg/License.txt \
+	edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE
+
+# The "edk2-arm-vars.fd" varstore template is suitable for aarch64 as we=
ll.
+# Similarly, the "edk2-i386-vars.fd" varstore template is suitable for x=
86_64
+# as well, independently of "secure" too.
+all: \
+	../pc-bios/edk2-aarch64-code.fd \
+	../pc-bios/edk2-arm-code.fd \
+	../pc-bios/edk2-i386-code.fd \
+	../pc-bios/edk2-i386-secure-code.fd \
+	../pc-bios/edk2-x86_64-code.fd \
+	../pc-bios/edk2-x86_64-secure-code.fd \
+	\
+	../pc-bios/edk2-arm-vars.fd \
+	../pc-bios/edk2-i386-vars.fd \
+	\
+	../pc-bios/edk2-licenses.txt
+
+submodules:
+	cd edk2 && git submodule update --init --force
+
+# See notes on the ".NOTPARALLEL" target and the "+" indicator in
+# "tests/uefi-test-tools/Makefile".
+.NOTPARALLEL:
+
+../pc-bios/edk2-aarch64-code.fd: submodules
+	+./edk2-build.sh \
+		aarch64 \
+		--arch=3DAARCH64 \
+		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
+		-D NETWORK_IP6_ENABLE \
+		-D HTTP_BOOT_ENABLE
+	cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_$(call toolchain,aarch64)/FV/QE=
MU_EFI.fd \
+		$@
+	truncate --size=3D64M $@
+
+../pc-bios/edk2-arm-code.fd: submodules
+	+./edk2-build.sh \
+		arm \
+		--arch=3DARM \
+		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
+		-D NETWORK_IP6_ENABLE \
+		-D HTTP_BOOT_ENABLE
+	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_EFI.f=
d \
+		$@
+	truncate --size=3D64M $@
+
+../pc-bios/edk2-i386-code.fd: submodules
+	+./edk2-build.sh \
+		i386 \
+		--arch=3DIA32 \
+		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
+		-D NETWORK_IP6_ENABLE \
+		-D HTTP_BOOT_ENABLE \
+		-D TLS_ENABLE \
+		-D TPM2_ENABLE \
+		-D TPM2_CONFIG_ENABLE
+	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
+
+../pc-bios/edk2-i386-secure-code.fd: submodules
+	+./edk2-build.sh \
+		i386 \
+		--arch=3DIA32 \
+		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
+		-D NETWORK_IP6_ENABLE \
+		-D HTTP_BOOT_ENABLE \
+		-D TLS_ENABLE \
+		-D TPM2_ENABLE \
+		-D TPM2_CONFIG_ENABLE \
+		-D SECURE_BOOT_ENABLE \
+		-D SMM_REQUIRE
+	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
+
+../pc-bios/edk2-x86_64-code.fd: submodules
+	+./edk2-build.sh \
+		x86_64 \
+		--arch=3DX64 \
+		--platform=3DOvmfPkg/OvmfPkgX64.dsc \
+		-D NETWORK_IP6_ENABLE \
+		-D HTTP_BOOT_ENABLE \
+		-D TLS_ENABLE \
+		-D TPM2_ENABLE \
+		-D TPM2_CONFIG_ENABLE
+	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
+
+../pc-bios/edk2-x86_64-secure-code.fd: submodules
+	+./edk2-build.sh \
+		x86_64 \
+		--arch=3DIA32 \
+		--arch=3DX64 \
+		--platform=3DOvmfPkg/OvmfPkgIa32X64.dsc \
+		-D NETWORK_IP6_ENABLE \
+		-D HTTP_BOOT_ENABLE \
+		-D TLS_ENABLE \
+		-D TPM2_ENABLE \
+		-D TPM2_CONFIG_ENABLE \
+		-D SECURE_BOOT_ENABLE \
+		-D SMM_REQUIRE
+	cp edk2/Build/Ovmf3264/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $=
@
+
+../pc-bios/edk2-arm-vars.fd: ../pc-bios/edk2-arm-code.fd
+	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_VARS.=
fd \
+		$@
+	truncate --size=3D64M $@
+
+../pc-bios/edk2-i386-vars.fd: ../pc-bios/edk2-i386-code.fd
+	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_VARS.fd $@
+
+# The license file accumulates several individual licenses from under ed=
k2,
+# prefixing each individual license with a header (generated by "tail") =
that
+# states its pathname.
+../pc-bios/edk2-licenses.txt: submodules
+	tail -n $(shell cat $(licenses) | wc -l) $(licenses) > $@
+	dos2unix $@
+
+clean:
+	rm -rf edk2/Build
+	cd edk2/Conf && \
+		rm -rf .cache BuildEnv.sh build_rule.txt target.txt \
+			tools_def.txt
diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
new file mode 100755
index 000000000000..936d2c874a22
--- /dev/null
+++ b/roms/edk2-build.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+# Wrapper shell script for building a  virtual platform firmware in edk2=
.
+#
+# Copyright (C) 2019, Red Hat, Inc.
+#
+# This program and the accompanying materials are licensed and made avai=
lable
+# under the terms and conditions of the BSD License that accompanies thi=
s
+# distribution. The full text of the license may be found at
+# <http://opensource.org/licenses/bsd-license.php>.
+#
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+
+set -e -u -C
+
+# Save the command line arguments. We need to reset $# to 0 before sourc=
ing
+# "edksetup.sh", as it will inherit $@.
+emulation_target=3D$1
+shift
+num_args=3D0
+args=3D()
+for arg in "$@"; do
+  args[num_args++]=3D"$arg"
+done
+shift $num_args
+
+cd edk2
+
+# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
+export PYTHON_COMMAND=3Dpython2
+
+# Source "edksetup.sh" carefully.
+set +e +u +C
+source ./edksetup.sh
+ret=3D$?
+set -e -u -C
+if [ $ret -ne 0 ]; then
+  exit $ret
+fi
+
+# Fetch some option arguments, and set the cross-compilation environment=
 (if
+# any), for the edk2 "build" utility.
+source ../edk2-funcs.sh
+edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target")
+edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
+qemu_edk2_set_cross_env "$emulation_target"
+
+# Build the platform firmware.
+build \
+  --cmd-len=3D65536 \
+  -n "$edk2_thread_count" \
+  --buildtarget=3DDEBUG \
+  --tagname=3D"$edk2_toolchain" \
+  "${args[@]}"
--=20
2.19.1.3.g30247aa5d201
