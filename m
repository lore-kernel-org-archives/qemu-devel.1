Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMP-0001iV-1f
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMO-0007xg-0r
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:05 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMN-0007x7-SB
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:03 -0400
Received: by mail-qk0-x241.google.com with SMTP id r62so6801980qkf.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:23:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:39 -0700
Message-Id: <20170623162241.8964-14-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 13/15] target/s390x: Indicate and check for
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's allow to enable it for the qemu cpu model and correctly emulate
it.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170622094151.28633-2-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 1 +
 target/s390x/mem_helper.c | 2 --
 target/s390x/translate.c  | 6 +++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index d4fcddb..51b17b9 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -688,6 +688,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
         S390_FEAT_STFLE_45,
         S390_FEAT_STFLE_49,
+        S390_FEAT_LOCAL_TLB_CLEARING,
         S390_FEAT_STFLE_53,
     };
     int i;
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a0a805c..182c46f 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1629,8 +1629,6 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-    /* XXX: the LC bit should be considered as 0 if the local-TLB-clearing
-       facility is not installed.  */
     if (m4 & 1) {
         tlb_flush_page(cs, page);
     } else {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index df3fefa..1db5f2d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2385,7 +2385,11 @@ static ExitStatus op_ipte(DisasContext *s, DisasOps *o)
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
