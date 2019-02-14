Received: from eggs.gnu.org ([209.51.188.92]:54118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLL-00084L-VI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLK-0004up-DS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:43 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLK-0004rs-3m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: by mail-wm1-x344.google.com with SMTP id q21so7181776wmc.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:06:03 +0000
Message-Id: <20190214190603.25030-28-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/27] gdbstub: Send a reply to the vKill packet.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Sandra Loosemore <sandra@codesourcery.com>

Per the GDB remote protocol documentation

https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#index-vKill-packet

the debug stub is expected to send a reply to the 'vKill' packet.  At
least some versions of GDB crash if the gdb stub simply exits without
sending a reply.  This patch fixes QEMU's gdb stub to conform to the
expected behavior.

Note that QEMU's existing handling of the legacy 'k' packet is
correct: in that case GDB does not expect a reply, and QEMU does not
send one.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
Message-id: 1550008033-26540-1-git-send-email-sandra@codesourcery.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub.c b/gdbstub.c
index ff19579452d..bc774ae9925 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1361,6 +1361,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             break;
         } else if (strncmp(p, "Kill;", 5) == 0) {
             /* Kill the target */
+            put_packet(s, "OK");
             error_report("QEMU: Terminated via GDBstub");
             exit(0);
         } else {
-- 
2.20.1
