Received: from eggs.gnu.org ([2001:4830:134:3::10]:59631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eC6fQ-0006uD-EB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eC6fN-00047j-9u
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:24:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eC6fN-00046m-3H
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:23:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Nov 2017 17:23:43 +0100
Message-Id: <20171107162348.16843-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/5] fw_cfg: add DMA operations &
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

v5:
- resent to CC kdump people on the paddr_vmcoreinfo_note() export patch

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
2.15.0.125.g8f49766d64
