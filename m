Received: from eggs.gnu.org ([2001:4830:134:3::10]:52657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctU02-0005nj-N4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctTzy-0005cf-Ps
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctTzy-0005at-6Z
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 08:55:27 +0200
Message-Id: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

First attempt on making display updates thread-save for real.  Most
interesting patches at this point are #2 (adds helper functions to
create and use a dirty bitmap copy) and #3 (updates vga code to use
them).

Patch #1 fixes a bug I've noticed while wading through the vga code,
and #4 removes the temporary workaround for testing purposes.  Which
will of course break some or all non-vga display adapters as those
are not ported over yet.

git branch is available here:
  git://git.kraxel.org/qemu work/vga-fixes

Gerd Hoffmann (4):
  vga: add vga_scanline_invalidated helper
  memory: add support getting and using a dirty bitmap copy.
  vga: make display updates thread safe.
  [testing] console: remove do_safe_dpy_refresh

 exec.c                  | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/vga.c        | 50 +++++++++++++++++--------------
 include/exec/memory.h   | 13 ++++++++
 include/exec/ram_addr.h |  8 +++++
 include/qemu/typedefs.h |  1 +
 memory.c                | 15 ++++++++++
 ui/console.c            | 25 +---------------
 7 files changed, 145 insertions(+), 46 deletions(-)

-- 
1.8.3.1
