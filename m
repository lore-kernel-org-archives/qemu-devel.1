Received: from eggs.gnu.org ([2001:4830:134:3::10]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5Y-00088M-4S
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5V-0004hL-07
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:16 -0300
Message-Id: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 00/35] fix bugs reported by Clang
 Static Analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi,

This series is the result of having fun with Clang's Static Analyzer during
the week-end (see https://clang-analyzer.llvm.org/).

No need to delay the first batch for -rc0.

Patch 1 was in another series (delayed for 2.11), it would be nice to have it
in 2.10.

I built a docker image based on debian/unstable to use bleeding code, the
Dockerfile is provided at the end of this series as RFC for people wanted
to give a try (also include 'dockershell' script and a fix in ./configure).
These RFC patches (33-35) are not expected to enter 2.10.

I used the following commands:

$ make docker-image-debian-bleeding-dev
$ ./scripts/dockershell debian-bleeding-dev
$ mkdir -p build
$ cd build
$ ../configure --host-cc=clang-5.0 --cc=clang-5.0 --cxx=clang++-5.0 \
  --disable-docs --enable-debug
$ scan-build-5.0 -o testresults --keep-going -maxloop 2 -no-failure-reports \
  -analyzer-config stable-report-filename=true \
  -disable-checker alpha.clone.CloneChecker \
  -enable-checker alpha.core.CastSize \
  -enable-checker alpha.core.Conversion \
  -enable-checker alpha.core.IdenticalExpr \
  -enable-checker alpha.core.SizeofPtr \
  -disable-checker alpha.deadcode.UnreachableCode \
  -enable-checker alpha.security.ArrayBoundV2 \
  -enable-checker alpha.security.MallocOverflow \
  -enable-checker alpha.unix.cstring.BufferOverlap \
  -enable-checker alpha.unix.cstring.OutOfBounds \
  -disable-checker deadcode.DeadStores \
  -disable-checker optin.performance.Padding \
  -enable-checker optin.portability.UnixAPI \
  -disable-checker security.insecureAPI.getpw \
  -disable-checker security.insecureAPI.gets \
  -enable-checker security.insecureAPI.strcpy \
  -disable-checker unix.Vfork \
    make -k -j4

Regards,

Phil.

Philippe Mathieu-Daudé (35):
  tests: add missing dependency to build QTEST_QEMU_BINARY
  loader: check get_image_size() return value
  thunk: check nb_fields is valid before continuing
  ivshmem: fix incorrect error handling in ivshmem_recv_msg()
  nbd: fix memory leak in nbd_opt_go()
  qcow2: remove inconsistent check
  qcow2: fix null pointer dereference
  qcow2: fix null pointer dereference
  ui/vnc: fix leak of SocketAddress **
  net/eth: fix incorrect check of iov_to_buf() return value
  i2c/exynos4210: correctly check i2c_recv() return value
  vfio/platform: fix use of freed memory
  vfio/pci: fix use of freed memory
  vfio/ccw: fix incorrect malloc() size
  usb: correctly handle Zero Length Packets
  usb/dev-mtp: fix use of uninitialized values
  usb/dev-mtp: fix use of uninitialized values
  usb/dev-mtp: fix use of uninitialized values
  usb/dev-mtp: fix use of uninitialized variable
  arm/boot: fix undefined instruction on secondary smp cpu bootloader
  arm/sysbus-fdt: fix null pointer dereference
  arm/vexpress: fix potential memory leak
  m68k/translate: fix incorrect copy/paste
  linux-user/sh4: fix incorrect memory write
  linux-user: extract is_error() out of syscall.c
  linux-user: use is_error() to avoid warnings and make the code clearer
  syscall: fix dereference of undefined pointer
  syscall: check dup/dup2/dup3() errors, return EBADFD/EINVAL if
    required
  syscall: fix out-of-bound memory access
  syscall: fix use of uninitialized values
  syscall: replace strcpy() by g_strlcpy()
  timer/pxa2xx: silent warning about out-of-bound memory access
  configure: clang does not support -Wexpansion-to-defined
  docker: add debian 'bleeding' image with gcc7 and clang5
  script to run docker image

 block/qcow2-bitmap.c                               |  4 +-
 block/qcow2-refcount.c                             |  4 +-
 configure                                          |  6 +-
 hw/arm/boot.c                                      |  2 +-
 hw/arm/sysbus-fdt.c                                | 11 ++-
 hw/arm/vexpress.c                                  |  5 +-
 hw/core/loader.c                                   |  4 +-
 hw/i2c/exynos4210_i2c.c                            |  8 +-
 hw/misc/ivshmem.c                                  |  5 +-
 hw/timer/pxa2xx_timer.c                            |  2 +-
 hw/usb/dev-mtp.c                                   | 60 +++++++++-----
 hw/usb/redirect.c                                  |  2 +-
 hw/vfio/ccw.c                                      |  2 +-
 hw/vfio/pci.c                                      | 11 ++-
 hw/vfio/platform.c                                 |  2 +-
 linux-user/elfload.c                               |  2 +-
 linux-user/flatload.c                              | 15 ++--
 linux-user/qemu.h                                  |  5 ++
 linux-user/syscall.c                               | 45 +++++++----
 nbd/client.c                                       |  8 +-
 net/eth.c                                          |  4 +-
 scripts/dockershell                                | 30 +++++++
 target/m68k/translate.c                            |  3 +-
 tests/Makefile.include                             |  2 +-
 .../docker/dockerfiles/debian-bleeding-dev.docker  | 94 ++++++++++++++++++++++
 thunk.c                                            |  5 +-
 ui/vnc.c                                           | 36 ++++-----
 27 files changed, 279 insertions(+), 98 deletions(-)
 create mode 100755 scripts/dockershell
 create mode 100644 tests/docker/dockerfiles/debian-bleeding-dev.docker

-- 
2.13.3
