Received: from eggs.gnu.org ([2001:4830:134:3::10]:42031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2U-0002Bc-Os
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2Q-0003s6-PV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:50 +0200
Message-Id: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/29] Refactoring with clang-tidy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Various refactring questions on previously sent series prompted me to
look at coccinelle to automate some changes again. Alas, semantic
patches are not so easy to express for me, cocci doesn't catch all
cases, is quite slow, and it doesn't seem possible to evaluate
expressions to check if E =3D=3D E-1 or if E is pow2 for example.

I started looking at clang-tidy
(http://clang.llvm.org/extra/clang-tidy/) as an alternative to do some
refactoring.

Our build-system doesn't generate compile_commands.json, which is
pretty much required to use clang refactoring tools. But it is as easy
as running "bear make" to make one, using https://github.com/rizsotto/Bea=
r.

Then, you can run checks and automate fixes (here only "qemu-round")
over the code base with:
run-clang-tidy.py -header-filter=3D'.*' -checks=3D'-*,qemu-round' -fix

There are some path bugs that can easily be solved, see
https://bugs.llvm.org/show_bug.cgi?id=3D33440 for details.

I ran 'qemu-round' check in this series, and added a few other manual
refactoring I had pending. (I'll submit other series for the rest of
the checks later)

My WIP qemu checks are here:
https://github.com/elmarco/clang-tools-extra/tree/master/clang-tidy/qemu

The "round-check" is:
https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qemu/=
RoundCheck.cpp

I don't know if you can express a semantic patch that would be as
powerful. The code remains easy to write & read imho, and quite fast
to apply. I like the tool, it's probably a good complement to
coccinelle overall.

v2:
- rebased, and resent to CC qemu-trivial
- drop slirp patch, as Samuel said he applied it on his tree
- added r-b/a-b tags

Thanks

Marc-Andr=C3=A9 Lureau (29):
  i386: use ROUND_UP macro
  vnc: use QEMU_ALIGN_DOWN
  vhdx: use QEMU_ALIGN_DOWN
  vhost: use QEMU_ALIGN_DOWN
  i8254: use QEMU_ALIGN_DOWN
  pcspk: use QEMU_ALIGN_DOWN
  dmg: use DIV_ROUND_UP
  qcow2: use DIV_ROUND_UP
  vpc: use DIV_ROUND_UP
  vvfat: use DIV_ROUND_UP
  vnc: use DIV_ROUND_UP
  ui: use DIV_ROUND_UP
  vga: use DIV_ROUND_UP
  virtio-gpu: use DIV_ROUND_UP
  monitor: use DIV_ROUND_UP
  console: use DIV_ROUND_UP
  virtio-serial: use DIV_ROUND_UP
  piix: use DIV_ROUND_UP
  q35: use DIV_ROUND_UP
  usb-hub: use DIV_ROUND_UP
  msix: use DIV_ROUND_UP
  ppc: use DIV_ROUND_UP
  i386/dump: use DIV_ROUND_UP
  kvm: use DIV_ROUND_UP
  decnumber: use DIV_ROUND_UP
  i386: introduce ELF_NOTE_SIZE macro
  i386: replace g_malloc()+memcpy() with g_memdup()
  test-iov: replace g_malloc()+memcpy() with g_memdup()
  eepro100: replace g_malloc()+memcpy() with g_memdup()

 include/ui/console.h        |  2 +-
 linux-headers/asm-x86/kvm.h |  2 +-
 block/dmg.c                 |  2 +-
 block/qcow2-cluster.c       |  2 +-
 block/vhdx-log.c            |  2 +-
 block/vpc.c                 |  4 ++--
 block/vvfat.c               |  4 ++--
 hw/audio/pcspk.c            |  2 +-
 hw/char/virtio-serial-bus.c |  8 ++++----
 hw/display/vga.c            |  2 +-
 hw/display/virtio-gpu.c     |  4 ++--
 hw/i386/multiboot.c         |  3 +--
 hw/net/eepro100.c           |  3 +--
 hw/pci-host/piix.c          |  2 +-
 hw/pci-host/q35.c           |  2 +-
 hw/pci/msix.c               |  4 ++--
 hw/timer/i8254_common.c     |  4 ++--
 hw/usb/dev-hub.c            |  8 ++++----
 hw/virtio/vhost.c           |  2 +-
 libdecnumber/decNumber.c    |  2 +-
 monitor.c                   |  4 ++--
 target/i386/arch_dump.c     | 40 ++++++++++++++++++++-------------------=
-
 target/ppc/mem_helper.c     |  2 +-
 target/ppc/translate.c      |  2 +-
 tests/test-iov.c            |  3 +--
 ui/cursor.c                 |  2 +-
 ui/vnc-enc-tight.c          |  2 +-
 ui/vnc.c                    | 10 +++++-----
 28 files changed, 63 insertions(+), 66 deletions(-)

--=20
2.13.1.395.gf7b71de06
