Received: from eggs.gnu.org ([2001:4830:134:3::10]:43234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1e-00036l-Lj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1b-0003qd-NY
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8O1b-0003po-Eq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:03 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 13:11:55 +0200
Message-Id: <20181005111157.12801-3-kraxel@redhat.com>
In-Reply-To: <20181005111157.12801-1-kraxel@redhat.com>
References: <20181005111157.12801-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] hw/display/qxl: Suppress clang-7 warning
 about misaligned atomic operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

If QEMU is compiled with clang-7 it results in the warning:

hw/display/qxl.c:1884:19: error: misaligned or large atomic operation
may incur significant performance penalty [-Werror,-Watomic-alignment]
    old_pending =3D atomic_fetch_or(&d->ram->int_pending, le_events);
                  ^

This is because the Spice headers forgot to define the QXLRam struct
with the '__aligned__(4)' attribute.  clang 7 and newer will thus
warn that the access here to int_pending might not be 4-aligned
(because the QXLRam object d->ram points at might start at a
misaligned address).  In fact we set up d->ram in init_qxl_ram() so
it always starts at a 4K boundary, so we know the atomic access here
is OK.

Newer Spice versions (with Spice commit
beda5ec7a6848be20c0cac2a9a8ef2a41e8069c1) will fix the bug;
for older Spice versions, work around it by telling the compiler
explicitly that the alignment is OK using __builtin_assume_aligned().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180927155538.699-1-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/compiler.h |  9 +++++++++
 hw/display/qxl.c        | 26 +++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 5843812710..bf47e7bee4 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -122,6 +122,15 @@
 #ifndef __has_feature
 #define __has_feature(x) 0 /* compatibility with non-clang compilers */
 #endif
+
+#ifndef __has_builtin
+#define __has_builtin(x) 0 /* compatibility with non-clang compilers */
+#endif
+
+#if __has_builtin(__builtin_assume_aligned) || QEMU_GNUC_PREREQ(4, 7)
+#define HAS_ASSUME_ALIGNED
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 747986478f..e628cf1286 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1893,7 +1893,31 @@ static void qxl_send_events(PCIQXLDevice *d, uint3=
2_t events)
         trace_qxl_send_events_vm_stopped(d->id, events);
         return;
     }
-    old_pending =3D atomic_fetch_or(&d->ram->int_pending, le_events);
+    /*
+     * Older versions of Spice forgot to define the QXLRam struct
+     * with the '__aligned__(4)' attribute. clang 7 and newer will
+     * thus warn that atomic_fetch_or(&d->ram->int_pending, ...)
+     * might be a misaligned atomic access, and will generate an
+     * out-of-line call for it, which results in a link error since
+     * we don't currently link against libatomic.
+     *
+     * In fact we set up d->ram in init_qxl_ram() so it always starts
+     * at a 4K boundary, so we know that &d->ram->int_pending is
+     * naturally aligned for a uint32_t. Newer Spice versions
+     * (with Spice commit beda5ec7a6848be20c0cac2a9a8ef2a41e8069c1)
+     * will fix the bug directly. To deal with older versions,
+     * we tell the compiler to assume the address really is aligned.
+     * Any compiler which cares about the misalignment will have
+     * __builtin_assume_aligned.
+     */
+#ifdef HAS_ASSUME_ALIGNED
+#define ALIGNED_UINT32_PTR(P) ((uint32_t *)__builtin_assume_aligned(P, 4=
))
+#else
+#define ALIGNED_UINT32_PTR(P) ((uint32_t *)P)
+#endif
+
+    old_pending =3D atomic_fetch_or(ALIGNED_UINT32_PTR(&d->ram->int_pend=
ing),
+                                  le_events);
     if ((old_pending & le_events) =3D=3D le_events) {
         return;
     }
--=20
2.9.3
