Received: from eggs.gnu.org ([2001:4830:134:3::10]:33089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlE5-0005Zr-6E
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlE2-00050B-1S
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlE1-0004zp-Rh
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B789916AE
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:22:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:10 +0200
Message-Id: <20181012002217.2864-5-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/11] chardev: Assert backend's
 chr_can_read() is positive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index e115166995..952f9c9bcc 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -159,12 +159,15 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, =
int len, bool write_all)
 int qemu_chr_be_can_write(Chardev *s)
 {
     CharBackend *be =3D s->be;
+    int res;
=20
     if (!be || !be->chr_can_read) {
         return 0;
     }
=20
-    return be->chr_can_read(be->opaque);
+    res =3D be->chr_can_read(be->opaque);
+    assert(res >=3D 0);
+    return res;
 }
=20
 void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len)
--=20
2.17.1
