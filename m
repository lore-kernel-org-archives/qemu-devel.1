Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U6s-0006gw-8L
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U6r-0005nr-Fh
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:49:30 -0400
Received: from mail.ispras.ru ([83.149.199.45]:40064)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U6r-0005mL-7N
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:49:29 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 13:49:29 +0300
Message-ID: <20171031104929.3079.59019.stgit@pasha-VirtualBox>
In-Reply-To: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
References: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFCPATCH20/20] replay: don't destroy mutex at exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru

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
