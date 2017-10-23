Received: from eggs.gnu.org ([2001:4830:134:3::10]:36861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytp-0005y8-JN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytn-0005ZD-J2
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6Ytn-0005Z2-AO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F006B651
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:19:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 11:19:46 +0200
Message-Id: <20171023091947.20771-9-kraxel@redhat.com>
In-Reply-To: <20171023091947.20771-1-kraxel@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] ui: normalize the 'sysrq' key into the
 'print' key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The 'sysrq' key was mistakenly added to QEMU to deal with incorrect handling
of the 'print' key in the ps2 device:

  commit f2289cb6924afc97b2a75d21bfc9217024d11741
  Author: balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
  Date:   Wed Jun 4 10:14:16 2008 +0000

    Add sysrq to key names known by "sendkey".

    Adding sysrq keycode to the table enabling running sysrq debugging in
    the guest via the monitor sendkey command, like:

    (qemu) sendkey alt-sysrq-t

    Tested on x86-64 target and Linux guest.

    Signed-off-by: Ryan Harper <ryanh@us.ibm.com>

The ps2 device is now fixed wrt modifiers and the 'print' key. Further the
handling of the 'sysrq' key has some problems of its own, documented in the
previous commit. To cleanup this mess, we convert any use of 'sysrq' into
'print' prior to dispatching the event to device models.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20171019142848.572-9-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input.c   | 14 ++++++++++++++
 qapi/ui.json |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/ui/input.c b/ui/input.c
index 4e821f8f2b..3e2d324278 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -353,6 +353,20 @@ void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
     assert(!(evt->type == INPUT_EVENT_KIND_KEY &&
              evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER));
 
+
+    /*
+     * 'sysrq' was mistakenly added to hack around the fact that
+     * the ps2 driver was not generating correct scancodes sequences
+     * when 'alt+print' was pressed. This flaw is now fixed and the
+     * 'sysrq' key serves no further purpose. We normalize it to
+     * 'print', so that downstream receivers of the event don't
+     * neeed to deal with this mistake
+     */
+    if (evt->type == INPUT_EVENT_KIND_KEY &&
+        evt->u.key.data->key->u.qcode.data == Q_KEY_CODE_SYSRQ) {
+        evt->u.key.data->key->u.qcode.data = Q_KEY_CODE_PRINT;
+    }
+
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
         return;
     }
diff --git a/qapi/ui.json b/qapi/ui.json
index e5d6610b4a..07b468f625 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -748,6 +748,13 @@
 # @ac_bookmarks: since 2.10
 # altgr, altgr_r: dropped in 2.10
 #
+# 'sysrq' was mistakenly added to hack around the fact that
+# the ps2 driver was not generating correct scancodes sequences
+# when 'alt+print' was pressed. This flaw is now fixed and the
+# 'sysrq' key serves no further purpose. Any further use of
+# 'sysrq' will be transparently changed to 'print', so they
+# are effectively synonyms.
+#
 # Since: 1.3.0
 #
 ##
-- 
2.9.3
