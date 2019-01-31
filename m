Received: from eggs.gnu.org ([209.51.188.92]:50325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCE0-00064N-CM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDy-0003Dj-2t
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52446)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDw-00038F-A3
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:44 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:17:32 +0300
Message-ID: <20190131131732.23264.62834.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 23/25] replay: fix replay shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch fixes shutdown of the replay process, which is terminated with
the assert when shutdown event is read from the log.
replay_finish_event reads new data_kind and therefore the value of data_kind
should be preserved to be valid at qemu_system_shutdown_request call.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/replay/replay.c b/replay/replay.c
index e578958..8f2e17c 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -49,14 +49,14 @@ bool replay_next_event_is(int event)
     }
 
     while (true) {
-        if (event == replay_state.data_kind) {
+        unsigned int data_kind = replay_state.data_kind;
+        if (event == data_kind) {
             res = true;
         }
-        switch (replay_state.data_kind) {
+        switch (data_kind) {
         case EVENT_SHUTDOWN ... EVENT_SHUTDOWN_LAST:
             replay_finish_event();
-            qemu_system_shutdown_request(replay_state.data_kind -
-                                         EVENT_SHUTDOWN);
+            qemu_system_shutdown_request(data_kind - EVENT_SHUTDOWN);
             break;
         default:
             /* clock, time_t, checkpoint and other events */
