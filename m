Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafP-0003oS-0K
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafM-0001Jj-J2
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafM-0001Jb-D9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B6037F1F
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:05:47 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:18 -0400
Message-Id: <1495649128-10529-3-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 02/12] migration: Introduce announcement timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Introdec an annoucement timer structure and initialization to
be used by for self-annoucement.

Based on the work by Germano Veit Michel <germano@redhat.com>

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
---
 include/migration/vmstate.h | 13 +++++++++++++
 migration/savevm.c          | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8489659..a6bf84d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1057,6 +1057,19 @@ void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
 
+typedef struct AnnounceTimer {
+    QEMUTimer *tm;
+    AnnounceParameters params;
+    QEMUClockType type;
+    int round;
+} AnnounceTimer;
+
+AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
+                                       QEMUClockType type);
+AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
+                                          QEMUClockType type,
+                                          QEMUTimerCB *cb);
+
 static inline
 int64_t self_announce_delay(int round)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index cee2837..607b090 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -230,6 +230,28 @@ static void qemu_announce_self_once(void *opaque)
     }
 }
 
+AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
+                                       QEMUClockType type)
+{
+    AnnounceTimer *timer = g_new(AnnounceTimer, 1);
+
+    timer->params = *params;
+    timer->round = params->rounds;
+    timer->type = type;
+
+    return timer;
+}
+
+AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
+                                          QEMUClockType type,
+                                          QEMUTimerCB *cb)
+{
+    AnnounceTimer *timer = qemu_announce_timer_new(params, type);
+
+    timer->tm = timer_new_ms(type, cb, timer);
+    return timer;
+}
+
 void qemu_announce_self(void)
 {
     static QEMUTimer *timer;
-- 
2.7.4
