Received: from eggs.gnu.org ([209.51.188.92]:35169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyx5N-00006V-NX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyx5M-0002dK-7P
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gyx5L-0002bq-U6
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3391C820E9
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 11:09:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Feb 2019 12:08:09 +0100
Message-Id: <20190227110812.2185-6-quintela@redhat.com>
In-Reply-To: <20190227110812.2185-1-quintela@redhat.com>
References: <20190227110812.2185-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/8] multifd: Be flexible about packet size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

This way we can change the packet size in the future and everything
will work.  We choose an arbitrary big number (100 times configured
size) as a limit about how big we will reallocate.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e22d02760b..83025a7565 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -723,13 +723,13 @@ static void multifd_pages_clear(MultiFDPages_t *pag=
es)
 static void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet =3D p->packet;
-    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
+    uint32_t page_max =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
     int i;
=20
     packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
     packet->version =3D cpu_to_be32(MULTIFD_VERSION);
     packet->flags =3D cpu_to_be32(p->flags);
-    packet->pages_alloc =3D cpu_to_be32(page_count);
+    packet->pages_alloc =3D cpu_to_be32(page_max);
     packet->pages_used =3D cpu_to_be32(p->pages->used);
     packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
     packet->packet_num =3D cpu_to_be64(p->packet_num);
@@ -746,7 +746,7 @@ static void multifd_send_fill_packet(MultiFDSendParam=
s *p)
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp=
)
 {
     MultiFDPacket_t *packet =3D p->packet;
-    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
+    uint32_t pages_max =3D MULTIFD_PACKET_SIZE / qemu_target_page_size()=
;
     RAMBlock *block;
     int i;
=20
@@ -769,12 +769,24 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
     p->flags =3D be32_to_cpu(packet->flags);
=20
     packet->pages_alloc =3D be32_to_cpu(packet->pages_alloc);
-    if (packet->pages_alloc > page_count) {
+    /*
+     * If we recevied a packet that is 100 times bigger than expected
+     * just stop migration.  It is a magic number.
+     */
+    if (packet->pages_alloc > pages_max * 100) {
         error_setg(errp, "multifd: received packet "
-                   "with size %d and expected maximum size %d",
-                   packet->pages_alloc, page_count) ;
+                   "with size %d and expected a maximum size of %d",
+                   packet->pages_alloc, pages_max * 100) ;
         return -1;
     }
+    /*
+     * We received a packet that is bigger than expected but inside
+     * reasonable limits (see previous comment).  Just reallocate.
+     */
+    if (packet->pages_alloc > p->pages->allocated) {
+        multifd_pages_clear(p->pages);
+        multifd_pages_init(packet->pages_alloc);
+    }
=20
     p->pages->used =3D be32_to_cpu(packet->pages_used);
     if (p->pages->used > packet->pages_alloc) {
--=20
2.20.1
