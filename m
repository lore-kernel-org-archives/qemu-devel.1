Received: from eggs.gnu.org ([2001:4830:134:3::10]:36275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUZho-0008KW-J8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUZhl-0006cN-HR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:30:32 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:32937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUZhl-0006br-AR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:30:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id r103so141347350wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:30:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 15:28:49 +0100
Message-Id: <20170710142850.10468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] include/exec/cpu-defs.h: try and make
 SoftMMU page size match target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, bobby.prani@gmail.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

While the SoftMMU is not emulating the target MMU of a system there is
a relationship between its page size and that of the target. If the
target MMU is full featured the functions called to re-fill the
entries in the SoftMMU entries start moving up the perf profiles. If
we can we should try and prevent too much thrashing around by having
the page sizes the same.

Ideally we should use TARGET_PAGE_BITS_MIN but that potentially
involves a fair bit of #include re-jigging so I went for 10 bits (1k
pages) which I think is the smallest of all our emulated systems.

Some quick numbers show a reasonable performance win on an x86_64
host:

 ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt \
   -display none -m 16384 -cpu cortex-a57 -serial mon:stdio \
   -drive file=../jessie-arm64.qcow2,id=myblock,index=0,if=none \
   -device virtio-blk-device,drive=myblock \
   -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark-build.service" \
   -kernel ../aarch64-current-linux-kernel-only.img -machine gic-version=3 -smp 4

8 bit TLB:
  run 1: ret=0 (PASS), time=425.202797 (1/1)
  run 2: ret=0 (PASS), time=410.421742 (2/2)
  run 3: ret=0 (PASS), time=417.666752 (3/3)
  run 4: ret=0 (PASS), time=411.158793 (4/4)
  run 5: ret=0 (PASS), time=417.133068 (5/5)
  Results summary:
  0: 5 times (100.00%), avg time 416.317 (35.70 varience/5.98 deviation)

10 bit TLB
  run 1: ret=0 (PASS), time=359.310380 (1/1)
  run 2: ret=0 (PASS), time=387.826981 (2/2)
  run 3: ret=0 (PASS), time=381.097123 (3/3)
  run 4: ret=0 (PASS), time=393.826197 (4/4)
  run 5: ret=0 (PASS), time=384.340781 (5/5)
  Results summary:
  0: 5 times (100.00%), avg time 381.280 (173.08 varience/13.16 deviation)

CC: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/cpu-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index bc8e7f848d..a0f9249752 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -89,7 +89,7 @@ typedef uint64_t target_ulong;
  * of tlb_table inside env (which is non-trivial but not huge).
  */
 #define CPU_TLB_BITS                                             \
-    MIN(8,                                                       \
+    MIN(10,                                                      \
         TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
         (NB_MMU_MODES <= 1 ? 0 :                                 \
          NB_MMU_MODES <= 2 ? 1 :                                 \
-- 
2.13.0
