Received: from eggs.gnu.org ([208.118.235.92]:43082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgEi-0008CN-1D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgDQ-0005cM-0t
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:38:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehgDP-0005aX-Kk
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:37:35 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 19:37:28 +0100
Message-Id: <20180202183731.29990-13-armbru@redhat.com>
In-Reply-To: <20180202183731.29990-1-armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v7 12/15] hw/timer: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/timer/xilinx_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 59439c05be..2d658b5791 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -127,7 +127,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
             break;
 
     }
-    D(fprintf(stderr, "%s timer=%d %x=%x\n", __func__, timer, addr * 4, r));
+    D(error_report("%s timer=%d %x=%x", __func__, timer, addr * 4, r));
     return r;
 }
 
@@ -135,8 +135,8 @@ static void timer_enable(struct xlx_timer *xt)
 {
     uint64_t count;
 
-    D(fprintf(stderr, "%s timer=%d down=%d\n", __func__,
-              xt->nr, xt->regs[R_TCSR] & TCSR_UDT));
+    D(error_report("%s timer=%d down=%d", __func__,
+                   xt->nr, xt->regs[R_TCSR] & TCSR_UDT));
 
     ptimer_stop(xt->ptimer);
 
@@ -160,7 +160,7 @@ timer_write(void *opaque, hwaddr addr,
     addr >>= 2;
     timer = timer_from_addr(addr);
     xt = &t->timers[timer];
-    D(fprintf(stderr, "%s addr=%x val=%x (timer=%d off=%d)\n",
+    D(error_report("%s addr=%x val=%x (timer=%d off=%d)",
              __func__, addr * 4, value, timer, addr & 3));
     /* Further decoding to address a specific timers reg.  */
     addr &= 3;
@@ -197,7 +197,7 @@ static void timer_hit(void *opaque)
 {
     struct xlx_timer *xt = opaque;
     struct timerblock *t = xt->parent;
-    D(fprintf(stderr, "%s %d\n", __func__, xt->nr));
+    D(error_report("%s %d", __func__, xt->nr));
     xt->regs[R_TCSR] |= TCSR_TINT;
 
     if (xt->regs[R_TCSR] & TCSR_ARHT)
-- 
2.13.6
