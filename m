Received: from eggs.gnu.org ([2001:4830:134:3::10]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeN-0005Sv-Vt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeJ-0000E1-4I
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:56 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:37040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeI-0000Dn-Un
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:51 -0400
Received: by mail-pg0-x22a.google.com with SMTP id d8so15605692pgt.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:31 -0700
Message-Id: <20170906144940.30880-6-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 05/14] disas/i386: Add disassembly of vex.0f38.f5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Which includes pext, pdep and bzhi.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 disas/i386.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/disas/i386.c b/disas/i386.c
index 7a238b203b..7eaa378a10 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -683,6 +683,7 @@ fetch_data(struct disassemble_info *info, bfd_byte *addr)
 #define PREGRP105 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 105 } }
 #define PREGRP106 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 106 } }
 #define PREGRP107 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 107 } }
+#define PREGRP108 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 108 } }
 
 #define X86_64_0  NULL, { { NULL, X86_64_SPECIAL }, { NULL, 0 } }
 #define X86_64_1  NULL, { { NULL, X86_64_SPECIAL }, { NULL, 1 } }
@@ -1484,7 +1485,7 @@ static const unsigned char threebyte_0x38_uses_REPNZ_prefix[256] = {
   /* c0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* cf */
   /* d0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* df */
   /* e0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* ef */
-  /* f0 */ 1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0, /* ff */
+  /* f0 */ 1,1,0,0,0,1,0,1,0,0,0,0,0,0,0,0, /* ff */
   /*       -------------------------------        */
   /*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
 };
@@ -1508,7 +1509,7 @@ static const unsigned char threebyte_0x38_uses_REPZ_prefix[256] = {
   /* c0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* cf */
   /* d0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* df */
   /* e0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* ef */
-  /* f0 */ 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0, /* ff */
+  /* f0 */ 0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0, /* ff */
   /*       -------------------------------        */
   /*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
 };
@@ -2808,6 +2809,14 @@ static const struct dis386 prefix_user_table[][4] = {
     { "bsfS",	{ Gv, Ev } },
     { "(bad)",	{ XX } },
   },
+
+  /* PREGRP108 */
+  {
+    { "bzhi",   { Gv, Ev, Bv } },
+    { "pext",   { Gv, Bv, Ev } },
+    { "(bad)",  { XX } },
+    { "pdep",   { Gv, Bv, Ev } },
+  },
 };
 
 static const struct dis386 x86_64_table[][2] = {
@@ -3108,7 +3117,7 @@ static const struct dis386 three_byte_table[][256] = {
     { PREGRP105 },
     { "(bad)", { XX } },
     { "(bad)", { XX } },
-    { "(bad)", { XX } },
+    { PREGRP108 },
     { "(bad)", { XX } },
     { PREGRP106 },
     /* f8 */
-- 
2.13.5
