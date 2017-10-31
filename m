Received: from eggs.gnu.org ([2001:4830:134:3::10]:38724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e9YKd-0000ZU-OT
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e9YKc-0000Id-Nf
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e9YKc-0000HG-AD
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:19:58 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2017 16:19:33 +0100
Message-Id: <20171031151938.14982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] fw_cfg: add DMA operations &
 etc/vmcoreinfo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series adds DMA operations support to the qemu fw_cfg kernel
module and populates "etc/vmcoreinfo" with vmcoreinfo location
details.

Note: the support for this entry handling has been merged for next
qemu release (2.11)

v4:
- export paddr_vmcoreinfo_note() to fix fw_cfg.ko build
- fix build with !CONFIG_CRASH_CORE
- replace the unbounded yield() loop with a usleep_range() loop and a
  200ms timeout
- do not write vmcoreinfo entry when running the kdump kernel (D. Hatayam=
a)
- drop the experimental sysfs write support patch from this series

v3: (thanks kbuild)
- add "fw_cfg: fix the command line module name" patch
- fix build of "fw_cfg: add DMA register" with CONFIG_FW_CFG_SYSFS_CMDLIN=
E=3Dy
- fix 'Wshift-count-overflow'

v2:
- use platform device for dma mapping
- add etc/vmcoreinfo patch
- some code cleanups

Marc-Andr=C3=A9 Lureau (5):
  fw_cfg: fix the command line module name
  fw_cfg: add DMA register
  fw_cfg: do DMA read operation
  crash: export paddr_vmcoreinfo_note()
  fw_cfg: write vmcoreinfo details

 drivers/firmware/qemu_fw_cfg.c | 292 +++++++++++++++++++++++++++++++++++=
++----
 kernel/crash_core.c            |   1 +
 2 files changed, 264 insertions(+), 29 deletions(-)

--=20
2.15.0.rc0.40.gaefcc5f6f
