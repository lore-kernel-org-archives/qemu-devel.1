Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5301622D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A3Il0kCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5301622D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LZs-0007aP-CV
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1H-0005hI-Dn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1F-0000Kq-Ru
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:59 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1F-00005E-EU; Wed, 21 Aug 2019 03:26:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjH26Wsz9sRM; Wed, 21 Aug 2019 17:25:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372355;
 bh=jK/ciQJoSLXGmTAlQkkkT7mytfHoAHk++6GYWm8bOaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A3Il0kCbHGwp+6xoHS3g0Zcn0KLkFjwNWTyIPsjuDej0cEsvtUqRAwMaY7DB5+APh
 U8pvbZv5+tPkWSU7pyDR6lcn7otMNwQmSrn5YldI28hWW3w0HdqLT6KlFh5DG5PWP0
 u04uWid690q79Nphe3NEcwQBdwHUkt4TmCx0HIJQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:40 +1000
Message-Id: <20190821072542.23090-41-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 40/42] ppc: conform to processor User's Manual
 for xscvdpspn
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, "Paul A. Clarke" <pc@us.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Paul A. Clarke" <pc@us.ibm.com>

The POWER8 and POWER9 User's Manuals specify the implementation
behavior for what the ISA leaves "undefined" behavior for the
xscvdpspn and xscvdpsp instructions.  This patch corrects the QEMU
implementation to match the hardware implementation for that case.

ISA 3.0B has xscvdpspn leaving its result in word 0 of the target registe=
r,
with the other words of the target register left "undefined".

The User's Manuals specify:
  VSX scalar convert from double-precision to single-precision (xscvdpsp,
  xscvdpspn).
  VSR[32:63] is set to VSR[0:31].
So, words 0 and 1 both contain the result.

Note: this is important because GCC as of version 8 or so, assumes and ta=
kes
advantage of this behavior to optimize the following sequence:
  xscvdpspn vs0,vs1
  mffprwz   r8,f0
ISA 3.0B has xscvdpspn leaving its result in word 0 of the target registe=
r,
and mffprwz expecting its input to come from word 1 of the source registe=
r.
This sequence fails with QEMU, as a shift is required between those two
instructions.  However, since the hardware splats the result to both word=
s 0
and 1 of its output register, the shift is not necessary.

Expect a future revision of the ISA to specify this behavior.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

v2
- Splitting patch "ppc: Three floating point fixes"; this is just one par=
t.
- Updated commit message to clarify behavior is documented in User's Manu=
als.
- Updated commit message to correct which words are in output and source =
of
  xscvdpspn and mffprz.
- No source changes to this part of the original patch.

Message-Id: <1566236601-22954-1-git-send-email-pc@us.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 5611cf0156..23b9c97439 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2871,10 +2871,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t o=
pcode,
=20
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 {
+    uint64_t result;
+
     float_status tstat =3D env->fp_status;
     set_float_exception_flags(0, &tstat);
=20
-    return (uint64_t)float64_to_float32(xb, &tstat) << 32;
+    result =3D (uint64_t)float64_to_float32(xb, &tstat);
+    /* hardware replicates result to both words of the doubleword result=
.  */
+    return (result << 32) | result;
 }
=20
 uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
--=20
2.21.0


