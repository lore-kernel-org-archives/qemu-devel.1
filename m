Received: from eggs.gnu.org ([209.51.188.92]:51283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSf-00004v-EC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSe-0000Um-FY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1h3LSe-0000US-7Q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20190311135923euoutp016c07d9da816abb9b5a0391593bbebd94~K7DvbAwJe1017010170euoutp01Y
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:59:23 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 11 Mar 2019 16:58:49 +0300
Message-Id: <20190311135850.6537-4-i.maximets@samsung.com>
In-Reply-To: <20190311135850.6537-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20190311135850.6537-1-i.maximets@samsung.com>
	<CGME20190311135922eucas1p2e131e72beea41ae584761ea5a62a948c@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/4] memfd: set up correct errno if not
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

qemu_memfd_create() prints the value of 'errno' which is not
set in this case.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/memfd.c b/util/memfd.c
index d74ce4d793..393d23da96 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -40,6 +40,7 @@ static int memfd_create(const char *name, unsigned int =
flags)
 #ifdef __NR_memfd_create
     return syscall(__NR_memfd_create, name, flags);
 #else
+    errno =3D ENOSYS;
     return -1;
 #endif
 }
--=20
2.17.1
