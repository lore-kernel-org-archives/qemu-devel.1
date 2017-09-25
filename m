Received: from eggs.gnu.org ([2001:4830:134:3::10]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dwR09-00067b-TJ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dwR08-0000Dd-Cg
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:52:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dwR08-0000DP-5q
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:52:36 -0400
Received: by mail-oi0-x241.google.com with SMTP id a74so3509068oib.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 03:52:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911165929.2791-1-marcandre.lureau@redhat.com>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 25 Sep 2017 12:52:34 +0200
Message-ID: <CAJ+F1CJSkJwY5ek8MmL5dmrLJwGN7vEoj9SqCH6dtU2YxSN8qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/7] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Anderson <anderson@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

ping

On Mon, Sep 11, 2017 at 6:59 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Recent linux kernels enable KASLR to randomize phys/virt memory
> addresses. This series aims to provide enough information in qemu
> dumps so that crash utility can work with randomized kernel too (it
> hasn't been tested on other archs than x86 though, help welcome).
>
> The previous design to provide qemu with debug details (using qemu-ga
> and a dedicated vmcoreinfo ACPI device) failed to satisfy the
> requirements during previous iterations.
>
> In particular, the previous proposed vmcoreinfo ACPI device had the
> following issues:
> - hazardous memory handling with no explicit synchronization
> - occupy 2 fw-cfg entries (for memory and pointer)
> - occupy 4k of guest memory (this could have been tweaked)
> - did not provide ACPI methods (this could have been added)
> - may be difficult to maintain compatibility (according to Michael)
>
> This is a new proposal, that leverage fw-cfg device instead of adding
> a new device. A "etc/vmcoreinfo" entry is added, where the guest,
> during boot or later, can write the addr/size location of an ELF note
> to be appended in the qemu dump.
>
> Note: only guest kernel is expected to write to a fw-cfg entry.  This
> method is not meant for general qemu/user-space communication. There
> are more appropriate devices for this purpose, and the guest kernel
> should not expose this facility.
>
> This is quite easier to implement, and uses less of the limited fw-cfg
> slots, and guest memory. It also solves the synchronization issue, and
> may be easier to discover or to maintain compatibility.
>
> The Linux ELF note is expected to be the VMCOREINFO note, which will
> have a special handling in qemu in this case helping kaslr-kernel
> debugging. But it could be any valid ELF note.
>
> Crash 7.1.9 will parse the "phys_base" value from the VMCOREINFO note,
> and thus will work with KASLR-dump produced by this series.
>
> The series implements the note addition in qemu ELF/kdump,
> as well as the python scripts/dump-guest-memory.py.
>
> To test:
>
> Using kernel from https://github.com/elmarco/linux fw-cfg branch,
> Compile and run guest kernel with CONFIG_RANDOMIZE_BASE=3Dy & CONFIG_FW_C=
FG_SYSFS=3Dy.
>
> Run qemu with -device vmcoreinfo
>
> Produce an ELF dump:
> { "execute": "dump-guest-memory", "arguments": { "protocol": "file:dump",=
 "paging": false } }
>
> Produce a kdump:
> { "execute": "dump-guest-memory", "arguments": { "protocol": "file:dump",=
 "paging": false, "format": "kdump-zlib" } }
>
> Or with (gdb) dump-guest-memory, with scripts/dump-guest-memory.py script=
.
>
> Analyze with crash >=3D 7.1.9 (or the git version for 4.13 fixes..):
>
> $ crash vmlinux dump
>
> v6: after Michael Tsirkin review
> - rebased
> - modify fw_cfg write callback, called for all write
> - back to a seperate -device vmcoreinfo
> - add host_format/guest_format fields
> - clear/reset fw_cfg entry values on reset
> - write 0 as guest format to disable device
>
> v5:
> - removed x-write-pointer-available patch from this series
> - drop vmcoreinfo device
> - add write callback to fw_cfg entries
> - add a writable fw_cfg "vmcoreinfo" entry
> - split phys_base update from VMCOREINFO note in a seperate patch
> - most patches had non-trivial changes, dropping reviewed-by tags
>
> v4: from Laszlo review
> - switch to warn_report*()
> - update test to follow vmgenid and use boot-sector infrastructure
> - fix range checks in the python script
> - add vmcoreinfo_get() stub
>
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
>
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
>
> Marc-Andr=C3=A9 Lureau (7):
>   fw_cfg: add write callback
>   hw/misc: add vmcoreinfo device
>   dump: add guest ELF note
>   dump: update phys_base header field based on VMCOREINFO content
>   kdump: set vmcoreinfo location
>   scripts/dump-guest-memory.py: add vmcoreinfo
>   MAINTAINERS: add Dump maintainers
>
>  scripts/dump-guest-memory.py |  61 +++++++++++++++
>  include/hw/misc/vmcoreinfo.h |  46 +++++++++++
>  include/hw/nvram/fw_cfg.h    |   3 +
>  include/sysemu/dump.h        |   2 +
>  dump.c                       | 183 +++++++++++++++++++++++++++++++++++++=
++++++
>  hw/acpi/vmgenid.c            |   2 +-
>  hw/core/loader.c             |   2 +-
>  hw/i386/acpi-build.c         |   2 +-
>  hw/isa/lpc_ich9.c            |   4 +-
>  hw/misc/vmcoreinfo.c         |  96 +++++++++++++++++++++++
>  hw/nvram/fw_cfg.c            |  14 +++-
>  MAINTAINERS                  |  11 +++
>  docs/specs/vmcoreinfo.txt    |  49 ++++++++++++
>  hw/misc/Makefile.objs        |   1 +
>  14 files changed, 467 insertions(+), 9 deletions(-)
>  create mode 100644 include/hw/misc/vmcoreinfo.h
>  create mode 100644 hw/misc/vmcoreinfo.c
>  create mode 100644 docs/specs/vmcoreinfo.txt
>
> --
> 2.14.1.146.gd35faa819
>
>



--=20
Marc-Andr=C3=A9 Lureau
