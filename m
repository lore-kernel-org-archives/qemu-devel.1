Received: from eggs.gnu.org ([2001:4830:134:3::10]:54703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2T-0008Mj-4R
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2S-0006u1-8S
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:17 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:33 +0100
Message-Id: <20171214171004.25058-16-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 15/46] s390x/tcg: use s390_program_interrupt()
 in SCLP Service Call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Now we can drop potential_page_fault(). While at it, move the
unlock further up, looks cleaner.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171130162744.25442-11-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 5 ++---
 target/s390x/translate.c   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 556340756c..02654617b3 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -62,11 +62,10 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
     qemu_mutex_lock_iothread();
     int r = sclp_service_call(env, r1, r2);
+    qemu_mutex_unlock_iothread();
     if (r < 0) {
-        program_interrupt(env, -r, 4);
-        r = 0;
+        s390_program_interrupt(env, -r, 4, GETPC());
     }
-    qemu_mutex_unlock_iothread();
     return r;
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d0859c4bc7..76b222b0ce 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3704,7 +3704,6 @@ static ExitStatus op_sqxb(DisasContext *s, DisasOps *o)
 static ExitStatus op_servc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_servc(cc_op, cpu_env, o->in2, o->in1);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.13.6
