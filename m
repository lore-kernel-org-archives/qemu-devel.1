Received: from eggs.gnu.org ([209.51.188.92]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gp4HZ-00017q-Bj
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gp4HY-0005yr-GL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:48:57 -0500
Received: from sonic304-19.consmr.mail.sg3.yahoo.com ([106.10.242.209]:37613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gp4HX-0005xI-ND
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:48:56 -0500
From: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Date: Thu, 31 Jan 2019 13:48:37 +0900
Message-Id: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, Eric Blake <eblake@redhat.com>, lucienmp_antispam@yahoo.com

The result is that vCont now does not recognise the case where no process/thread is provided after the action.

This may not show up with GDB, but using Lauterbach Trace32, and Hexrays IDA Pro this issue is immediately seen.
The response is a "$#00" empty packet, showing it is unsupported packet.

This is defined in the RSP document as "An action with no thread-id matches all threads."
(https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#vCont-packet )

Thus the valid vCont packets now are as below, however parsing is still not very strict.
  vCont;c/s                 - Step/Continue all threads
  vCont;c/s:[pX.]Y          - Step/Continue optional process X, thread Y
  vCont;C##/S##:[pX.]Y      - Step/Continue with signal ## on optional process X, thread Y
  * If X or Y are -1 then it applies the action to all processes/threads.

Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
---
 gdbstub.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb509..ce0dde2e24 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1169,6 +1169,7 @@ static int is_query_packet(const char *p, const char *query, char separator)
  */
 static int gdb_handle_vcont(GDBState *s, const char *p)
 {
+    GDBThreadIdKind vcontThreadType ;
     int res, signal = 0;
     char cur_action;
     char *newstates;
@@ -1218,12 +1219,23 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
             goto out;
         }
 
-        if (*p++ != ':') {
+        /*
+         * In the case we have vCont;c or vCont;s - action is on all threads
+         * Alternatively vCont;c;s:p1.1 is a possible, but meaningless format,
+         * And in the else the "vCont;c:p1.1;... format is supported.
+         */
+        if (*p == '\0' || *p == ';') {
+            vcontThreadType = GDB_ALL_THREADS ;
+            pid = 1 ;
+            tid = 1 ;
+        } else if (*p++ == ':') {
+            vcontThreadType = read_thread_id(p, &p, &pid, &tid) ;
+        } else {
             res = -ENOTSUP;
             goto out;
         }
 
-        switch (read_thread_id(p, &p, &pid, &tid)) {
+        switch (vcontThreadType) {
         case GDB_READ_THREAD_ERR:
             res = -EINVAL;
             goto out;
-- 
2.17.2
