Received: from eggs.gnu.org ([209.51.188.92]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0004vY-O3
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkl-0002LG-Kq
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:29 +1100
Message-Id: <20190226045304.25618-16-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/50] tests/device-plug: Add CCW unplug test
 for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

As CCW unplugs are surprise removals without asking the guest first,
we can test this without any guest interaction.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218092202.26683-5-david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/device-plug-test.c | 41 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
index cd9ada539d..d1a6c94af2 100644
--- a/tests/device-plug-test.c
+++ b/tests/device-plug-test.c
@@ -15,17 +15,26 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
-static void device_del_request(QTestState *qtest, const char *id)
+static void device_del_start(QTestState *qtest, const char *id)
 {
-    QDict *resp;
+    qtest_qmp_send(qtest,
+                   "{'execute': 'device_del', 'arguments': { 'id': %s } =
}", id);
+}
+
+static void device_del_finish(QTestState *qtest)
+{
+    QDict *resp =3D qtest_qmp_receive(qtest);
=20
-    resp =3D qtest_qmp(qtest,
-                     "{'execute': 'device_del', 'arguments': { 'id': %s =
} }",
-                     id);
     g_assert(qdict_haskey(resp, "return"));
     qobject_unref(resp);
 }
=20
+static void device_del_request(QTestState *qtest, const char *id)
+{
+    device_del_start(qtest, id);
+    device_del_finish(qtest);
+}
+
 static void system_reset(QTestState *qtest)
 {
     QDict *resp;
@@ -77,8 +86,25 @@ static void test_pci_unplug_request(void)
     qtest_quit(qtest);
 }
=20
+static void test_ccw_unplug(void)
+{
+    QTestState *qtest =3D qtest_initf("-device virtio-balloon-ccw,id=3Dd=
ev0");
+
+    /*
+     * The DEVICE_DELETED events will be sent before the command
+     * completes.
+     */
+    device_del_start(qtest, "dev0");
+    wait_device_deleted_event(qtest, "dev0");
+    device_del_finish(qtest);
+
+    qtest_quit(qtest);
+}
+
 int main(int argc, char **argv)
 {
+    const char *arch =3D qtest_get_arch();
+
     g_test_init(&argc, &argv, NULL);
=20
     /*
@@ -89,5 +115,10 @@ int main(int argc, char **argv)
     qtest_add_func("/device-plug/pci-unplug-request",
                    test_pci_unplug_request);
=20
+    if (!strcmp(arch, "s390x")) {
+        qtest_add_func("/device-plug/ccw-unplug",
+                       test_ccw_unplug);
+    }
+
     return g_test_run();
 }
--=20
2.20.1
