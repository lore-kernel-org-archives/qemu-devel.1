Received: from eggs.gnu.org ([2001:4830:134:3::10]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSJ0-0008QS-Pq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIy-00010l-Kk
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIy-00010P-Fo
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnBw5132823
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k0gcs0cy0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:43 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:43 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:12 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180703205221.24788-6-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] test-qga: add trivial tests for some
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

These commands did not get their tests in the original commits:
- guest-get-host-name
- guest-get-timezone
- guest-get-users

Trivial tests that mostly only call the commands were added.

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
* replace QDECREF() with qobject_unref()
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/test-qga.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 54 insertions(+)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 30c9643257..350f27812a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -854,6 +854,54 @@ static void test_qga_guest_exec_invalid(gconstpointe=
r fix)
     qobject_unref(ret);
 }
=20
+static void test_qga_guest_get_host_name(gconstpointer fix)
+{
+    const TestFixture *fixture =3D fix;
+    QDict *ret, *val;
+
+    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-host-name'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    val =3D qdict_get_qdict(ret, "return");
+    g_assert(qdict_haskey(val, "host-name"));
+
+    qobject_unref(ret);
+}
+
+static void test_qga_guest_get_timezone(gconstpointer fix)
+{
+    const TestFixture *fixture =3D fix;
+    QDict *ret, *val;
+
+    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-timezone'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    /* Make sure there's at least offset */
+    val =3D qdict_get_qdict(ret, "return");
+    g_assert(qdict_haskey(val, "offset"));
+
+    qobject_unref(ret);
+}
+
+static void test_qga_guest_get_users(gconstpointer fix)
+{
+    const TestFixture *fixture =3D fix;
+    QDict *ret;
+    QList *val;
+
+    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-users'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    /* There is not much to test here */
+    val =3D qdict_get_qlist(ret, "return");
+    g_assert_nonnull(val);
+
+    qobject_unref(ret);
+}
+
 static void test_qga_guest_get_osinfo(gconstpointer data)
 {
     TestFixture fixture;
@@ -946,6 +994,12 @@ int main(int argc, char **argv)
                          test_qga_guest_exec_invalid);
     g_test_add_data_func("/qga/guest-get-osinfo", &fix,
                          test_qga_guest_get_osinfo);
+    g_test_add_data_func("/qga/guest-get-host-name", &fix,
+                         test_qga_guest_get_host_name);
+    g_test_add_data_func("/qga/guest-get-timezone", &fix,
+                         test_qga_guest_get_timezone);
+    g_test_add_data_func("/qga/guest-get-users", &fix,
+                         test_qga_guest_get_users);
=20
     ret =3D g_test_run();
=20
--=20
2.11.0
