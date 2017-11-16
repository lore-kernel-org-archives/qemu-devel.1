Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFNbe-00021P-QY
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFNbe-00018K-0K
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:05:38 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 16 Nov 2017 18:05:26 +0100
Message-Id: <20171116170526.12643-4-david@redhat.com>
In-Reply-To: <20171116170526.12643-1-david@redhat.com>
References: <20171116170526.12643-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 3/3] s390x/tcg: fix DIAG 308 with >
 1 VCPU (MTTCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Currently, multi threaded TCG with > 1 VCPU gets stuck during IPL, when
the bios tries to switch to the loaded kernel via DIAG 308.

As run_on_cpu() is used, we run into a deadlock after handling the reset.
We need the iolock (just like KVM).

Signed-off-by: David Hildenbrand <david@redhat.com>
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
