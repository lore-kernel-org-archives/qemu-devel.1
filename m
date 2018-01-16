Received: from eggs.gnu.org ([2001:4830:134:3::10]:59605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZv-0007sW-E2
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZu-0000mg-Hz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:15 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ebFZu-0000mE-CP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: by mail-ot0-x244.google.com with SMTP id w4so12197186otg.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:58:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 15 Jan 2018 18:57:58 -0600
Message-Id: <1516064279-14816-7-git-send-email-minyard@acm.org>
In-Reply-To: <1516064279-14816-1-git-send-email-minyard@acm.org>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 6/7] ipmi: disable IRQ and ATN on an external
 disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Otherwise there's no way to clear them without an external command,
and it could lock the OS in the VM if they were stuck.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index abab3bb..58ade79 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -424,6 +424,11 @@ static void chr_event(void *opaque, int event)
             return;
         }
         ibe->connected = false;
+        /*
+         * Don't hang the OS trying to handle the ATN bit, other end will
+         * resend on a reconnect.
+         */
+        k->set_atn(s, 0, 0);
         if (ibe->waiting_rsp) {
             ibe->waiting_rsp = false;
             ibe->inbuf[1] = ibe->outbuf[1] | 0x04;
-- 
2.7.4
