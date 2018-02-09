Received: from eggs.gnu.org ([2001:4830:134:3::10]:56709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEjC-0001Lb-1i
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEj8-0002zD-7L
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ekEj8-0002yp-2D
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:54 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Feb 2018 20:52:39 +0100
Message-Id: <20180209195239.16048-4-david@redhat.com>
In-Reply-To: <20180209195239.16048-1-david@redhat.com>
References: <20180209195239.16048-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/3] cpus: CPU threads are always created
 initially for one CPU only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

It can never happen for single-threaded TCG that we have more than one
CPU in the list, while the first one has not been marked as "created".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 cpus.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index 22ab15840f..2653a89e88 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1383,11 +1383,9 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
 
-    CPU_FOREACH(cpu) {
-        cpu->thread_id = qemu_get_thread_id();
-        cpu->created = true;
-        cpu->can_do_io = 1;
-    }
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->created = true;
+    cpu->can_do_io = 1;
     qemu_cond_signal(&qemu_cpu_cond);
 
     /* wait for initial kick-off after machine start */
-- 
2.14.3
