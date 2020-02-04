Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA7C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03A921582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03A921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytBC-0003u1-Vf
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iytA8-0002fJ-8k
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iytA4-000171-8G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:24 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42498 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iytA3-00012U-Tq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:20 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8EC141A1D19;
 Tue,  4 Feb 2020 09:02:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6DCF21A0F0A;
 Tue,  4 Feb 2020 09:02:17 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/3] target/mips: Fix handling of LL/SC instructions after
 7dd547e5ab
Date: Tue,  4 Feb 2020 09:01:55 +0100
Message-Id: <1580803317-4422-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580803317-4422-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580803317-4422-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 James Clarke <jrtc27@jrtc27.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>

After 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f the env->llval value
is loaded as an unsigned value (instead of sign-extended as before).
Therefore, the CMPXCHG in gen_st_cond() in translate.c fails if the
sign bit is set in the loaded value.

Fix this by sign-extending the llval value for the 32-bit case.

I discovered this issue because FreeBSD MIPS64 was looping forever
in an atomic helper function when trying to start /sbin/init.

Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Fixes: 7dd547e5ab ("target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*=
_SUFFIX")
Buglink: https://bugs.launchpad.net/qemu/+bug/1861605
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200202153409.28534-1-jrtc27@jrtc27.com>
---
 target/mips/op_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 15d05a5..467914d 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -305,7 +305,7 @@ static inline hwaddr do_translate_address(CPUMIPSStat=
e *env,
     }
 }
=20
-#define HELPER_LD_ATOMIC(name, insn, almask)                            =
      \
+#define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                   =
      \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_=
idx)  \
 {                                                                       =
      \
     if (arg & almask) {                                                 =
      \
@@ -316,12 +316,12 @@ target_ulong helper_##name(CPUMIPSState *env, targe=
t_ulong arg, int mem_idx)  \
     }                                                                   =
      \
     env->CP0_LLAddr =3D do_translate_address(env, arg, 0, GETPC());     =
        \
     env->lladdr =3D arg;                                                =
        \
-    env->llval =3D cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());  =
        \
+    env->llval =3D do_cast cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GET=
PC());  \
     return env->llval;                                                  =
      \
 }
-HELPER_LD_ATOMIC(ll, ldl, 0x3)
+HELPER_LD_ATOMIC(ll, ldl, 0x3, (target_long)(int32_t))
 #ifdef TARGET_MIPS64
-HELPER_LD_ATOMIC(lld, ldq, 0x7)
+HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
 #endif
 #undef HELPER_LD_ATOMIC
 #endif
--=20
2.7.4


