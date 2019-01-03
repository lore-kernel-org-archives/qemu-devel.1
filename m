Received: from eggs.gnu.org ([208.118.235.92]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyoX-0003CZ-Bx
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyoU-00015w-H7
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geyoU-0000u8-9P
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DEE9142BEF
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 08:56:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 09:56:34 +0100
Message-Id: <20190103085638.17600-2-philmd@redhat.com>
In-Reply-To: <20190103085638.17600-1-philmd@redhat.com>
References: <20190103085638.17600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/5] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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
v4: reordered the commit description to make sens (eblake)

Note this trigger the following checkpatch warning (patchew)
which I'm ignoring because this is consistent with how the
rest of this file uses:

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
