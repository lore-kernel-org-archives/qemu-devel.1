Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVO-0004mS-14
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVK-0006Cj-8B
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:46 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVK-0006C9-1g
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:42 -0500
Received: by mail-wm0-x242.google.com with SMTP id x7so22123216wmc.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:02 +0100
Message-Id: <1520342370-123606-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/34] cpus: CPU threads are always created
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

It can never happen for single-threaded TCG that we have more than one
CPU in the list, while the first one has not been marked as "created".

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180209195239.16048-4-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index bcfc0a4..9bcff7d 100644
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
1.8.3.1
