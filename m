Received: from eggs.gnu.org ([2001:4830:134:3::10]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriele.galeotti.xyz@gmail.com>) id 1ctfft-0006qp-RK
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriele.galeotti.xyz@gmail.com>) id 1ctffo-00063e-Tx
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:24:01 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriele.galeotti.xyz@gmail.com>)
	id 1ctffo-000622-NP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:23:56 -0400
Received: by mail-wr0-x244.google.com with SMTP id p52so14842870wrc.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 12:23:56 -0700 (PDT)
From: Gabriele Galeotti <gabriele.galeotti.xyz@gmail.com>
Message-ID: <e72bc20d-9da1-255b-bc44-e6e8786799be@gmail.com>
Date: Thu, 30 Mar 2017 21:30:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] LEON3 timer patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chouteau@adacore.com


Hi all.
According to "GR712RC Dual-Core LEON3FT SPARC V8 Processor User’s Manual",
"11.3 Registers", pg 87-88, Table 55 Timer control register, the IP 
"interrupt pending"
bit:

Interrupt Pending (IP): The core sets this bit to ‘1’ when an interrupt 
is signalled. This bit remains ‘1’
until cleared by writing ‘0’ to this bit.

Thus  the code handling should changed so that the pending bit is 
mantained when "value" has a 1
in that position.


Signed-off-by: Gabriele Galeotti <gabriele.galeotti.xyz@gmail.com>
---
  hw/timer/grlib_gptimer.c | 3 ---
  1 file changed, 3 deletions(-)

diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e9..c555ae8 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -276,9 +276,6 @@ static void grlib_gptimer_write(void *opaque, hwaddr 
addr,
              trace_grlib_gptimer_writel(id, addr, value);
.
              if (value & GPTIMER_INT_PENDING) {
-                /* clear pending bit */
-                value &= ~GPTIMER_INT_PENDING;
-            } else {
                  /* keep pending bit */
                  value |= unit->timers[id].config & GPTIMER_INT_PENDING;
              }
--.
2.9.0
