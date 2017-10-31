Received: from eggs.gnu.org ([2001:4830:134:3::10]:57404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5T-0005aU-NF
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5T-0003tO-0L
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:03 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39826)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5S-0003t2-On
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:02 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 13:48:02 +0300
Message-ID: <20171031104802.3079.79946.stgit@pasha-VirtualBox>
In-Reply-To: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
References: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFCPATCH04/20] replay: fix processing async events
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

Asynchronous events saved at checkpoints may invoke
callbacks when processed. These callbacks may also generate/read
new events (e.g. clock reads). Therefore event processing flag must be
reset before callback invocation.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 replay/replay-events.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 94a6dcc..768b505 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -295,13 +295,13 @@ void replay_read_events(int checkpoint)
         if (!event) {
             break;
         }
+        replay_finish_event();
+        read_event_kind = -1;
         replay_mutex_unlock();
         replay_run_event(event);
         replay_mutex_lock();
 
         g_free(event);
-        replay_finish_event();
-        read_event_kind = -1;
     }
 }
 
