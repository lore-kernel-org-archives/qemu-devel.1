Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2i-0005tb-16
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2h-0000qH-8f
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:12 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:51 +0100
Message-Id: <20180215212552.26997-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] ahci-test: fix opts leak of skip tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Fixes the following ASAN report:

Direct leak of 128 byte(s) in 8 object(s) allocated from:
    #0 0x7fefce311850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7fefcdd5ef0c in g_malloc ../glib/gmem.c:94
    #2 0x559b976faff0 in create_ahci_io_test /home/elmarco/src/qemu/tests=
/ahci-test.c:1810

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/ahci-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 7aa5af428c..1bd3cc7ca8 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1822,6 +1822,7 @@ static void create_ahci_io_test(enum IOMode type, e=
num AddrMode addr,
     if ((addr =3D=3D ADDR_MODE_LBA48) && (offset =3D=3D OFFSET_HIGH) &&
         (mb_to_sectors(test_image_size_mb) <=3D 0xFFFFFFF)) {
         g_test_message("%s: skipped; test image too small", name);
+        g_free(opts);
         g_free(name);
         return;
     }
--=20
2.16.1.73.g5832b7e9f2
