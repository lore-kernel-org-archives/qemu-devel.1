Received: from eggs.gnu.org ([2001:4830:134:3::10]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdla-0002W7-Am
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlW-0000HC-Bq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:06 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRdlW-0000CJ-63
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:02 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127135100euoutp01fb9940a93c2de058ee2cd77efaea7227~q-2vApVGp2475424754euoutp01J
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:51:00 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 16:50:29 +0300
Message-Id: <20181127135030.1671-4-i.maximets@samsung.com>
In-Reply-To: <20181127135030.1671-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135059eucas1p2371079ab1d368d8d444d6a183719cfc7@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/4] memfd: set up correct errno if not
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

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
