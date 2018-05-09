Received: from eggs.gnu.org ([2001:4830:134:3::10]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGND7-0004XP-KT
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGND4-000135-Jv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37856 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGND4-00012C-FL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19C9F40200A1
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:38 +0200
Message-Id: <20180509112406.6183-14-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/41] migration: Define MultifdRecvParams sooner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Once there, we don't need the struct names anywhere, just the
typedefs.  And now also document all fields.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f46a373074..cb14399ef9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -445,17 +445,45 @@ typedef struct {
     uint8_t id;
 } __attribute__((packed)) MultiFDInit_t;
 
-struct MultiFDSendParams {
+typedef struct {
+    /* this fields are not changed once the thread is created */
+    /* channel number */
     uint8_t id;
+    /* channel thread name */
     char *name;
+    /* channel thread id */
     QemuThread thread;
+    /* communication channel */
     QIOChannel *c;
+    /* sem where to wait for more work */
     QemuSemaphore sem;
+    /* this mutex protects the following parameters */
     QemuMutex mutex;
+    /* is this channel thread running */
     bool running;
+    /* should this thread finish */
     bool quit;
-};
-typedef struct MultiFDSendParams MultiFDSendParams;
+}  MultiFDSendParams;
+
+typedef struct {
+    /* this fields are not changed once the thread is created */
+    /* channel number */
+    uint8_t id;
+    /* channel thread name */
+    char *name;
+    /* channel thread id */
+    QemuThread thread;
+    /* communication channel */
+    QIOChannel *c;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
+    /* this mutex protects the following parameters */
+    QemuMutex mutex;
+    /* is this channel thread running */
+    bool running;
+    /* should this thread finish */
+    bool quit;
+} MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
@@ -657,18 +685,6 @@ int multifd_save_setup(void)
     return 0;
 }
 
-struct MultiFDRecvParams {
-    uint8_t id;
-    char *name;
-    QemuThread thread;
-    QIOChannel *c;
-    QemuSemaphore sem;
-    QemuMutex mutex;
-    bool running;
-    bool quit;
-};
-typedef struct MultiFDRecvParams MultiFDRecvParams;
-
 struct {
     MultiFDRecvParams *params;
     /* number of created threads */
-- 
2.17.0
