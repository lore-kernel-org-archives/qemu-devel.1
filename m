Received: from eggs.gnu.org ([2001:4830:134:3::10]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfa2-0002nP-B1
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZz-0005BE-7o
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:54 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUfZz-0005B8-3E
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:51 -0400
Received: by mail-qk0-f195.google.com with SMTP id v143so14389601qkb.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 13:46:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 10 Jul 2017 10:45:21 -1000
Message-Id: <20170710204521.2058-9-rth@twiddle.net>
In-Reply-To: <20170710204521.2058-1-rth@twiddle.net>
References: <20170710204521.2058-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 8/8] target/s390x: Fix risbg handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, david@redhat.com

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
index f94ba7c..0c609bd 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3471,8 +3471,8 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
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
