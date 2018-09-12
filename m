Received: from eggs.gnu.org ([2001:4830:134:3::10]:47951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00No-00020b-F5
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00Nm-0001Dt-HZ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:20:20 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56230)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00Nk-0001Cb-Ba
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:20:16 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 12 Sep 2018 11:20:13 +0300
Message-ID: <20180912082013.3228.33664.stgit@pasha-VirtualBox>
In-Reply-To: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 25/25] ui: fix virtual timers
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

UI uses timers based on virtual clock for managing key queue.
This is incorrect because this service is not related to the guest state,
and its events should not be recorded and replayed. But these timers should
stop when the guest is not executing.
This patch changes using virtual clock to the new virtual_ext clock,
which runs as virtual clock, but its timers are not saved to the log.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 ui/input.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index 51b1019..dd7f6d7 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -271,7 +271,7 @@ static void qemu_input_queue_process(void *opaque)
         item = QTAILQ_FIRST(queue);
         switch (item->type) {
         case QEMU_INPUT_QUEUE_DELAY:
-            timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)
+            timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT)
                       + item->delay_ms);
             return;
         case QEMU_INPUT_QUEUE_EVENT:
@@ -301,7 +301,7 @@ static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
     queue_count++;
 
     if (start_timer) {
-        timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)
+        timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT)
                   + item->delay_ms);
     }
 }
@@ -448,8 +448,8 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
     }
 
     if (!kbd_timer) {
-        kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, qemu_input_queue_process,
-                                 &kbd_queue);
+        kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_EXT,
+                                 qemu_input_queue_process, &kbd_queue);
     }
     if (queue_count < queue_limit) {
         qemu_input_queue_delay(&kbd_queue, kbd_timer,
