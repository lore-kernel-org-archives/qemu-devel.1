Received: from eggs.gnu.org ([209.51.188.92]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyv-0008ED-MA
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyt-0003pN-0c
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUys-0003XU-Dd
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:38 -0500
Date: Tue, 15 Jan 2019 15:06:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-46-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 45/49] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

GCC 8 introduced the -Wstringop-truncation checker to detect truncation b=
y
the strncat and strncpy functions (closely related to -Wstringop-overflow=
,
which detect buffer overflow by string-modifying functions declared in
<string.h>).

In tandem of -Wstringop-truncation, the "nonstring" attribute was added:

  The nonstring variable attribute specifies that an object or member
  declaration with type array of char, signed char, or unsigned char,
  or pointer to such a type is intended to store character arrays that
  do not necessarily contain a terminating NUL. This is useful in detecti=
ng
  uses of such arrays or pointers with functions that expect NUL-terminat=
ed
  strings, and to avoid warnings when such an array or pointer is used as
  an argument to a bounded string manipulation function such as strncpy.

  From the GCC manual: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable=
-Attributes.html#index-nonstring-variable-attribute

Add the QEMU_NONSTRING macro which checks if the compiler supports this
attribute.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/compiler.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 261842beae..2d8f507c73 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -151,6 +151,21 @@
 # define QEMU_ERROR(X)
 #endif
=20
+/*
+ * The nonstring variable attribute specifies that an object or member
+ * declaration with type array of char or pointer to char is intended
+ * to store character arrays that do not necessarily contain a terminati=
ng
+ * NUL character. This is useful in detecting uses of such arrays or poi=
nters
+ * with functions that expect NUL-terminated strings, and to avoid warni=
ngs
+ * when such an array or pointer is used as an argument to a bounded str=
ing
+ * manipulation function such as strncpy.
+ */
+#if __has_attribute(nonstring)
+# define QEMU_NONSTRING __attribute__((nonstring))
+#else
+# define QEMU_NONSTRING
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
--=20
MST
