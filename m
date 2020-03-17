Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F46C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA46020724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA46020724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEmc-000235-0D
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVK-0004mZ-Hd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVJ-0007EP-73
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:42 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54317)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVI-00079j-RX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:41 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McY0J-1jqsm43zJN-00d2SH; Tue, 17 Mar 2020 16:51:30 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/37] linux-user: do prlimit selectively
Date: Tue, 17 Mar 2020 16:50:46 +0100
Message-Id: <20200317155116.1227513-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wBTezntg/MGI6bIrWXYV24/VFgMTo/4yH9qxUNAdIuMFnrbVA+b
 hoKDBk8xoVYGFS+shBZUfImZs3gumy+OZNemHwN2NAwC8raOfvytsyZ0QayUiIz2zoB0vHi
 r3VDHI8Uzm5YNB8qrWiLgZ9tpDnVwn0mhZBKTtAwUQyoYFVrJQsIfNCXAWcjFn021upODTu
 nM9puZ38jTtGwqpOH92Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3n5A30sRZOk=:q+v60rWe96GsEilf3haQjG
 6qQrOgT9GPmTBnr5reBqypx060yAlgRUwiFEHDmM7o8HoMUG5sTtaKpnXEigwJfpxU4aBqtG9
 VTBo3xniCrsI0vo/EcZxDX88FutJeRejO+RMtNkCvYowmkzGMxafZeNBBzF9wRHdRmHXa4uFo
 jyEIxbrW4nNIiU0z8+iY1ZKjKEuYaSX9HqJCnjMhgIrsN1NSJXMDxndEvimd2NXr4oZLdS0jq
 D9Dp5UV9c36XeMdi3lAiYWDC8AYIXXvs4gMtQUhUKavZ3OFR7omVRcHb4TE3ZtXqP43jjCl8x
 Z4pX7gE0f+DkIG5J3aAqZiYuyTm3EZii0q5Jh2qwf/caDM59Y16pB8iB0X8+JDuj/ZKAfhiJU
 BgG2Or24a8KXul7RAVSFB+cBsqNYcYnzk309nlrSMxbUJASCQyW9cj776NjuAzHEXs8X89S22
 ouYrlYoZ+oswXqr0ghDmieRexkGG/PFwi4IUlYTU4fbuEPuyOrTV/U5FCRDZoQbnATyk7xW0Q
 jI6orkiPKlja7aqjXoQYIeXcW17EmNVdqUXYu/9HYvrnoIesMEh7Y9OsbLdlBrqDVpmMbgEvr
 6aqv6xYoPrHzJp/plbGxFwW0476M5mFS7YWVkdkhIkjLgJ1f7yQYJIV5zhYZRp4ahqcSn+Pd9
 T5mXhH8l7t4HEI7uy03XrHbilXPaKhjFFdG5VqMG8X4T2XXwmobTN3P9mNhLKUO+EmoxrKIJR
 IyALpdmIThHpMoDHrbM/F9fJQefxB5uOzrhGz8PKBIW+hWQrh2l4cW/Hlo2/pHVqyWnEgduAi
 CVLIdMGpWY7S2wDkM0Qd8D/UiT3Q2UGAJhBuxZqYHubePCl4k8hnJVAjMBCUEPony9v4Xlf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Tobias Koch <tobias.koch@nonterra.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tobias Koch <tobias.koch@nonterra.com>

Analogous to what commit 5dfa88f7 did for setrlimit, this commit
selectively ignores limits for memory-related resources in prlimit64
calls. This is to prevent too restrictive limits from causing QEMU
itself to malfunction.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200305202400.27574-1-tobias.koch@nonterra.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 811495c3a0bc..be676c3a4fb4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11904,7 +11904,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         struct target_rlimit64 *target_rnew, *target_rold;
         struct host_rlimit64 rnew, rold, *rnewp = 0;
         int resource = target_to_host_resource(arg2);
-        if (arg3) {
+
+        if (arg3 && (resource != RLIMIT_AS &&
+                     resource != RLIMIT_DATA &&
+                     resource != RLIMIT_STACK)) {
             if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
                 return -TARGET_EFAULT;
             }
-- 
2.24.1


