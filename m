Received: from eggs.gnu.org ([2001:4830:134:3::10]:44228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW6kQ-0000Tu-OY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW6kN-0005t1-LN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW6kN-0005sQ-B7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C39A356CD
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 19:59:30 +0000 (UTC)
Date: Fri, 14 Jul 2017 22:59:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714222705-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170714182012.4595-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/8] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com, lersek@redhat.com

On Fri, Jul 14, 2017 at 08:20:03PM +0200, Marc-Andr=E9 Lureau wrote:
> Recent linux kernels enable KASLR to randomize phys/virt memory
> addresses. This series aims to provide enough information in qemu
> dumps so that crash utility can work with randomized kernel too (it
> hasn't been tested on other archs than x86 though, help welcome).
>=20
> The vmcoreinfo device is an emulated ACPI device that exposes a 4k
> memory range to the guest to store various informations useful to
> debug the guest OS. (it is greatly inspired by the VMGENID device
> implementation). The version field with value 0 is meant to give
> paddr/size of the VMCOREINFO ELF PT_NOTE, other values can be used for
> different purposes or OSes. (note: some wanted to see pvpanic somehow
> merged with this device, I have no clear idea how to do that, nor do I
> think this is a good idea since the devices are quite different, used
> at different time for different purposes. And it can be done as a
> future iteration if it is appropriate, feel free to send patches)

First, I think you underestimate the difficulty of maintaining
compatibility.

Second, this seems racy - how do you know when is guest done writing out
the data?

Given you have very little data to export (PA, size - do
you even need size?) - how about just using an ACPI method do it,
instead of exporting a physical addess and storing address there.  This
way you can add more methods as you add functionality.

VMGENID has very specific requirements around performance,
and does not care about consistency at all.
This does not apply here.


> Crash 7.1.9 will parse the "phys_base" value from the VMCOREINFO note,
> and thus will work with KASLR-dump produced by this series.
>=20
> By priority, VMCOREINFO "phys_base" value is the most accurate. If not
> available, qemu will keep the current guessed value.
>=20
> The series implements the VMCOREINFO note addition in qemu ELF/kdump,
> as well as the python scripts/dump-guest-memory.py.
>=20
> To test:
>=20
> Compile and run a guest kernel with CONFIG_RANDOMIZE_BASE=3Dy.
>=20
> Run qemu with -device vmcoreinfo.
>=20
> Load the experimental vmcoreinfo module in guest
> https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c.
>=20
> Produce an ELF dump:
> { "execute": "dump-guest-memory", "arguments": { "protocol": "file:dump=
", "paging": false } }
>=20
> Produce a kdump:
> { "execute": "dump-guest-memory", "arguments": { "protocol": "file:dump=
", "paging": false, "format": "kdump-zlib" } }
>=20
> Or with (gdb) dump-guest-memory, with scripts/dump-guest-memory.py scri=
pt.
>=20
> Analyze with crash >=3D 7.1.9
> $ crash vmlinux dump
>=20
> v4: from Laszlo review
> - switch to warn_report*()
> - update test to follow vmgenid and use boot-sector infrastructure
> - fix range checks in the python script
> - add vmcoreinfo_get() stub
>=20
> v3: from Laszlo review
> - change vmcoreinfo offset to 36
> - reset err to null after report
> - use PRIu32
> - change name_size and desc_size against MAX_VMCOREINFO_SIZE
> - python code simplification
> - check boundaries of blocks in phys_memory_read()
> - fix some vmgi vs vmci names
> - add more comments in code
> - fix comment indentation
> - add r-b tags
>=20
> v2: from Laszlo review
> - vmci: fix guest endianess handling
> - vmci: fix wrong sizeof()
> - vmci: add back reset logic from vmgenid
> - dump: have 1MB size limit for vmcoreinfo
> - dump: fix potential off-by-1 buffer manipulation
> - dump: use temporary variable for qemu_strtou64
> - dump: fixed VMCOREINFO duplication in kdump
> - update gdb script to not call into qemu process
> - update MAINTAINERS with some new files
>=20
> Marc-Andr=E9 Lureau (8):
>   vmgenid: replace x-write-pointer-available hack
>   acpi: add vmcoreinfo device
>   stubs: add vmcoreinfo_get() stub
>   tests: add simple vmcoreinfo test
>   dump: add vmcoreinfo ELF note
>   kdump: add vmcoreinfo ELF note
>   scripts/dump-guest-memory.py: add vmcoreinfo
>   MAINTAINERS: add Dump maintainers
>=20
>  scripts/dump-guest-memory.py         |  47 ++++++++
>  include/hw/acpi/aml-build.h          |   1 +
>  include/hw/acpi/bios-linker-loader.h |   2 +
>  include/hw/acpi/vmcoreinfo.h         |  37 ++++++
>  include/hw/compat.h                  |   4 -
>  include/sysemu/dump.h                |   2 +
>  dump.c                               | 154 +++++++++++++++++++++++++
>  hw/acpi/aml-build.c                  |   2 +
>  hw/acpi/bios-linker-loader.c         |  10 ++
>  hw/acpi/vmcoreinfo.c                 | 211 +++++++++++++++++++++++++++=
++++++++
>  hw/acpi/vmgenid.c                    |   9 +-
>  hw/i386/acpi-build.c                 |  14 +++
>  stubs/vmcoreinfo.c                   |   9 ++
>  tests/vmcoreinfo-test.c              | 141 +++++++++++++++++++++++
>  MAINTAINERS                          |   9 ++
>  default-configs/arm-softmmu.mak      |   1 +
>  default-configs/i386-softmmu.mak     |   1 +
>  default-configs/x86_64-softmmu.mak   |   1 +
>  docs/specs/vmcoreinfo.txt            | 138 +++++++++++++++++++++++
>  hw/acpi/Makefile.objs                |   1 +
>  stubs/Makefile.objs                  |   1 +
>  tests/Makefile.include               |   2 +
>  22 files changed, 785 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/acpi/vmcoreinfo.h
>  create mode 100644 hw/acpi/vmcoreinfo.c
>  create mode 100644 stubs/vmcoreinfo.c
>  create mode 100644 tests/vmcoreinfo-test.c
>  create mode 100644 docs/specs/vmcoreinfo.txt
>=20
> --=20
> 2.13.1.395.gf7b71de06
>=20
