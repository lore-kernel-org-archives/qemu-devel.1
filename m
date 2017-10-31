Received: from eggs.gnu.org ([2001:4830:134:3::10]:51097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Uh2-00047a-Vp
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugz-0000h9-T4
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:52 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45374)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugz-0000gt-LC
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:49 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:26:49 +0300
Message-ID: <20171031112649.10516.32488.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 20/26] replay: don't destroy mutex at exit
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

---
 replay/replay.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/replay/replay.c b/replay/replay.c
index 7fc50ea..3f431ad 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -358,7 +358,6 @@ void replay_finish(void)
     replay_snapshot = NULL;
 
     replay_finish_events();
-    replay_mutex_destroy();
 }
 
 void replay_add_blocker(Error *reason)
