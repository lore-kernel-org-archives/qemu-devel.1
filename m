Received: from eggs.gnu.org ([2001:4830:134:3::10]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGntj-00068J-15
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGntZ-0000zC-Ne
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:22:11 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Nov 2017 16:21:43 +0100
Message-Id: <20171120152145.25853-3-cohuck@redhat.com>
In-Reply-To: <20171120152145.25853-1-cohuck@redhat.com>
References: <20171120152145.25853-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 2/4] s390x/tcg: fix DIAG 308 with > 1
 VCPU (MTTCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Currently, multi threaded TCG with > 1 VCPU gets stuck during IPL, when
the bios tries to switch to the loaded kernel via DIAG 308.

As run_on_cpu() is used, we run into a deadlock after handling the reset.
We need the iolock (just like KVM).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171116170526.12643-4-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 4afd90b969..d272851e1c 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -103,7 +103,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
         break;
     case 0x308:
         /* ipl */
+        qemu_mutex_lock_iothread();
         handle_diag_308(env, r1, r3);
+        qemu_mutex_unlock_iothread();
         r = 0;
         break;
     case 0x288:
-- 
2.13.6
