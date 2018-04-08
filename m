Received: from eggs.gnu.org ([2001:4830:134:3::10]:43673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f5BnI-0003s5-Gc
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 10:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f5BnF-0004HS-GA
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 10:59:48 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f5BnF-0004H6-C8
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 10:59:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id s2so6457906qti.2
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 07:59:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  8 Apr 2018 11:59:33 -0300
Message-Id: <20180408145933.1149-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12] gdbstub: fix off-by-one in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

memtohex() adds an extra trailing NUL character.

Reported-by: AddressSanitizer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
(gdb) dump binary memory /tmp/dram.bin 0x94000000 0x94100000
Remote connection closed

=================================================================
==22732==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffe43018340 at pc 0x55f2655fde81 bp 0x7ffe43017210 sp 0x7ffe43017208
WRITE of size 1 at 0x7ffe43018340 thread T0
    #0 0x55f2655fde80 in memtohex /source/qemu/gdbstub.c:520
    #1 0x55f26560254d in gdb_handle_packet /source/qemu/gdbstub.c:1140
    #2 0x55f2656073c3 in gdb_read_byte /source/qemu/gdbstub.c:1703
    #3 0x55f2656076a7 in gdb_chr_receive /source/qemu/gdbstub.c:1909
    #4 0x55f266457656 in qemu_chr_be_write_impl /source/qemu/chardev/char.c:175
    #5 0x55f2664576f9 in qemu_chr_be_write /source/qemu/chardev/char.c:187
    #6 0x55f26646f6f0 in tcp_chr_read /source/qemu/chardev/char-socket.c:470
    #7 0x55f2664bc9e3 in qio_channel_fd_source_dispatch /source/qemu/io/channel-watch.c:84
    #8 0x7f17d01b30f4 in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
    #9 0x55f2665c7f10 in glib_pollfds_poll /source/qemu/util/main-loop.c:215
    #10 0x55f2665c8100 in os_host_main_loop_wait /source/qemu/util/main-loop.c:263
    #11 0x55f2665c82d6 in main_loop_wait /source/qemu/util/main-loop.c:522
    #12 0x55f26599e13b in main_loop /source/qemu/vl.c:1943
    #13 0x55f2659b0869 in main /source/qemu/vl.c:4734

Address 0x7ffe43018340 is located in stack of thread T0 at offset 4192 in frame
    #0 0x55f265601266 in gdb_handle_packet /source/qemu/gdbstub.c:996

  This frame has 3 object(s):
    [32, 40) 'p'
    [96, 4192) 'buf' <== Memory access at offset 4192 overflows this variable
    [4224, 8320) 'mem_buf'
SUMMARY: AddressSanitizer: stack-buffer-overflow /source/qemu/gdbstub.c:520 in memtohex
Shadow bytes around the buggy address:
  0x1000485fb010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x1000485fb060: 00 00 00 00 00 00 00 00[f2]f2 f2 f2 00 00 00 00
  0x1000485fb070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000485fb0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==22732==ABORTING
---
 gdbstub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index a76b2fa481..18a8d8a710 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -507,6 +507,7 @@ static inline int tohex(int v)
         return v - 10 + 'a';
 }
 
+/* writes 2*len+1 bytes in buf */
 static void memtohex(char *buf, const uint8_t *mem, int len)
 {
     int i, c;
@@ -999,8 +1000,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     const char *p;
     uint32_t thread;
     int ch, reg_size, type, res;
-    char buf[MAX_PACKET_LENGTH];
     uint8_t mem_buf[MAX_PACKET_LENGTH];
+    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     uint8_t *registers;
     target_ulong addr, len;
 
-- 
2.17.0
