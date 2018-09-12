Received: from eggs.gnu.org ([2001:4830:134:3::10]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NN-0001aq-IP
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NM-0000yW-S2
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56132)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NM-0000y4-Is
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:52 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 12 Sep 2018 11:19:50 +0300
Message-ID: <20180912081950.3228.68987.stgit@pasha-VirtualBox>
In-Reply-To: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 21/25] replay: replay BH for IDE trim
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch makes IDE trim BH deterministic, because it affects
the device state. Therefore its invocation should be replayed
instead of running at the random moment.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 2c62efc..04e22e7 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -35,6 +35,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "sysemu/replay.h"
 
 #include "hw/ide/internal.h"
 #include "trace.h"
@@ -479,7 +480,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
 done:
     iocb->aiocb = NULL;
     if (iocb->bh) {
-        qemu_bh_schedule(iocb->bh);
+        replay_bh_schedule_event(iocb->bh);
     }
 }
 
