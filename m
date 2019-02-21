Received: from eggs.gnu.org ([209.51.188.92]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwtcB-0004gb-NA
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwtcA-0001yE-TY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:35 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwtcA-0001xq-NM
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:34 -0500
Received: by mail-pl1-x635.google.com with SMTP id p19so3387196plo.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:02:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 11:02:29 -0800
Message-Id: <20190221190229.22599-3-richard.henderson@linaro.org>
In-Reply-To: <20190221190229.22599-1-richard.henderson@linaro.org>
References: <20190221190229.22599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/2] include/exec/helper-head.h: support "const
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20190221093459.22547-1-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
