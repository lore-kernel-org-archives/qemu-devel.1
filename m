Received: from eggs.gnu.org ([2001:4830:134:3::10]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy2-0003S7-Qf
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxy-00024Y-Ig
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:14 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxy-000242-Bu
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:10 -0400
Received: by mail-wr0-x243.google.com with SMTP id l24so5604078wre.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:01 +0200
Message-Id: <1508343141-31835-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/29] disas: Always initialize
 read_memory_inner_func properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

I've recently seen this with valgrind while running the HMP tester:

==22373== Conditional jump or move depends on uninitialised value(s)
==22373==    at 0x4A41FD: arm_disas_set_info (cpu.c:504)
==22373==    by 0x3867A7: monitor_disas (disas.c:390)
==22373==    by 0x38E80E: memory_dump (monitor.c:1339)
==22373==    by 0x38FA43: handle_hmp_command (monitor.c:3123)
==22373==    by 0x38FB9E: qmp_human_monitor_command (monitor.c:613)
==22373==    by 0x4E3124: qmp_marshal_human_monitor_command (qmp-marshal.c:1736)
==22373==    by 0x769678: do_qmp_dispatch (qmp-dispatch.c:104)
==22373==    by 0x769678: qmp_dispatch (qmp-dispatch.c:131)
==22373==    by 0x38B734: handle_qmp_command (monitor.c:3853)
==22373==    by 0x76ED07: json_message_process_token (json-streamer.c:105)
==22373==    by 0x78D40A: json_lexer_feed_char (json-lexer.c:323)
==22373==    by 0x78D4CD: json_lexer_feed (json-lexer.c:373)
==22373==    by 0x38A08D: monitor_qmp_read (monitor.c:3895)

And indeed, in monitor_disas, the read_memory_inner_func variable was
not initialized, but arm_disas_set_info() expects this to be NULL
or a valid pointer. Let's properly set this to NULL in the
INIT_DISASSEMBLE_INFO to fix it in all functions that use the
disassemble_info struct.

Fixes: f7478a92dd9ee2276bfaa5b7317140d3f9d6a53b ("Fix Thumb-1 BE32 execution")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1506524313-20037-1-git-send-email-thuth@redhat.com>
---
 disas.c             | 1 -
 include/disas/bfd.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas.c b/disas.c
index d6a1eb9..54eea3f 100644
--- a/disas.c
+++ b/disas.c
@@ -190,7 +190,6 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
 
     s.cpu = cpu;
     s.info.read_memory_func = target_read_memory;
-    s.info.read_memory_inner_func = NULL;
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
     s.info.print_address_func = generic_print_address;
diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index b01e002..d99da68 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -479,6 +479,7 @@ int generic_symbol_at_address(bfd_vma, struct disassemble_info *);
   (INFO).buffer_vma = 0, \
   (INFO).buffer_length = 0, \
   (INFO).read_memory_func = buffer_read_memory, \
+  (INFO).read_memory_inner_func = NULL, \
   (INFO).memory_error_func = perror_memory, \
   (INFO).print_address_func = generic_print_address, \
   (INFO).print_insn = NULL, \
-- 
1.8.3.1
