Received: from eggs.gnu.org ([2001:4830:134:3::10]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYl2-0005Ae-Vl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYky-0007Xf-WF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:05 -0300
Message-Id: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 00/20] fix bugs reported by Clang
 Static Analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi,

This series is the result of [now NOT] having fun with Clang's Static Analyzer
(see https://clang-analyzer.llvm.org/).

v2:
- addressed review feedbacks,
- added various R-b,
- dropped noise (Peter sharp eye),
- dropped dup patches

Patches 1-13 are already reviewed,
Patches 14,15 address feedbacks from v1,
Patch 16 test if patch collecting tools can handle missing patches,
Patches 17-19 are new,
Patch 20 is new but not very important ;) bonus that can wait 2.11.

Regards,

Phil.

v1:

Patch 1 was in another series (delayed for 2.11), it would be nice to have it
in 2.10.

I ran Clang static analyzer "scan-build" via a docker image based on
debian/unstable to use bleeding code, if one is interested in reproduce or use
it the Dockerfile is available here:
http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07487.html

I used the following commands:

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

Philippe Mathieu-Daudé (20):
  tests: add missing dependency to build QTEST_QEMU_BINARY
  loader: check get_image_size() return value
  ivshmem: fix incorrect error handling in ivshmem_recv_msg()
  nbd: fix memory leak in nbd_opt_go()
  qcow2: fix null pointer dereference
  ui/vnc: fix leak of SocketAddress **
  net/eth: fix incorrect check of iov_to_buf() return value
  vfio/platform: fix use of freed memory
  vfio/pci: fix use of freed memory
  m68k/translate: fix incorrect copy/paste
  linux-user/sh4: fix incorrect memory write
  syscall: fix dereference of undefined pointer
  syscall: fix use of uninitialized values
  syscall: check inotify() and eventfd() return value
  thunk: assert nb_fields is valid
  bt-sdp: fix memory leak in sdp_service_record_build()
  9pfs: avoid sign conversion error simplifying the code
  spapr_vio: fix overflow of qdevs in spapr_dt_vdevice()
  i2c/exynos4210: fix write to I2CADD register, bit 0 is not mapped

 block/qcow2-refcount.c  |  4 +--
 hw/9pfs/9p.c            |  6 ++---
 hw/bt/sdp.c             |  6 +++--
 hw/core/loader.c        |  4 +--
 hw/i2c/exynos4210_i2c.c |  2 +-
 hw/misc/ivshmem.c       |  5 +++-
 hw/ppc/spapr_vio.c      |  4 +--
 hw/vfio/pci.c           | 11 ++++++---
 hw/vfio/platform.c      |  2 +-
 linux-user/elfload.c    |  2 +-
 linux-user/syscall.c    | 18 +++++++++++---
 nbd/client.c            |  8 +++---
 net/eth.c               |  4 +--
 target/m68k/translate.c |  2 +-
 tests/Makefile.include  |  2 +-
 thunk.c                 |  3 ++-
 ui/vnc.c                | 66 ++++++++++++++++++++++++-------------------------
 17 files changed, 83 insertions(+), 66 deletions(-)

-- 
2.13.3
