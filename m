Received: from eggs.gnu.org ([209.51.188.92]:56233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6H-0003mD-E0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6F-0004DR-Al
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCR6A-000475-Sp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:50 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  5 Apr 2019 16:49:34 +0100
Message-Id: <20190405154934.18664-3-dgilbert@redhat.com>
In-Reply-To: <20190405154934.18664-1-dgilbert@redhat.com>
References: <20190405154934.18664-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] migration: Fix migrate_set_parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, quintela@redhat.com, peterx@redhat.com

From: Juan Quintela <quintela@redhat.com>

Otherwise we are setting err twice, what is wrong and causes an abort.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190403114958.3705-2-quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.21.0
