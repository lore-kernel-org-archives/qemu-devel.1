Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1et9Vt-0002B5-Qf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1et9Vp-0003Xz-LH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:08:05 -0500
From: Nia Alarie <nia.alarie@gmail.com>
Date: Tue,  6 Mar 2018 10:07:20 +0000
Message-Id: <20180306100721.19419-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/2] s390x/sclpconsole: Remove dead code -
 remove exit handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, Nia Alarie <nia.alarie@gmail.com>

The other event handlers (quiesce and cpu) do not define these
handlers, and this one does nothing, so it can be removed.

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/char/sclpconsole-lm.c          |  6 ------
 hw/char/sclpconsole.c             |  6 ------
 hw/s390x/event-facility.c         | 14 --------------
 include/hw/s390x/event-facility.h |  1 -
 4 files changed, 27 deletions(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index c500bdaf29..84efd8df73 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -318,11 +318,6 @@ static int console_init(SCLPEvent *event)
     return 0;
 }
 
-static int console_exit(SCLPEvent *event)
-{
-    return 0;
-}
-
 static void console_reset(DeviceState *dev)
 {
    SCLPEvent *event = SCLP_EVENT(dev);
@@ -349,7 +344,6 @@ static void console_class_init(ObjectClass *klass, void *data)
     dc->reset = console_reset;
     dc->vmsd = &vmstate_sclplmconsole;
     ec->init = console_init;
-    ec->exit = console_exit;
     ec->get_send_mask = send_mask;
     ec->get_receive_mask = receive_mask;
     ec->can_handle_event = can_handle_event;
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index d0265dfa7a..e6ba0a46bd 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -246,11 +246,6 @@ static void console_reset(DeviceState *dev)
    scon->notify = false;
 }
 
-static int console_exit(SCLPEvent *event)
-{
-    return 0;
-}
-
 static Property console_properties[] = {
     DEFINE_PROP_CHR("chardev", SCLPConsole, chr),
     DEFINE_PROP_END_OF_LIST(),
@@ -265,7 +260,6 @@ static void console_class_init(ObjectClass *klass, void *data)
     dc->reset = console_reset;
     dc->vmsd = &vmstate_sclpconsole;
     ec->init = console_init;
-    ec->exit = console_exit;
     ec->get_send_mask = send_mask;
     ec->get_receive_mask = receive_mask;
     ec->can_handle_event = can_handle_event;
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 155a69467b..79de3c738f 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -431,26 +431,12 @@ static void event_realize(DeviceState *qdev, Error **errp)
     }
 }
 
-static void event_unrealize(DeviceState *qdev, Error **errp)
-{
-    SCLPEvent *event = SCLP_EVENT(qdev);
-    SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
-    if (child->exit) {
-        int rc = child->exit(event);
-        if (rc < 0) {
-            error_setg(errp, "SCLP event exit failed.");
-            return;
-        }
-    }
-}
-
 static void event_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->bus_type = TYPE_SCLP_EVENTS_BUS;
     dc->realize = event_realize;
-    dc->unrealize = event_unrealize;
 }
 
 static const TypeInfo sclp_event_type_info = {
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 5119b9b7f0..b913f85edc 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -174,7 +174,6 @@ typedef struct SCLPEvent {
 typedef struct SCLPEventClass {
     DeviceClass parent_class;
     int (*init)(SCLPEvent *event);
-    int (*exit)(SCLPEvent *event);
 
     /* get SCLP's send mask */
     unsigned int (*get_send_mask)(void);
-- 
2.16.2
