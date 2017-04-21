Received: from eggs.gnu.org ([2001:4830:134:3::10]:37089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgF-0001wY-PH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgD-0001F6-65
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d1UgC-0001Dn-Vv
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F596118E21
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:16:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Apr 2017 11:16:23 +0200
Message-Id: <20170421091632.30900-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] hw/display: make display updates thread
 safe, part 1
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

Ok, 2.10 is open, lets start tackling the display update race
conditions.  This series adds the helper functions used to receive
a dirty bitmap snapshot, which is used by the display adapters then.
Also a bunch of display adapters are converted to use those helpers.

Changes from previous version:  Fixed one vga patch.  Left out are the
sparc adapters for now (Mark Cave-Ayland is busy cleaning them up and
fixing them).  Also left out the patch dropping the temporary
workaround, that obviously has to wait until all display adapters are
switched over.

please review,
  Gerd

Gerd Hoffmann (9):
  bitmap: add bitmap_copy_and_clear_atomic
  memory: add support getting and using a dirty bitmap copy.
  vga: add vga_scanline_invalidated helper
  vga: make display updates thread safe.
  framebuffer: make display updates thread safe
  exynos: make display updates thread safe
  g364fb: make display updates thread safe
  vmsvga: fix vmsvga_update_display
  sm501: make display updates thread safe

 include/exec/memory.h        | 47 +++++++++++++++++++++++++++
 include/exec/ram_addr.h      |  7 +++++
 include/qemu/bitmap.h        |  2 ++
 include/qemu/typedefs.h      |  1 +
 exec.c                       | 75 ++++++++++++++++++++++++++++++++++++++++++++
 hw/display/exynos4210_fimd.c | 11 ++++---
 hw/display/framebuffer.c     | 11 +++----
 hw/display/g364fb.c          | 28 +++--------------
 hw/display/sm501.c           | 23 ++++----------
 hw/display/vga.c             | 50 ++++++++++++++++-------------
 hw/display/vmware_vga.c      | 21 ++-----------
 memory.c                     | 17 ++++++++++
 util/bitmap.c                | 11 +++++++
 13 files changed, 213 insertions(+), 91 deletions(-)

-- 
2.9.3
