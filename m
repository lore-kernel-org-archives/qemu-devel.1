Received: from eggs.gnu.org ([2001:4830:134:3::10]:42108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006aY-QN
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvg-0007Oe-0a
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cvf-0007Lt-O6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31C45C04B948
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:16:55 +0200
Message-Id: <20170424121708.31953-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] vga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Here comes the vga patch queue.  It brings the first batch of display
update race fixes, xres+yres properties for qxl and virtio, also some
cleanups piled up during the 2.9 freeze.

please pull,
  Gerd

The following changes since commit 32c7e0ab755745e961f1772e95cac381cc6876=
9d:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170=
421' into staging (2017-04-21 15:59:27 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-vga-20170424-1

for you to fetch changes up to 729abb6a920e80c3866f60d1638f08f2eba98a9a:

  virtio-gpu: add xres and yres properties (2017-04-24 10:12:28 +0200)

----------------------------------------------------------------
fix display update races, part one.
add xres + yres properties to qxl and virtio.
misc fixes and cleanups.

----------------------------------------------------------------
Gerd Hoffmann (10):
      bitmap: add bitmap_copy_and_clear_atomic
      memory: add support getting and using a dirty bitmap copy.
      vga: add vga_scanline_invalidated helper
      vga: make display updates thread safe.
      framebuffer: make display updates thread safe
      exynos: make display updates thread safe
      g364fb: make display updates thread safe
      vmsvga: fix vmsvga_update_display
      qxl: add xres and yres properties
      virtio-gpu: add xres and yres properties

Laurent Vivier (1):
      virtio-gpu: replace PIXMAN_* by PIXMAN_BE_*

Marc-Andr=C3=A9 Lureau (2):
      console: add same surface replace pre-condition
      console: add same displaychangelistener registration pre-condition

 hw/display/qxl.h               |  2 ++
 include/exec/memory.h          | 47 ++++++++++++++++++++++++++
 include/exec/ram_addr.h        |  7 ++++
 include/hw/virtio/virtio-gpu.h |  2 ++
 include/qemu/bitmap.h          |  2 ++
 include/qemu/typedefs.h        |  1 +
 exec.c                         | 75 ++++++++++++++++++++++++++++++++++++=
++++++
 hw/display/exynos4210_fimd.c   | 11 ++++---
 hw/display/framebuffer.c       | 11 +++----
 hw/display/g364fb.c            | 28 +++-------------
 hw/display/qxl.c               | 34 +++++++++++++------
 hw/display/vga.c               | 50 +++++++++++++++-------------
 hw/display/virtio-gpu.c        | 41 +++++++----------------
 hw/display/vmware_vga.c        | 21 ++----------
 memory.c                       | 17 ++++++++++
 ui/console.c                   |  4 +++
 util/bitmap.c                  | 11 +++++++
 17 files changed, 251 insertions(+), 113 deletions(-)
