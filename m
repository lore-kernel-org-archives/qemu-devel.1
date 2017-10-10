Received: from eggs.gnu.org ([2001:4830:134:3::10]:37985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzx-00045T-Br
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzr-0007VL-M5
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1uzr-0007UK-EU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:54:59 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 15:54:47 +0200
Message-Id: <20171010135453.6704-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] ui: start adding dma-buf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

The kernel side of vfio display support seems to be close to merge
now, with some luck they hit the next merge window.  Time to start
reviewing the qemu patches so they can be merged timely ...

This series adds support for dma-bufs to the qemu ui infrastructure
and the egl-headless ui (other UIs will follow later).  Intel vgpu's
will export the guest display as dma-buf, so this is needed to show
the guest display.

Gerd Hoffmann (6):
  console: add support for dmabufs
  opengl: move shader init from console-gl.c to shader.c
  opengl: add flipping vertex shader
  egl-helpers: add dmabuf import support
  egl-helpers: add egl_texture_blit and egl_texture_blend
  egl-headless: add dmabuf support

 Makefile                         |  6 ++--
 include/qemu/typedefs.h          |  1 +
 include/ui/console.h             | 39 ++++++++++++++++-----
 include/ui/egl-helpers.h         |  7 ++++
 include/ui/gtk.h                 |  2 +-
 include/ui/sdl2.h                |  2 +-
 include/ui/shader.h              | 12 +++----
 include/ui/spice-display.h       |  2 +-
 ui/console-gl.c                  | 45 ++++---------------------
 ui/console.c                     | 33 ++++++++++++++++++
 ui/egl-headless.c                | 59 ++++++++++++++++++++++++++++++--
 ui/egl-helpers.c                 | 73 ++++++++++++++++++++++++++++++++++++++++
 ui/gtk-egl.c                     |  2 +-
 ui/gtk-gl-area.c                 |  2 +-
 ui/sdl2-gl.c                     |  4 +--
 ui/shader.c                      | 57 ++++++++++++++++++++++++++-----
 ui/spice-display.c               |  2 +-
 ui/shader/texture-blit-flip.vert | 10 ++++++
 18 files changed, 283 insertions(+), 75 deletions(-)
 create mode 100644 ui/shader/texture-blit-flip.vert

-- 
2.9.3
