Received: from eggs.gnu.org ([209.51.188.92]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUV-00071y-Mz
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUT-00010k-Qa
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwQUT-0000rV-95
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A322E6A9E
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:56:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 12:56:06 +0100
Message-Id: <20190220115611.3192-4-quintela@redhat.com>
In-Reply-To: <20190220115611.3192-1-quintela@redhat.com>
References: <20190220115611.3192-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/8] multifd: Create new next_packet_size
 field
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

We need to send this field when we add compression support.  As we are
still on x- stage, we can do this kind of changes.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 15 +++++++++++++--
 migration/trace-events |  4 ++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 29f0d431a8..26ed26fc2d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -534,6 +534,8 @@ typedef struct {
     /* maximum number of allocated pages */
     uint32_t pages_alloc;
     uint32_t pages_used;
+    /* size of the next packet that contains pages */
+    uint32_t next_packet_size;
     uint64_t packet_num;
     char ramblock[256];
     uint64_t offset[];
@@ -581,6 +583,8 @@ typedef struct {
     MultiFDPacket_t *packet;
     /* multifd flags for each packet */
     uint32_t flags;
+    /* size of the next packet that contains pages */
+    uint32_t next_packet_size;
     /* global number of generated multifd packets */
     uint64_t packet_num;
     /* thread local variables */
@@ -617,6 +621,8 @@ typedef struct {
     /* global number of generated multifd packets */
     uint64_t packet_num;
     /* thread local variables */
+    /* size of the next packet that contains pages */
+    uint32_t next_packet_size;
     /* packets sent through this channel */
     uint64_t num_packets;
     /* pages sent through this channel */
@@ -721,6 +727,7 @@ static void multifd_send_fill_packet(MultiFDSendParam=
s *p)
     packet->flags =3D cpu_to_be32(p->flags);
     packet->pages_alloc =3D cpu_to_be32(migrate_multifd_page_count());
     packet->pages_used =3D cpu_to_be32(p->pages->used);
+    packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
     packet->packet_num =3D cpu_to_be64(p->packet_num);
=20
     if (p->pages->block) {
@@ -772,6 +779,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvPara=
ms *p, Error **errp)
         return -1;
     }
=20
+    p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
     p->packet_num =3D be64_to_cpu(packet->packet_num);
=20
     if (p->pages->used) {
@@ -1011,6 +1019,7 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num =3D p->packet_num;
             uint32_t flags =3D p->flags;
=20
+            p->next_packet_size =3D used * qemu_target_page_size();
             multifd_send_fill_packet(p);
             p->flags =3D 0;
             p->num_packets++;
@@ -1018,7 +1027,8 @@ static void *multifd_send_thread(void *opaque)
             p->pages->used =3D 0;
             qemu_mutex_unlock(&p->mutex);
=20
-            trace_multifd_send(p->id, packet_num, used, flags);
+            trace_multifd_send(p->id, packet_num, used, flags,
+                               p->next_packet_size);
=20
             ret =3D qio_channel_write_all(p->c, (void *)p->packet,
                                         p->packet_len, &local_err);
@@ -1253,7 +1263,8 @@ static void *multifd_recv_thread(void *opaque)
=20
         used =3D p->pages->used;
         flags =3D p->flags;
-        trace_multifd_recv(p->id, p->packet_num, used, flags);
+        trace_multifd_recv(p->id, p->packet_num, used, flags,
+                           p->next_packet_size);
         p->num_packets++;
         p->num_pages +=3D used;
         qemu_mutex_unlock(&p->mutex);
diff --git a/migration/trace-events b/migration/trace-events
index bd2d0cd25a..a11e66e1d9 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -77,13 +77,13 @@ get_queued_page_not_dirty(const char *block_name, uin=
t64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags) "channel %d packet number %" PRIu64 " pages %d flags 0x%x"
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet number %" PRIu64 " pag=
es %d flags 0x%x next packet size %d"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %d"
 multifd_recv_sync_main_wait(uint8_t id) "channel %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "c=
hannel %d packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%d"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x"
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %d"
 multifd_send_sync_main_wait(uint8_t id) "channel %d"
--=20
2.20.1
