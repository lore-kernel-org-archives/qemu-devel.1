Received: from eggs.gnu.org ([2001:4830:134:3::10]:51650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEO-00084b-6N
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEJ-0004EQ-Dx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEJ-0004Dr-8n
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:51 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:26 +0100
Message-Id: <1543851204-41186-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/71] vhost-user-test: small changes to
 init_hugepagefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

After the conversion to qgraph, the equivalent of "main" will be in
a constructor and will run even if the tests are not being requested.
Therefore, it should not assert that init_hugepagefs succeeds and will
be called when creating the TestServer.  This patch changes the prototype
of init_hugepagefs, this way the next patch looks nicer.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 93d5157..a282fc5 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -461,13 +461,19 @@ static void chr_read(void *opaque, const uint8_t *b=
uf, int size)
     g_mutex_unlock(&s->data_mutex);
 }
=20
-static const char *init_hugepagefs(const char *path)
+static const char *init_hugepagefs(void)
 {
+    const char *path =3D getenv("QTEST_HUGETLBFS_PATH");
     struct statfs fs;
     int ret;
=20
+    if (!path) {
+        return NULL;
+    }
+
     if (access(path, R_OK | W_OK | X_OK)) {
         g_test_message("access on path (%s): %s\n", path, strerror(errno=
));
+        abort();
         return NULL;
     }
=20
@@ -477,11 +483,13 @@ static const char *init_hugepagefs(const char *path=
)
=20
     if (ret !=3D 0) {
         g_test_message("statfs on path (%s): %s\n", path, strerror(errno=
));
+        abort();
         return NULL;
     }
=20
     if (fs.f_type !=3D HUGETLBFS_MAGIC) {
         g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
+        abort();
         return NULL;
     }
=20
@@ -974,7 +982,6 @@ static void test_multiqueue(void)
=20
 int main(int argc, char **argv)
 {
-    const char *hugefs;
     int ret;
     char template[] =3D "/tmp/vhost-test-XXXXXX";
=20
@@ -989,13 +996,7 @@ int main(int argc, char **argv)
     }
     g_assert(tmpfs);
=20
-    hugefs =3D getenv("QTEST_HUGETLBFS_PATH");
-    if (hugefs) {
-        root =3D init_hugepagefs(hugefs);
-        g_assert(root);
-    } else {
-        root =3D tmpfs;
-    }
+    root =3D init_hugepagefs() ? : tmpfs;
=20
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
--=20
1.8.3.1
