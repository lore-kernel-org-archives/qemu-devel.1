Received: from eggs.gnu.org ([2001:4830:134:3::10]:58055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dKtfD-0007Oz-0m
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dKtfC-0003k1-8D
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dKtfC-0003jY-2e
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:47:50 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 13 Jun 2017 23:47:36 +0200
Message-Id: <20170613214736.19963-4-david@redhat.com>
In-Reply-To: <20170613214736.19963-1-david@redhat.com>
References: <20170613214736.19963-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/3] s390x/cpumodel: allow to enable MVCOS
 for qemu cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com, Miroslav Benes <mbenes@suse.cz>

This allows botting a recent linux kernel (e.g. compiled for z900) and
using mvcos for uaccess:

qemu-system-s390x ... -cpu qemu,mvcos=on ...

While at it, correctly fake its abscence.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 1 +
 target/s390x/mem_helper.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c508ae1..348e760 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -682,6 +682,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_LONG_DISPLACEMENT_FAST,
         S390_FEAT_ETF2_ENH,
         S390_FEAT_STORE_CLOCK_FAST,
+        S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_STFLE_45,
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index cb27465..e0a5de0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1508,6 +1508,9 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
     HELPER_LOG("%s dest %" PRIx64 ", src %" PRIx64 ", len %" PRIx64 "\n",
                __func__, dest, src, len);
 
+    if (!s390_has_feat(S390_FEAT_MOVE_WITH_OPTIONAL_SPEC)) {
+        program_interrupt(env, PGM_OPERATION, 6);
+    }
     if (!(env->psw.mask & PSW_MASK_DAT)) {
         program_interrupt(env, PGM_SPECIAL_OP, 6);
     }
-- 
2.9.3
