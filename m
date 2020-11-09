Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B16C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B349221D93
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B349221D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbxhX-0008Bz-Py
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 22:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kbxgu-0007eM-JB; Sun, 08 Nov 2020 22:18:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kbxgs-00088P-AQ; Sun, 08 Nov 2020 22:18:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CTx5016zwz15SjZ;
 Mon,  9 Nov 2020 11:17:40 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 11:17:40 +0800
Message-ID: <5FA8B4D4.5080406@huawei.com>
Date: Mon, 9 Nov 2020 11:17:40 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH] target/microblaze: Fix possible array out of bounds in
 mmu_write()
References: <5FA10ABA.1080109@huawei.com>
 <72d0a4aa-f875-80c0-eae3-6af843c217c2@amsat.org>
In-Reply-To: <72d0a4aa-f875-80c0-eae3-6af843c217c2@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=alex.chen@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 22:05:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, edgar.iglesias@gmail.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/11/6 22:16, Philippe Mathieu-Daudé wrote:
> On 11/3/20 8:46 AM, AlexChen wrote:
>> The size of env->mmu.regs is 3, but the range of 'rn' is [0, 5].
>> To avoid data access out of bounds, only if 'rn' is less than 3, we
>> can print env->mmu.regs[rn]. In other cases, we can print
>> env->mmu.regs[MMU_R_TLBX].
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>> ---
>>  target/microblaze/mmu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
>> index 1dbbb271c4..917ad6d69e 100644
>> --- a/target/microblaze/mmu.c
>> +++ b/target/microblaze/mmu.c
>> @@ -234,7 +234,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>>      unsigned int i;
>>
>>      qemu_log_mask(CPU_LOG_MMU,
>> -                  "%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]);
>> +                  "%s rn=%d=%x old=%x\n", __func__, rn, v,
>> +                  rn < 3 ? env->mmu.regs[rn] : env->mmu.regs[MMU_R_TLBX]);
> 
> Nack. If rn >= ARRAY_SIZE(env->mmu.regs), then don't displays it.
> Else it is confuse to see a value unrelated to the MMU index used...
> 
Hi Philippe,

Thanks for your review.
The env->mmu.regs[MMU_R_TLBX] is used when rn >= ARRAY_SIZE(env->mmu.regs),
can we change the description of the log as follows so that it doesn't confuse us?

---
 target/microblaze/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 1dbbb271c4..14863ed8d1 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -234,7 +234,9 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
     unsigned int i;

     qemu_log_mask(CPU_LOG_MMU,
-                  "%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]);
+                  "%s rn=%d=%x %s=%x\n", __func__, rn, v,
+                  rn < 3 ? "old" : "regs[MMU_R_TLBX]",
+                  rn < 3 ? env->mmu.regs[rn] : env->mmu.regs[MMU_R_TLBX]);

     if (cpu->cfg.mmu < 2 || !cpu->cfg.mmu_tlb_access) {
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");

Thanks,
Alex



