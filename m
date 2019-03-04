Received: from eggs.gnu.org ([209.51.188.92]:49380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1h0iCz-0005pZ-7w
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1h0iCu-0003De-1D
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:40:20 -0500
Received: from sonic309-21.consmr.mail.sg3.yahoo.com ([106.10.244.84]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1h0iCo-0002z2-UR
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:40:13 -0500
From: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Date: Mon,  4 Mar 2019 16:39:36 +0900
Message-Id: <20190304073936.55294-1-lucienmp_antispam@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: laurent@vivier.eu, Luc Michel <luc.michel@greensocs.com>, Eric Blake <eblake@redhat.com>, lucienmp_antispam@yahoo.com

This fixes a regression in rsp packet vCont, this was due to the
recently added multiprocess support. (Short commit hash: e40e520).

The result is that vCont now does not recognise the case where
no process/thread is provided after the action.

This may not show up with GDB, but using Lauterbach Trace32,
and Hexrays IDA Pro this issue is immediately seen.

The response is a "$#00" empty packet, showing it is unsupported packet.

This is defined in the RSP document as "An action with no thread-id
matches all threads."
(https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#vCont-packet)

This is where the document lacks details. It says that the vCont packet
is used to "Resume the inferior, specifying different actions for each
thread."

So it seems to target only one inferior (i.e. one process).

When multiprocess extension is in use, this packet must be supported,
and used in place of 'Hc' (which modifies s->c_cpu) and other action
packets (s, S, ...) which are deprecated.

So the question is: when the vCont packet does not specifies a
thread-id, what _process_ we should choose?

Going for all process is probably ok because:
  - we don't have to bother choosing a PID,
  - it will cover the mono-process case correctly (main use-case of this
form of vCont packet I think).

The alternative would be can go for GDB_ALL_THREAD and take the PID of the
first attached CPU.  But may lead to problems, so I have chosen the
GDB_ALL_PROCESSES.

A request for improved documentation has been made at;
https://sourceware.org/bugzilla/show_bug.cgi?id=24177

Thus, for now, the valid vCont packets now are as below.
However, parsing is still not very strict and many other invalid arguments
formats are possible but they are not expected from standard debuggers.

 * vCont;c/s
 ** Step/Continue all threads

 * vCont;c/s:[pX.]Y
 ** Step/Continue optional process X, thread Y

 * vCont;C##/S##:[pX.]Y
 ** Step/Continue with signal ## on optional process X, thread Y

 * If X or Y are -1 then it applies the action to all processes/threads.

Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
---
Third attempt, taking greatly valued input on formatting.
Also includes a change to the way kind is handled for no-action vcont
---
 gdbstub.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a4be63f6eb..f8680f7ee8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1145,6 +1145,7 @@ static int is_query_packet(const char *p, const char *query, char separator)
  */
 static int gdb_handle_vcont(GDBState *s, const char *p)
 {
+    GDBThreadIdKind kind;
     int res, signal = 0;
     char cur_action;
     char *newstates;
@@ -1194,12 +1195,24 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
             goto out;
         }
 
-        if (*p++ != ':') {
+        /*
+         * When we have vCont;c or vCont;s - action is on all threads
+         * Alternatively action maybe followed by a ';' and more specifiers
+         * such as vCont;c;s:p1.1 is a possible, but meaningless format.
+         * Otherwise if the action is followed by a ':' then
+         * the pPID.TID format is expected (for example "vCont;c:p1.1;...).
+         */
+        if (*p == '\0' || *p == ';') {
+            /* unclear behavior in RSP spec, assume GDB_ALL_PROCESSES is ok */
+            kind = GDB_ALL_PROCESSES;
+        } else if (*p++ == ':') {
+            kind = read_thread_id(p, &p, &pid, &tid);
+        } else {
             res = -ENOTSUP;
             goto out;
         }
 
-        switch (read_thread_id(p, &p, &pid, &tid)) {
+        switch (kind) {
         case GDB_READ_THREAD_ERR:
             res = -EINVAL;
             goto out;
-- 
2.20.1
