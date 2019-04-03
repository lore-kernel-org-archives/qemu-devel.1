Received: from eggs.gnu.org ([209.51.188.92]:59201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeXF-0003qH-KA
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeXE-0002cc-Gx
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hBeXA-0002Jh-8i
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA904308FC23
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 11:51:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Apr 2019 13:49:58 +0200
Message-Id: <20190403114958.3705-9-quintela@redhat.com>
In-Reply-To: <20190403114958.3705-1-quintela@redhat.com>
References: <20190403114958.3705-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/8] multifd: rest of zlib compression (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

This is still a work in progress, but get everything sent as expected
and it is faster than the code that is already there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 06b25ac66d..1b3b88d711 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1118,7 +1118,41 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num =3D p->packet_num;
             uint32_t flags =3D p->flags;
=20
-            p->next_packet_size =3D used * qemu_target_page_size();
+            if (used) {
+                if (migrate_use_multifd_zlib()) {
+                    struct iovec *iov =3D p->pages->iov;
+                    z_stream *zs =3D &p->zs;
+                    uint32_t out_size =3D 0;
+                    int i;
+
+                    for (i =3D 0; i < used; i++ ) {
+                        uint32_t available =3D p->zbuff_len - out_size;
+                        int flush =3D Z_NO_FLUSH;
+
+                        if (i =3D=3D used  - 1) {
+                            flush =3D Z_SYNC_FLUSH;
+                        }
+
+                        zs->avail_in =3D iov[i].iov_len;
+                        zs->next_in =3D iov[i].iov_base;
+
+                        zs->avail_out =3D available;
+                        zs->next_out =3D p->zbuff + out_size;
+
+                        ret =3D deflate(zs, flush);
+                        if (ret !=3D Z_OK) {
+                            printf("problem with deflate? %d\n", ret);
+                            qemu_mutex_unlock(&p->mutex);
+                            break;
+                        }
+                        out_size +=3D available - zs->avail_out;
+                    }
+                    p->next_packet_size =3D out_size;
+                } else {
+                    p->next_packet_size =3D used * qemu_target_page_size=
();
+                }
+            }
+
             multifd_send_fill_packet(p);
             p->flags =3D 0;
             p->num_packets++;
@@ -1136,8 +1170,13 @@ static void *multifd_send_thread(void *opaque)
             }
=20
             if (used) {
-                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
-                                             used, &local_err);
+                if (migrate_use_multifd_zlib()) {
+                    ret =3D qio_channel_write_all(p->c, (void *)p->zbuff=
,
+                                               p->next_packet_size, &loc=
al_err);
+                } else {
+                    ret =3D qio_channel_writev_all(p->c, p->pages->iov,
+                                                 used, &local_err);
+                }
                 if (ret !=3D 0) {
                     break;
                 }
@@ -1384,8 +1423,52 @@ static void *multifd_recv_thread(void *opaque)
         qemu_mutex_unlock(&p->mutex);
=20
         if (used) {
-            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
-                                        used, &local_err);
+            uint32_t in_size =3D p->next_packet_size;
+            uint32_t out_size =3D 0;
+            uint32_t expected_size =3D used * qemu_target_page_size();
+            int i;
+
+            if (migrate_use_multifd_zlib()) {
+                z_stream *zs =3D &p->zs;
+
+                ret =3D qio_channel_read_all(p->c, (void *)p->zbuff,
+                                           in_size, &local_err);
+
+                if (ret !=3D 0) {
+                    break;
+                }
+
+                zs->avail_in =3D in_size;
+                zs->next_in =3D p->zbuff;
+
+                for (i =3D 0; i < used; i++ ) {
+                    struct iovec *iov =3D &p->pages->iov[i];
+                    int flush =3D Z_NO_FLUSH;
+
+                    if (i =3D=3D used  - 1) {
+                        flush =3D Z_SYNC_FLUSH;
+                    }
+
+                    zs->avail_out =3D iov->iov_len;
+                    zs->next_out =3D iov->iov_base;
+
+                    ret =3D inflate(zs, flush);
+                    if (ret !=3D Z_OK) {
+                        printf("%d: problem with inflate? %d\n", p->id, =
ret);
+                        qemu_mutex_unlock(&p->mutex);
+                        break;
+                    }
+                    out_size +=3D iov->iov_len;
+                }
+                if (out_size !=3D expected_size) {
+                    printf("out size %d expected size %d\n",
+                           out_size, expected_size);
+                    break;
+                }
+            } else {
+                ret =3D qio_channel_readv_all(p->c, p->pages->iov,
+                                            used, &local_err);
+            }
             if (ret !=3D 0) {
                 break;
             }
--=20
2.20.1
