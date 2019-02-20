Received: from eggs.gnu.org ([209.51.188.92]:37051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUV-000719-Fh
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUR-0000nz-3P
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwQUQ-0000UU-Td
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEED63DE0B
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:56:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 12:56:04 +0100
Message-Id: <20190220115611.3192-2-quintela@redhat.com>
In-Reply-To: <20190220115611.3192-1-quintela@redhat.com>
References: <20190220115611.3192-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/8] multifd: Only send pages when packet
 are not empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

We send packages without pages sometimes for sysnchronizanion.  The
iov functions do the right thing, but we will be changing this code in
future patches.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 59191c1ed2..8b5fd67d66 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1025,9 +1025,12 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
=20
-            ret =3D qio_channel_writev_all(p->c, p->pages->iov, used, &l=
ocal_err);
-            if (ret !=3D 0) {
-                break;
+            if (used) {
+                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
+                                             used, &local_err);
+                if (ret !=3D 0) {
+                    break;
+                }
             }
=20
             qemu_mutex_lock(&p->mutex);
@@ -1254,9 +1257,12 @@ static void *multifd_recv_thread(void *opaque)
         p->num_pages +=3D used;
         qemu_mutex_unlock(&p->mutex);
=20
-        ret =3D qio_channel_readv_all(p->c, p->pages->iov, used, &local_=
err);
-        if (ret !=3D 0) {
-            break;
+        if (used) {
+            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
+                                        used, &local_err);
+            if (ret !=3D 0) {
+                break;
+            }
         }
=20
         if (flags & MULTIFD_FLAG_SYNC) {
--=20
2.20.1
