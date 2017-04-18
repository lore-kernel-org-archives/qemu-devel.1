Received: from eggs.gnu.org ([2001:4830:134:3::10]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1d0QMK-0006tg-Mh
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1d0QMK-0001Cj-11
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:27:44 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 18 Apr 2017 13:27:31 +0300
Message-Id: <1492511251-16720-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] qemu-img: wait for convert coroutines to
 complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

We should wait for other coroutines on error path, i.e. one of coroutines
terminates with i/o error, before cleaning the common structures. In the
other case we would crash in a lot of different places. This behaviour
was introduced by commit 2d9187bc65.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Peter Lieven <pl@kamp.de>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..3b04c5f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1899,7 +1899,7 @@ static int convert_do_copy(ImgConvertState *s)
         qemu_coroutine_enter(s->co[i]);
     }
 
-    while (s->ret == -EINPROGRESS) {
+    while (s->running_coroutines) {
         main_loop_wait(false);
     }
 
-- 
2.7.4
