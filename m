Received: from eggs.gnu.org ([209.51.188.92]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwUSE-0006GQ-E5
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwUSB-000792-Ln
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:10:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwUSB-0006ya-7G
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:10:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 424C273A91
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:58:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 13:57:55 +0100
Message-Id: <20190220125755.3906-4-quintela@redhat.com>
In-Reply-To: <20190220125755.3906-1-quintela@redhat.com>
References: <20190220125755.3906-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] multifd: Start of zlib compression code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is still work in progress.

It is already faster that normal compression code inside qemu.
It don't do any unnecesary copies.  And as packages are bigger, we get
better compression.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                  |  6 ++-
 migration/ram.c        | 96 ++++++++++++++++++++++++++++++++++++++++--
 migration/trace-events |  2 +-
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/hmp.c b/hmp.c
index abbd49ec17..7c1ad2376d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1789,8 +1789,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
-        if (err || cache_size > INT64_MAX
-            || (size_t)cache_size !=3D cache_size) {
+        if (err) {
+            break;
+        }
+        if (cache_size > INT64_MAX || (size_t)cache_size !=3D cache_size=
) {
             error_setg(&err, "Invalid size %s", valuestr);
             break;
         }
diff --git a/migration/ram.c b/migration/ram.c
index 7de27e1a35..feb857d395 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -519,6 +519,7 @@ exit:
 #define MULTIFD_VERSION 1
=20
 #define MULTIFD_FLAG_SYNC (1 << 0)
+#define MULTIFD_FLAG_ZLIB (1 << 1)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
@@ -1031,6 +1032,7 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
     Error *local_err =3D NULL;
+    z_stream *zs =3D &p->zs;
     int ret;
=20
     trace_multifd_send_thread_start(p->id);
@@ -1050,8 +1052,43 @@ static void *multifd_send_thread(void *opaque)
             uint32_t used =3D p->pages->used;
             uint64_t packet_num =3D p->packet_num;
             uint32_t flags =3D p->flags;
+            struct iovec *iov =3D p->pages->iov;
=20
             p->next_packet_size =3D used * qemu_target_page_size();
+
+            if (used && migrate_use_multifd_zlib()) {
+                uint32_t in_size =3D used * qemu_target_page_size();
+                uint32_t out_size =3D 0;
+                int i;
+
+                for (i =3D 0; i < used; i++ ) {
+                    uint32_t available =3D p->zbuff_len - out_size;
+                    int flush =3D Z_NO_FLUSH;
+
+                    if (i =3D=3D used  - 1) {
+                        flush =3D Z_SYNC_FLUSH;
+                    }
+
+                    zs->avail_in =3D iov[i].iov_len;
+                    zs->next_in =3D iov[i].iov_base;
+
+                    zs->avail_out =3D available;
+                    zs->next_out =3D p->zbuff + out_size;
+
+                    ret =3D deflate(zs, flush);
+                    if (ret !=3D Z_OK) {
+                        printf("problem with deflate? %d\n", ret);
+                        qemu_mutex_unlock(&p->mutex);
+                        break;
+                    }
+                    out_size +=3D available - zs->avail_out;
+                }
+                printf("%d deflate in %d out %d diff %d\n",
+                       p->id, in_size, out_size, in_size - out_size);
+
+                p->next_packet_size =3D out_size;
+            }
+
             multifd_send_fill_packet(p);
             p->flags =3D 0;
             p->num_packets++;
@@ -1069,8 +1106,13 @@ static void *multifd_send_thread(void *opaque)
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
@@ -1283,6 +1325,7 @@ static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p =3D opaque;
     Error *local_err =3D NULL;
+    z_stream *zs =3D &p->zs;
     int ret;
=20
     trace_multifd_recv_thread_start(p->id);
@@ -1317,8 +1360,53 @@ static void *multifd_recv_thread(void *opaque)
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
+
+                printf("%d: out_size =3D %d, in_size =3D %d, expected_si=
ze =3D %d avail_in: %d\n",
+                       p->id, out_size, in_size, expected_size, zs->avai=
l_in);
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
diff --git a/migration/trace-events b/migration/trace-events
index a11e66e1d9..8aaae32e67 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -77,7 +77,7 @@ get_queued_page_not_dirty(const char *block_name, uint6=
4_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet number %" PRIu64 " pag=
es %d flags 0x%x next packet size %d"
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %d"
 multifd_recv_sync_main_wait(uint8_t id) "channel %d"
--=20
2.20.1
