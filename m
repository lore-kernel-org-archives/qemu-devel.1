Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F624C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D820D2070B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D820D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPe6g-0005bW-3F
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 23:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1jPe49-00053V-2m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1jPe46-0002h5-Ts
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:22:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3672 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1jPe3y-0002O2-G3; Fri, 17 Apr 2020 23:22:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B2ABCFFFF7C2FECB6CBD;
 Sat, 18 Apr 2020 11:22:28 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0;
 Sat, 18 Apr 2020 11:22:21 +0800
Subject: Re: [PATCH 2/3] intc/gicv3_kvm: use kvm_gicc_access to get
 ICC_CTLR_EL1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200413091552.62748-1-zhukeqian1@huawei.com>
 <20200413091552.62748-3-zhukeqian1@huawei.com>
 <CAFEAcA9iUAtVvuv_8AOm0TkYzDD54QHZEL_DKRv_b_YpaVTJ_g@mail.gmail.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <4d163384-ea47-17fb-9575-bcfdfa05b05e@huawei.com>
Date: Sat, 18 Apr 2020 11:22:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9iUAtVvuv_8AOm0TkYzDD54QHZEL_DKRv_b_YpaVTJ_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2020/4/17 19:09, Peter Maydell wrote:
> On Mon, 13 Apr 2020 at 10:18, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>
>> Replace kvm_device_access with kvm_gicc_access to simplify
>> code.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  hw/intc/arm_gicv3_kvm.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> index ca43bf87ca..85f6420498 100644
>> --- a/hw/intc/arm_gicv3_kvm.c
>> +++ b/hw/intc/arm_gicv3_kvm.c
>> @@ -678,9 +678,8 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>>      }
>>
>>      /* Initialize to actual HW supported configuration */
>> -    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
>> -                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
>> -                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
>> +    kvm_gicc_access(s, ICC_CTLR_EL1, c->cpu->cpu_index,
>> +                    &c->icc_ctlr_el1[GICV3_NS], false);
> 
> This works at the moment, but I'd rather we avoided looking into
> cpu->cpu_index inside the GIC code. The cpu_index is the overall
> index of the CPU of all CPUs in the system, which is not in
> theory the same as "index of this CPU for this GIC". The two
> currently match up because arm_gicv3_common_realize() populates
> its s->cpu[i].cpu by calling qemu_get_cpu(i), but in future
> we might change that code (eg so that the board code has to
> explicitly wire up the CPUs to the GIC object by passing
> pointers to the CPUs to the GIC via link properties). So I'd
> rather not have the internals of the GIC code bake in the
> assumption that 'global CPU index is the same as the index
> of the CPU for this GIC object'.
OK, I get it. This patch can be ignored.
> 
> (All the other places that call kvm_gicc_access() are doing it
> as part of a loop from 0 to n->num_cpus, so they don't have this
> issue.)
> 
> thanks
> -- PMM
> 
> .
> 
Thanks,
Keqian


