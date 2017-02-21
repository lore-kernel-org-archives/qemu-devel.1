Received: from eggs.gnu.org ([2001:4830:134:3::10]:56198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEk-0001Yo-LV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEj-0004JJ-Gh
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBEj-0004Ii-7n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B7EAC05AA6F
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:16:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:38 +0400
Message-Id: <20170221141451.28305-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/30] tests: fix tco-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/tco-test.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/tco-test.c b/tests/tco-test.c
index ef02ec5903..c4c264eb3d 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -42,11 +42,18 @@ typedef struct {
     bool noreboot;
     QPCIDevice *dev;
     QPCIBar tco_io_bar;
+    QPCIBus *bus;
 } TestData;
=20
+static void test_end(TestData *d)
+{
+    g_free(d->dev);
+    qpci_free_pc(d->bus);
+    qtest_end();
+}
+
 static void test_init(TestData *d)
 {
-    QPCIBus *bus;
     QTestState *qs;
     char *s;
=20
@@ -57,8 +64,8 @@ static void test_init(TestData *d)
     qtest_irq_intercept_in(qs, "ioapic");
     g_free(s);
=20
-    bus =3D qpci_init_pc(NULL);
-    d->dev =3D qpci_device_find(bus, QPCI_DEVFN(0x1f, 0x00));
+    d->bus =3D qpci_init_pc(NULL);
+    d->dev =3D qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
     g_assert(d->dev !=3D NULL);
=20
     qpci_device_enable(d->dev);
@@ -148,7 +155,7 @@ static void test_tco_defaults(void)
                     SW_IRQ_GEN_DEFAULT);
     g_assert_cmpint(qpci_io_readw(d.dev, d.tco_io_bar, TCO_TMR), =3D=3D,
                     TCO_TMR_DEFAULT);
-    qtest_end();
+    test_end(&d);
 }
=20
 static void test_tco_timeout(void)
@@ -192,7 +199,7 @@ static void test_tco_timeout(void)
     g_assert(ret =3D=3D 1);
=20
     stop_tco(&d);
-    qtest_end();
+    test_end(&d);
 }
=20
 static void test_tco_max_timeout(void)
@@ -225,7 +232,7 @@ static void test_tco_max_timeout(void)
     g_assert(ret =3D=3D 1);
=20
     stop_tco(&d);
-    qtest_end();
+    test_end(&d);
 }
=20
 static QDict *get_watchdog_action(void)
@@ -262,7 +269,7 @@ static void test_tco_second_timeout_pause(void)
     QDECREF(ad);
=20
     stop_tco(&td);
-    qtest_end();
+    test_end(&td);
 }
=20
 static void test_tco_second_timeout_reset(void)
@@ -287,7 +294,7 @@ static void test_tco_second_timeout_reset(void)
     QDECREF(ad);
=20
     stop_tco(&td);
-    qtest_end();
+    test_end(&td);
 }
=20
 static void test_tco_second_timeout_shutdown(void)
@@ -312,7 +319,7 @@ static void test_tco_second_timeout_shutdown(void)
     QDECREF(ad);
=20
     stop_tco(&td);
-    qtest_end();
+    test_end(&td);
 }
=20
 static void test_tco_second_timeout_none(void)
@@ -337,7 +344,7 @@ static void test_tco_second_timeout_none(void)
     QDECREF(ad);
=20
     stop_tco(&td);
-    qtest_end();
+    test_end(&td);
 }
=20
 static void test_tco_ticks_counter(void)
@@ -365,7 +372,7 @@ static void test_tco_ticks_counter(void)
     } while (!(qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS) & TCO_TIMEOU=
T));
=20
     stop_tco(&d);
-    qtest_end();
+    test_end(&d);
 }
=20
 static void test_tco1_control_bits(void)
@@ -383,7 +390,7 @@ static void test_tco1_control_bits(void)
     qpci_io_writew(d.dev, d.tco_io_bar, TCO1_CNT, val);
     g_assert_cmpint(qpci_io_readw(d.dev, d.tco_io_bar, TCO1_CNT), =3D=3D=
,
                     TCO_LOCK);
-    qtest_end();
+    test_end(&d);
 }
=20
 static void test_tco1_status_bits(void)
@@ -412,7 +419,7 @@ static void test_tco1_status_bits(void)
     g_assert(ret =3D=3D 1);
     qpci_io_writew(d.dev, d.tco_io_bar, TCO1_STS, val);
     g_assert_cmpint(qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS), =3D=3D=
, 0);
-    qtest_end();
+    test_end(&d);
 }
=20
 static void test_tco2_status_bits(void)
@@ -439,7 +446,7 @@ static void test_tco2_status_bits(void)
     g_assert(ret =3D=3D 1);
     qpci_io_writew(d.dev, d.tco_io_bar, TCO2_STS, val);
     g_assert_cmpint(qpci_io_readw(d.dev, d.tco_io_bar, TCO2_STS), =3D=3D=
, 0);
-    qtest_end();
+    test_end(&d);
 }
=20
 int main(int argc, char **argv)
--=20
2.11.0.295.gd7dffce1c.dirty
