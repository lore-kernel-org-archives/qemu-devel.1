Received: from eggs.gnu.org ([2001:4830:134:3::10]:57529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d0uEn-0001s5-Fl
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d0uEk-0003qa-CG
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:21:57 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d0uEk-0003qR-7A
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:21:54 -0400
Received: by mail-yb0-x244.google.com with SMTP id l192so1163304ybl.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 11:21:54 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Thu, 20 Apr 2017 02:21:29 +0800
Message-Id: <1492626091-30531-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/char: remove console_exit function in
 sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

    Currently, the console_exit function in sclpconsole-lm.c and
    sclpconsole.c does nothing, just remove them. Since there is
    a NULL check on the DeviceClass exit callback as suggested by
    Frederic Konrad, it should be safe to simply remove them.

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/char/sclpconsole-lm.c          | 6 ------
 hw/char/sclpconsole.c             | 6 ------
 include/hw/s390x/event-facility.h | 2 +-
 3 files changed, 1 insertion(+), 13 deletions(-)

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
