Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C0ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E3B21855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E3B21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMj3-0003eG-D6
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iFMhr-0002pb-SO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iFMho-0005jp-V2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iFMho-0005jj-Q7; Tue, 01 Oct 2019 14:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE82910C0929;
 Tue,  1 Oct 2019 18:16:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 539C36013A;
 Tue,  1 Oct 2019 18:16:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] s390x/tcg: MVCL: Exit to main loop if there are pending
 interrupts
Date: Tue,  1 Oct 2019 20:16:55 +0200
Message-Id: <20191001181655.25948-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 18:17:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MVCL is interruptible and we should check for interrupts and process
them after writing back the variables to the registers.

I can see both checks triggering. Most of them pass the first check,
however, sometimes also the second check strikes and an interrupt gets
delivered. (I assume pending interrupts that were not deliverable when
injected but are now deliverable)

When booting Fedora 30, I can see a handful of these exits and it seems
to work reliable. (it never get's triggered via EXECUTE, though)

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4254548935..96f0728cb7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1005,6 +1005,24 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
     return *destlen ? 3 : cc;
 }
=20
+static inline bool should_interrupt_instruction(CPUState *cs)
+{
+    /*
+     * Something asked us to stop executing chained TBs, e.g.,
+     * cpu_interrupt() or cpu_exit().
+     */
+    if ((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0) {
+        return true;
+    }
+
+    /* We have a deliverable interrupt pending. */
+    if ((atomic_read(&cs->interrupt_request) & CPU_INTERRUPT_HARD) &&
+        s390_cpu_has_int(S390_CPU(cs))) {
+        return true;
+    }
+    return false;
+}
+
 /* move long */
 uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
@@ -1015,6 +1033,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t =
r1, uint32_t r2)
     uint64_t srclen =3D env->regs[r2 + 1] & 0xffffff;
     uint64_t src =3D get_address(env, r2);
     uint8_t pad =3D env->regs[r2 + 1] >> 24;
+    CPUState *cs =3D env_cpu(env);
     S390Access srca, desta;
     uint32_t cc, cur_len;
=20
@@ -1065,7 +1084,14 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2)
         env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destle=
n);
         set_address_zero(env, r1, dest);
=20
-        /* TODO: Deliver interrupts. */
+        /*
+         * MVCL is interruptible. Check if there is any irq, and if so,
+         * return to the main loop where we can process it. In case we
+         * don't deliver an interrupt, we'll end up back in this handler=
.
+         */
+        if (unlikely(should_interrupt_instruction(cs))) {
+            cpu_loop_exit_restore(cs, ra);
+        }
     }
     return cc;
 }
--=20
2.21.0


