Received: from eggs.gnu.org ([2001:4830:134:3::10]:49638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVy3U-00078h-QF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVy3Q-0001e2-1x
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:10:24 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cVy3P-0001dx-Pe
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:10:19 -0500
Received: by mail-yb0-x243.google.com with SMTP id l23so12876445ybj.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 02:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-2-ale+qemu@clearmind.me>
In-Reply-To: <20170121084600.5860-2-ale+qemu@clearmind.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Jan 2017 10:10:08 +0000
Message-ID: <CAJ+F1CKqDZtyy3jXqTmk=juYAjm=8a-U4+_Pqtg3ikmQZ4BdvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] Factor out {linux, bsd}-user/qemu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Di Federico <ale+qemu@clearmind.me>, qemu-devel@nongnu.org

Hi

On Sat, Jan 21, 2017 at 12:46 PM Alessandro Di Federico <
ale+qemu@clearmind.me> wrote:

A quite large part of {linux,bsd}-user/qemu.h is shared, this patch
introduces qemu-user-common.h which factors it out. This shared part is
also the bare minimum required to build a linux-user-like target, and,
in particular, it will be useful for the libtcg targets.


Looks good. Probably worth to mention that the main difference is in commit
658f2dc970996d547a641b5685e384ebe6f2648e not being applied to bsd-user.

---
 bsd-user/qemu.h    | 193
+----------------------------------------------------
 linux-user/qemu.h  | 176 +-----------------------------------------------
 qemu-user-common.h | 180 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+), 367 deletions(-)
 create mode 100644 qemu-user-common.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 2b2b9184e0..b51319caf0 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -17,10 +17,8 @@
 #ifndef QEMU_H
 #define QEMU_H

-
-#include "cpu.h"
+#include "qemu-user-common.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"

 #undef DEBUG_REMAP
 #ifdef DEBUG_REMAP
@@ -217,195 +215,6 @@ void mmap_fork_end(int child);
 /* main.c */
 extern unsigned long x86_stack_size;

-/* user access */
-
-#define VERIFY_READ 0
-#define VERIFY_WRITE 1 /* implies read access */
-
-static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
-{
-    return page_check_range((target_ulong)addr, size,
-                            (type =3D=3D VERIFY_READ) ? PAGE_READ : (PAGE_=
READ
| PAGE_WRITE)) =3D=3D 0;
-}
-
-/* NOTE __get_user and __put_user use host pointers and don't check
access. */
-/* These are usually used to access struct data members once the
- * struct has been locked - usually with lock_user_struct().
- */
-#define __put_user(x, hptr)\
-({\
-    int size =3D sizeof(*hptr);\
-    switch(size) {\
-    case 1:\
-        *(uint8_t *)(hptr) =3D (uint8_t)(typeof(*hptr))(x);\
-        break;\
-    case 2:\
-        *(uint16_t *)(hptr) =3D tswap16((typeof(*hptr))(x));\
-        break;\
-    case 4:\
-        *(uint32_t *)(hptr) =3D tswap32((typeof(*hptr))(x));\
-        break;\
-    case 8:\
-        *(uint64_t *)(hptr) =3D tswap64((typeof(*hptr))(x));\
-        break;\
-    default:\
-        abort();\
-    }\
-    0;\
-})
-
-#define __get_user(x, hptr) \
-({\
-    int size =3D sizeof(*hptr);\
-    switch(size) {\
-    case 1:\
-        x =3D (typeof(*hptr))*(uint8_t *)(hptr);\
-        break;\
-    case 2:\
-        x =3D (typeof(*hptr))tswap16(*(uint16_t *)(hptr));\
-        break;\
-    case 4:\
-        x =3D (typeof(*hptr))tswap32(*(uint32_t *)(hptr));\
-        break;\
-    case 8:\
-        x =3D (typeof(*hptr))tswap64(*(uint64_t *)(hptr));\
-        break;\
-    default:\
-        /* avoid warning */\
-        x =3D 0;\
-        abort();\
-    }\
-    0;\
-})
-
-/* put_user()/get_user() take a guest address and check access */
-/* These are usually used to access an atomic data type, such as an int,
- * that has been passed by address.  These internally perform locking
- * and unlocking on the data type.
- */
-#define put_user(x, gaddr, target_type)                                 \
-({                                                                      \
-    abi_ulong __gaddr =3D (gaddr);                                        =
\
-    target_type *__hptr;                                                \
-    abi_long __ret;                                                     \
-    if ((__hptr =3D lock_user(VERIFY_WRITE, __gaddr, sizeof(target_type),
0))) { \
-        __ret =3D __put_user((x), __hptr);                                =
\
-        unlock_user(__hptr, __gaddr, sizeof(target_type));              \
-    } else                                                              \
-        __ret =3D -TARGET_EFAULT;                                         =
\
-    __ret;                                                              \
-})
-
-#define get_user(x, gaddr, target_type)                                 \
-({                                                                      \
-    abi_ulong __gaddr =3D (gaddr);                                        =
\
-    target_type *__hptr;                                                \
-    abi_long __ret;                                                     \
-    if ((__hptr =3D lock_user(VERIFY_READ, __gaddr, sizeof(target_type),
1))) { \
-        __ret =3D __get_user((x), __hptr);                                =
\
-        unlock_user(__hptr, __gaddr, 0);                                \
-    } else {                                                            \
-        /* avoid warning */                                             \
-        (x) =3D 0;                                                        =
\
-        __ret =3D -TARGET_EFAULT;                                         =
\
-    }                                                                   \
-    __ret;                                                              \
-})
-
-#define put_user_ual(x, gaddr) put_user((x), (gaddr), abi_ulong)
-#define put_user_sal(x, gaddr) put_user((x), (gaddr), abi_long)
-#define put_user_u64(x, gaddr) put_user((x), (gaddr), uint64_t)
-#define put_user_s64(x, gaddr) put_user((x), (gaddr), int64_t)
-#define put_user_u32(x, gaddr) put_user((x), (gaddr), uint32_t)
-#define put_user_s32(x, gaddr) put_user((x), (gaddr), int32_t)
-#define put_user_u16(x, gaddr) put_user((x), (gaddr), uint16_t)
-#define put_user_s16(x, gaddr) put_user((x), (gaddr), int16_t)
-#define put_user_u8(x, gaddr)  put_user((x), (gaddr), uint8_t)
-#define put_user_s8(x, gaddr)  put_user((x), (gaddr), int8_t)
-
-#define get_user_ual(x, gaddr) get_user((x), (gaddr), abi_ulong)
-#define get_user_sal(x, gaddr) get_user((x), (gaddr), abi_long)
-#define get_user_u64(x, gaddr) get_user((x), (gaddr), uint64_t)
-#define get_user_s64(x, gaddr) get_user((x), (gaddr), int64_t)
-#define get_user_u32(x, gaddr) get_user((x), (gaddr), uint32_t)
-#define get_user_s32(x, gaddr) get_user((x), (gaddr), int32_t)
-#define get_user_u16(x, gaddr) get_user((x), (gaddr), uint16_t)
-#define get_user_s16(x, gaddr) get_user((x), (gaddr), int16_t)
-#define get_user_u8(x, gaddr)  get_user((x), (gaddr), uint8_t)
-#define get_user_s8(x, gaddr)  get_user((x), (gaddr), int8_t)
-
-/* copy_from_user() and copy_to_user() are usually used to copy data
- * buffers between the target and host.  These internally perform
- * locking/unlocking of the memory.
- */
-abi_long copy_from_user(void *hptr, abi_ulong gaddr, size_t len);
-abi_long copy_to_user(abi_ulong gaddr, void *hptr, size_t len);
-
-/* Functions for accessing guest memory.  The tget and tput functions
-   read/write single values, byteswapping as necessary.  The lock_user
function
-   gets a pointer to a contiguous area of guest memory, but does not
perform
-   any byteswapping.  lock_user may return either a pointer to the guest
-   memory, or a temporary buffer.  */
-
-/* Lock an area of guest memory into the host.  If copy is true then the
-   host area will have the same contents as the guest.  */
-static inline void *lock_user(int type, abi_ulong guest_addr, long len,
int copy)
-{
-    if (!access_ok(type, guest_addr, len))
-        return NULL;
-#ifdef DEBUG_REMAP
-    {
-        void *addr;
-        addr =3D g_malloc(len);
-        if (copy)
-            memcpy(addr, g2h(guest_addr), len);
-        else
-            memset(addr, 0, len);
-        return addr;
-    }
-#else
-    return g2h(guest_addr);
-#endif
-}
-
-/* Unlock an area of guest memory.  The first LEN bytes must be
-   flushed back to guest memory. host_ptr =3D NULL is explicitly
-   allowed and does nothing. */
-static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
-                               long len)
-{
-
-#ifdef DEBUG_REMAP
-    if (!host_ptr)
-        return;
-    if (host_ptr =3D=3D g2h(guest_addr))
-        return;
-    if (len > 0)
-        memcpy(g2h(guest_addr), host_ptr, len);
-    g_free(host_ptr);
-#endif
-}
-
-/* Return the length of a string in target memory or -TARGET_EFAULT if
-   access error. */
-abi_long target_strlen(abi_ulong gaddr);
-
-/* Like lock_user but for null terminated strings.  */
-static inline void *lock_user_string(abi_ulong guest_addr)
-{
-    abi_long len;
-    len =3D target_strlen(guest_addr);
-    if (len < 0)
-        return NULL;
-    return lock_user(VERIFY_READ, guest_addr, (long)(len + 1), 1);
-}
-
-/* Helper macros for locking/unlocking a target struct.  */
-#define lock_user_struct(type, host_ptr, guest_addr, copy)      \
-    (host_ptr =3D lock_user(type, guest_addr, sizeof(*host_ptr), copy))
-#define unlock_user_struct(host_ptr, guest_addr, copy)          \
-    unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
-
 #if defined(CONFIG_USE_NPTL)
 #include <pthread.h>
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da73a01106..b56abb5942 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -2,9 +2,8 @@
 #define QEMU_H

 #include "hostdep.h"
-#include "cpu.h"
+#include "qemu-user-common.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"

 #undef DEBUG_REMAP
 #ifdef DEBUG_REMAP
@@ -436,179 +435,6 @@ void mmap_fork_end(int child);
 /* main.c */
 extern unsigned long guest_stack_size;

-/* user access */
-
-#define VERIFY_READ 0
-#define VERIFY_WRITE 1 /* implies read access */
-
-static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
-{
-    return page_check_range((target_ulong)addr, size,
-                            (type =3D=3D VERIFY_READ) ? PAGE_READ : (PAGE_=
READ
| PAGE_WRITE)) =3D=3D 0;
-}
-
-/* NOTE __get_user and __put_user use host pointers and don't check access=
.
-   These are usually used to access struct data members once the struct ha=
s
-   been locked - usually with lock_user_struct.  */
-
-/* Tricky points:
-   - Use __builtin_choose_expr to avoid type promotion from ?:,
-   - Invalid sizes result in a compile time error stemming from
-     the fact that abort has no parameters.
-   - It's easier to use the endian-specific unaligned load/store
-     functions than host-endian unaligned load/store plus tswapN.  */
-
-#define __put_user_e(x, hptr, e)                                        \
-  (__builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, stb_p,                 =
  \
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2, stw_##e##_p,           =
  \
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4, stl_##e##_p,           =
  \
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, stq_##e##_p, abort)))) =
  \
-     ((hptr), (x)), (void)0)
-
-#define __get_user_e(x, hptr, e)                                        \
-  ((x) =3D (typeof(*hptr))(                                               =
\
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, ldub_p,                =
  \
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2, lduw_##e##_p,          =
  \
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4, ldl_##e##_p,           =
  \
-   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, ldq_##e##_p, abort)))) =
  \
-     (hptr)), (void)0)
-
-#ifdef TARGET_WORDS_BIGENDIAN
-# define __put_user(x, hptr)  __put_user_e(x, hptr, be)
-# define __get_user(x, hptr)  __get_user_e(x, hptr, be)
-#else
-# define __put_user(x, hptr)  __put_user_e(x, hptr, le)
-# define __get_user(x, hptr)  __get_user_e(x, hptr, le)
-#endif
-
-/* put_user()/get_user() take a guest address and check access */
-/* These are usually used to access an atomic data type, such as an int,
- * that has been passed by address.  These internally perform locking
- * and unlocking on the data type.
- */
-#define put_user(x, gaddr, target_type)
    \
-({                                                                     \
-    abi_ulong __gaddr =3D (gaddr);                                       \
-    target_type *__hptr;                                               \
-    abi_long __ret =3D 0;
    \
-    if ((__hptr =3D lock_user(VERIFY_WRITE, __gaddr, sizeof(target_type),
0))) { \
-        __put_user((x), __hptr);                               \
-        unlock_user(__hptr, __gaddr, sizeof(target_type));             \
-    } else                                                             \
-        __ret =3D -TARGET_EFAULT;
    \
-    __ret;                                                             \
-})
-
-#define get_user(x, gaddr, target_type)
    \
-({                                                                     \
-    abi_ulong __gaddr =3D (gaddr);                                       \
-    target_type *__hptr;                                               \
-    abi_long __ret =3D 0;
    \
-    if ((__hptr =3D lock_user(VERIFY_READ, __gaddr, sizeof(target_type),
1))) { \
-        __get_user((x), __hptr);                               \
-        unlock_user(__hptr, __gaddr, 0);                               \
-    } else {                                                           \
-        /* avoid warning */                                            \
-        (x) =3D 0;                                                       \
-        __ret =3D -TARGET_EFAULT;
    \
-    }                                                                  \
-    __ret;                                                             \
-})
-
-#define put_user_ual(x, gaddr) put_user((x), (gaddr), abi_ulong)
-#define put_user_sal(x, gaddr) put_user((x), (gaddr), abi_long)
-#define put_user_u64(x, gaddr) put_user((x), (gaddr), uint64_t)
-#define put_user_s64(x, gaddr) put_user((x), (gaddr), int64_t)
-#define put_user_u32(x, gaddr) put_user((x), (gaddr), uint32_t)
-#define put_user_s32(x, gaddr) put_user((x), (gaddr), int32_t)
-#define put_user_u16(x, gaddr) put_user((x), (gaddr), uint16_t)
-#define put_user_s16(x, gaddr) put_user((x), (gaddr), int16_t)
-#define put_user_u8(x, gaddr)  put_user((x), (gaddr), uint8_t)
-#define put_user_s8(x, gaddr)  put_user((x), (gaddr), int8_t)
-
-#define get_user_ual(x, gaddr) get_user((x), (gaddr), abi_ulong)
-#define get_user_sal(x, gaddr) get_user((x), (gaddr), abi_long)
-#define get_user_u64(x, gaddr) get_user((x), (gaddr), uint64_t)
-#define get_user_s64(x, gaddr) get_user((x), (gaddr), int64_t)
-#define get_user_u32(x, gaddr) get_user((x), (gaddr), uint32_t)
-#define get_user_s32(x, gaddr) get_user((x), (gaddr), int32_t)
-#define get_user_u16(x, gaddr) get_user((x), (gaddr), uint16_t)
-#define get_user_s16(x, gaddr) get_user((x), (gaddr), int16_t)
-#define get_user_u8(x, gaddr)  get_user((x), (gaddr), uint8_t)
-#define get_user_s8(x, gaddr)  get_user((x), (gaddr), int8_t)
-
-/* copy_from_user() and copy_to_user() are usually used to copy data
- * buffers between the target and host.  These internally perform
- * locking/unlocking of the memory.
- */
-abi_long copy_from_user(void *hptr, abi_ulong gaddr, size_t len);
-abi_long copy_to_user(abi_ulong gaddr, void *hptr, size_t len);
-
-/* Functions for accessing guest memory.  The tget and tput functions
-   read/write single values, byteswapping as necessary.  The lock_user
function
-   gets a pointer to a contiguous area of guest memory, but does not
perform
-   any byteswapping.  lock_user may return either a pointer to the guest
-   memory, or a temporary buffer.  */
-
-/* Lock an area of guest memory into the host.  If copy is true then the
-   host area will have the same contents as the guest.  */
-static inline void *lock_user(int type, abi_ulong guest_addr, long len,
int copy)
-{
-    if (!access_ok(type, guest_addr, len))
-        return NULL;
-#ifdef DEBUG_REMAP
-    {
-        void *addr;
-        addr =3D g_malloc(len);
-        if (copy)
-            memcpy(addr, g2h(guest_addr), len);
-        else
-            memset(addr, 0, len);
-        return addr;
-    }
-#else
-    return g2h(guest_addr);
-#endif
-}
-
-/* Unlock an area of guest memory.  The first LEN bytes must be
-   flushed back to guest memory. host_ptr =3D NULL is explicitly
-   allowed and does nothing. */
-static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
-                               long len)
-{
-
-#ifdef DEBUG_REMAP
-    if (!host_ptr)
-        return;
-    if (host_ptr =3D=3D g2h(guest_addr))
-        return;
-    if (len > 0)
-        memcpy(g2h(guest_addr), host_ptr, len);
-    g_free(host_ptr);
-#endif
-}
-
-/* Return the length of a string in target memory or -TARGET_EFAULT if
-   access error. */
-abi_long target_strlen(abi_ulong gaddr);
-
-/* Like lock_user but for null terminated strings.  */
-static inline void *lock_user_string(abi_ulong guest_addr)
-{
-    abi_long len;
-    len =3D target_strlen(guest_addr);
-    if (len < 0)
-        return NULL;
-    return lock_user(VERIFY_READ, guest_addr, (long)(len + 1), 1);
-}
-
-/* Helper macros for locking/unlocking a target struct.  */
-#define lock_user_struct(type, host_ptr, guest_addr, copy)     \
-    (host_ptr =3D lock_user(type, guest_addr, sizeof(*host_ptr), copy))
-#define unlock_user_struct(host_ptr, guest_addr, copy)         \
-    unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
-
 #include <pthread.h>

 /* Include target-specific struct and function definitions;
diff --git a/qemu-user-common.h b/qemu-user-common.h
new file mode 100644
index 0000000000..349dd72fff
--- /dev/null
+++ b/qemu-user-common.h
@@ -0,0 +1,180 @@
+#ifndef QEMU_USER_COMMON_H
+#define QEMU_USER_COMMON_H
+
+#include "cpu.h"
+#include "exec/cpu_ldst.h"
+
+/* user access */
+
+#define VERIFY_READ 0
+#define VERIFY_WRITE 1 /* implies read access */
+
+static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
+{
+    return page_check_range((target_ulong)addr, size,
+                            (type =3D=3D VERIFY_READ) ? PAGE_READ : (PAGE_=
READ
| PAGE_WRITE)) =3D=3D 0;
+}
+
+/* NOTE __get_user and __put_user use host pointers and don't check access=
.
+   These are usually used to access struct data members once the struct ha=
s
+   been locked - usually with lock_user_struct.  */
+
+/* Tricky points:
+   - Use __builtin_choose_expr to avoid type promotion from ?:,
+   - Invalid sizes result in a compile time error stemming from
+     the fact that abort has no parameters.
+   - It's easier to use the endian-specific unaligned load/store
+     functions than host-endian unaligned load/store plus tswapN.  */
+
+#define __put_user_e(x, hptr, e)                                        \
+  (__builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, stb_p,                 =
  \
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2, stw_##e##_p,           =
  \
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4, stl_##e##_p,           =
  \
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, stq_##e##_p, abort)))) =
  \
+     ((hptr), (x)), (void)0)
+
+#define __get_user_e(x, hptr, e)                                        \
+  ((x) =3D (typeof(*hptr))(                                               =
\
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, ldub_p,                =
  \
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2, lduw_##e##_p,          =
  \
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4, ldl_##e##_p,           =
  \
+   __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, ldq_##e##_p, abort)))) =
  \
+     (hptr)), (void)0)
+
+#ifdef TARGET_WORDS_BIGENDIAN
+# define __put_user(x, hptr)  __put_user_e(x, hptr, be)
+# define __get_user(x, hptr)  __get_user_e(x, hptr, be)
+#else
+# define __put_user(x, hptr)  __put_user_e(x, hptr, le)
+# define __get_user(x, hptr)  __get_user_e(x, hptr, le)
+#endif
+
+/* put_user()/get_user() take a guest address and check access */
+/* These are usually used to access an atomic data type, such as an int,
+ * that has been passed by address.  These internally perform locking
+ * and unlocking on the data type.
+ */
+#define put_user(x, gaddr, target_type)
    \
+({                                                                     \
+    abi_ulong __gaddr =3D (gaddr);                                       \
+    target_type *__hptr;                                               \
+    abi_long __ret =3D 0;
    \
+    if ((__hptr =3D lock_user(VERIFY_WRITE, __gaddr, sizeof(target_type),
0))) { \
+        __put_user((x), __hptr);                               \
+        unlock_user(__hptr, __gaddr, sizeof(target_type));             \
+    } else                                                             \
+        __ret =3D -TARGET_EFAULT;
    \
+    __ret;                                                             \
+})
+
+#define get_user(x, gaddr, target_type)
    \
+({                                                                     \
+    abi_ulong __gaddr =3D (gaddr);                                       \
+    target_type *__hptr;                                               \
+    abi_long __ret =3D 0;
    \
+    if ((__hptr =3D lock_user(VERIFY_READ, __gaddr, sizeof(target_type),
1))) { \
+        __get_user((x), __hptr);                               \
+        unlock_user(__hptr, __gaddr, 0);                               \
+    } else {                                                           \
+        /* avoid warning */                                            \
+        (x) =3D 0;                                                       \
+        __ret =3D -TARGET_EFAULT;
    \
+    }                                                                  \
+    __ret;                                                             \
+})
+
+#define put_user_ual(x, gaddr) put_user((x), (gaddr), abi_ulong)
+#define put_user_sal(x, gaddr) put_user((x), (gaddr), abi_long)
+#define put_user_u64(x, gaddr) put_user((x), (gaddr), uint64_t)
+#define put_user_s64(x, gaddr) put_user((x), (gaddr), int64_t)
+#define put_user_u32(x, gaddr) put_user((x), (gaddr), uint32_t)
+#define put_user_s32(x, gaddr) put_user((x), (gaddr), int32_t)
+#define put_user_u16(x, gaddr) put_user((x), (gaddr), uint16_t)
+#define put_user_s16(x, gaddr) put_user((x), (gaddr), int16_t)
+#define put_user_u8(x, gaddr)  put_user((x), (gaddr), uint8_t)
+#define put_user_s8(x, gaddr)  put_user((x), (gaddr), int8_t)
+
+#define get_user_ual(x, gaddr) get_user((x), (gaddr), abi_ulong)
+#define get_user_sal(x, gaddr) get_user((x), (gaddr), abi_long)
+#define get_user_u64(x, gaddr) get_user((x), (gaddr), uint64_t)
+#define get_user_s64(x, gaddr) get_user((x), (gaddr), int64_t)
+#define get_user_u32(x, gaddr) get_user((x), (gaddr), uint32_t)
+#define get_user_s32(x, gaddr) get_user((x), (gaddr), int32_t)
+#define get_user_u16(x, gaddr) get_user((x), (gaddr), uint16_t)
+#define get_user_s16(x, gaddr) get_user((x), (gaddr), int16_t)
+#define get_user_u8(x, gaddr)  get_user((x), (gaddr), uint8_t)
+#define get_user_s8(x, gaddr)  get_user((x), (gaddr), int8_t)
+
+/* copy_from_user() and copy_to_user() are usually used to copy data
+ * buffers between the target and host.  These internally perform
+ * locking/unlocking of the memory.
+ */
+abi_long copy_from_user(void *hptr, abi_ulong gaddr, size_t len);
+abi_long copy_to_user(abi_ulong gaddr, void *hptr, size_t len);
+
+/* Functions for accessing guest memory.  The tget and tput functions
+   read/write single values, byteswapping as necessary.  The lock_user
function
+   gets a pointer to a contiguous area of guest memory, but does not
perform
+   any byteswapping.  lock_user may return either a pointer to the guest
+   memory, or a temporary buffer.  */
+
+/* Lock an area of guest memory into the host.  If copy is true then the
+   host area will have the same contents as the guest.  */
+static inline void *lock_user(int type, abi_ulong guest_addr, long len,
int copy)
+{
+    if (!access_ok(type, guest_addr, len))
+        return NULL;
+#ifdef DEBUG_REMAP
+    {
+        void *addr;
+        addr =3D g_malloc(len);
+        if (copy)
+            memcpy(addr, g2h(guest_addr), len);
+        else
+            memset(addr, 0, len);
+        return addr;
+    }
+#else
+    return g2h(guest_addr);
+#endif
+}
+
+/* Unlock an area of guest memory.  The first LEN bytes must be
+   flushed back to guest memory. host_ptr =3D NULL is explicitly
+   allowed and does nothing. */
+static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
+                               long len)
+{
+
+#ifdef DEBUG_REMAP
+    if (!host_ptr)
+        return;
+    if (host_ptr =3D=3D g2h(guest_addr))
+        return;
+    if (len > 0)
+        memcpy(g2h(guest_addr), host_ptr, len);
+    g_free(host_ptr);
+#endif
+}
+
+/* Return the length of a string in target memory or -TARGET_EFAULT if
+   access error. */
+abi_long target_strlen(abi_ulong gaddr);
+
+/* Like lock_user but for null terminated strings.  */
+static inline void *lock_user_string(abi_ulong guest_addr)
+{
+    abi_long len;
+    len =3D target_strlen(guest_addr);
+    if (len < 0)
+        return NULL;
+    return lock_user(VERIFY_READ, guest_addr, (long)(len + 1), 1);
+}
+
+/* Helper macros for locking/unlocking a target struct.  */
+#define lock_user_struct(type, host_ptr, guest_addr, copy)     \
+    (host_ptr =3D lock_user(type, guest_addr, sizeof(*host_ptr), copy))
+#define unlock_user_struct(host_ptr, guest_addr, copy)         \
+    unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
+
+#endif /* QEMU_USER_COMMON_H */
--
2.11.0


--=20
Marc-Andr=C3=A9 Lureau
