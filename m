Received: from eggs.gnu.org ([2001:4830:134:3::10]:60998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Cz-0008Ob-6h
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Cy-0008Lw-I3
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6Cy-0008LO-Bj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:24 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7810D19D05F
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:53:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:52:02 +0400
Message-Id: <20170207135211.15870-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/28] tests: fix e1000e leaks
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
 tests/e1000e-test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 8c42ca919f..c612dc64ec 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -99,7 +99,10 @@ static QPCIBus *test_bus;
=20
 static void e1000e_pci_foreach_callback(QPCIDevice *dev, int devfn, void=
 *data)
 {
-    *(QPCIDevice **) data =3D dev;
+    QPCIDevice **res =3D data;
+
+    g_assert_null(*res);
+    *res =3D dev;
 }
=20
 static QPCIDevice *e1000e_device_find(QPCIBus *bus)
@@ -403,6 +406,7 @@ static void data_test_clear(e1000e_device *d)
     e1000e_device_clear(test_bus, d);
     close(test_sockets[0]);
     pc_alloc_uninit(test_alloc);
+    g_free(d->pci_dev);
     qpci_free_pc(test_bus);
     qtest_end();
 }
--=20
2.11.0.295.gd7dffce1c.dirty
