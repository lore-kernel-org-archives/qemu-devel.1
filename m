Received: from eggs.gnu.org ([209.51.188.92]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn7Ag-0006A3-JJ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn78c-0005aG-Ml
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn78c-0005a1-HY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:38 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 25 Jan 2019 20:27:17 +0100
Message-Id: <20190125192719.15339-2-philmd@redhat.com>
In-Reply-To: <20190125192719.15339-1-philmd@redhat.com>
References: <20190125192719.15339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] configure: Disable W^X on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>

Since OpenBSD 6.0 [1], W^X is enforced by default [2].
TCG requires WX access. Disable W^X if it is available.
This fixes:

  # lm32-softmmu/qemu-system-lm32
  Could not allocate dynamic translator buffer

  # sysctl kern.wxabort=3D1
  kern.wxabort: 0 -> 1
  # lm32-softmmu/qemu-system-lm32
  mmap: Not supported
  Abort trap (core dumped)
  # gdb -q lm32-softmmu/qemu-system-lm32 qemu-system-lm32.core
  (gdb) bt
  #0  0x000017e3c156c50a in _thread_sys___syscall () at {standard input}:=
5
  #1  0x000017e3c15e5d7a in *_libc_mmap (addr=3DVariable "addr" is not av=
ailable.) at /usr/src/lib/libc/sys/mmap.c:47
  #2  0x000017e17d9abc8b in alloc_code_gen_buffer () at /usr/src/qemu/acc=
el/tcg/translate-all.c:1064
  #3  0x000017e17d9abd04 in code_gen_alloc (tb_size=3D0) at /usr/src/qemu=
/accel/tcg/translate-all.c:1112
  #4  0x000017e17d9abe81 in tcg_exec_init (tb_size=3D0) at /usr/src/qemu/=
accel/tcg/translate-all.c:1149
  #5  0x000017e17d9897e9 in tcg_init (ms=3D0x17e45e456800) at /usr/src/qe=
mu/accel/tcg/tcg-all.c:66
  #6  0x000017e17d9891b8 in accel_init_machine (acc=3D0x17e3c3f50800, ms=3D=
0x17e45e456800) at /usr/src/qemu/accel/accel.c:63
  #7  0x000017e17d989312 in configure_accelerator (ms=3D0x17e45e456800, p=
rogname=3D0x7f7fffff07b0 "lm32-softmmu/qemu-system-lm32") at /usr/src/qem=
u/accel/accel.c:111
  #8  0x000017e17d9d8616 in main (argc=3D1, argv=3D0x7f7fffff06b8, envp=3D=
0x7f7fffff06c8) at vl.c:4325

[1] https://www.openbsd.org/faq/upgrade60.html
[2] https://undeadly.org/cgi?action=3Darticle&sid=3D20160527203200

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index b18281c61f..f6acc028a7 100755
--- a/configure
+++ b/configure
@@ -5795,6 +5795,17 @@ if test "$mingw32" =3D "yes" ; then
     done
 fi
=20
+# Disable W^X if available
+if test "$tcg" =3D "yes" -a "$targetos" =3D "OpenBSD"; then
+    cat > $TMPC <<EOF
+    int main(void) { return 0; }
+EOF
+    wx_ldflags=3D"-Wl,-z,wxneeded"
+    if compile_prog "" "$wx_ldflags"; then
+        QEMU_LDFLAGS=3D"$QEMU_LDFLAGS -Wl,-z,wxneeded"
+    fi
+fi
+
 qemu_confdir=3D$sysconfdir$confsuffix
 qemu_moddir=3D$libdir$confsuffix
 qemu_datadir=3D$datadir$confsuffix
--=20
2.20.1
