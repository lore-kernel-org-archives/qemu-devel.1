Received: from eggs.gnu.org ([2001:4830:134:3::10]:48634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Un-0006yY-0d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Ui-0002AX-4O
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:59:37 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d45Uh-0002A3-VX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:59:32 -0400
Received: by mail-pg0-x241.google.com with SMTP id s1so2827421pgc.2
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 05:59:31 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Fri, 28 Apr 2017 20:55:08 +0800
Message-Id: <1493384110-32060-2-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
References: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] hw/char/sclp*: remove console_exit
 function in sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Currently the console_exit function in sclpconsole-lm.c and sclpconsole.c
does nothing, so remove them and convert the callback in SCLPEventClass to
void. Since there is a NULL check on the DeviceClass exit callback, it
should be ok to simply remove them.

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/char/sclpconsole-lm.c          | 6 ------
 hw/char/sclpconsole.c             | 6 ------
 hw/s390x/event-facility.c         | 6 +-----
 include/hw/s390x/event-facility.h | 2 +-
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 07d6ebd..86ddda6 100644
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
index b78f240..e916cac 100644
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
index 34b2faf..f7c509c 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -413,11 +413,7 @@ static void event_unrealize(DeviceState *qdev, Error **errp)
     SCLPEvent *event = SCLP_EVENT(qdev);
     SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
     if (child->exit) {
-        int rc = child->exit(event);
-        if (rc < 0) {
-            error_setg(errp, "SCLP event exit failed.");
-            return;
-        }
+        child->exit(event);
     }
 }
 
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index def1bb0..1a32f3a 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -162,7 +162,7 @@ typedef struct SCLPEvent {
 typedef struct SCLPEventClass {
     DeviceClass parent_class;
     int (*init)(SCLPEvent *event);
-    int (*exit)(SCLPEvent *event);
+    void (*exit)(SCLPEvent *event);
 
     /* get SCLP's send mask */
     unsigned int (*get_send_mask)(void);
-- 
2.7.4
