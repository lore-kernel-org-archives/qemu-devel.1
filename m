Received: from eggs.gnu.org ([208.118.235.92]:36621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfRZp-0004C9-Tb
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfRZk-0003b6-BK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:40:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfRZk-0003ab-16
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:39:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC55F811DE
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 15:39:54 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-216.phx2.redhat.com [10.3.116.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B54F55D6A6
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 15:39:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  4 Jan 2019 09:39:51 -0600
Message-Id: <20190104153951.32306-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use the __auto_type keyword to make sure our min/max macros only
evaluate their arguments once.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

RFC because __auto_type didn't exist until gcc 4.9, and I don't know
which clang version introduced it (other than that it went in
during 2015: https://reviews.llvm.org/D12686).  Our minimum gcc
version is 4.8, which has typeof; I'm not sure if our minimum clang
version supports typeof.

I'm considering adding a snippet to compiler.h that looks like:

 #if .... // new enough gcc/clang
 #define QEMU_TYPEOF(a) __auto_type
 #else
 #define QEMU_TYPEOF(a) typeof(a)
 #endif

at which point we could blindly use QEMU_TYPEOF(a)=3D(a) anywhere we
need automatic typing, for the benefit of smaller macro expansion
[and proper handling of VLA types, although I don't think we use
those to care about that aspect of __auto_type] in newer compilers,
while still getting automatic type deduction in older compilers for
macros that want single evaluation, and where we've localized the
version checks to one spot instead of everywhere.  But for that to
work, again, I need to know whether typeof is supported in our
minimum clang version, and how to properly spell the version check
for clang on when to prefer __auto_type over typeof (at least I
know how to spell it for gcc).

While at it, the comments to MIN_NON_ZERO() state that callers should
only compare unsigned types; I suspect we don't actually obey that
rule, but I also think the comment is over-strict - the macro works
as long as both arguments are non-negative, and when called with a
mix of signed and unsigned types, as long as the type promotion
preserves the fact that the value is still non-negative.  But it
might be interesting to add compile-time checking (or maybe runtime
asserts) that the macro is indeed only used on non-negative values.

 include/qemu/osdep.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bcdec0..b941572b808 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -233,17 +233,31 @@ extern int daemon(int, int);
 #endif

 #ifndef MIN
-#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#define MIN(a, b)              \
+    ({                         \
+        __auto_type _a =3D (a);  \
+        __auto_type _b =3D (b);  \
+        _a < _b ? _a : _b;     \
+    })
 #endif
 #ifndef MAX
-#define MAX(a, b) (((a) > (b)) ? (a) : (b))
+#define MAX(a, b)              \
+    ({                         \
+        __auto_type _a =3D (a);  \
+        __auto_type _b =3D (b);  \
+        _a > _b ? _a : _b;     \
+    })
 #endif

 /* Minimum function that returns zero only iff both values are zero.
  * Intended for use with unsigned values only. */
 #ifndef MIN_NON_ZERO
-#define MIN_NON_ZERO(a, b) ((a) =3D=3D 0 ? (b) : \
-                                ((b) =3D=3D 0 ? (a) : (MIN(a, b))))
+#define MIN_NON_ZERO(a, b)                              \
+    ({                                                  \
+        __auto_type _a =3D (a);                           \
+        __auto_type _b =3D (b);                           \
+        _a =3D=3D 0 ? _b : (_b =3D=3D 0 || _b > _a) ? _a : _b;  \
+    })
 #endif

 /* Round number down to multiple */
--=20
2.20.1
