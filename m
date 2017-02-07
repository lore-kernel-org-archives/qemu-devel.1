Received: from eggs.gnu.org ([2001:4830:134:3::10]:60981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Cv-0008Kz-Ca
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Cu-0008KG-Mb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6Cu-0008K4-HC
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:20 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F22D6AAC5
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:53:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:52:01 +0400
Message-Id: <20170207135211.15870-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/28] tests: fix i440fx-test leaks
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
 tests/i440fx-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index da2d5a53f0..e9d05c87d1 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -134,6 +134,8 @@ static void test_i440fx_defaults(gconstpointer opaque=
)
     /* 3.2.26 */
     g_assert_cmpint(qpci_config_readb(dev, 0x93), =3D=3D, 0x00); /* TRC =
*/
=20
+    g_free(dev);
+    qpci_free_pc(bus);
     qtest_end();
 }
=20
@@ -270,6 +272,9 @@ static void test_i440fx_pam(gconstpointer opaque)
         /* Verify the area is not our new mask */
         g_assert(!verify_area(pam_area[i].start, pam_area[i].end, 0x82))=
;
     }
+
+    g_free(dev);
+    qpci_free_pc(bus);
     qtest_end();
 }
=20
--=20
2.11.0.295.gd7dffce1c.dirty
