Received: from eggs.gnu.org ([2001:4830:134:3::10]:45892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYBA-0008NG-5C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYB6-0000bq-4X
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:40 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41602)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYB5-0000bO-Sl
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:36 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:25:36 +0300
Message-ID: <20180111082536.27295.67619.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v3 07/30] replay: fix processing async
 events
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

Asynchronous events saved at checkpoints may invoke
callbacks when processed. These callbacks may also generate/read
new events (e.g. clock reads). Therefore event processing flag must be
reset before callback invocation.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
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
 
