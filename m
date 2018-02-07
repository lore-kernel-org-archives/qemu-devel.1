Received: from eggs.gnu.org ([2001:4830:134:3::10]:50145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOSh-0000Fi-OP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOSa-00041Z-5V
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:27 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47374)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOSZ-00041K-Uj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:20 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 07 Feb 2018 15:04:21 +0300
Message-ID: <20180207120421.5389.41673.stgit@pasha-VirtualBox>
In-Reply-To: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v6 05/20] replay: fix processing async
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org

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
 
