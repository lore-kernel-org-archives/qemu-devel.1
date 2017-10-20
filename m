Received: from eggs.gnu.org ([2001:4830:134:3::10]:59126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtx-00033q-6b
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtw-0003dK-JO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:58 +0200
Message-Id: <20171020115418.2050-27-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 26/46] s390x/tcg: flush the tlb on SIGP SET
 PREFIX
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

Thanks to Aurelien Jarno for doing this in his prototype.

We can flush the whole TLB as this should happen really rarely.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-26-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/sigp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index d70f5cb0ba..c5a5dac911 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -287,6 +287,7 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
     }
 
     cpu->env.psa = addr;
+    tlb_flush(cs);
     cpu_synchronize_post_init(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.13.6
