Received: from eggs.gnu.org ([2001:4830:134:3::10]:54132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026i-KX
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002CJ-HE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-00029k-Al
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:05 +0200
Message-Id: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 00/10] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Second round.  Helper API should be solid now, after patch discussions
and initial testing.  API is documented now in the header file.
Additionally to vga the sparc display adapters (cg3, tcx) are converted
too.  Still quite some work until we've got them all converted.  Still
enough progress that I think posting the new revision is useful.

cheers,
  Gerd

Gerd Hoffmann (5):
  bitmap: add bitmap_copy_and_clear_atomic
  memory: add support getting and using a dirty bitmap copy.
  vga: add vga_scanline_invalidated helper
  vga: make display updates thread safe.
  [testing] console: remove do_safe_dpy_refresh

Mark Cave-Ayland (5):
  cg3: remove TARGET_PAGE_SIZE rounding on dirty page detection
  cg3: fix up size parameter for memory_region_get_dirty()
  cg3: make display updates thread safe
  tcx: introduce tcx_check_dirty() function
  tcx: make display updates thread safe

 include/exec/memory.h   | 47 +++++++++++++++++++++++++++
 include/exec/ram_addr.h |  7 ++++
 include/qemu/bitmap.h   |  2 ++
 include/qemu/typedefs.h |  1 +
 exec.c                  | 75 ++++++++++++++++++++++++++++++++++++++++++
 hw/display/cg3.c        | 40 +++++++++++------------
 hw/display/tcx.c        | 86 ++++++++++++++++++-------------------------------
 hw/display/vga.c        | 50 +++++++++++++++-------------
 memory.c                | 17 ++++++++++
 ui/console.c            | 25 +-------------
 util/bitmap.c           | 11 +++++++
 11 files changed, 241 insertions(+), 120 deletions(-)

-- 
2.9.3
