Received: from eggs.gnu.org ([2001:4830:134:3::10]:60689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqZGT-00076K-7A
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqZGP-0000hF-UT
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:33:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqZGP-0000gx-Ny
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:33:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 17 Aug 2018 09:33:33 +0200
Message-Id: <1534491213-24748-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] qom: Rename object_new_with_props to
 object_new_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

While adding the object_initialize_child() function, Paolo suggested
to rename the similar object_new_with_props() function accordingly:

http://marc.info/?i=e034610d-9a1d-a8a5-ee92-b2e3f0ba2891@redhat.com

This way it is more obvious that this function creates a new object
as a child of another object.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/auxbus.c                 |  4 +--
 include/crypto/tlscredsanon.h    |  4 +--
 include/crypto/tlscredspsk.h     |  4 +--
 include/crypto/tlscredsx509.h    |  4 +--
 include/qom/object.h             | 44 +++++++++++++--------------
 iothread.c                       |  6 ++--
 qom/object.c                     | 22 +++++++-------
 tests/check-qom-proplist.c       | 66 +++++++++++++++++++---------------------
 tests/test-crypto-block.c        |  2 +-
 tests/test-crypto-secret.c       | 44 +++++++++++++--------------
 tests/test-crypto-tlscredsx509.c |  2 +-
 tests/test-crypto-tlssession.c   |  4 +--
 tests/test-io-channel-tls.c      |  2 +-
 ui/vnc.c                         | 28 ++++++++---------
 14 files changed, 116 insertions(+), 120 deletions(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 0e56d9a..c3729e5 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -67,8 +67,8 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
     Object *auxtoi2c;
 
     bus = AUX_BUS(qbus_create(TYPE_AUX_BUS, parent, name));
-    auxtoi2c = object_new_with_props(TYPE_AUXTOI2C, OBJECT(bus), "i2c",
-                                     &error_abort, NULL);
+    auxtoi2c = object_new_child(TYPE_AUXTOI2C, OBJECT(bus), "i2c",
+                                &error_abort, NULL);
     qdev_set_parent_bus(DEVICE(auxtoi2c), BUS(bus));
 
     bus->bridge = AUXTOI2C(auxtoi2c);
diff --git a/include/crypto/tlscredsanon.h b/include/crypto/tlscredsanon.h
index 4d6b7e4..7cfa03f 100644
--- a/include/crypto/tlscredsanon.h
+++ b/include/crypto/tlscredsanon.h
@@ -41,14 +41,14 @@ typedef struct QCryptoTLSCredsAnonClass QCryptoTLSCredsAnonClass;
  * due to lacking MITM attack protection amongst other problems.
  *
  * This is a user creatable object, which can be instantiated
- * via object_new_propv():
+ * via object_new_child():
  *
  * <example>
  *   <title>Creating anonymous TLS credential objects in code</title>
  *   <programlisting>
  *   Object *obj;
  *   Error *err = NULL;
- *   obj = object_new_propv(TYPE_QCRYPTO_TLS_CREDS_ANON,
+ *   obj = object_new_child(TYPE_QCRYPTO_TLS_CREDS_ANON,
  *                          "tlscreds0",
  *                          &err,
  *                          "endpoint", "server",
diff --git a/include/crypto/tlscredspsk.h b/include/crypto/tlscredspsk.h
index 306d36c..781ac56 100644
--- a/include/crypto/tlscredspsk.h
+++ b/include/crypto/tlscredspsk.h
@@ -39,14 +39,14 @@ typedef struct QCryptoTLSCredsPSKClass QCryptoTLSCredsPSKClass;
  * of the Pre-Shared Key credential used to perform a TLS handshake.
  *
  * This is a user creatable object, which can be instantiated
- * via object_new_propv():
+ * via object_new_child():
  *
  * <example>
  *   <title>Creating TLS-PSK credential objects in code</title>
  *   <programlisting>
  *   Object *obj;
  *   Error *err = NULL;
- *   obj = object_new_propv(TYPE_QCRYPTO_TLS_CREDS_PSK,
+ *   obj = object_new_child(TYPE_QCRYPTO_TLS_CREDS_PSK,
  *                          "tlscreds0",
  *                          &err,
  *                          "dir", "/path/to/dir",
diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.h
index 66ad6a7..d0ef017 100644
--- a/include/crypto/tlscredsx509.h
+++ b/include/crypto/tlscredsx509.h
@@ -45,14 +45,14 @@ typedef struct QCryptoTLSCredsX509Class QCryptoTLSCredsX509Class;
  * of x509 credentials used to perform a TLS handshake.
  *
  * This is a user creatable object, which can be instantiated
- * via object_new_propv():
+ * via object_new_child():
  *
  * <example>
  *   <title>Creating x509 TLS credential objects in code</title>
  *   <programlisting>
  *   Object *obj;
  *   Error *err = NULL;
- *   obj = object_new_propv(TYPE_QCRYPTO_TLS_CREDS_X509,
+ *   obj = object_new_child(TYPE_QCRYPTO_TLS_CREDS_X509,
  *                          "tlscreds0",
  *                          &err,
  *                          "endpoint", "server",
diff --git a/include/qom/object.h b/include/qom/object.h
index f0b0bf3..88f9b59 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -609,7 +609,7 @@ struct InterfaceClass
 Object *object_new(const char *typename);
 
 /**
- * object_new_with_props:
+ * object_new_child:
  * @typename:  The name of the type of the object to instantiate.
  * @parent: the parent object
  * @id: The unique ID of the object
@@ -635,15 +635,15 @@ Object *object_new(const char *typename);
  *   Error *err = NULL;
  *   Object *obj;
  *
- *   obj = object_new_with_props(TYPE_MEMORY_BACKEND_FILE,
- *                               object_get_objects_root(),
- *                               "hostmem0",
- *                               &err,
- *                               "share", "yes",
- *                               "mem-path", "/dev/shm/somefile",
- *                               "prealloc", "yes",
- *                               "size", "1048576",
- *                               NULL);
+ *   obj = object_new_child(TYPE_MEMORY_BACKEND_FILE,
+ *                          object_get_objects_root(),
+ *                          "hostmem0",
+ *                          &err,
+ *                          "share", "yes",
+ *                          "mem-path", "/dev/shm/somefile",
+ *                          "prealloc", "yes",
+ *                          "size", "1048576",
+ *                          NULL);
  *
  *   if (!obj) {
  *     g_printerr("Cannot create memory backend: %s\n",
@@ -657,27 +657,27 @@ Object *object_new(const char *typename);
  *
  * Returns: The newly allocated, instantiated & initialized object.
  */
-Object *object_new_with_props(const char *typename,
-                              Object *parent,
-                              const char *id,
-                              Error **errp,
-                              ...) QEMU_SENTINEL;
+Object *object_new_child(const char *typename,
+                         Object *parent,
+                         const char *id,
+                         Error **errp,
+                         ...) QEMU_SENTINEL;
 
 /**
- * object_new_with_propv:
+ * object_new_childv:
  * @typename:  The name of the type of the object to instantiate.
  * @parent: the parent object
  * @id: The unique ID of the object
  * @errp: pointer to error object
  * @vargs: list of property names and values
  *
- * See object_new_with_props() for documentation.
+ * See object_new_child() for documentation.
  */
-Object *object_new_with_propv(const char *typename,
-                              Object *parent,
-                              const char *id,
-                              Error **errp,
-                              va_list vargs);
+Object *object_new_childv(const char *typename,
+                          Object *parent,
+                          const char *id,
+                          Error **errp,
+                          va_list vargs);
 
 /**
  * object_set_props:
diff --git a/iothread.c b/iothread.c
index aff1281..02dfeaa 100644
--- a/iothread.c
+++ b/iothread.c
@@ -363,9 +363,9 @@ IOThread *iothread_create(const char *id, Error **errp)
 {
     Object *obj;
 
-    obj = object_new_with_props(TYPE_IOTHREAD,
-                                object_get_internal_root(),
-                                id, errp, NULL);
+    obj = object_new_child(TYPE_IOTHREAD,
+                           object_get_internal_root(),
+                           id, errp, NULL);
 
     return IOTHREAD(obj);
 }
diff --git a/qom/object.c b/qom/object.c
index 75d1d48..aa3074a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -557,28 +557,28 @@ Object *object_new(const char *typename)
 }
 
 
-Object *object_new_with_props(const char *typename,
-                              Object *parent,
-                              const char *id,
-                              Error **errp,
-                              ...)
+Object *object_new_child(const char *typename,
+                         Object *parent,
+                         const char *id,
+                         Error **errp,
+                         ...)
 {
     va_list vargs;
     Object *obj;
 
     va_start(vargs, errp);
-    obj = object_new_with_propv(typename, parent, id, errp, vargs);
+    obj = object_new_childv(typename, parent, id, errp, vargs);
     va_end(vargs);
 
     return obj;
 }
 
 
-Object *object_new_with_propv(const char *typename,
-                              Object *parent,
-                              const char *id,
-                              Error **errp,
-                              va_list vargs)
+Object *object_new_childv(const char *typename,
+                          Object *parent,
+                          const char *id,
+                          Error **errp,
+                          va_list vargs)
 {
     Object *obj;
     ObjectClass *klass;
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 92898e1..b11ddf6 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -344,14 +344,14 @@ static void test_dummy_createv(void)
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
-                              parent,
-                              "dummy0",
-                              &err,
-                              "bv", "yes",
-                              "sv", "Hiss hiss hiss",
-                              "av", "platypus",
-                              NULL));
+        object_new_child(TYPE_DUMMY,
+                         parent,
+                         "dummy0",
+                         &err,
+                         "bv", "yes",
+                         "sv", "Hiss hiss hiss",
+                         "av", "platypus",
+                         NULL));
 
     g_assert(err == NULL);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
@@ -373,11 +373,7 @@ static Object *new_helper(Error **errp,
     Object *obj;
 
     va_start(vargs, parent);
-    obj = object_new_with_propv(TYPE_DUMMY,
-                                parent,
-                                "dummy0",
-                                errp,
-                                vargs);
+    obj = object_new_childv(TYPE_DUMMY, parent, "dummy0", errp, vargs);
     va_end(vargs);
     return obj;
 }
@@ -452,14 +448,14 @@ static void test_dummy_badenum(void)
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     Object *dobj =
-        object_new_with_props(TYPE_DUMMY,
-                              parent,
-                              "dummy0",
-                              &err,
-                              "bv", "yes",
-                              "sv", "Hiss hiss hiss",
-                              "av", "yeti",
-                              NULL);
+        object_new_child(TYPE_DUMMY,
+                         parent,
+                         "dummy0",
+                         &err,
+                         "bv", "yes",
+                         "sv", "Hiss hiss hiss",
+                         "av", "yeti",
+                          NULL);
 
     g_assert(dobj == NULL);
     g_assert(err != NULL);
@@ -479,7 +475,7 @@ static void test_dummy_getenum(void)
     int val;
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
+        object_new_child(TYPE_DUMMY,
                          parent,
                          "dummy0",
                          &err,
@@ -521,14 +517,14 @@ static void test_dummy_iterator(void)
 {
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
-                              parent,
-                              "dummy0",
-                              &error_abort,
-                              "bv", "yes",
-                              "sv", "Hiss hiss hiss",
-                              "av", "platypus",
-                              NULL));
+        object_new_child(TYPE_DUMMY,
+                         parent,
+                         "dummy0",
+                         &error_abort,
+                         "bv", "yes",
+                         "sv", "Hiss hiss hiss",
+                         "av", "platypus",
+                         NULL));
 
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
@@ -563,11 +559,11 @@ static void test_dummy_delchild(void)
 {
     Object *parent = object_get_objects_root();
     DummyDev *dev = DUMMY_DEV(
-        object_new_with_props(TYPE_DUMMY_DEV,
-                              parent,
-                              "dev0",
-                              &error_abort,
-                              NULL));
+        object_new_child(TYPE_DUMMY_DEV,
+                         parent,
+                         "dev0",
+                         &error_abort,
+                         NULL));
 
     object_unparent(OBJECT(dev));
 }
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index fd29a04..6e14c47 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -239,7 +239,7 @@ static ssize_t test_block_write_func(QCryptoBlock *block,
 
 static Object *test_block_secret(void)
 {
-    return object_new_with_props(
+    return object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
index 13fc6c4..335bd3d 100644
--- a/tests/test-crypto-secret.c
+++ b/tests/test-crypto-secret.c
@@ -27,7 +27,7 @@
 
 static void test_secret_direct(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -58,7 +58,7 @@ static void test_secret_indirect_good(void)
 
     g_assert(write(fd, "123456", 6) == 6);
 
-    sec = object_new_with_props(
+    sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -81,7 +81,7 @@ static void test_secret_indirect_good(void)
 
 static void test_secret_indirect_badfile(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -104,7 +104,7 @@ static void test_secret_indirect_emptyfile(void)
     g_assert(fd >= 0);
     g_assert_nonnull(fname);
 
-    sec = object_new_with_props(
+    sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -127,7 +127,7 @@ static void test_secret_indirect_emptyfile(void)
 
 static void test_secret_noconv_base64_good(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -148,7 +148,7 @@ static void test_secret_noconv_base64_good(void)
 
 static void test_secret_noconv_base64_bad(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -163,7 +163,7 @@ static void test_secret_noconv_base64_bad(void)
 
 static void test_secret_noconv_utf8(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -184,7 +184,7 @@ static void test_secret_noconv_utf8(void)
 
 static void test_secret_conv_base64_utf8valid(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -205,7 +205,7 @@ static void test_secret_conv_base64_utf8valid(void)
 
 static void test_secret_conv_base64_utf8invalid(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -224,7 +224,7 @@ static void test_secret_conv_base64_utf8invalid(void)
 
 static void test_secret_conv_utf8_base64(void)
 {
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -244,7 +244,7 @@ static void test_secret_conv_utf8_base64(void)
 
 static void test_secret_crypt_raw(void)
 {
-    Object *master = object_new_with_props(
+    Object *master = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "master",
@@ -252,7 +252,7 @@ static void test_secret_crypt_raw(void)
         "data", "9miloPQCzGy+TL6aonfzVcptibCmCIhKzrnlfwiWivk=",
         "format", "base64",
         NULL);
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -277,7 +277,7 @@ static void test_secret_crypt_raw(void)
 
 static void test_secret_crypt_base64(void)
 {
-    Object *master = object_new_with_props(
+    Object *master = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "master",
@@ -285,7 +285,7 @@ static void test_secret_crypt_base64(void)
         "data", "9miloPQCzGy+TL6aonfzVcptibCmCIhKzrnlfwiWivk=",
         "format", "base64",
         NULL);
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -309,7 +309,7 @@ static void test_secret_crypt_base64(void)
 
 static void test_secret_crypt_short_key(void)
 {
-    Object *master = object_new_with_props(
+    Object *master = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "master",
@@ -317,7 +317,7 @@ static void test_secret_crypt_short_key(void)
         "data", "9miloPQCzGy+TL6aonfzVc",
         "format", "base64",
         NULL);
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -335,7 +335,7 @@ static void test_secret_crypt_short_key(void)
 
 static void test_secret_crypt_short_iv(void)
 {
-    Object *master = object_new_with_props(
+    Object *master = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "master",
@@ -343,7 +343,7 @@ static void test_secret_crypt_short_iv(void)
         "data", "9miloPQCzGy+TL6aonfzVcptibCmCIhKzrnlfwiWivk=",
         "format", "base64",
         NULL);
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -361,7 +361,7 @@ static void test_secret_crypt_short_iv(void)
 
 static void test_secret_crypt_missing_iv(void)
 {
-    Object *master = object_new_with_props(
+    Object *master = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "master",
@@ -369,7 +369,7 @@ static void test_secret_crypt_missing_iv(void)
         "data", "9miloPQCzGy+TL6aonfzVcptibCmCIhKzrnlfwiWivk=",
         "format", "base64",
         NULL);
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
@@ -386,7 +386,7 @@ static void test_secret_crypt_missing_iv(void)
 
 static void test_secret_crypt_bad_iv(void)
 {
-    Object *master = object_new_with_props(
+    Object *master = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "master",
@@ -394,7 +394,7 @@ static void test_secret_crypt_bad_iv(void)
         "data", "9miloPQCzGy+TL6aonfzVcptibCmCIhKzrnlfwiWivk=",
         "format", "base64",
         NULL);
-    Object *sec = object_new_with_props(
+    Object *sec = object_new_child(
         TYPE_QCRYPTO_SECRET,
         object_get_objects_root(),
         "sec0",
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx509.c
index 30f9ac4..19d8aa0 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -42,7 +42,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
                                               Error **errp)
 {
     Object *parent = object_get_objects_root();
-    Object *creds = object_new_with_props(
+    Object *creds = object_new_child(
         TYPE_QCRYPTO_TLS_CREDS_X509,
         parent,
         "testtlscreds",
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 6fa9950..6e4c268 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -55,7 +55,7 @@ static QCryptoTLSCreds *test_tls_creds_psk_create(
     const char *dir)
 {
     Object *parent = object_get_objects_root();
-    Object *creds = object_new_with_props(
+    Object *creds = object_new_child(
         TYPE_QCRYPTO_TLS_CREDS_PSK,
         parent,
         (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
@@ -187,7 +187,7 @@ static QCryptoTLSCreds *test_tls_creds_x509_create(
     const char *certdir)
 {
     Object *parent = object_get_objects_root();
-    Object *creds = object_new_with_props(
+    Object *creds = object_new_child(
         TYPE_QCRYPTO_TLS_CREDS_X509,
         parent,
         (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 4900c6d..2118b61 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -68,7 +68,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
                                               const char *certdir)
 {
     Object *parent = object_get_objects_root();
-    Object *creds = object_new_with_props(
+    Object *creds = object_new_child(
         TYPE_QCRYPTO_TLS_CREDS_X509,
         parent,
         (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
diff --git a/ui/vnc.c b/ui/vnc.c
index 3596932..4e1cefa 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3536,21 +3536,21 @@ vnc_display_create_creds(bool x509,
     Error *err = NULL;
 
     if (x509) {
-        creds = object_new_with_props(TYPE_QCRYPTO_TLS_CREDS_X509,
-                                      parent,
-                                      credsid,
-                                      &err,
-                                      "endpoint", "server",
-                                      "dir", dir,
-                                      "verify-peer", x509verify ? "yes" : "no",
-                                      NULL);
+        creds = object_new_child(TYPE_QCRYPTO_TLS_CREDS_X509,
+                                 parent,
+                                 credsid,
+                                 &err,
+                                 "endpoint", "server",
+                                 "dir", dir,
+                                 "verify-peer", x509verify ? "yes" : "no",
+                                  NULL);
     } else {
-        creds = object_new_with_props(TYPE_QCRYPTO_TLS_CREDS_ANON,
-                                      parent,
-                                      credsid,
-                                      &err,
-                                      "endpoint", "server",
-                                      NULL);
+        creds = object_new_child(TYPE_QCRYPTO_TLS_CREDS_ANON,
+                                 parent,
+                                 credsid,
+                                 &err,
+                                 "endpoint", "server",
+                                 NULL);
     }
 
     g_free(credsid);
-- 
1.8.3.1
