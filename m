Received: from eggs.gnu.org ([2001:4830:134:3::10]:49322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80V7-0002ha-L5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80V6-00005q-R1
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:09 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d80V6-00005c-L1
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:08 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  9 May 2017 10:27:59 +0200
Message-Id: <20170509082800.10756-3-aurelien@aurel32.net>
In-Reply-To: <20170509082800.10756-1-aurelien@aurel32.net>
References: <20170509082800.10756-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 2/3] target/s390x: fix SIGNAL PROCESSOR return
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

The SIGNAL PROCESSOR helper returns its value through the CC register.
set_cc_static should be called just after the helper.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 558ff78084..c58c27f8e9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3363,6 +3363,7 @@ static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
     check_privileged(s);
     potential_page_fault(s);
     gen_helper_sigp(cc_op, cpu_env, o->in2, r1, o->in1);
+    set_cc_static(s);
     tcg_temp_free_i32(r1);
     return NO_EXIT;
 }
-- 
2.11.0
