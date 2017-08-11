Received: from eggs.gnu.org ([2001:4830:134:3::10]:45172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaN-0000Ca-8b
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaM-0007Tz-7L
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:23:03 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 11 Aug 2017 11:19:19 -0700
Message-ID: <20b283f7eaf100783b291de3830dd226ec286b6a.1502474835.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1502474835.git.alistair.francis@xilinx.com>
References: <cover.1502474835.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 1/3] target/arm: Update the memops for
 exclusive load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

Acording to the ARM ARM exclusive loads require the same allignment as
exclusive stores. Let's update the memops used for the load to match
that of the store. This adds the alignment requirement to the memops.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 58ed4c6d05..245175e2f1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1854,7 +1854,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                                TCGv_i64 addr, int size, bool is_pair)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
-    TCGMemOp memop = s->be_data + size;
+    TCGMemOp memop = size | MO_ALIGN | s->be_data;
 
     g_assert(size <= 3);
     tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), memop);
-- 
2.11.0
