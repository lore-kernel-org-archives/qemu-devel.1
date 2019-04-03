Received: from eggs.gnu.org ([209.51.188.92]:59648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeYa-0004ou-OG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeYZ-0005FO-S6
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hBeYZ-0005D2-LL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA67C8553D
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 11:51:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Apr 2019 13:49:51 +0200
Message-Id: <20190403114958.3705-2-quintela@redhat.com>
In-Reply-To: <20190403114958.3705-1-quintela@redhat.com>
References: <20190403114958.3705-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/8] migration: Fix migrate_set_parameter
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

Otherwise we are setting err twice, what is wrong and causes an abort.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 92941142af..8eec768088 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1825,8 +1825,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
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
--=20
2.20.1
