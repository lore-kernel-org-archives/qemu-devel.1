Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJz2-0003HT-Os
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJz0-0000B6-Am
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:16 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ehJz0-0000AT-6S
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:14 -0500
Received: by mail-ot0-x243.google.com with SMTP id a2so6527186otf.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:53:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  1 Feb 2018 12:53:01 -0600
Message-Id: <1517511182-9944-7-git-send-email-minyard@acm.org>
In-Reply-To: <1517511182-9944-1-git-send-email-minyard@acm.org>
References: <1517511182-9944-1-git-send-email-minyard@acm.org>
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Otherwise there's no way to clear them without an external command,
and it could lock the OS in the VM if they were stuck.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 8c0535d..bf0b7ee 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -425,6 +425,11 @@ static void chr_event(void *opaque, int event)
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
