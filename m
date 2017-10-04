Received: from eggs.gnu.org ([2001:4830:134:3::10]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzmUb-0001b4-4W
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzmUX-0003El-U3
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzmUX-0003DG-Nx
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:25:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  4 Oct 2017 18:25:43 +0200
Message-Id: <20171004162543.12233-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/tcg: initialize machine check queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Just as for external interrupts and I/O interrupts, we need to
initialize mchk_index during cpu reset.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Trying a device_add with a ccw device under tcg currently insta-crashes
qemu. Probably nobody ever tried the crw machine check support that I
hacked in...

Needs more work to avoid a guest kernel panic next; but let's pick the
low-hanging fruit first.

---
 target/s390x/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4e1823a3e0..3fdf9bae70 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -111,6 +111,7 @@ static void s390_cpu_initial_reset(CPUState *s)
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
+    env->mchk_index = -1;
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
@@ -148,6 +149,7 @@ static void s390_cpu_full_reset(CPUState *s)
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
+    env->mchk_index = -1;
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
-- 
2.13.6
