Received: from eggs.gnu.org ([2001:4830:134:3::10]:41785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYu-0007a1-E2
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYt-0005Tx-8A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:52 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYs-0005Rb-Vm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:51 -0500
Received: by mail-wm0-x242.google.com with SMTP id 141so11110806wme.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:50 +0100
Message-Id: <1515756676-3860-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/52] disas/s390: fix global-buffer-overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Spotted thanks to ASAN:

==25226==ERROR: AddressSanitizer: global-buffer-overflow on address 0x556715a1f120 at pc 0x556714b6f6b1 bp 0x7ffcdfac1360 sp 0x7ffcdfac1350
READ of size 1 at 0x556715a1f120 thread T0
    #0 0x556714b6f6b0 in init_disasm /home/elmarco/src/qemu/disas/s390.c:219
    #1 0x556714b6fa6a in print_insn_s390 /home/elmarco/src/qemu/disas/s390.c:294
    #2 0x55671484d031 in monitor_disas /home/elmarco/src/qemu/disas.c:635
    #3 0x556714862ec0 in memory_dump /home/elmarco/src/qemu/monitor.c:1324
    #4 0x55671486342a in hmp_memory_dump /home/elmarco/src/qemu/monitor.c:1418
    #5 0x5567148670be in handle_hmp_command /home/elmarco/src/qemu/monitor.c:3109
    #6 0x5567148674ed in qmp_human_monitor_command /home/elmarco/src/qemu/monitor.c:613
    #7 0x556714b00918 in qmp_marshal_human_monitor_command /home/elmarco/src/qemu/build/qmp-marshal.c:1704
    #8 0x556715138a3e in do_qmp_dispatch /home/elmarco/src/qemu/qapi/qmp-dispatch.c:104
    #9 0x556715138f83 in qmp_dispatch /home/elmarco/src/qemu/qapi/qmp-dispatch.c:131
    #10 0x55671485cf88 in handle_qmp_command /home/elmarco/src/qemu/monitor.c:3839
    #11 0x55671514e80b in json_message_process_token /home/elmarco/src/qemu/qobject/json-streamer.c:105
    #12 0x5567151bf2dc in json_lexer_feed_char /home/elmarco/src/qemu/qobject/json-lexer.c:323
    #13 0x5567151bf827 in json_lexer_feed /home/elmarco/src/qemu/qobject/json-lexer.c:373
    #14 0x55671514ee62 in json_message_parser_feed /home/elmarco/src/qemu/qobject/json-streamer.c:124
    #15 0x556714854b1f in monitor_qmp_read /home/elmarco/src/qemu/monitor.c:3881
    #16 0x556715045440 in qemu_chr_be_write_impl /home/elmarco/src/qemu/chardev/char.c:172
    #17 0x556715047184 in qemu_chr_be_write /home/elmarco/src/qemu/chardev/char.c:184
    #18 0x55671505a8e6 in tcp_chr_read /home/elmarco/src/qemu/chardev/char-socket.c:440
    #19 0x5567150943c3 in qio_channel_fd_source_dispatch /home/elmarco/src/qemu/io/channel-watch.c:84
    #20 0x7fb90292b90b in g_main_dispatch ../glib/gmain.c:3182
    #21 0x7fb90292c7ac in g_main_context_dispatch ../glib/gmain.c:3847
    #22 0x556715162eca in glib_pollfds_poll /home/elmarco/src/qemu/util/main-loop.c:214
    #23 0x556715163001 in os_host_main_loop_wait /home/elmarco/src/qemu/util/main-loop.c:261
    #24 0x5567151631fa in main_loop_wait /home/elmarco/src/qemu/util/main-loop.c:515
    #25 0x556714ad6d3b in main_loop /home/elmarco/src/qemu/vl.c:1950
    #26 0x556714ade329 in main /home/elmarco/src/qemu/vl.c:4865
    #27 0x7fb8fe5c9009 in __libc_start_main (/lib64/libc.so.6+0x21009)
    #28 0x5567147af4d9 in _start (/home/elmarco/src/qemu/build/s390x-softmmu/qemu-system-s390x+0xf674d9)

0x556715a1f120 is located 32 bytes to the left of global variable 'char_hci_type_info' defined in '/home/elmarco/src/qemu/hw/bt/hci-csr.c:493:23' (0x556715a1f140) of size 104
0x556715a1f120 is located 8 bytes to the right of global variable 's390_opcodes' defined in '/home/elmarco/src/qemu/disas/s390.c:860:33' (0x556715a15280) of size 40600

This fix is based on Andreas Arnez <arnez@linux.vnet.ibm.com> upstream
commit:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=9ace48f3d7d80ce09c5df60cccb433470410b11b

2014-08-19  Andreas Arnez  <arnez@linux.vnet.ibm.com>

       * s390-dis.c (init_disasm): Simplify initialization of
       opc_index[].  This also fixes an access after the last element
       of s390_opcodes[].

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180104160523.22995-19-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/s390.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/disas/s390.c b/disas/s390.c
index 1f167d2..6393860 100644
--- a/disas/s390.c
+++ b/disas/s390.c
@@ -207,18 +207,14 @@ static int opc_index[256];
 static void
 init_disasm (struct disassemble_info *info)
 {
-  const struct s390_opcode *opcode;
-  const struct s390_opcode *opcode_end;
+  int i;
 
   memset (opc_index, 0, sizeof (opc_index));
-  opcode_end = s390_opcodes + s390_num_opcodes;
-  for (opcode = s390_opcodes; opcode < opcode_end; opcode++)
-    {
-      opc_index[(int) opcode->opcode[0]] = opcode - s390_opcodes;
-      while ((opcode < opcode_end) &&
-	     (opcode[1].opcode[0] == opcode->opcode[0]))
-	opcode++;
-    }
+
+  /* Reverse order, such that each opc_index ends up pointing to the
+     first matching entry instead of the last.  */
+  for (i = s390_num_opcodes; i--; )
+    opc_index[s390_opcodes[i].opcode[0]] = i;
 
 #ifdef QEMU_DISABLE
   switch (info->mach)
-- 
1.8.3.1
