Received: from eggs.gnu.org ([2001:4830:134:3::10]:44863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kR-0005YU-RN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kP-0001vE-4A
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:27 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3kO-0001uS-UL
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:25 -0500
Received: by mail-pg0-x241.google.com with SMTP id q20so5367460pgv.2
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:30:24 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:30:10 -0600
Message-Id: <1512682213-4354-6-git-send-email-minyard@acm.org>
In-Reply-To: <1512682213-4354-1-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 5/8] ipmi: disable IRQ and ATN on an external
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
Cc: Corey Minyard <cminyard@mvista.com>

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
