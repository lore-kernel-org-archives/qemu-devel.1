Received: from eggs.gnu.org ([2001:4830:134:3::10]:50944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZSL-0008Tr-1e
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZSK-0004Ip-7T
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:49 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZSK-0004IB-1L
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:48 -0400
Received: by mail-pg0-x244.google.com with SMTP id f127so7257622pgc.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:35:09 -0700
Message-Id: <20170604173509.29684-70-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 69/69] target/s390x: addressing exceptions are
 suppressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We have to make the address in the old PSW point at the next
instruction, as addressing exceptions are suppressing and not
nullifying.

I assume that there are a lot of other broken cases (as most instructions
we care about are suppressing) - all trigger_pgm_exception() specifying
and explicit number or ILEN_LATER look suspicious, however this is another
story that might require bigger changes (and I have to understand when
the address might already have been incremented first).

This is needed to make an upcoming kvm-unit-test work.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170529121228.2789-1-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 291db72..a8d20c5 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -204,7 +204,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     if (raddr > ram_size) {
         DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func__,
                 (uint64_t)raddr, (uint64_t)ram_size);
-        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_LATER);
+        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_LATER_INC);
         return 1;
     }
 
-- 
2.9.4
