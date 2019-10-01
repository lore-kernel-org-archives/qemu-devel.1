Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5AECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C6120842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C6120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTTg-0007oo-Nf
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsq-0002GS-VN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsi-0002wP-I5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsO-0001z8-GK; Tue, 01 Oct 2019 19:48:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlSJr086592; Tue, 1 Oct 2019 19:47:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccat810x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:53 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlZ2029380;
 Tue, 1 Oct 2019 23:47:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 2v9y59fak2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:52 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlqxN36831538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:52 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12F442805E;
 Tue,  1 Oct 2019 23:47:52 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA8F728058;
 Tue,  1 Oct 2019 23:47:51 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:51 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/97] target/arm: Don't abort on M-profile exception return
 in linux-user mode
Date: Tue,  1 Oct 2019 18:45:52 -0500
Message-Id: <20191001234616.7825-74-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

An attempt to do an exception-return (branch to one of the magic
addresses) in linux-user mode for M-profile should behave like
a normal branch, because linux-user mode is always going to be
in 'handler' mode. This used to work, but we broke it when we added
support for the M-profile security extension in commit d02a8698d7ae2bfed.

In that commit we allowed even handler-mode calls to magic return
values to be checked for and dealt with by causing an
EXCP_EXCEPTION_EXIT exception to be taken, because this is
needed for the FNC_RETURN return-from-non-secure-function-call
handling. For system mode we added a check in do_v7m_exception_exit()
to make any spurious calls from Handler mode behave correctly, but
forgot that linux-user mode would also be affected.

How an attempted return-from-non-secure-function-call in linux-user
mode should be handled is not clear -- on real hardware it would
result in return to secure code (not to the Linux kernel) which
could then handle the error in any way it chose. For QEMU we take
the simple approach of treating this erroneous return the same way
it would be handled on a CPU without the security extensions --
treat it as a normal branch.

The upshot of all this is that for linux-user mode we should never
do any of the bx_excret magic, so the code change is simple.

This ought to be a weird corner case that only affects broken guest
code (because Linux user processes should never be attempting to do
exception returns or NS function returns), except that the code that
assigns addresses in RAM for the process and stack in our linux-user
code does not attempt to avoid this magic address range, so
legitimate code attempting to return to a trampoline routine on the
stack can fall into this case. This change fixes those programs,
but we should also look at restricting the range of memory we
use for M-profile linux-user guests to the area that would be
real RAM in hardware.

Cc: qemu-stable@nongnu.org
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190822131534.16602-1-peter.maydell@linaro.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1840922
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 5e5584c89f36b302c666bc6db535fd3f7ff35ad2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d408e4d7ef..d9d4e765ca 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -964,10 +964,27 @@ static inline void gen_bx(DisasContext *s, TCGv_i32 var)
     store_cpu_field(var, thumb);
 }
 
-/* Set PC and Thumb state from var. var is marked as dead.
+/*
+ * Set PC and Thumb state from var. var is marked as dead.
  * For M-profile CPUs, include logic to detect exception-return
  * branches and handle them. This is needed for Thumb POP/LDM to PC, LDR to PC,
  * and BX reg, and no others, and happens only for code in Handler mode.
+ * The Security Extension also requires us to check for the FNC_RETURN
+ * which signals a function return from non-secure state; this can happen
+ * in both Handler and Thread mode.
+ * To avoid having to do multiple comparisons in inline generated code,
+ * we make the check we do here loose, so it will match for EXC_RETURN
+ * in Thread mode. For system emulation do_v7m_exception_exit() checks
+ * for these spurious cases and returns without doing anything (giving
+ * the same behaviour as for a branch to a non-magic address).
+ *
+ * In linux-user mode it is unclear what the right behaviour for an
+ * attempted FNC_RETURN should be, because in real hardware this will go
+ * directly to Secure code (ie not the Linux kernel) which will then treat
+ * the error in any way it chooses. For QEMU we opt to make the FNC_RETURN
+ * attempt behave the way it would on a CPU without the security extension,
+ * which is to say "like a normal branch". That means we can simply treat
+ * all branches as normal with no magic address behaviour.
  */
 static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
 {
@@ -975,10 +992,12 @@ static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
      * s->base.is_jmp that we need to do the rest of the work later.
      */
     gen_bx(s, var);
+#ifndef CONFIG_USER_ONLY
     if (arm_dc_feature(s, ARM_FEATURE_M_SECURITY) ||
         (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M))) {
         s->base.is_jmp = DISAS_BX_EXCRET;
     }
+#endif
 }
 
 static inline void gen_bx_excret_final_code(DisasContext *s)
-- 
2.17.1


