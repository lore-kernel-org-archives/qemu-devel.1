Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB03C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 01:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688ED205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 01:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688ED205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB7MI-0004lH-CA
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 21:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jB7LW-0004L8-5b
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jB7LU-0003DS-R5
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:36:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3190 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jB7LU-0003A2-Fh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:36:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 72F593B11861BF67967C;
 Mon,  9 Mar 2020 08:49:38 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 08:49:30 +0800
Subject: Re: [PATCH v4 0/3] delay timer_new from init to realize to fix
 memleaks.
To: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <8af2cdaa-7e3e-409f-5351-7fc54e00aab5@ilande.co.uk>
 <CAFEAcA_8SWR6MrNL98GFNASs0_qE_U4pgiw_LyiydKVaSb7C8A@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <f354213e-9878-76f7-e628-85e6f963c4a6@huawei.com>
Date: Mon, 9 Mar 2020 08:49:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8SWR6MrNL98GFNASs0_qE_U4pgiw_LyiydKVaSb7C8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
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
Cc: Euler Robot <euler.robot@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/8/2020 9:39 PM, Peter Maydell wrote:
> On Sun, 8 Mar 2020 at 11:58, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> I just tried this patchset applied on top of git master and it causes qemu-system-ppc
>> to segfault on startup:
>>
>> $ gdb --args ./qemu-system-ppc
>> ...
>> ...
>> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555e7e38c in timer_del (ts=0x0) at util/qemu-timer.c:429
>> 429         QEMUTimerList *timer_list = ts->timer_list;
>> (gdb) bt
>> #0  0x0000555555e7e38c in timer_del (ts=0x0) at util/qemu-timer.c:429
>> #1  0x0000555555b5d2c1 in mos6522_reset (dev=0x555556e0ac50) at hw/misc/mos6522.c:468
>> #2  0x0000555555b63570 in mos6522_cuda_reset (dev=0x555556e0ac50) at
>> hw/misc/macio/cuda.c:599
> 
> It looks like we haven't caught all the cases of "somebody created a
> MOS6522 (or one of its subclasses) but forgot to realize it". This
> particular one I think is the s->cuda which is inited in macio_oldworld_init()
> but not realized in macio_oldworld_realize(). I think that pmu_init() in
> hw/misc/macio/pmu.c also has this bug. We need to go through and
> audit all the places where we create TYPE_MOS6522 or any of its
> subclasses and make sure they are also realizing the devices they create.
> (The presence of the new 3-phase reset infrastructure in the backtrace
> is a red herring here -- this would have crashed the same way with the
> old code too.)
> 

Yes, that's right, this series miss other cases, I will search and fix all
the cases about MOS6522 device.

Thanks.

> We should probably find some generic place in Device code where we
> can stick an assert "are we trying to reset an unrealized device?"
> because I bet we have other instances of this bug which we haven't
> noticed because the reset function happens to not misbehave on
> an inited-but-not-realized device...
> 
> thanks
> -- PMM
> .
> 

