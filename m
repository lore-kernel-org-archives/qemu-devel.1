Received: from eggs.gnu.org ([2001:4830:134:3::10]:33052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNycl-0000G1-VO
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNycl-0000YA-4u
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNyck-0000Xd-VE
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 22 Jun 2017 11:41:49 +0200
Message-Id: <20170622094151.28633-2-david@redhat.com>
In-Reply-To: <20170622094151.28633-1-david@redhat.com>
References: <20170622094151.28633-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] target/s390x: Indicate and check for
 local tlb clearing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

Let's allow to enable it for the qemu cpu model and correctly emulate
it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 1 +
 target/s390x/mem_helper.c | 2 --
 target/s390x/translate.c  | 6 +++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 478bcc6..8fce957 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -685,6 +685,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_STFLE_45,
+        S390_FEAT_LOCAL_TLB_CLEARING,
     };
     int i;
 
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 80caab9..41e5a1d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1558,8 +1558,6 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-    /* XXX: the LC bit should be considered as 0 if the local-TLB-clearing
-       facility is not installed.  */
     if (m4 & 1) {
         tlb_flush_page(cs, page);
     } else {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8c055b7..7efc10b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2412,7 +2412,11 @@ static ExitStatus op_ipte(DisasContext *s, DisasOps *o)
     TCGv_i32 m4;
 
     check_privileged(s);
-    m4 = tcg_const_i32(get_field(s->fields, m4));
+    if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
+        m4 = tcg_const_i32(get_field(s->fields, m4));
+    } else {
+        m4 = tcg_const_i32(0);
+    }
     gen_helper_ipte(cpu_env, o->in1, o->in2, m4);
     tcg_temp_free_i32(m4);
     return NO_EXIT;
-- 
2.9.4
