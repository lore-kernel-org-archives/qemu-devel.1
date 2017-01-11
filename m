Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uv-0006GS-Hz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uu-0003HA-7W
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:45 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uu-0003Gh-2a
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:44 -0500
Received: by mail-pf0-x244.google.com with SMTP id 127so31457948pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:44 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:40 -0800
Message-Id: <20170111021820.24416-26-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 25/65] disas/i386.c: Handle tzcnt
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
 disas/i386.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/i386.c b/disas/i386.c
index 57145d0..07f871f 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -682,6 +682,7 @@ fetch_data(struct disassemble_info *info, bfd_byte *addr)
 #define PREGRP104 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 104 } }
 #define PREGRP105 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 105 } }
 #define PREGRP106 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 106 } }
+#define PREGRP107 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 107 } }
 
 #define X86_64_0  NULL, { { NULL, X86_64_SPECIAL }, { NULL, 0 } }
 #define X86_64_1  NULL, { { NULL, X86_64_SPECIAL }, { NULL, 1 } }
@@ -1247,7 +1248,7 @@ static const struct dis386 dis386_twobyte[] = {
   { "ud2b",		{ XX } },
   { GRP8 },
   { "btcS",		{ Ev, Gv } },
-  { "bsfS",		{ Gv, Ev } },
+  { PREGRP107 },
   { PREGRP36 },
   { "movs{bR|x|bR|x}",	{ Gv, Eb } },
   { "movs{wR|x|wR|x}",	{ Gv, Ew } }, /* yes, there really is movsww ! */
@@ -1431,7 +1432,7 @@ static const unsigned char twobyte_uses_REPZ_prefix[256] = {
   /* 80 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 8f */
   /* 90 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 9f */
   /* a0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* af */
-  /* b0 */ 0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0, /* bf */
+  /* b0 */ 0,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0, /* bf */
   /* c0 */ 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0, /* cf */
   /* d0 */ 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0, /* df */
   /* e0 */ 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0, /* ef */
@@ -2800,6 +2801,13 @@ static const struct dis386 prefix_user_table[][4] = {
     { "shrxS",	{ Gv, Ev, Bv } },
   },
 
+  /* PREGRP107 */
+  {
+    { "bsfS",	{ Gv, Ev } },
+    { "tzcntS",	{ Gv, Ev } },
+    { "bsfS",	{ Gv, Ev } },
+    { "(bad)",	{ XX } },
+  },
 };
 
 static const struct dis386 x86_64_table[][2] = {
-- 
2.9.3
