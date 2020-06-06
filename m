Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55C2206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55C2206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYmx-0001K7-Qh
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgR-00073B-Hi
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgQ-0007eb-FP
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvoW-1jURgM0mJM-00UpGg; Sat, 06 Jun 2020 15:16:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/19] linux-user/mmap.c: fix integer underflow in
 target_mremap
Date: Sat,  6 Jun 2020 15:15:53 +0200
Message-Id: <20200606131607.1250819-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5vJbdaOyDOX3IMuwj7hoM3dwXxGnuZNYnT2XOSsk1C9ZXpOPz9M
 FCbrpW+c9RRCHL9YsReuoWlNznlvnesTC/otnrfqiPD2QMO2m+sehww62L8fdXlyeEAV3dc
 agNzoqwe8i7NNkpXwuOBeTGpJpfjQJYUdrf/GZTZdL2ji+oJWezmj12fsAx+5RMl9N9U3VF
 +Ajpgr+SPeR4mab4cwv8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fsqNGXrgIQs=:NH0NKH2RETzBlgDmx00wVf
 DuxFiBNe2ZWOzxk+T67dNB+XilJGRAtjTxN8R/tQdsmBFjvQiPL0fcd1vxJClDH+XdCbeKaVB
 VQyjC8GDZHcc4069n5F8t71fmwSw0Il4eJFJ9PSEMX0yBxUUiqfbDMDy3CEz/rLQAvrjykxiP
 NamrY6YNL7mdn4LqDYo5mjbCJAzv7zy6F+IdF/QdpFHd9+rN7UkQasf3m73rUKUgjmlPP7Ow3
 QhiegWrm7fJnn8g9h5gr7Pun6ifBOBRgmskoDaJXkNhRmyAneoxQf8ZqvBlaOSAoB+8K7YyU/
 QGryAPFlnDr3baw3GAXrRN05eUcBx88+A7N1yQY5f0EhVbO18sLS/xzaqG9vAFaOi5cQBdYOP
 5ImU7TwyRahuHdSkvG85MF65JknkomtAVfPMBqt3tDbI8RRDIOBo/4q8XJYqY7xvlufoxDszq
 EC8pWK6hErcoxmYufuwDrNgFvDi5ut13fpdVMz5Hcu8YVbLN7gd32pwmjr1oysvIGzdwzsbYX
 BbzCVDQLpFHWjrhog8NgmsfsySTEaLQlicjq+9KPnJ02u7mtmrwZN4xJgDLjUtOUq2+ewEuJA
 /9OGAsm2Tkjn8XNWVEP0mUHhm/YuddKK1agXsXzxT92u7kBtMnfVhePEkHQPKC11w6Gnd3lwr
 rNwEl2HOkyOGdgCNJ6qoZwPUXNTXt3TJ81RRtIaz0ThuYhajZK+qEWuVW+TBhfV0zuKUtOanU
 SIBCkt0dq0LdusPrx2135+1gCf0tbY28Vm4mVyh7XBbe/JAjJHiJGLTgSO+4z7DqJ6ejN8ABV
 h1AMKv9HEitlNRsxbMxY8qaKYXX6sy6/qIqRHdtZYGyceP9RMlj0AN4RR01UDUksc+kmxMC
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Jonathan Marler <johnnymarler@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Marler <johnnymarler@gmail.com>

Fixes: https://bugs.launchpad.net/bugs/1876373

This code path in mmap occurs when a page size is decreased with mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the pages that were released.  However, it has the diff operation reversed, subtracting the larger old_size from the smaller new_size.  Instead, it should be subtracting the smaller new_size from the larger old_size.  You can also see in the previous line of the change that this mmap_reserve call only occurs when old_size > new_size.

Bug: https://bugs.launchpad.net/qemu/+bug/1876373
Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
Reviewded-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200502161225.14346-1-johnnymarler@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e37803379747..caab62909eb1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         if (prot == 0) {
             host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
             if (host_addr != MAP_FAILED && reserved_va && old_size > new_size) {
-                mmap_reserve(old_addr + old_size, new_size - old_size);
+                mmap_reserve(old_addr + old_size, old_size - new_size);
             }
         } else {
             errno = ENOMEM;
-- 
2.26.2


