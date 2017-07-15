Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuP-0006WL-Ev
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuN-0000v9-L0
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:13 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWQuN-0000uy-F4
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:11 -0400
Received: by mail-pf0-x244.google.com with SMTP id k24so866159pfj.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 10:31:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 15 Jul 2017 07:30:50 -1000
Message-Id: <20170715173050.31018-9-rth@twiddle.net>
In-Reply-To: <20170715173050.31018-1-rth@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 8/8] target/s390x: Fix risbg handling
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

The rotation is to the left, but extract shifts to the right.
The computation of the extract parameters needs adjusting.

For the entry condition, simplify

	64 - rot + len <= 64
	-rot + len <= 0
	len <= rot

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reported-by: David Hildenbrand <david@redhat.com>
Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b46f4c8..1dffcee 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3479,8 +3479,8 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
     }
 
     /* In some cases we can implement this with extract.  */
-    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
-        tcg_gen_extract_i64(o->out, o->in2, rot, len);
+    if (imask == 0 && pos == 0 && len > 0 && len <= rot) {
+        tcg_gen_extract_i64(o->out, o->in2, 64 - rot, len);
         return NO_EXIT;
     }
 
-- 
2.9.4
