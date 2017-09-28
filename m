Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaF-0004yi-BI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaD-0003f8-7A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfaD-0003es-1I
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:57 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:03 +0200
Message-Id: <20170928203708.9376-26-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 25/30] s390x/tcg: flush the tlb on SIGP SET
 PREFIX
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Thanks to Aurelien Jarno for doing this in his prototype.

We can flush the whole TLB as this should happen really rarely.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.13.5
