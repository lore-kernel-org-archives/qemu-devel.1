Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D722C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6120D21783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6120D21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFZyt-0003O7-J9
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iFZy8-0002vs-4K
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iFZy7-0002zx-48
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iFZy6-0002zg-VV; Wed, 02 Oct 2019 04:26:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B0B230860B5;
 Wed,  2 Oct 2019 08:26:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-58.ams2.redhat.com [10.36.117.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A089C5D9D6;
 Wed,  2 Oct 2019 08:26:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
Date: Wed,  2 Oct 2019 10:26:36 +0200
Message-Id: <20191002082636.7739-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 02 Oct 2019 08:26:42 +0000 (UTC)
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
them after writing back the variables to the registers. Let's check
for any exit requests and exit to the main loop.

When booting Fedora 30, I can see a handful of these exits and it seems
to work reliable. (it never get's triggered via EXECUTE, though)

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Check only if icount_decr.u32 < 0
- Drop should_interrupt_instruction() and perform the check inline
- Rephrase comment, subject, and description

---
 target/s390x/mem_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4254548935..87e4ebd169 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1015,6 +1015,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t =
r1, uint32_t r2)
     uint64_t srclen =3D env->regs[r2 + 1] & 0xffffff;
     uint64_t src =3D get_address(env, r2);
     uint8_t pad =3D env->regs[r2 + 1] >> 24;
+    CPUState *cs =3D env_cpu(env);
     S390Access srca, desta;
     uint32_t cc, cur_len;
=20
@@ -1065,7 +1066,14 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2)
         env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destle=
n);
         set_address_zero(env, r1, dest);
=20
-        /* TODO: Deliver interrupts. */
+        /*
+         * MVCL is interruptible. Check if somebody (e.g., cpu_interrupt=
() or
+         * cpu_exit()) asked us to return to the main loop. In case ther=
e is
+         * no deliverable interrupt, we'll end up back in this handler.
+         */
+        if (unlikely((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32)=
 < 0)) {
+            cpu_loop_exit_restore(cs, ra);
+        }
     }
     return cc;
 }
--=20
2.21.0


