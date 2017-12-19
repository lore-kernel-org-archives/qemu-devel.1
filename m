Received: from eggs.gnu.org ([2001:4830:134:3::10]:60607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnl-0001iE-8L
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnk-00013i-6O
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:37 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:21 -0300
Message-Id: <20171219173425.8113-6-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/9] iotests: replace xrange() by range() for
 python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/044 | 14 +++++++-------
 tests/qemu-iotests/163 |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 11ea0f4d35..1e96800176 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -52,23 +52,23 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
             # Write a refcount table
             fd.seek(off_reftable)
 
-            for i in xrange(0, h.refcount_table_clusters):
+            for i in range(0, h.refcount_table_clusters):
                 sector = ''.join(struct.pack('>Q',
                     off_refblock + i * 64 * 512 + j * 512)
-                    for j in xrange(0, 64))
+                    for j in range(0, 64))
                 fd.write(sector)
 
             # Write the refcount blocks
             assert(fd.tell() == off_refblock)
-            sector = ''.join(struct.pack('>H', 1) for j in xrange(0, 64 * 256))
-            for block in xrange(0, h.refcount_table_clusters):
+            sector = ''.join(struct.pack('>H', 1) for j in range(0, 64 * 256))
+            for block in range(0, h.refcount_table_clusters):
                 fd.write(sector)
 
             # Write the L1 table
             assert(fd.tell() == off_l1)
             assert(off_l2 + 512 * h.l1_size == off_data)
             table = ''.join(struct.pack('>Q', (1 << 63) | off_l2 + 512 * j)
-                for j in xrange(0, h.l1_size))
+                for j in range(0, h.l1_size))
             fd.write(table)
 
             # Write the L2 tables
@@ -79,14 +79,14 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
             off = off_data
             while remaining > 1024 * 512:
                 pytable = list((1 << 63) | off + 512 * j
-                    for j in xrange(0, 1024))
+                    for j in range(0, 1024))
                 table = struct.pack('>1024Q', *pytable)
                 fd.write(table)
                 remaining = remaining - 1024 * 512
                 off = off + 1024 * 512
 
             table = ''.join(struct.pack('>Q', (1 << 63) | off + 512 * j)
-                for j in xrange(0, remaining / 512))
+                for j in range(0, remaining / 512))
             fd.write(table)
 
 
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 403842354e..fb0d0257ec 100644
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -41,7 +41,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         div_roundup = lambda n, d: (n + d - 1) / d
 
         def split_by_n(data, n):
-            for x in xrange(0, len(data), n):
+            for x in range(0, len(data), n):
                 yield struct.unpack('>Q', data[x:x + n])[0] & l1_mask
 
         def check_l1_table(h, l1_data):
-- 
2.15.1
