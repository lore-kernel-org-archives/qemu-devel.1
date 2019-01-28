Received: from eggs.gnu.org ([209.51.188.92]:50403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1goAAg-0002Bs-5k
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1goAAf-0004a3-5p
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:54:06 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:41415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1goAAe-0004Ye-OC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:54:05 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 28 Jan 2019 17:53:33 +0100
Message-Id: <20190128165333.3814-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/hppa: fix setting registers via gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

While doing 'set $pcoqh=0xf0000000' i triggered the assertion below. From looking
at the source, it looks like the argument order for deposit64() is wrong, and val
needs to be moved to the end.

Signed-off-by: Sven Schnelle <svens@stackframe.org>

qemu-system-hppa: /home/svens/qemu/include/qemu/bitops.h:419: deposit64: Assertion `start >= 0 && length > 0 && length <= 64 - start' failed.

Thread 1 "qemu-system-hpp" received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=0x6) at ../sysdeps/unix/sysv/linux/raise.c:50
50	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
 #0  0x00007ffff4f8785b in __GI_raise (sig=sig@entry=0x6) at ../sysdeps/unix/sysv/linux/raise.c:50
 #1  0x00007ffff4f72535 in __GI_abort () at abort.c:79
 #2  0x00007ffff4f7240f in __assert_fail_base
    (fmt=0x7ffff50d4ee0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x555555cc62a8 "start >= 0 && length > 0 && length <= 64 - start", file=0x555555cc6280 "/home/svens/qemu/include/qemu/bitops.h", line=0x1a3, function=<optimized out>) at assert.c:92
 #3  0x00007ffff4f800a2 in __GI___assert_fail
    (assertion=0x555555cc62a8 "start >= 0 && length > 0 && length <= 64 - start", file=0x555555cc6280 "/home/svens/qemu/include/qemu/bitops.h", line=0x1a3, function=0x555555cc6760 <__PRETTY_FUNCTION__.15114> "deposit64") at assert.c:101
 #4  0x00005555558dd0db in deposit64 (value=0x0, start=0x0, length=0x0, fieldval=0x20) at /home/svens/qemu/include/qemu/bitops.h:419
 #5  0x00005555558dd87a in hppa_cpu_gdb_write_register (cs=0x5555563394e0, mem_buf=0x7fffffffb134 "", n=0x41) at /home/svens/qemu/target/hppa/gdbstub.c:269
 #6  0x0000555555822397 in gdb_write_register (cpu=0x5555563394e0, mem_buf=0x7fffffffb134 "", reg=0x41) at /home/svens/qemu/gdbstub.c:905
 #7  0x0000555555823802 in gdb_handle_packet (s=0x555556992020, line_buf=0x55555699203c "G", '0' <repeats 40 times>, "fff1", '0' <repeats 131 times>, "1", '0' <repeats 22 times>, "6"...) at /home/svens/qemu/gdbstub.c:1481
 #8  0x000055555582573c in gdb_read_byte (s=0x555556992020, ch=0x35) at /home/svens/qemu/gdbstub.c:2131
 #9  0x0000555555825972 in gdb_chr_receive (opaque=0x555556992020, buf=0x7fffffffd170 "$G", '0' <repeats 40 times>, "fff1", '0' <repeats 131 times>, "1", '0' <repeats 22 times>..., size=0x405) at /home/svens/qemu/gdbstub.c:2369
 #10 0x0000555555bd51bc in qemu_chr_be_write_impl (s=0x5555566cd100, buf=0x7fffffffd170 "$G", '0' <repeats 40 times>, "fff1", '0' <repeats 131 times>, "1", '0' <repeats 22 times>..., len=0x405) at chardev/char.c:175
 #11 0x0000555555bd5220 in qemu_chr_be_write (s=0x5555566cd100, buf=0x7fffffffd170 "$G", '0' <repeats 40 times>, "fff1", '0' <repeats 131 times>, "1", '0' <repeats 22 times>..., len=0x405) at chardev/char.c:187
 #12 0x0000555555bdde8d in tcp_chr_read (chan=0x55555697ea00, cond=G_IO_IN, opaque=0x5555566cd100) at chardev/char-socket.c:490
 #13 0x0000555555bf81c3 in qio_channel_fd_source_dispatch (source=0x5555569c6220, callback=0x555555bddcdf <tcp_chr_read>, user_data=0x5555566cd100) at io/channel-watch.c:84
 #14 0x00007ffff6937cb8 in g_main_context_dispatch () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
 #15 0x0000555555c73851 in glib_pollfds_poll () at util/main-loop.c:215
 #16 0x0000555555c738cb in os_host_main_loop_wait (timeout=0x3b9aca00) at util/main-loop.c:238
 #17 0x0000555555c73984 in main_loop_wait (nonblocking=0x0) at util/main-loop.c:497
 #18 0x00005555558f4130 in main_loop () at vl.c:1925
 #19 0x00005555558fbb43 in main (argc=0xd, argv=0x7fffffffe5e8, envp=0x7fffffffe658) at vl.c:4662

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index e2e9c4d77f..3157a690f2 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -266,7 +266,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 65 ... 127:
         {
             uint64_t *fr = &env->fr[(n - 64) / 2];
-            *fr = deposit64(*fr, val, (n & 1 ? 0 : 32), 32);
+            *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
         }
         break;
     default:
-- 
2.20.1
