Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW14-0003Wz-Iy
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW13-0005RD-JX
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:22 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW13-0005QP-Ct
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:21 -0400
Received: by mail-pg0-x241.google.com with SMTP id 123so894305pga.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:21 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:11 -0700
Message-Id: <20170804062314.12594-4-rth@twiddle.net>
In-Reply-To: <20170804062314.12594-1-rth@twiddle.net>
References: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 3/6] disas/i386: Add disassembly of
 vex.0f38.f5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
2.13.3
