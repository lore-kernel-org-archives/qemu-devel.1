Received: from eggs.gnu.org ([2001:4830:134:3::10]:33192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVR-00084l-9a
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVO-0006Z7-5e
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXyVN-0006Yt-UE
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:46 -0400
Received: by mail-qk0-x244.google.com with SMTP id t186so1002409qkf.2
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:35:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Jul 2017 13:34:44 -1000
Message-Id: <20170719233455.8740-4-rth@twiddle.net>
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 03/14] tcg: Expand glue macros before
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
index bb9287727c..b0c5bafa99 100644
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
2.13.3
