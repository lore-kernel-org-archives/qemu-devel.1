Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAc-0001Jf-Il
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAb-00049C-Nh
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:26 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAb-000493-Jw
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:25 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so8699876qte.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:08 -0700
Message-Id: <20170512234009.32557-9-rth@twiddle.net>
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
References: <20170512234009.32557-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 8/9] target/s390x: fix SIGNAL PROCESSOR return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

The SIGNAL PROCESSOR helper returns its value through the CC register.
set_cc_static should be called just after the helper.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170509082800.10756-3-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 19276cc..3a0a3ee 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3406,6 +3406,7 @@ static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
     check_privileged(s);
     potential_page_fault(s);
     gen_helper_sigp(cc_op, cpu_env, o->in2, r1, o->in1);
+    set_cc_static(s);
     tcg_temp_free_i32(r1);
     return NO_EXIT;
 }
-- 
2.9.3
