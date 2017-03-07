Received: from eggs.gnu.org ([2001:4830:134:3::10]:33595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clGqq-0001gn-MG
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clGqn-0001k1-Hs
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1clGqn-0001jq-BL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:16:33 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  7 Mar 2017 09:16:27 -0600
Message-Id: <20170307151627.27212-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.9 v2] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, f4bug@amsat.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Comparison symbol is misused. It may lead to memory corruption.
Introduced in commit 7d3123e.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
[eblake: add CVE details, update conditional]
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
v2: use >=3D instead of >, fix R-b
---
 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 5c9dee3..3dc2564 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size)
     char small[1024];
     char *buffer;

-    buffer =3D sizeof(small) < size ? small : g_malloc(MIN(65536, size))=
;
+    buffer =3D sizeof(small) >=3D size ? small : g_malloc(MIN(65536, siz=
e));
     while (size > 0) {
         ssize_t count =3D read_sync(ioc, buffer, MIN(65536, size));

--=20
2.9.3
