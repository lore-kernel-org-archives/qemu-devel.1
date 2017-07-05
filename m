Received: from eggs.gnu.org ([2001:4830:134:3::10]:57270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dSdL4-0006u2-P6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dSdKz-0002OS-89
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:59:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43878 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dSdKz-0002MB-1Y
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:58:57 -0400
From: Alexander Graf <agraf@suse.de>
Date: Wed,  5 Jul 2017 07:59:15 +0200
Message-Id: <1499234355-138591-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The default keyboard delay time in the input layer is 10ms. I don't know
how that number came to be, but empirical tests on some OpenQA driven ARM
systems show that 10ms really is a reasonable default number for the delay.

With the current 1ms we're constantly typing faster than the guest receives
keyboard events from our XHCI attached USB HID device.

This patch moves the delay to 10ms. That way our default is much safer (good!)
and also consistent with the input layer default (also good!).

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 qemu-options.hx | 2 +-
 ui/vnc.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 896ff17..64806f0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1730,7 +1730,7 @@ spec but is traditional QEMU behavior.
 @item key-delay-ms
 
 Set keyboard delay, for key down and key up events, in milliseconds.
-Default is 1.  Keyboards are low-bandwidth devices, so this slowdown
+Default is 10.  Keyboards are low-bandwidth devices, so this slowdown
 can help the device and guest to keep up and not lose events in case
 events are arriving in bulk.  Possible causes for the latter are flaky
 network connections, or scripts for automated testing.
diff --git a/ui/vnc.c b/ui/vnc.c
index 26136f5..eb91559 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3808,7 +3808,7 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     lock_key_sync = qemu_opt_get_bool(opts, "lock-key-sync", true);
-    key_delay_ms = qemu_opt_get_number(opts, "key-delay-ms", 1);
+    key_delay_ms = qemu_opt_get_number(opts, "key-delay-ms", 10);
     sasl = qemu_opt_get_bool(opts, "sasl", false);
 #ifndef CONFIG_VNC_SASL
     if (sasl) {
-- 
1.8.5.6
