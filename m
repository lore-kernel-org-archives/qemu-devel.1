Received: from eggs.gnu.org ([209.51.188.92]:40005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gwkl4-0002zM-33
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gwkl3-0004Am-7a
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:35:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gwkl2-00048N-Vj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:35:09 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 21 Feb 2019 10:34:59 +0100
Message-Id: <20190221093459.22547-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] include/exec/helper-head.h: support "const
 void *" in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

Especially when dealing with out-of-line gvec helpers, it is often
helpful to specify some vector pointers as constant. E.g. when
we have two inputs and one output, marking the two inputs as consts
pointers helps to avoid bugs.

Const pointers can be specified via "cptr", however behave in TCG just
like ordinary pointers. We can specify helpers like:

DEF_HELPER_FLAGS_4(gvec_vbperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)

void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
                         uint32_t desc)

And make sure that here, only v1 will be written (as long as const is
not casted away, of course).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/helper-head.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index ab4f8b6623..f2519c9741 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -30,6 +30,7 @@
 #define dh_alias_f32 i32
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
+#define dh_alias_cptr ptr
 #define dh_alias_void void
 #define dh_alias_noreturn noreturn
 #define dh_alias(t) glue(dh_alias_, t)
@@ -43,6 +44,7 @@
 #define dh_ctype_f32 float32
 #define dh_ctype_f64 float64
 #define dh_ctype_ptr void *
+#define dh_ctype_cptr const void *
 #define dh_ctype_void void
 #define dh_ctype_noreturn void QEMU_NORETURN
 #define dh_ctype(t) dh_ctype_##t
@@ -88,6 +90,7 @@
 #define dh_is_64bit_i32 0
 #define dh_is_64bit_i64 1
 #define dh_is_64bit_ptr (sizeof(void *) == 8)
+#define dh_is_64bit_cptr dh_is_64bit_ptr
 #define dh_is_64bit(t) glue(dh_is_64bit_, dh_alias(t))
 
 #define dh_is_signed_void 0
@@ -105,6 +108,7 @@
    extension instructions that may be required, e.g. ia64's addp4.  But
    for now we don't support any 64-bit targets with 32-bit pointers.  */
 #define dh_is_signed_ptr 0
+#define dh_is_signed_cptr dh_is_signed_ptr
 #define dh_is_signed_env dh_is_signed_ptr
 #define dh_is_signed(t) dh_is_signed_##t
 
@@ -117,6 +121,7 @@
 #define dh_callflag_f32  0
 #define dh_callflag_f64  0
 #define dh_callflag_ptr  0
+#define dh_callflag_cptr dh_callflag_ptr
 #define dh_callflag_void 0
 #define dh_callflag_noreturn TCG_CALL_NO_RETURN
 #define dh_callflag(t) glue(dh_callflag_, dh_alias(t))
-- 
2.17.2
