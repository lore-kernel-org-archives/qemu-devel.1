Received: from eggs.gnu.org ([2001:4830:134:3::10]:60125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxFha-0006fM-J7
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxFhV-00067c-26
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxFhU-000675-SW
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:44 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Sep 2017 19:00:27 +0200
Message-Id: <20170927170027.8539-4-david@redhat.com>
In-Reply-To: <20170927170027.8539-1-david@redhat.com>
References: <20170927170027.8539-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/3] s390x/tcg: make STFL store into the
 lowcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

Using virtual memory access is wrong and will soon include low-address
protection checks, which is to be bypassed for STFL.

This was originally part of a bigger STFL(E) refactoring.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      | 2 +-
 target/s390x/misc_helper.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 75ba04fc15..52c2963baa 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -104,7 +104,6 @@ DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
@@ -153,6 +152,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_2(xsch, void, env, i64)
 DEF_HELPER_2(csch, void, env, i64)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 293fc8428a..0b93381188 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -541,13 +541,18 @@ static unsigned do_stfle(CPUS390XState *env, uint64_t words[MAX_STFL_WORDS])
     return max_bit / 64;
 }
 
+#ifndef CONFIG_USER_ONLY
 void HELPER(stfl)(CPUS390XState *env)
 {
     uint64_t words[MAX_STFL_WORDS];
+    LowCore *lowcore;
 
+    lowcore = cpu_map_lowcore(env);
     do_stfle(env, words);
-    cpu_stl_data(env, 200, words[0] >> 32);
+    lowcore->stfl_fac_list = cpu_to_be32(words[0] >> 32);
+    cpu_unmap_lowcore(lowcore);
 }
+#endif
 
 uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
 {
-- 
2.13.5
