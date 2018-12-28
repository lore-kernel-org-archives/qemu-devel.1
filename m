Received: from eggs.gnu.org ([208.118.235.92]:47710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwl0-0001GL-Fa
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 13:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwkI-0006zZ-Br
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 13:21:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gcw1j-0001Wc-G3
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:34:30 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 28 Dec 2018 18:33:52 +0100
Message-Id: <20181228173356.15359-2-philmd@redhat.com>
In-Reply-To: <20181228173356.15359-1-philmd@redhat.com>
References: <20181228173356.15359-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/5] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v4: reordered the commit description to make sens (eblake)

Note this trigger the following checkpatch warning (patchew):

  WARNING: architecture specific defines should be avoided
  #50: FILE: include/qemu/compiler.h:163:
  +#if __has_attribute(nonstring)
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
2.17.2
