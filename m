Received: from eggs.gnu.org ([2001:4830:134:3::10]:34700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHu-0001f2-On
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHt-0007nm-Rl
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOIHt-0007nB-Mm
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EEA17A7F6
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 07:46:21 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 31 May 2018 09:46:01 +0200
Message-Id: <20180531074601.10647-4-slp@redhat.com>
In-Reply-To: <20180531074601.10647-1-slp@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on serial_xmit
 if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>

If writing to the frontend channel failed with EPIPE, don't set up a
retry. EPIPE is not a recoverable error, so trying again is a waste of CPU
cycles.

If the vCPU writing to the serial device and emulator thread are pinned
to the same pCPU, it can also compromise the stability of the Guest OS,
as both threads will be competing for pCPU's time, with the vCPU
actively polling the serial device and barely giving time to the
emulator thread to make actual progress.
---
 hw/char/serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2c080c9..f26e86b 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -262,6 +262,7 @@ static void serial_xmit(SerialState *s)
             /* in loopback mode, say that we just received a char */
             serial_receive1(s, &s->tsr, 1);
         } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) != 1 &&
+                   errno != EPIPE &&
                    s->tsr_retry < MAX_XMIT_RETRY) {
             assert(s->watch_tag == 0);
             s->watch_tag =
-- 
1.8.3.1
