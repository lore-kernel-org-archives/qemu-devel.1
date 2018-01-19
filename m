Received: from eggs.gnu.org ([2001:4830:134:3::10]:54486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSI6-0001rX-8v
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSI5-0005ti-Fs
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:44:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53848)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSI5-0005tQ-7T
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:44:49 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Fri, 19 Jan 2018 11:44:51 +0300
Message-ID: <20180119084451.7100.73664.stgit@pasha-VirtualBox>
In-Reply-To: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 18/23] replay: don't destroy mutex at
 exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

Replay mutex is held by vCPU thread and destroy function is called
from atexit of the main thread. Therefore we cannot destroy it safely.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/replay/replay.c b/replay/replay.c
index a3ab3bb..585c5de 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -356,7 +356,6 @@ void replay_finish(void)
     replay_snapshot = NULL;
 
     replay_finish_events();
-    replay_mutex_destroy();
 }
 
 void replay_add_blocker(Error *reason)
