Received: from eggs.gnu.org ([2001:4830:134:3::10]:41603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1d7iWQ-0005dq-EM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1d7iWP-0001IR-4H
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:18 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1d7iWO-0001II-Ue
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:17 -0400
Received: by mail-it0-x241.google.com with SMTP id c26so7255420itd.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:16:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV++8rKxPrAXv1GWrwtiK4CNZCv+QoSzYkG-1LYF2SEgw@mail.gmail.com>
References: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
	<20170502142207.GJ22502@stefanha-x1.localdomain>
	<CAEfK_46hGYYpO4YhYcxdUar1ugLQwbpJMgxAJDJU13zSpbD4zw@mail.gmail.com>
	<20170505144506.GA14316@stefanha-x1.localdomain>
	<CAEfK_44TpSJVi7JULXMRLftM5BFUJs=vHSxKG3h=YOUjQz1t+g@mail.gmail.com>
	<CAJSP0QV++8rKxPrAXv1GWrwtiK4CNZCv+QoSzYkG-1LYF2SEgw@mail.gmail.com>
From: Doug Gale <doug16k@gmail.com>
Date: Mon, 8 May 2017 09:16:15 -0400
Message-ID: <CAEfK_44j8k3Jiqp7LbXNasKjcfTT0uPPAbyPN=xg=HDAk0WoRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] gdbstub: implement remote debugging
 protocol escapes for command receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Right, only GETLINE_* states write to the linebuf, so line_buf_index <
1 is correct. Updated patch:

>From 2e6c45260cae60bbae446bffe43f948ab002c529 Mon Sep 17 00:00:00 2001
From: Doug Gale <doug16k@gmail.com>
Date: Mon, 1 May 2017 12:22:10 -0400
Subject: [PATCH] gdbstub: implement remote debugging protocol escapes for
 command receive

- decode escape sequences
- decompress run-length encoding escape sequences
- report command parsing problems to output when debug output is enabled
- reject packet checksums that are not valid hex digits
- compute the checksum based on the packet stream, not based on the
  decoded packet

Tested with GDB and QtCreator integrated debugger on SMP QEMU instance.
Works for me.

Signed-off-by: Doug Gale <doug16k@gmail.com>
---
 gdbstub.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9911153..dee0ff3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -286,6 +286,8 @@ enum RSState {
     RS_INACTIVE,
     RS_IDLE,
     RS_GETLINE,
+    RS_GETLINE_ESC,
+    RS_GETLINE_RLE,
     RS_CHKSUM1,
     RS_CHKSUM2,
 };
@@ -296,7 +298,8 @@ typedef struct GDBState {
     enum RSState state; /* parsing state */
     char line_buf[MAX_PACKET_LENGTH];
     int line_buf_index;
-    int line_csum;
+    int line_sum; /* running checksum */
+    int line_csum; /* checksum at the end of the packet */
     uint8_t last_packet[MAX_PACKET_LENGTH + 4];
     int last_packet_len;
     int signal;
@@ -1508,7 +1511,6 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb,
const char *fmt, ...)

 static void gdb_read_byte(GDBState *s, int ch)
 {
-    int i, csum;
     uint8_t reply;

 #ifndef CONFIG_USER_ONLY
@@ -1542,35 +1544,123 @@ static void gdb_read_byte(GDBState *s, int ch)
         switch(s->state) {
         case RS_IDLE:
             if (ch == '$') {
+                /* start of command packet */
                 s->line_buf_index = 0;
+                s->line_sum = 0;
                 s->state = RS_GETLINE;
+            } else {
+#ifdef DEBUG_GDB
+                printf("gdbstub received garbage between packets: 0x%x\n", ch);
+#endif
             }
             break;
         case RS_GETLINE:
+            if (ch == '}') {
+                /* start escape sequence */
+                s->state = RS_GETLINE_ESC;
+                s->line_sum += ch;
+            } else if (ch == '*') {
+                /* start run length encoding sequence */
+                s->state = RS_GETLINE_RLE;
+                s->line_sum += ch;
+            } else if (ch == '#') {
+                /* end of command, start of checksum*/
+                s->state = RS_CHKSUM1;
+            } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
+#ifdef DEBUG_GDB
+                printf("gdbstub command buffer overrun, dropping command\n");
+#endif
+                s->state = RS_IDLE;
+            } else {
+                /* unescaped command character */
+                s->line_buf[s->line_buf_index++] = ch;
+                s->line_sum += ch;
+            }
+            break;
+        case RS_GETLINE_ESC:
             if (ch == '#') {
-            s->state = RS_CHKSUM1;
+                /* unexpected end of command in escape sequence */
+                s->state = RS_CHKSUM1;
             } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
+                /* command buffer overrun */
+#ifdef DEBUG_GDB
+                printf("gdbstub command buffer overrun, dropping command\n");
+#endif
                 s->state = RS_IDLE;
             } else {
-            s->line_buf[s->line_buf_index++] = ch;
+                /* parse escaped character and leave escape state */
+                s->line_buf[s->line_buf_index++] = ch ^ 0x20;
+                s->line_sum += ch;
+                s->state = RS_GETLINE;
+            }
+            break;
+        case RS_GETLINE_RLE:
+            if (ch < ' ') {
+                /* invalid RLE count encoding */
+#ifdef DEBUG_GDB
+                printf("gdbstub got invalid RLE count: 0x%x\n", ch);
+#endif
+                s->state = RS_GETLINE;
+            } else {
+                /* decode repeat length */
+                int repeat = (unsigned char)ch - ' ' + 3;
+                if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
+                    /* that many repeats would overrun the command buffer */
+#ifdef DEBUG_GDB
+                    printf("gdbstub command buffer overrun,"
+                           " dropping command\n");
+#endif
+                    s->state = RS_IDLE;
+                } else if (s->line_buf_index < 1) {
+                    /* got a repeat but we have nothing to repeat */
+#ifdef DEBUG_GDB
+                    printf("gdbstub got invalid RLE sequence\n");
+#endif
+                    s->state = RS_GETLINE;
+                } else {
+                    /* repeat the last character */
+                    memset(s->line_buf + s->line_buf_index,
+                           s->line_buf[s->line_buf_index - 1], repeat);
+                    s->line_buf_index += repeat;
+                    s->line_sum += ch;
+                    s->state = RS_GETLINE;
+                }
             }
             break;
         case RS_CHKSUM1:
+            /* get high hex digit of checksum */
+            if (!isxdigit(ch)) {
+#ifdef DEBUG_GDB
+                printf("gdbstub got invalid command checksum digit\n");
+#endif
+                s->state = RS_GETLINE;
+                break;
+            }
             s->line_buf[s->line_buf_index] = '\0';
             s->line_csum = fromhex(ch) << 4;
             s->state = RS_CHKSUM2;
             break;
         case RS_CHKSUM2:
+            /* get low hex digit of checksum */
+            if (!isxdigit(ch)) {
+#ifdef DEBUG_GDB
+                printf("gdbstub got invalid command checksum digit\n");
+#endif
+                s->state = RS_GETLINE;
+                break;
+            }
             s->line_csum |= fromhex(ch);
-            csum = 0;
-            for(i = 0; i < s->line_buf_index; i++) {
-                csum += s->line_buf[i];
-            }
-            if (s->line_csum != (csum & 0xff)) {
+
+            if (s->line_csum != (s->line_sum & 0xff)) {
+                /* send NAK reply */
                 reply = '-';
                 put_buffer(s, &reply, 1);
+#ifdef DEBUG_GDB
+                printf("gdbstub got command packet with incorrect checksum\n");
+#endif
                 s->state = RS_IDLE;
             } else {
+                /* send ACK reply */
                 reply = '+';
                 put_buffer(s, &reply, 1);
                 s->state = gdb_handle_packet(s, s->line_buf);
-- 
2.7.4


On Mon, May 8, 2017 at 5:01 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sun, May 7, 2017 at 4:26 PM, Doug Gale <doug16k@gmail.com> wrote:
>> On Fri, May 5, 2017 at 10:45 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> On Tue, May 02, 2017 at 10:32:40AM -0400, Doug Gale wrote:
>>>> +            } else {
>>>> +                /* decode repeat length */
>>>> +                int repeat = (unsigned char)ch - ' ' + 3;
>>>> +                if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
>>>> +                    /* that many repeats would overrun the command buffer */
>>>> +#ifdef DEBUG_GDB
>>>> +                    printf("gdbstub command buffer overrun,"
>>>> +                           " dropping command\n");
>>>> +#endif
>>>> +                    s->state = RS_IDLE;
>>>> +                } else if (s->line_buf_index <= 2) {
>>>
>>> Why s->line_buf_index <= 2?  I expected s->line_buf_index < 1 since we
>>> just need 1 character to clone for run-length decoding.
>>
>> Yes, on second thought, <= 2 is off by one. [0] would be the '$', [1]
>> would be the repeated character, and [2] would be the '*'.
>
> '$' and '*' are not placed into line_buf[] and do not increment
> line_buf_index.  They don't count.
>
> I think the correct condition is line_buf_index < 1 so that the
> following input from the GDB documentation parses: "$0* " -> "0000".
>
> https://sourceware.org/gdb/onlinedocs/gdb/Overview.html
