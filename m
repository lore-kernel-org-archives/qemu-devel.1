Received: from eggs.gnu.org ([2001:4830:134:3::10]:34556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOuB-00042g-7x
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu9-0002bA-OX
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:59 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOu9-0002ac-K0
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:57 -0400
Received: by mail-qk0-x242.google.com with SMTP id y201so11030198qka.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:19 -0700
Message-Id: <20170607003119.14778-71-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 70/70] target/s390x: addressing exceptions
 are suppressing
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
