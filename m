Received: from eggs.gnu.org ([209.51.188.92]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wil-0003wL-8I
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wik-0000bg-CJ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wik-0000aj-4F
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id w2so23643921wrt.11
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:11 +0100
Message-Id: <1552117698-12355-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/25] configure: Disable W^X on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since OpenBSD 6.0 [1], W^X is enforced by default [2].
TCG requires WX access. Disable W^X if it is available.
This fixes:

  # lm32-softmmu/qemu-system-lm32
  Could not allocate dynamic translator buffer

  # sysctl kern.wxabort=1
  kern.wxabort: 0 -> 1
  # lm32-softmmu/qemu-system-lm32
  mmap: Not supported
  Abort trap (core dumped)
  # gdb -q lm32-softmmu/qemu-system-lm32 qemu-system-lm32.core
  (gdb) bt
  #0  0x000017e3c156c50a in _thread_sys___syscall () at {standard input}:5
  #1  0x000017e3c15e5d7a in *_libc_mmap (addr=Variable "addr" is not available.) at /usr/src/lib/libc/sys/mmap.c:47
  #2  0x000017e17d9abc8b in alloc_code_gen_buffer () at /usr/src/qemu/accel/tcg/translate-all.c:1064
  #3  0x000017e17d9abd04 in code_gen_alloc (tb_size=0) at /usr/src/qemu/accel/tcg/translate-all.c:1112
  #4  0x000017e17d9abe81 in tcg_exec_init (tb_size=0) at /usr/src/qemu/accel/tcg/translate-all.c:1149
  #5  0x000017e17d9897e9 in tcg_init (ms=0x17e45e456800) at /usr/src/qemu/accel/tcg/tcg-all.c:66
  #6  0x000017e17d9891b8 in accel_init_machine (acc=0x17e3c3f50800, ms=0x17e45e456800) at /usr/src/qemu/accel/accel.c:63
  #7  0x000017e17d989312 in configure_accelerator (ms=0x17e45e456800, progname=0x7f7fffff07b0 "lm32-softmmu/qemu-system-lm32") at /usr/src/qemu/accel/accel.c:111
  #8  0x000017e17d9d8616 in main (argc=1, argv=0x7f7fffff06b8, envp=0x7f7fffff06c8) at vl.c:4325

[1] https://www.openbsd.org/faq/upgrade60.html
[2] https://undeadly.org/cgi?action=article&sid=20160527203200

Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
Message-Id: <20190307142822.8531-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index c9a260c..62a2a49 100755
--- a/configure
+++ b/configure
@@ -5903,6 +5903,17 @@ if test "$mingw32" = "yes" ; then
     done
 fi
 
+# Disable OpenBSD W^X if available
+if test "$tcg" = "yes" && test "$targetos" = "OpenBSD"; then
+    cat > $TMPC <<EOF
+    int main(void) { return 0; }
+EOF
+    wx_ldflags="-Wl,-z,wxneeded"
+    if compile_prog "" "$wx_ldflags"; then
+        QEMU_LDFLAGS="$QEMU_LDFLAGS $wx_ldflags"
+    fi
+fi
+
 qemu_confdir=$sysconfdir$confsuffix
 qemu_moddir=$libdir$confsuffix
 qemu_datadir=$datadir$confsuffix
-- 
1.8.3.1
