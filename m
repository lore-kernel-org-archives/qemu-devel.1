Received: from eggs.gnu.org ([2001:4830:134:3::10]:55963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEM-0001Dd-K0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEH-00045K-It
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBEH-00044q-9k
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:45 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74B4CC05683F
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:15:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:31 +0400
Message-Id: <20170221141451.28305-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/30] tests: fix ide-test leaks
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
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/ide-test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index fb541f88b5..2fa97bc36b 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -339,6 +339,7 @@ static void test_bmdma_simple_rw(void)
     g_assert(memcmp(buf, cmpbuf, len) =3D=3D 0);
=20
=20
+    free_pci_device(dev);
     g_free(buf);
     g_free(cmpbuf);
 }
@@ -369,6 +370,7 @@ static void test_bmdma_short_prdt(void)
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, 0);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    free_pci_device(dev);
 }
=20
 static void test_bmdma_one_sector_short_prdt(void)
@@ -398,6 +400,7 @@ static void test_bmdma_one_sector_short_prdt(void)
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, 0);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    free_pci_device(dev);
 }
=20
 static void test_bmdma_long_prdt(void)
@@ -426,6 +429,7 @@ static void test_bmdma_long_prdt(void)
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    free_pci_device(dev);
 }
=20
 static void test_bmdma_no_busmaster(void)
@@ -449,6 +453,7 @@ static void test_bmdma_no_busmaster(void)
      * in practice. At least we want to be aware of any changes. */
     g_assert_cmphex(status, =3D=3D, BM_STS_ACTIVE | BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    free_pci_device(dev);
 }
=20
 static void test_bmdma_setup(void)
@@ -525,6 +530,7 @@ static void test_identify(void)
     assert_bit_set(buf[85], 0x20);
=20
     ide_test_quit();
+    free_pci_device(dev);
 }
=20
 /*
@@ -562,6 +568,7 @@ static void make_dirty(uint8_t device)
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
     g_free(buf);
+    free_pci_device(dev);
 }
=20
 static void test_flush(void)
@@ -608,6 +615,7 @@ static void test_flush(void)
     assert_bit_clear(data, BSY | DF | ERR | DRQ);
=20
     ide_test_quit();
+    free_pci_device(dev);
 }
=20
 static void test_retry_flush(const char *machine)
@@ -658,6 +666,7 @@ static void test_retry_flush(const char *machine)
     assert_bit_clear(data, BSY | DF | ERR | DRQ);
=20
     ide_test_quit();
+    free_pci_device(dev);
 }
=20
 static void test_flush_nodev(void)
@@ -675,6 +684,7 @@ static void test_flush_nodev(void)
=20
     /* Just testing that qemu doesn't crash... */
=20
+    free_pci_device(dev);
     ide_test_quit();
 }
=20
@@ -741,6 +751,7 @@ static uint8_t ide_wait_clear(uint8_t flag)
     while (true) {
         data =3D qpci_io_readb(dev, ide_bar, reg_status);
         if (!(data & flag)) {
+            free_pci_device(dev);
             return data;
         }
         if (difftime(time(NULL), st) > 5.0) {
@@ -850,6 +861,7 @@ static void cdrom_pio_impl(int nblocks)
     g_free(pattern);
     g_free(rx);
     test_bmdma_teardown();
+    free_pci_device(dev);
 }
=20
 static void test_cdrom_pio(void)
--=20
2.11.0.295.gd7dffce1c.dirty
