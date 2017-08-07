Received: from eggs.gnu.org ([2001:4830:134:3::10]:48755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIu-00079h-6J
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIf-0003mi-0e
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:48 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:21 +0200
Message-Id: <1502117160-24655-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 17/56] migration: Make MigrationStats sizes
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes should use QAPI type 'size' (uint64_t).  MigrationStats members
@transferred, @remaining, @total, @normal-bytes, @page-size are 'int'
(int64_t).  populate_ram_info(), populate_disk_info() and and many
places that update them in global variable @ram_counters implicitly
convert from unsigned types.

Change these MigrationStats members to 'size'.

query-migrate now reports them correctly above 2^63-1 instead of their
(negative) two's complement.

HMP's "info migrate" already reported them correctly, because it
printed the signed integer with PRIu64.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 4a3d07e..2eee676 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -620,11 +620,11 @@
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
-  'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
+  'data': {'transferred': 'size', 'remaining': 'size', 'total': 'size' ,
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
-           'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
+           'normal-bytes': 'size', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int', 'page-size' : 'int' } }
+           'postcopy-requests' : 'int', 'page-size' : 'size' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.7.5
