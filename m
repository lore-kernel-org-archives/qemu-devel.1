Received: from eggs.gnu.org ([2001:4830:134:3::10]:40040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNm8-000675-Vb
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNm8-0005No-7J
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:08 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sun,  5 Aug 2018 14:28:28 -0400
Message-Id: <20180805182832.3012-4-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 3/6] target/s390x: fix ipm polluting irrelevant
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

Suppose psw.mask=0x0000000080000000, cc=2, r1=0 and we do "ipm 1".
This command must touch only bits 32-39, so the expected output
is r1=0x20000000. However, currently qemu yields r1=0x20008000,
because irrelevant parts of PSW leak into r1 during program mask
transfer.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f318fb6e4e..05442dff36 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2442,8 +2442,8 @@ static DisasJumpType op_ipm(DisasContext *s, DisasOps *o)
     tcg_gen_andi_i64(o->out, o->out, ~0xff000000ull);
 
     t1 = tcg_temp_new_i64();
-    tcg_gen_shli_i64(t1, psw_mask, 20);
-    tcg_gen_shri_i64(t1, t1, 36);
+    tcg_gen_andi_i64(t1, psw_mask, 0x00000f0000000000);
+    tcg_gen_shri_i64(t1, t1, 16);
     tcg_gen_or_i64(o->out, o->out, t1);
 
     tcg_gen_extu_i32_i64(t1, cc_op);
-- 
2.16.2.windows.1
