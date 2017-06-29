Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZPj-0001N8-L6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZPg-0007fs-UQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dQZPg-0007fB-NA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBC714C539
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 13:23:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Jun 2017 15:23:03 +0200
Message-Id: <20170629132310.18865-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/7] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Recent linux kernels enable KASLR to randomize phys/virt memory
addresses. This series aims to provide enough information in qemu
dumps so that crash utility can work with randomized kernel too (it
hasn't been tested on other archs than x86 though, help welcome).

The vmcoreinfo device is an emulated ACPI device that exposes a 4k
memory range to the guest to store various informations useful to
debug the guest OS. (it is greatly inspired by the VMGENID device
implementation). The version field with value 0 is meant to give
paddr/size of the VMCOREINFO ELF PT_NOTE, other values can be used for
different purposes or OSes. (note: some wanted to see pvpanic somehow
merged with this device, I have no clear idea how to do that, nor do I
think this is a good idea since the devices are quite different, used
at different time for different purposes. And it can be done as a
future iteration if it is appropriate, feel free to send patches)

Crash 7.1.9 will parse the "phys_base" value from the VMCOREINFO note,
and thus will work with KASLR-dump produced by this series.

By priority, VMCOREINFO "phys_base" value is the most accurate. If not
available, qemu will keep the current guessed value.

The series implements the VMCOREINFO note addition in qemu ELF/kdump,
as well as the python scripts/dump-guest-memory.py.

To test:

Compile and run a guest kernel with CONFIG_RANDOMIZE_BASE=3Dy.

Run qemu with -device vmcoreinfo.

Load the experimental vmcoreinfo module in guest
https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c.

Produce an ELF dump:
{ "execute": "dump-guest-memory", "arguments": { "protocol": "file:dump",=
 "paging": false } }

Produce a kdump:
{ "execute": "dump-guest-memory", "arguments": { "protocol": "file:dump",=
 "paging": false, "format": "kdump-zlib" } }

Or with (gdb) dump-guest-memory, with scripts/dump-guest-memory.py script=
.

Analyze with crash >=3D 7.1.9
$ crash vmlinux dump

Marc-Andr=C3=A9 Lureau (7):
  vmgenid: replace x-write-pointer-available hack
  acpi: add vmcoreinfo device
  tests: add simple vmcoreinfo test
  dump: add vmcoreinfo ELF note
  kdump: add vmcoreinfo ELF note
  scripts/dump-guest-memory.py: add vmcoreinfo
  MAINTAINERS: add Dump maintainers

 scripts/dump-guest-memory.py         |  32 ++++++
 include/hw/acpi/aml-build.h          |   1 +
 include/hw/acpi/bios-linker-loader.h |   2 +
 include/hw/acpi/vmcoreinfo.h         |  37 ++++++
 include/hw/compat.h                  |   4 -
 include/sysemu/dump.h                |   2 +
 dump.c                               | 165 ++++++++++++++++++++++++++-
 hw/acpi/aml-build.c                  |   2 +
 hw/acpi/bios-linker-loader.c         |   6 +
 hw/acpi/vmcoreinfo.c                 | 214 +++++++++++++++++++++++++++++=
++++++
 hw/acpi/vmgenid.c                    |   9 +-
 hw/i386/acpi-build.c                 |  14 +++
 tests/vmcoreinfo-test.c              | 130 +++++++++++++++++++++
 MAINTAINERS                          |   7 ++
 default-configs/arm-softmmu.mak      |   1 +
 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 docs/specs/vmcoreinfo.txt            | 138 ++++++++++++++++++++++
 hw/acpi/Makefile.objs                |   1 +
 tests/Makefile.include               |   2 +
 20 files changed, 753 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/acpi/vmcoreinfo.h
 create mode 100644 hw/acpi/vmcoreinfo.c
 create mode 100644 tests/vmcoreinfo-test.c
 create mode 100644 docs/specs/vmcoreinfo.txt

--=20
2.13.1.395.gf7b71de06
