Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD76C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0834020830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0834020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzqL-0002OK-87
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:07:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzju-0005kN-HC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjs-0001Xm-Q4
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzjs-0001X8-Cn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A63D9356F6;
	Tue,  9 Apr 2019 23:01:11 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB8F1048130;
	Tue,  9 Apr 2019 23:01:02 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:17 +0200
Message-Id: <20190409230022.6462-8-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 09 Apr 2019 23:01:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 07/12] roms: build edk2 firmware
 binaries and variable store templates
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409230017.gncvDD18r4LPrzCIXqRXZjYJ-42VKdmBGobyGm84myM@z>

Add the "efi" target to "Makefile".

Introduce "Makefile.edk2" for building and cleaning the firmware images
and varstore templates.

Collect the common bits from the recipes in the helper script
"edk2-build.sh".

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes:
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Phil's R-b
   =20
    - pick up Michael's R-b
   =20
    - compress FD files with bzip2 rather than xz, so that decompression =
at
      "make install" time succeed on older build OSes too [Peter]
   =20
    - do not pick up Phil's T-b, consequently
   =20
    - do not pick up Igor's T-b for the same reason
   =20
    v2:
   =20
    - drop comma after copyright year, in both new files [Eric]
   =20
    - define the SHELL macro as /bin/bash near the top of "Makefile.edk2"=
,
      so that various bashisms (e.g. the "source" built-in, and the =3D=3D
      operator of "[") work even if /bin/sh isn't bash [Phil, Eric]
   =20
    - rework "Makefile.edk2" to produce xz-compressed flash device files
      [Dan, Michael, Phil]:
   =20
      - add implicit rule for compression,
   =20
      - mark uncompressed FD files as intermediate,
   =20
      - factor out the "flashdevs" macro for sharing between the "all" an=
d
        ".INTERMEDIATE" targets
   =20
    - due to said rework above, do not pick up Phil's R-b / T-b, and
      Michal's and Michael's R-b's

 roms/Makefile      |   5 +
 roms/Makefile.edk2 | 148 ++++++++++++++++++++
 roms/edk2-build.sh |  55 ++++++++
 3 files changed, 208 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index 93c3d467be14..0ce84a45ad57 100644
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
@@ -156,6 +157,9 @@ skiboot:
 	$(MAKE) -C skiboot CROSS=3D$(powerpc64_cross_prefix)
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
=20
+efi: edk2-basetools
+	$(MAKE) -f Makefile.edk2
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -166,3 +170,4 @@ clean:
 	rm -rf u-boot/build.e500
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
+	$(MAKE) -f Makefile.edk2 clean
diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
new file mode 100644
index 000000000000..822c547fec64
--- /dev/null
+++ b/roms/Makefile.edk2
@@ -0,0 +1,148 @@
+# Makefile for building firmware binaries and variable store templates f=
or a
+# number of virtual platforms in edk2.
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+SHELL =3D /bin/bash
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
+flashdevs :=3D \
+	aarch64-code \
+	arm-code \
+	i386-code \
+	i386-secure-code \
+	x86_64-code \
+	x86_64-secure-code \
+	\
+	arm-vars \
+	i386-vars
+
+all: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd.bz2)=
 \
+	../pc-bios/edk2-licenses.txt
+
+../pc-bios/edk2-%.fd.bz2: ../pc-bios/edk2-%.fd
+	bzip2 -9 -c $< > $@
+
+# When the build completes, we need not keep the uncompressed flash devi=
ce
+# files.
+.INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashde=
v).fd)
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
index 000000000000..4f46f8a6a217
--- /dev/null
+++ b/roms/edk2-build.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+# Wrapper shell script for building a  virtual platform firmware in edk2=
.
+#
+# Copyright (C) 2019 Red Hat, Inc.
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



