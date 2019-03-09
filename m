Received: from eggs.gnu.org ([209.51.188.92]:57844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAK-0000NB-5j
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAI-0001Ty-Uo
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAI-0001Qq-Lu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B04CD3082E1E
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:48:37 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:16 +0100
Message-Id: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/10] bundle edk2 platform firmware with QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Repo:   https://github.com/lersek/qemu.git
Branch: edk2_build

This series advances the roms/edk2 submodule to the "edk2-stable201903"
release, and builds and captures platform firmware binaries from that
release. At this point they are meant to be used by both end-users and
by Igor's ACPI unit tests in qtest ("make check").

Previous discussion:

  [Qemu-devel] bundling edk2 platform firmware images with QEMU
  http://mid.mail-archive.com/80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat=
.com
  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02601.html

Note that the series was formatted with "--no-binary" (affecting patch
#8), therefore it cannot be applied with "git-am". See the remote
repo/branch reference near the top instead.

Thanks,
Laszlo

Laszlo Ersek (10):
  roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
  roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
  tests/uefi-test-tools/build.sh: work around TianoCore#1607
  roms/edk2: advance to tag edk2-stable201903
  roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
  roms/Makefile: replace the $(EFIROM) target with "edk2-basetools"
  roms: build edk2 firmware binaries and variable store templates
  pc-bios: add edk2 firmware binaries and variable store templates
  pc-bios: document the edk2 firmware images; add firmware descriptors
  Makefile: install the edk2 firmware images and their descriptors

 Makefile                                       |  17 +-
 pc-bios/README                                 |  11 +
 pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
 pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
 pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
 pc-bios/descriptors/60-edk2-arm.json           |  31 +++
 pc-bios/descriptors/60-edk2-i386.json          |  33 +++
 pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
 pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 bytes
 pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 bytes
 pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 bytes
 pc-bios/edk2-i386-code.fd                      | Bin 0 -> 3653632 bytes
 pc-bios/edk2-i386-secure-code.fd               | Bin 0 -> 3653632 bytes
 pc-bios/edk2-i386-vars.fd                      | Bin 0 -> 540672 bytes
 pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++++
 pc-bios/edk2-x86_64-code.fd                    | Bin 0 -> 3653632 bytes
 pc-bios/edk2-x86_64-secure-code.fd             | Bin 0 -> 3653632 bytes
 roms/Makefile                                  |   9 +-
 roms/Makefile.edk2                             | 138 +++++++++++
 roms/edk2                                      |   2 +-
 roms/edk2-build.sh                             |  55 +++++
 roms/edk2-funcs.sh                             | 253 +++++++++++++++++++=
+
 tests/uefi-test-tools/build.sh                 | 100 +-------
 23 files changed, 897 insertions(+), 95 deletions(-)
 create mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
 create mode 100644 pc-bios/descriptors/50-edk2-x86_64-secure.json
 create mode 100644 pc-bios/descriptors/60-edk2-aarch64.json
 create mode 100644 pc-bios/descriptors/60-edk2-arm.json
 create mode 100644 pc-bios/descriptors/60-edk2-i386.json
 create mode 100644 pc-bios/descriptors/60-edk2-x86_64.json
 create mode 100644 pc-bios/edk2-aarch64-code.fd
 create mode 100644 pc-bios/edk2-arm-code.fd
 create mode 100644 pc-bios/edk2-arm-vars.fd
 create mode 100644 pc-bios/edk2-i386-code.fd
 create mode 100644 pc-bios/edk2-i386-secure-code.fd
 create mode 100644 pc-bios/edk2-i386-vars.fd
 create mode 100644 pc-bios/edk2-licenses.txt
 create mode 100644 pc-bios/edk2-x86_64-code.fd
 create mode 100644 pc-bios/edk2-x86_64-secure-code.fd
 create mode 100644 roms/Makefile.edk2
 create mode 100755 roms/edk2-build.sh
 create mode 100644 roms/edk2-funcs.sh

--=20
2.19.1.3.g30247aa5d201
