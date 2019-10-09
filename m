Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657DDC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ED521848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ED521848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGqW-0000x6-I0
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iIBg8-0001CJ-7v
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iIBg6-0005Xq-Vd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:06:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2248 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iIBg1-0005W5-Nv; Wed, 09 Oct 2019 09:06:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3FCCB19A5915D8434BA4;
 Wed,  9 Oct 2019 21:06:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 21:06:34 +0800
Subject: Re: [RFC PATCH 07/12] arm/sdei: override qemu_irq handler when
 binding interrupt
To: Peter Maydell <peter.maydell@linaro.org>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-8-git-send-email-guoheyi@huawei.com>
 <CAFEAcA9ZHs=GdJ-_Ap1PWdgDjSDBnnRqG1UkMGx_FiqCJ5ZyGw@mail.gmail.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <0aa6638c-1155-6446-114b-29d335367007@huawei.com>
Date: Wed, 9 Oct 2019 21:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZHs=GdJ-_Ap1PWdgDjSDBnnRqG1UkMGx_FiqCJ5ZyGw@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave Martin <Dave.Martin@arm.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Thanks for your comments. I will explain SDEI in another mail and please 
provide your suggestions for such situation.

Heyi


On 2019/9/30 21:19, Peter Maydell wrote:
> On Tue, 24 Sep 2019 at 16:23, Heyi Guo <guoheyi@huawei.com> wrote:
>> Override qemu_irq handler to support trigger SDEI event transparently
>> after guest binds interrupt to SDEI event. We don't have good way to
>> get GIC device and to guarantee SDEI device is initialized after GIC,
>> so we search GIC in system bus when the first SDEI request happens or
>> in VMSTATE post_load().
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>
>> +static void override_qemu_irq(QemuSDEState *s, int32_t event, uint32_t intid)
>> +{
>> +    qemu_irq irq;
>> +    QemuSDE *sde;
>> +    CPUState *cs;
>> +    int cpu;
>> +
>> +    /* SPI */
>> +    if (intid >= GIC_INTERNAL) {
>> +        cs = arm_get_cpu_by_id(0);
>> +        irq = qdev_get_gpio_in(s->gic_dev,
>> +                               gic_int_to_irq(s->num_irq, intid, 0));
>> +        if (irq) {
>> +            qemu_irq_intercept_in(&irq, qemu_sdei_irq_handler, 1);
>> +        }
> I'm not sure what this code is trying to do, but
> qemu_irq_intercept_in() is a function for internal use
> by the qtest testing infrastructure, so it shouldn't be
> used in 'real' QEMU code.
>
>> +        sde = get_sde_no_check(s, event, cs);
>> +        sde->irq = irq;
>> +        put_sde(sde, cs);
>> +        return;
>> +    }
>> @@ -1042,6 +1152,17 @@ void sdei_handle_request(CPUState *cs, struct kvm_run *run)
>>           return;
>>       }
>>
>> +    if (!sde_state->gic_dev) {
>> +        /* Search for ARM GIC device */
>> +        qbus_walk_children(sysbus_get_default(), dev_walkerfn,
>> +                           NULL, NULL, NULL, sde_state);
>> +        if (!sde_state->gic_dev) {
>> +            error_report("Cannot find ARM GIC device!");
>> +            run->hypercall.args[0] = SDEI_NOT_SUPPORTED;
>> +            return;
>> +        }
>> +    }
> Walking through the qbus tree looking for particular devices
> isn't really something I'd recommend either.
>
> thanks
> -- PMM
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>



