Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E633C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA15D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CEXX/vHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA15D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGc0V-0003nA-NX
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu8-0004ah-JG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu7-0001dz-1W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36903 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu6-0001Zo-Lw; Tue, 24 Mar 2020 01:15:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW5ZGqz9sSQ; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=oE4yK1ja4e8fv4EUGbm9wj49lexWi9/2JDgy8C7lmz4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CEXX/vHB2F4mMOI2cOhiXiPuMjmfWTe8ZcYD26XkiFocZnbILC2y0AsOaPBrt6U2K
 bZ35GRmx53PQ+xe7UDtS1qKCdgzB2qG0Z0KZJZAEr5aDp2ZNcTp9ra1bcZGmT4pFFI
 R0ZTtJ9Z7YhgkYtQWyJn7TyB3reP+LTKOLFyTPL4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 4/7] target/ppc: don't byte swap ELFv2 signal handler
Date: Tue, 24 Mar 2020 16:14:53 +1100
Message-Id: <20200324051456.256116-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324051456.256116-1-david@gibson.dropbear.id.au>
References: <20200324051456.256116-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>, Vincent Fazio <vfazio@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vincent Fazio <vfazio@gmail.com>

Previously, the signal handler would be byte swapped if the target and
host CPU used different endianness. This would cause a SIGSEGV when
attempting to translate the opcode pointed to by the swapped address.

 Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fault.
 0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/includ=
e/qemu/bswap.h:351
 351        __builtin_memcpy(&r, ptr, sizeof(r));

 #0  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/in=
clude/qemu/bswap.h:351
 #1  0x00000000600a92fe in ldl_be_p (ptr=3D0x4c2c061000000000) at qemu/in=
clude/qemu/bswap.h:449
 #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/exec/trans=
lator.h:201
 #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/ppc/trans=
late.c:7856
 #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/translator.c=
:102

The signal handler will be byte swapped as a result of the __get_user()
call in sigaction() if it is necessary, no additional swap is required.

Signed-off-by: Vincent Fazio <vfazio@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200319133244.8818-1-vfazio@xes-inc.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 linux-user/ppc/signal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 0c4e7ba54c..ecd99736b7 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -567,10 +567,8 @@ void setup_rt_frame(int sig, struct target_sigaction=
 *ka,
         env->nip =3D tswapl(handler->entry);
         env->gpr[2] =3D tswapl(handler->toc);
     } else {
-        /* ELFv2 PPC64 function pointers are entry points, but R12
-         * must also be set */
-        env->nip =3D tswapl((target_ulong) ka->_sa_handler);
-        env->gpr[12] =3D env->nip;
+        /* ELFv2 PPC64 function pointers are entry points. R12 must also=
 be set. */
+        env->gpr[12] =3D env->nip =3D ka->_sa_handler;
     }
 #else
     env->nip =3D (target_ulong) ka->_sa_handler;
--=20
2.25.1


