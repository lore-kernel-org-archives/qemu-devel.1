Received: from eggs.gnu.org ([209.51.188.92]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj72-0005FX-LB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj71-0003gQ-TU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:56 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj71-0003fP-AW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id x10so941874wrs.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:54 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.36.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:36:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:35 +0100
Message-Id: <1549305379-51117-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/77] monitor: do not use QTAILQ_FOREACH_SAFE
 across critical sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

monitor_qmp_requests_pop_any_with_lock cannot modify the monitor list
concurrently with monitor_cleanup, since the dispatch bottom half
runs in the main thread, but anyway it is a bit ugly to keep
"next" live across critical sections of monitor_lock and Coverity
complains (CID 1397072).

Replace QTAILQ_FOREACH_SAFE with a while loop and QTAILQ_FIRST,
it is cleaner and more future-proof.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index c09fa63..e5de576 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4617,8 +4617,6 @@ void monitor_init(Chardev *chr, int flags)
 
 void monitor_cleanup(void)
 {
-    Monitor *mon, *next;
-
     /*
      * We need to explicitly stop the I/O thread (but not destroy it),
      * clean up the monitor resources, then destroy the I/O thread since
@@ -4632,7 +4630,8 @@ void monitor_cleanup(void)
     /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
     monitor_destroyed = true;
-    QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
+    while (!QTAILQ_EMPTY(&mon_list)) {
+        Monitor *mon = QTAILQ_FIRST(&mon_list);
         QTAILQ_REMOVE(&mon_list, mon, entry);
         /* Permit QAPI event emission from character frontend release */
         qemu_mutex_unlock(&monitor_lock);
-- 
1.8.3.1
