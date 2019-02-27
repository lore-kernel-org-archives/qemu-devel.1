Received: from eggs.gnu.org ([209.51.188.92]:35144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyx5N-00006T-38
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyx5M-0002dA-76
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gyx5L-0002X8-VF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4862B8CC7
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 11:09:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Feb 2019 12:08:06 +0100
Message-Id: <20190227110812.2185-3-quintela@redhat.com>
In-Reply-To: <20190227110812.2185-1-quintela@redhat.com>
References: <20190227110812.2185-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/8] multifd: Rename "size" member to
 pages_alloc
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

It really indicates what is the number of allocated pages for one
packet.  Once there rename "used" to "pages_used".

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8b5fd67d66..29f0d431a8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -531,8 +531,9 @@ typedef struct {
     uint32_t magic;
     uint32_t version;
     uint32_t flags;
-    uint32_t size;
-    uint32_t used;
+    /* maximum number of allocated pages */
+    uint32_t pages_alloc;
+    uint32_t pages_used;
     uint64_t packet_num;
     char ramblock[256];
     uint64_t offset[];
@@ -718,8 +719,8 @@ static void multifd_send_fill_packet(MultiFDSendParam=
s *p)
     packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
     packet->version =3D cpu_to_be32(MULTIFD_VERSION);
     packet->flags =3D cpu_to_be32(p->flags);
-    packet->size =3D cpu_to_be32(migrate_multifd_page_count());
-    packet->used =3D cpu_to_be32(p->pages->used);
+    packet->pages_alloc =3D cpu_to_be32(migrate_multifd_page_count());
+    packet->pages_used =3D cpu_to_be32(p->pages->used);
     packet->packet_num =3D cpu_to_be64(p->packet_num);
=20
     if (p->pages->block) {
@@ -755,19 +756,19 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
=20
     p->flags =3D be32_to_cpu(packet->flags);
=20
-    packet->size =3D be32_to_cpu(packet->size);
-    if (packet->size > migrate_multifd_page_count()) {
+    packet->pages_alloc =3D be32_to_cpu(packet->pages_alloc);
+    if (packet->pages_alloc > migrate_multifd_page_count()) {
         error_setg(errp, "multifd: received packet "
                    "with size %d and expected maximum size %d",
-                   packet->size, migrate_multifd_page_count()) ;
+                   packet->pages_alloc, migrate_multifd_page_count()) ;
         return -1;
     }
=20
-    p->pages->used =3D be32_to_cpu(packet->used);
-    if (p->pages->used > packet->size) {
+    p->pages->used =3D be32_to_cpu(packet->pages_used);
+    if (p->pages->used > packet->pages_alloc) {
         error_setg(errp, "multifd: received packet "
-                   "with size %d and expected maximum size %d",
-                   p->pages->used, packet->size) ;
+                   "with %d pages and expected maximum pages are %d",
+                   p->pages->used, packet->pages_alloc) ;
         return -1;
     }
=20
--=20
2.20.1
