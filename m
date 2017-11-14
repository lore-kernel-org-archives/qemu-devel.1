Received: from eggs.gnu.org ([2001:4830:134:3::10]:60843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEkXN-0006pP-1m
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEkXM-0006An-5s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:22:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 15 Nov 2017 00:22:23 +0100
Message-Id: <20171114232223.25207-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] util/stats64: Fix min/max comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

stat64_min_slow() and stat64_max_slow() compare the wrong way.  This
makes iotest 136 fail with clang and -m32.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 util/stats64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/stats64.c b/util/stats64.c
index 9968fcceac..389c365a9e 100644
--- a/util/stats64.c
+++ b/util/stats64.c
@@ -91,7 +91,7 @@ bool stat64_min_slow(Stat64 *s, uint64_t value)
     low = atomic_read(&s->low);
 
     orig = ((uint64_t)high << 32) | low;
-    if (orig < value) {
+    if (value < orig) {
         /* We have to set low before high, just like stat64_min reads
          * high before low.  The value may become higher temporarily, but
          * stat64_get does not notice (it takes the lock) and the only ill
@@ -120,7 +120,7 @@ bool stat64_max_slow(Stat64 *s, uint64_t value)
     low = atomic_read(&s->low);
 
     orig = ((uint64_t)high << 32) | low;
-    if (orig > value) {
+    if (value > orig) {
         /* We have to set low before high, just like stat64_max reads
          * high before low.  The value may become lower temporarily, but
          * stat64_get does not notice (it takes the lock) and the only ill
-- 
2.13.6
