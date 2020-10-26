Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B5C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB2E20829
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB2E20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAd4-0007Lv-Cm
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAak-0005eQ-Ax
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:50 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAah-0005F2-3D
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:49 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MysiI-1kAhkl38iY-00vwkZ; Mon, 26 Oct 2020 23:03:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] Fix stack smashing when handling PR_GET_PDEATHSIG
Date: Mon, 26 Oct 2020 23:03:32 +0100
Message-Id: <20201026220339.195790-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220339.195790-1-laurent@vivier.eu>
References: <20201026220339.195790-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:15vxF7go/XQMFN3i8nJigGNO8kI5rqgsx9En3d19jArHNduwS0Y
 5hqtPsyPoZKJYOn6VkzYlVpGegbPYZqbZpqoYuiKsTJuYydKo1eYFhgDYk/m1LboSAUtuBd
 KqY+gYsoQt0gp5/jYyk2mQyTYjnlPaz+T93OWByjqPaHb4Jc8weY6QdR3AQwI8v8E3k23cD
 BbVKedXUcU7DhMZRpepBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CWFt4d6rj40=:cNiQn6H/r53l+vABA852wB
 LR2AlXwxkc3RfNoUWgaNNFqaYTbNbZe0VZO5oSg+DoXWomKydqnwyJLQpDFYD6dOzuTDKC29P
 2RSLZoJ6hipY+iIlvQ9PpuyljC8LeitBozyqJ0nYXed2dOMLBaLLuY7P4nrLW6KgUHjv3oKhi
 Tmk0nq4x3g2RztAhwv788ijWOp30YkwUXbpENpMsc2v9wDqgI4f/lgR0hznTnMm/m468cWKyy
 0g3uXbA/w4QjFdoFUrhyRh9k8pKOvV50AJtbgCAFqAMMA0R2+6o48tD5SXQ8hitr/tFF+AsKr
 H9ZX7m23iA61bwB373pmNJJwm68f9duyW+7+XQ/k4w7fj4jG8E4VXIjS8WZzOq9M7g40tlD1g
 7M5DvWr9lTdra/nVmfDHXTHiZ63CQBNGS4e3hlGold7iVzJ6ulcHF+1JAyIhwVKU3/1ZnSjQa
 zI24ab4pcA==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 18:03:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Ana Pazos <apazos@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

The bug was triggered by the following code on aarch64-linux-user:

int main(void)
{
  int PDeathSig = 0;
  if (prctl(PR_GET_PDEATHSIG, &PDeathSig) == 0 && PDeathSig == SIGKILL)
    prctl(PR_GET_PDEATHSIG, 0);
  return (PDeathSig == SIGKILL);
}

Signed-off-by: Stephen Long <steplong@quicinc.com>
Signed-off-by: Ana Pazos <apazos@quicinc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200507130302.3684-1-steplong@quicinc.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 897d20c076ce..3e0f14f2e67f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10703,7 +10703,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             int deathsig;
             ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
             if (!is_error(ret) && arg2
-                && put_user_ual(deathsig, arg2)) {
+                && put_user_s32(deathsig, arg2)) {
                 return -TARGET_EFAULT;
             }
             return ret;
-- 
2.26.2


