Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW7-0006iZ-4F
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW6-0005iA-H0
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:07 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdW6-0005h8-Cb
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:06 -0500
Received: by mail-pg0-x241.google.com with SMTP id b1so2475478pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:06 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:02 -0800
Message-Id: <20161224040042.12654-26-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 25/65] disas/i386.c: Handle tzcnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
