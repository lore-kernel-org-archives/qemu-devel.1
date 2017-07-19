Received: from eggs.gnu.org ([2001:4830:134:3::10]:41529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3N-0003IV-Cf
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3M-00026e-Jb
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:41 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3M-00026L-EA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:40 -0400
Received: by mail-pf0-x242.google.com with SMTP id q85so5086206pfq.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:57:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:11 -1000
Message-Id: <20170719045722.25492-4-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 03/14] tcg: Expand glue macros before
 stringifying helper names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/helper-tcg.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index bb92877..b0c5baf 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -6,31 +6,35 @@
 
 #include "exec/helper-head.h"
 
+/* Need one more level of indirection before stringification
+   to get all the macros expanded first.  */
+#define str(s) #s
+
 #define DEF_HELPER_FLAGS_0(NAME, FLAGS, ret) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) },
 
 #define DEF_HELPER_FLAGS_1(NAME, FLAGS, ret, t1) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) },
 
 #define DEF_HELPER_FLAGS_2(NAME, FLAGS, ret, t1, t2) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) },
 
 #define DEF_HELPER_FLAGS_3(NAME, FLAGS, ret, t1, t2, t3) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) },
 
 #define DEF_HELPER_FLAGS_4(NAME, FLAGS, ret, t1, t2, t3, t4) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) },
 
 #define DEF_HELPER_FLAGS_5(NAME, FLAGS, ret, t1, t2, t3, t4, t5) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
     | dh_sizemask(t5, 5) },
@@ -39,6 +43,7 @@
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
 
+#undef str
 #undef DEF_HELPER_FLAGS_0
 #undef DEF_HELPER_FLAGS_1
 #undef DEF_HELPER_FLAGS_2
-- 
2.9.4
