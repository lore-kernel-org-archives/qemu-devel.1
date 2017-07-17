Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2UJ-0007SU-ON
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2UF-0000kR-Uj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2UF-0000k7-Ns
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:43 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:38:37 +0200
Message-Id: <20170717093839.15341-2-kraxel@redhat.com>
In-Reply-To: <20170717093839.15341-1-kraxel@redhat.com>
References: <20170717093839.15341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

The current VNC default keyboard delay is 1ms. With that we're constantly
typing faster than the guest receives keyboard events from an XHCI attached
USB HID device.

The default keyboard delay time in the input layer however is 10ms. I don't know
how that number came to be, but empirical tests on some OpenQA driven ARM
systems show that 10ms really is a reasonable default number for the delay.

This patch moves the VNC delay also to 10ms. That way our default is much
safer (good!) and also consistent with the input layer default (also good!).

Signed-off-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 1499863425-103133-1-git-send-email-agraf@suse.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c        | 2 +-
 qemu-options.hx | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 26136f5d29..eb91559b6b 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 76b1c67737..6909285e85 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1753,7 +1753,7 @@ spec but is traditional QEMU behavior.
 @item key-delay-ms
 
 Set keyboard delay, for key down and key up events, in milliseconds.
-Default is 1.  Keyboards are low-bandwidth devices, so this slowdown
+Default is 10.  Keyboards are low-bandwidth devices, so this slowdown
 can help the device and guest to keep up and not lose events in case
 events are arriving in bulk.  Possible causes for the latter are flaky
 network connections, or scripts for automated testing.
-- 
2.9.3
