Received: from eggs.gnu.org ([2001:4830:134:3::10]:55335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW1-0006cL-CQ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW0-0005cJ-LN
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:01 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdW0-0005bG-GZ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:00 -0500
Received: by mail-pg0-x241.google.com with SMTP id i5so2479858pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:00 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:59 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:55 -0800
Message-Id: <20161224040042.12654-19-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 18/65] target-s390x: Use the new deposit and
 extract ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use the new primitives for RISBG.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 02bc705..6cebb7e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3134,20 +3134,26 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
         }
     }
 
-    /* In some cases we can implement this with deposit, which can be more
-       efficient on some hosts.  */
-    if (~mask == imask && i3 <= i4) {
-        if (s->fields->op2 == 0x5d) {
-            i3 += 32, i4 += 32;
-        }
+    len = i4 - i3 + 1;
+    pos = 63 - i4;
+    rot = i5 & 63;
+    if (s->fields->op2 == 0x5d) {
+        pos += 32;
+    }
+
+    /* In some cases we can implement this with extract.  */
+    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
+        tcg_gen_extract_i64(o->out, o->in2, rot, len);
+        return NO_EXIT;
+    }
+
+    /* In some cases we can implement this with deposit.  */
+    if (len > 0 && (imask == 0 || ~mask == imask)) {
         /* Note that we rotate the bits to be inserted to the lsb, not to
            the position as described in the PoO.  */
-        len = i4 - i3 + 1;
-        pos = 63 - i4;
-        rot = (i5 - pos) & 63;
+        rot = (rot - pos) & 63;
     } else {
-        pos = len = -1;
-        rot = i5 & 63;
+        pos = -1;
     }
 
     /* Rotate the input as necessary.  */
@@ -3155,7 +3161,11 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
 
     /* Insert the selected bits into the output.  */
     if (pos >= 0) {
-        tcg_gen_deposit_i64(o->out, o->out, o->in2, pos, len);
+        if (imask == 0) {
+            tcg_gen_deposit_z_i64(o->out, o->in2, pos, len);
+        } else {
+            tcg_gen_deposit_i64(o->out, o->out, o->in2, pos, len);
+        }
     } else if (imask == 0) {
         tcg_gen_andi_i64(o->out, o->in2, mask);
     } else {
-- 
2.9.3
