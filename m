Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DCEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961B020759
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961B020759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Oqe-0007wT-UE
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0Oob-0004ef-Mj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:34:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0OoZ-0001sj-Ub
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:34:41 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMnru-1kJAeP01Lg-00Ii8t; Tue, 28 Jul 2020 14:34:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] linux-user: Fix syscall rt_sigtimedwait() implementation
Date: Tue, 28 Jul 2020 14:34:31 +0200
Message-Id: <20200728123432.501354-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728123432.501354-1-laurent@vivier.eu>
References: <20200728123432.501354-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:edX6urSlCEgsoLDWellRc0E4g/BIv6mO5Pt0waljg7CSQWCJ6Fg
 fa8AylZkms8KH/pSOiK9sjx665rZ7B2vlTufwslIEWS1X/NwTgJrHSPczypwFDIMYU2xn/6
 va6dgOU2R7UjfnxaYO+NXYCXtphytY80kKMxaeSZ471KL7o7HwyPVhRgtdWwy5CubXP1EHq
 feVliJeNQCatQ4jquoMJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QhQV/5eaEZY=:ux4fwYIEvHM3wgz7ToqDZs
 yYzvrrJJvpEqT2p+zRjYgi3qvDLhuyuQeWUf5zhNJaxKtLjbEGEAh5adMWUF1MSunvcPGND8j
 UyEwqEm+exQUSjyuoa9C8UA1BvM5bxRU3RHihG/gEcnSTER+jNKiwKRtIBRtskz5awhkTFS8r
 5rAEjO9bhGdNrLOkLQelTkwAKGUqqhEPspnxfESGOFfLkfTHEC9Docqd92t/+BHT0d7IdxgmJ
 WmFvBilApUcDaMPfbGHeX31640rn10YCxZ8tsWGFWAiDWvg+f97tjwc5H8VkwxA4OaLs3HXPc
 aYMAM28AZCeusJ7qJqgM8P6v5WT5sjNW6Rc4h3cLtSmuR3iDfieG3oeuO/y2rmyZpZ2mDhVu/
 5qN0RPFxc+iWihaW30ZykPcmQphPjcgYaH1gE8bIiCb8GSX17Nod1WmhIHp2dukmBx7gjxAoJ
 beSNfCVdrES/JL+2w0nrxW2eAaVRSigxP1hGcs4KknVAbxofMBqsIDjD3eobLuZtMa1L+1W3x
 SDBjt6qqgjHRnDjbYpGV2jSjsInKfSGnU9OBeBKbvifreXhGfIZePFJD1L0LsZoPjsJbfzbDn
 nXIwBKgOVA5Ghqx0JLMPVGpyYtb7xl8VfzMISfcJx32m3zoKIFEEg/zJI1O46J6oaZRsm4/sK
 91ib8+fnKULVEZwGjSvdauIj/VFcAgJWjeJODOv3FbubpWYFzmqHBnamZTyrdq/Da7q2DXuEi
 HAMDthpolCtaapF+S4En9HgGLU+kpRTigxmZSBoGysOMUZQ0RkM7ItKBjKLdqsUBDLUwR8n97
 0qFxfycxkSr4wF8zjgeRsUYzOqNcZHzaJQTJFxD1f8aiBpCSZmpqDiXUZ14sUjbRcmuHQyN
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:34:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Implementation of 'rt_sigtimedwait()' in 'syscall.c' uses the
function 'target_to_host_timespec()' to transfer the value of
'struct timespec' from target to host. However, the implementation
doesn't check whether this conversion succeeds and thus can cause
an unaproppriate error instead of the 'EFAULT (Bad address)' which
is supposed to be set if the conversion from target to host fails.

This was confirmed with the LTP test for rt_sigtimedwait:
"/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c"
which causes an unapropriate error in test case "test_bad_adress3"
which is run with a bad adress for the 'struct timespec' argument:

FAIL: test_bad_address3 (349): Unexpected failure: EAGAIN/EWOULDBLOCK (11)

The test fails with an unexptected errno 'EAGAIN/EWOULDBLOCK' instead
of the expected EFAULT.

After the changes from this patch, the test case is executed successfully
along with the other LTP test cases for 'rt_sigtimedwait()':

PASS: test_bad_address3 (349): Test passed

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200724181651.167819-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5c4f6b95db4..c1ebf7b8f384 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8868,7 +8868,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg1, 0);
             if (arg3) {
                 puts = &uts;
-                target_to_host_timespec(puts, arg3);
+                if (target_to_host_timespec(puts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 puts = NULL;
             }
-- 
2.26.2


