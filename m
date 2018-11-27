Received: from eggs.gnu.org ([2001:4830:134:3::10]:51309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbHD-0003Zw-8u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbH9-0004uo-Bx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRbH1-0004sK-T6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127111119euoutp01dc4e9e4c525817ad5b6a2f1dfec8bca9~q9rT6PSFW3199131991euoutp01E
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 11:11:19 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 14:10:49 +0300
Message-Id: <20181127111050.18453-4-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127111050.18453-1-i.maximets@samsung.com>
	<CGME20181127111118eucas1p1b76423fb92768a8501aea2a1dbb512fd@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] memfd: set up correct errno if not
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

qemu_memfd_create() prints the value of 'errno' which is not
set in this case.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
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
