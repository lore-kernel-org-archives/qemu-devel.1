Received: from eggs.gnu.org ([2001:4830:134:3::10]:33936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpj-0001u1-JB
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpi-0000N7-Vw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpi-0000MU-Pp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9A397C849
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:59:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:24 +0100
Message-Id: <20171116115926.16627-10-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] util/stats64: Fix min/max comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

stat64_min_slow() and stat64_max_slow() compare the wrong way.  This
makes iotest 136 fail with clang and -m32.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20171114232223.25207-1-mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.14.3
