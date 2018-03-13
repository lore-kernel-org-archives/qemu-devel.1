Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsie-0006Ig-6P
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiZ-00043W-Jy
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiZ-00042y-CY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:27 -0400
Received: by mail-wm0-x241.google.com with SMTP id h76so872351wme.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:03 +0100
Message-Id: <20180313224719.4954-54-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 53/69] replay: fix processing async events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Asynchronous events saved at checkpoints may invoke
callbacks when processed. These callbacks may also generate/read
new events (e.g. clock reads). Therefore event processing flag must be
reset before callback invocation.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180227095203.1060.70831.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 94a6dcccfc..768b505f3d 100644
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
 
-- 
2.14.3
