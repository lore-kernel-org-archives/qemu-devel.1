Received: from eggs.gnu.org ([2001:4830:134:3::10]:58241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1fRSlF-00031W-1o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 21:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1fRSlB-0000W6-T8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 21:33:45 -0400
Received: from mail-oln040092253044.outbound.protection.outlook.com
	([40.92.253.44]:24271
	helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1fRSlB-0000Vn-3y
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 21:33:41 -0400
From: Junyan He <junyan.he@hotmail.com>
Date: Sat, 9 Jun 2018 01:33:34 +0000
Message-ID: <HK2PR06MB05318383D2F67399327FF63EEB7A0@HK2PR06MB0531.apcprd06.prod.outlook.com>
References: <1528506751-8719-1-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1528506751-8719-1-git-send-email-junyan.he@gmx.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 RESEND 7/7] migration/ram: ensure write
 persistence on loading all data to PMEM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "junyan.he@gmx.com" <junyan.he@gmx.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, Junyan He <junyan.he@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

Sorry missed dgilbert's comment about RAMBLOCK_FOREACH_MIGRATABLE in previo=
us revision.

________________________________
From: Qemu-devel <qemu-devel-bounces+junyan.he=3Dgmx.com@nongnu.org> on beh=
alf of junyan.he@gmx.com <junyan.he@gmx.com>
Sent: Saturday, June 9, 2018 1:12:31 AM
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com; crosthwaite.peter@gmail.com; mst@redhat.c=
om; dgilbert@redhat.com; ehabkost@redhat.com; quintela@redhat.com; Junyan H=
e; stefanha@redhat.com; pbonzini@redhat.com; imammedo@redhat.com; rth@twidd=
le.net
Subject: [Qemu-devel] [PATCH V6 RESEND 7/7] migration/ram: ensure write per=
sistence on loading all data to PMEM.

From: Junyan He <junyan.he@intel.com>

Because we need to make sure the pmem kind memory data is synced
after migration, we choose to call pmem_persist() when the migration
finish. This will make sure the data of pmem is safe and will not
lose if power is off.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 include/qemu/pmem.h | 1 +
 migration/ram.c     | 8 ++++++++
 stubs/pmem.c        | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index 00d6680..8f52b08 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -17,6 +17,7 @@
 #else  /* !CONFIG_LIBPMEM */

 void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
+void pmem_persist(const void *addr, size_t len);

 #endif /* CONFIG_LIBPMEM */

diff --git a/migration/ram.c b/migration/ram.c
index aa0c6f0..15418c2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,6 +33,7 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "qemu/main-loop.h"
+#include "qemu/pmem.h"
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
@@ -3046,6 +3047,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
 static int ram_load_cleanup(void *opaque)
 {
     RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+        if (ramblock_is_pmem(rb)) {
+            pmem_persist(rb->host, rb->used_length);
+        }
+    }
+
     xbzrle_load_cleanup();
     compress_threads_load_cleanup();

diff --git a/stubs/pmem.c b/stubs/pmem.c
index b4ec72d..f794262 100644
--- a/stubs/pmem.c
+++ b/stubs/pmem.c
@@ -17,3 +17,7 @@ void *pmem_memcpy_persist(void *pmemdest, const void *src=
, size_t len)
 {
     return memcpy(pmemdest, src, len);
 }
+
+void pmem_persist(const void *addr, size_t len)
+{
+}
--
2.7.4
