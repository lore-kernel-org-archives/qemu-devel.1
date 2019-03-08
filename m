Received: from eggs.gnu.org ([209.51.188.92]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24O0-0002EZ-B4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24Ny-0000If-41
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:33:20 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:07 +0100
Message-Id: <20190308013222.12524-4-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/18] cutils: Add qemu_strdup_hexlify() and
 qemu_strdup_unhexlify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Add two helpers: one to represent a binary data as a string of
hexadecimal values, and one to restore a such string into its
original binary data.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/cutils.h | 33 ++++++++++++++++++++++++++
 util/cutils.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d2dad3057c..375a5508b0 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -171,6 +171,39 @@ bool test_buffer_is_zero_next_accel(void);
 int uleb128_encode_small(uint8_t *out, uint32_t n);
 int uleb128_decode_small(const uint8_t *in, uint32_t *n);
=20
+/**
+ * qemu_strdup_hexlify:
+ *
+ * Encode a sequence of binary data into its hexadecimal stringified
+ * representation.
+ *
+ * @ptr: Buffer to hexlify
+ * @size: Length of the buffer
+ *
+ * Use qemu_strdup_unhexlify() to convert the hex string to original dat=
a.
+ *
+ * Returns: A newly allocated, zero-terminated hex encoded string repres=
enting
+ * the data. The returned string must be freed with g_free().
+ */
+gchar *qemu_strdup_hexlify(gconstpointer ptr, gsize size);
+
+/**
+ * qemu_strdup_unhexlify:
+ *
+ * Decode a sequence of hexadecimal encoded text into binary data.
+ *
+ * @hex_string: String to unhexlify
+ * @out_size: if not NULL: gsize to be written with the data length
+ *
+ * This function is the opposite of qemu_strdup_hexlify().
+ *
+ * Returns: A newly allocated buffer containing the binary data that tex=
t
+ * represents. The returned buffer must be freed with g_free().
+ * Note that the returned binary data is not necessarily zero-terminated=
,
+ * so it should not be used as a character string.
+ */
+gpointer qemu_strdup_unhexlify(const gchar *hex_string, gsize *out_size)=
;
+
 /**
  * qemu_pstrcmp0:
  * @str1: a non-NULL pointer to a C string (*str1 can be NULL)
diff --git a/util/cutils.c b/util/cutils.c
index e098debdc0..bf324c0d8b 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -779,6 +779,61 @@ int uleb128_decode_small(const uint8_t *in, uint32_t=
 *n)
     }
 }
=20
+static guchar hexval(const gchar v)
+{
+    switch (v) {
+    case '0' ... '9':
+        return v - '0';
+    case 'A' ... 'F':
+        return v - 'A' + 10;
+    case 'a' ... 'f':
+        return v - 'a' + 10;
+    default:
+        return 0;
+    }
+}
+
+gchar *qemu_strdup_hexlify(gconstpointer ptr, gsize len)
+{
+    guchar *data =3D (guchar *)ptr;
+    gchar *hex_string;
+
+    if (!ptr || !len) {
+        return g_strdup("");
+    }
+
+    hex_string =3D g_malloc(2 * len + 1);
+    for (gsize i =3D 0; i < len; i++) {
+        g_snprintf(&hex_string[2 * i], 3, "%02x", data[i]);
+    }
+
+    return hex_string;
+}
+
+gpointer qemu_strdup_unhexlify(const gchar *hex_string, gsize *out_size)
+{
+    size_t size =3D 0;
+    guchar *data =3D NULL;
+
+    if (hex_string) {
+        size =3D strlen(hex_string) / 2;
+        if (size) {
+            size_t i;
+
+            data =3D g_new(guchar, size + 1);
+            for (i =3D 0; i < size; i++) {
+                data[i]  =3D hexval(*hex_string++) << 4;
+                data[i] |=3D hexval(*hex_string++);
+            }
+            data[i] =3D '\0';
+        }
+    }
+    if (out_size) {
+        *out_size =3D size;
+    }
+    return data;
+}
+
 /*
  * helper to parse debug environment variables
  */
--=20
2.20.1
