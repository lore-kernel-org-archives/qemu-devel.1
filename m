Received: from eggsout.gnu.org ([209.51.188.92]:60921 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfxOG-0000HS-Su
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 20:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfxOC-0005PB-Sw
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 20:38:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfxOC-0005OP-Ll
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 20:38:08 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat,  5 Jan 2019 19:38:02 -0600
Message-Id: <20190106013802.3645-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] osdep: Make MIN/MAX evaluate arguments only
 once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dirty.ice.hu@gmail.com, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the macro QEMU_TYPEOF() to access __auto_type in new enough
compilers, while falling back to typeof on older compilers (the
fallback doesn't handle variable length arrays, but we don't use
those; it also expands to more text).

Then use that macro to make MIN/MAX only evaluate their argument
once; this uses type promotion (by adding to 0) to work around
the fact that typeof(bitfield) won't compile.  However, we are
unable to work around gcc refusing to compile ({}) in a constant
context, even when only used in the dead branch of a
__builtin_choose_expr(), so we have to provide a second macro
pair MIN_CONST and MAX_CONST for use when both arguments are
known to be compile-time constants and where the result must
also be usable in constant contexts.

Fix the resulting callsites that compute a compile-time constant
min or max to use the new macros.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Force use of our smart macros, and make macro handle bitfields,
constant expressions, and older compilers [Zoltan]
---
 hw/usb/hcd-xhci.h       |  2 +-
 include/exec/cpu-defs.h |  2 +-
 include/qemu/compiler.h | 10 +++++++++
 include/qemu/osdep.h    | 46 ++++++++++++++++++++++++++++++++++-------
 migration/qemu-file.c   |  2 +-
 5 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fc36a4c787c..10beee9a7b1 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -210,7 +210,7 @@ struct XHCIState {
     uint32_t dcbaap_high;
     uint32_t config;

-    USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
+    USBPort  uports[MAX_CONST(MAXPORTS_2, MAXPORTS_3)];
     XHCIPort ports[MAXPORTS];
     XHCISlot slots[MAXSLOTS];
     uint32_t numports;
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 6a60f94a41d..5b2fd46f687 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -90,7 +90,7 @@ typedef uint64_t target_ulong;
  * of tlb_table inside env (which is non-trivial but not huge).
  */
 #define CPU_TLB_BITS                                             \
-    MIN(8,                                                       \
+    MIN_CONST(8,                                                 \
         TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
         (NB_MMU_MODES <=3D 1 ? 0 :                                 \
          NB_MMU_MODES <=3D 2 ? 1 :                                 \
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 261842beae2..3bf6f68a6b0 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -191,4 +191,14 @@
 #define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x=
, __VA_ARGS__))
 #define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(=
x, __VA_ARGS__))

+/*
+ * Automatic type deduction, to be used as:
+ * QEMU_TYPEOF(expr) name =3D expr;
+ */
+#if QEMU_GNUC_PREREQ(4, 9)
+# define QEMU_TYPEOF(a) __auto_type
+#else
+# define QEMU_TYPEOF(a) typeof(a)
+#endif
+
 #endif /* COMPILER_H */
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bcdec0..821ce627f73 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -232,18 +232,48 @@ extern int daemon(int, int);
 #define SIZE_MAX ((size_t)-1)
 #endif

-#ifndef MIN
-#define MIN(a, b) (((a) < (b)) ? (a) : (b))
-#endif
-#ifndef MAX
-#define MAX(a, b) (((a) > (b)) ? (a) : (b))
-#endif
+/*
+ * Two variations of MIN/MAX macros. The first is for runtime use, and
+ * evaluates arguments only once (so it is safe even with side
+ * effects), but will not work in constant contexts (such as array
+ * size declarations).  The second is for compile-time use, where
+ * evaluating arguments twice is safe because the result is going to
+ * be constant anyway.
+ */
+#undef MIN
+#define MIN(a, b)                            \
+    ({                                       \
+        QEMU_TYPEOF((a) + 0) _a =3D (a) + 0;   \
+        QEMU_TYPEOF((b) + 0) _b =3D (b) + 0;   \
+        _a < _b ? _a : _b;                   \
+    })
+#define MIN_CONST(a, b)                                         \
+    __builtin_choose_expr(                                      \
+        __builtin_constant_p(a) && __builtin_constant_p(b),     \
+        (a) < (b) ? (a) : (b),                                  \
+        __builtin_unreachable())
+#undef MAX
+#define MAX(a, b)                            \
+    ({                                       \
+        QEMU_TYPEOF((a) + 0) _a =3D (a) + 0;   \
+        QEMU_TYPEOF((b) + 0) _b =3D (b) + 0;   \
+        _a > _b ? _a : _b;                   \
+    })
+#define MAX_CONST(a, b)                                         \
+    __builtin_choose_expr(                                      \
+        __builtin_constant_p(a) && __builtin_constant_p(b),     \
+        (a) > (b) ? (a) : (b),                                  \
+        __builtin_unreachable())

 /* Minimum function that returns zero only iff both values are zero.
  * Intended for use with unsigned values only. */
 #ifndef MIN_NON_ZERO
-#define MIN_NON_ZERO(a, b) ((a) =3D=3D 0 ? (b) : \
-                                ((b) =3D=3D 0 ? (a) : (MIN(a, b))))
+#define MIN_NON_ZERO(a, b)                              \
+    ({                                                  \
+        QEMU_TYPEOF((a) + 0) _a =3D (a) + 0;              \
+        QEMU_TYPEOF((b) + 0) _b =3D (b) + 0;              \
+        _a =3D=3D 0 ? _b : (_b =3D=3D 0 || _b > _a) ? _a : _b;  \
+    })
 #endif

 /* Round number down to multiple */
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 977b9ae07c1..9746cbec0f3 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -31,7 +31,7 @@
 #include "trace.h"

 #define IO_BUF_SIZE 32768
-#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
+#define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)

 struct QEMUFile {
     const QEMUFileOps *ops;
--=20
2.20.1
